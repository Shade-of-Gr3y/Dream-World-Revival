package org.libspark.thread
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import org.libspark.thread.errors.CurrentThreadNotFoundError;
   import org.libspark.thread.errors.IllegalThreadStateError;
   import org.libspark.thread.errors.InterruptedError;
   import org.libspark.thread.errors.ThreadLibraryNotInitializedError;
   
   public class Thread extends Monitor
   {
      
      private static var _executor:IThreadExecutor;
      
      private static var _threadIndex:uint = 0;
      
      private static var _currentThread:Thread = null;
      
      private static var _toplevelThreads:Array = [];
      
      private static var _uncaughtErrorHandler:Function = null;
      
      private static var _defaultErrorHandlers:Dictionary = null;
      
      private var _error:Object;
      
      private var _joinMonitor:IMonitor;
      
      private var _state:uint;
      
      private var _errorHandlers:Dictionary;
      
      private var _event:Event;
      
      private var _eventHandlers:Array;
      
      private var _eventMonitor:IMonitor;
      
      private var _isInterrupted:Boolean;
      
      private var _id:uint;
      
      private var _interruptedHandler:Function;
      
      private var _timeoutHandler:Function;
      
      private var _children:Array;
      
      private var _runHandler:Function;
      
      private var _waitMonitor:IMonitor;
      
      private var _savedRunHandler:Function;
      
      private var _name:String;
      
      private var _sleepMonitor:IMonitor;
      
      private var _errorThread:Thread;
      
      private var _runningState:uint;
      
      public function Thread()
      {
         super();
         this._id = ++_threadIndex;
         this._name = "Thread" + this._id;
         this._state = ThreadState.NEW;
         this._runningState = ThreadState.NEW;
         this._children = null;
         this._runHandler = null;
         this._savedRunHandler = null;
         this._timeoutHandler = null;
         this._interruptedHandler = null;
         this._waitMonitor = null;
         this._joinMonitor = null;
         this._sleepMonitor = null;
         this._eventMonitor = null;
         this._event = null;
         this._errorHandlers = null;
         this._error = null;
         this._errorThread = null;
         this._eventHandlers = null;
         this._isInterrupted = false;
      }
      
      public static function interrupted(param1:Function) : void
      {
         getCurrentThread()._interruptedHandler = param1;
      }
      
      public static function defaultErrorHandler(param1:Object, param2:Thread) : void
      {
      }
      
      private static function getDefaultErrorHandlers() : Dictionary
      {
         return _defaultErrorHandlers || (_defaultErrorHandlers = new Dictionary());
      }
      
      private static function getUncaughtErrorHandler() : Function
      {
         return uncaughtErrorHandler || defaultErrorHandler;
      }
      
      public static function error(param1:Class, param2:Function, param3:Boolean = true, param4:Boolean = false) : void
      {
         if(param2 != null)
         {
            getCurrentThread().addErrorHandler(param1,param2,param3,param4);
         }
         else
         {
            getCurrentThread().removeErrorHandler(param1);
         }
      }
      
      public static function initialize(param1:IThreadExecutor) : void
      {
         _threadIndex = 0;
         _currentThread = null;
         _toplevelThreads.length = 0;
         if(_executor != null)
         {
            _executor.stop();
         }
         _executor = param1;
         if(_executor != null)
         {
            _executor.start();
         }
      }
      
      public static function get uncaughtErrorHandler() : Function
      {
         return _uncaughtErrorHandler;
      }
      
      public static function get isReady() : Boolean
      {
         return _executor != null;
      }
      
      public static function event(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
      {
         getCurrentThread().addEventHandler(param1,param2,param3,param4,param5,param6);
      }
      
      public static function executeAllThreads() : void
      {
         var thread:Thread = null;
         var threads:Array = _toplevelThreads;
         var l:uint = threads.length;
         var i:uint = 0;
         while(i < l)
         {
            thread = Thread(threads[i]);
            if(!thread.execute())
            {
               threads.splice(i,1);
               l--;
            }
            else
            {
               i++;
            }
            if(thread._error != null && thread._errorThread != null)
            {
               try
               {
                  getUncaughtErrorHandler()(thread._error,thread._errorThread);
               }
               catch(e:Object)
               {
                  defaultErrorHandler(e,null);
               }
               thread._error = null;
               thread._errorThread = null;
            }
         }
      }
      
      private static function removeDefaultErrorHandler(param1:Class) : void
      {
         if(_defaultErrorHandlers == null)
         {
            return;
         }
         delete _defaultErrorHandlers[getQualifiedClassName(param1)];
      }
      
      public static function registerDefaultErrorHandler(param1:Class, param2:Function, param3:Boolean = false) : void
      {
         if(param2 != null)
         {
            addDefaultErrorHandler(param1,param2,param3);
         }
         else
         {
            removeDefaultErrorHandler(param1);
         }
      }
      
      public static function timeout(param1:Function) : void
      {
         getCurrentThread()._timeoutHandler = param1;
      }
      
      public static function get currentThread() : Thread
      {
         return _currentThread;
      }
      
      public static function sleep(param1:uint) : void
      {
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc2_:Thread = getCurrentThread();
         if(_loc2_._sleepMonitor == null)
         {
            _loc2_._sleepMonitor = new Monitor();
         }
         _loc2_._sleepMonitor.wait(param1);
      }
      
      internal static function getCurrentThread() : Thread
      {
         var _loc1_:Thread = currentThread;
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         throw new CurrentThreadNotFoundError("Expected Thread.currentThread is not null, but actual null.");
      }
      
      public static function set uncaughtErrorHandler(param1:Function) : void
      {
         _uncaughtErrorHandler = param1;
      }
      
      private static function addDefaultErrorHandler(param1:Class, param2:Function, param3:Boolean) : void
      {
         getDefaultErrorHandlers()[getQualifiedClassName(param1)] = new ErrorHandler(param2,false,param3);
      }
      
      public static function next(param1:Function) : void
      {
         getCurrentThread()._runHandler = param1;
      }
      
      private static function addToplevelThreads(param1:Array) : void
      {
         _toplevelThreads.push.apply(_toplevelThreads,param1);
      }
      
      private static function addToplevelThread(param1:Thread) : void
      {
         _toplevelThreads.push(param1);
      }
      
      public static function checkInterrupted() : Boolean
      {
         var _loc1_:Thread = getCurrentThread();
         var _loc2_:Boolean = _loc1_._isInterrupted;
         if(_loc2_)
         {
            _loc1_._isInterrupted = false;
         }
         return _loc2_;
      }
      
      private function resetErrorHandlers() : void
      {
         var _loc1_:String = null;
         if(this._errorHandlers == null)
         {
            return;
         }
         for(_loc1_ in this._errorHandlers)
         {
            if(ErrorHandler(this._errorHandlers[_loc1_]).reset)
            {
               delete this._errorHandlers[_loc1_];
            }
         }
      }
      
      private function execute() : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Thread = null;
         if(this._state == ThreadState.NEW)
         {
            return true;
         }
         if(this._state == ThreadState.TERMINATED)
         {
            return false;
         }
         var _loc1_:Object = this._error;
         var _loc2_:Thread = this._errorThread || this;
         var _loc3_:Array = this._children;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = Thread(_loc3_[_loc5_]);
               if(!_loc6_.execute())
               {
                  _loc3_.splice(_loc5_,1);
                  _loc4_--;
               }
               else
               {
                  _loc5_++;
               }
               if(_loc6_._error != null && _loc6_._errorThread != null && _loc1_ == null)
               {
                  _loc1_ = _loc6_._error;
                  _loc2_ = _loc6_._errorThread;
                  _loc6_._error = null;
                  _loc6_._errorThread = null;
               }
            }
         }
         return this.internalExecute(_loc1_,_loc2_);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function resetEventHandlers() : void
      {
         var _loc1_:EventHandler = null;
         if(this._eventHandlers == null)
         {
            return;
         }
         for each(_loc1_ in this._eventHandlers)
         {
            _loc1_.unregister();
         }
         this._eventHandlers.length = 0;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get state() : uint
      {
         return this._state;
      }
      
      private function getJoinMonitor() : IMonitor
      {
         return this._joinMonitor || (this._joinMonitor = new Monitor());
      }
      
      protected function finalize() : void
      {
      }
      
      private function getErrorHandler(param1:Object) : ErrorHandler
      {
         var _loc2_:ErrorHandler = this.getErrorHandlerFrom(param1,this._errorHandlers);
         if(_loc2_ == null)
         {
            _loc2_ = this.getErrorHandlerFrom(param1,_defaultErrorHandlers);
         }
         return _loc2_;
      }
      
      private function addEventHandler(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean, param5:int, param6:Boolean) : void
      {
         this.getEventHandlers().push(new EventHandler(param1,param2,this.eventHandler,param3,param4,param5,param6));
      }
      
      public function get className() : String
      {
         var _loc1_:Array = getQualifiedClassName(this).split(/::/);
         return _loc1_.length == 2 ? _loc1_[1] : _loc1_[0];
      }
      
      public function toString() : String
      {
         return this.formatName(this.name);
      }
      
      internal function monitorTimeout(param1:IMonitor) : void
      {
         if(this._state != ThreadState.TIMED_WAITING || this._waitMonitor != param1)
         {
            throw new IllegalThreadStateError("Thread can not wakeup.");
         }
         this._state = this._runningState;
         if(this._waitMonitor != this._sleepMonitor)
         {
            if(this._timeoutHandler != null)
            {
               this._runHandler = this._timeoutHandler;
            }
         }
         this._waitMonitor = null;
      }
      
      protected function formatName(param1:String) : String
      {
         return "[" + this.className + " " + param1 + "]";
      }
      
      public function join(param1:uint = 0) : Boolean
      {
         if(this._state == ThreadState.TERMINATED)
         {
            return false;
         }
         this.getJoinMonitor().wait(param1);
         return true;
      }
      
      protected function run() : void
      {
      }
      
      public function get isInterrupted() : Boolean
      {
         return this._isInterrupted;
      }
      
      internal function monitorWakeup(param1:IMonitor) : void
      {
         if(this._state != ThreadState.WAITING && this._state != ThreadState.TIMED_WAITING || this._waitMonitor != param1)
         {
            throw new IllegalThreadStateError("Thread can not wakeup.");
         }
         this._state = this._runningState;
         this._waitMonitor = null;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      private function removeErrorHandler(param1:Class) : void
      {
         if(this._errorHandlers == null)
         {
            return;
         }
         delete this._errorHandlers[getQualifiedClassName(param1)];
      }
      
      private function eventHandler(param1:Event, param2:EventHandler) : void
      {
         var current:Thread;
         var e:Event = param1;
         var handler:EventHandler = param2;
         if(this._event != null)
         {
            return;
         }
         this._event = e;
         this._runHandler = handler.func;
         this.resetEventHandlers();
         if(this._waitMonitor != null)
         {
            this._waitMonitor.leave(this);
            this._waitMonitor = null;
         }
         this._state = this._runningState;
         current = _currentThread;
         try
         {
            this.internalExecute(null,this);
         }
         finally
         {
            _currentThread = current;
         }
      }
      
      private function getEventMonitor() : IMonitor
      {
         return this._eventMonitor || (this._eventMonitor = new Monitor());
      }
      
      private function getErrorHandlers() : Dictionary
      {
         return this._errorHandlers || (this._errorHandlers = new Dictionary());
      }
      
      public function interrupt() : void
      {
         if(this._state == ThreadState.WAITING || this._state == ThreadState.TIMED_WAITING)
         {
            this._waitMonitor.leave(this);
            this._waitMonitor = null;
            this._state = this._runningState;
            if(this._interruptedHandler != null)
            {
               this._runHandler = this._interruptedHandler;
            }
            else
            {
               this._error = new InterruptedError();
            }
         }
         else
         {
            this._isInterrupted = true;
         }
      }
      
      public function start() : void
      {
         if(!isReady)
         {
            throw new ThreadLibraryNotInitializedError("Thread Library is not initialized. Please call Thread#initialize before.");
         }
         if(this._state != ThreadState.NEW)
         {
            throw new IllegalThreadStateError("Thread is already running.");
         }
         this._state = ThreadState.RUNNABLE;
         this._runningState = ThreadState.RUNNABLE;
         this._runHandler = this.run;
         var _loc1_:Thread = currentThread;
         if(_loc1_ != null)
         {
            _loc1_.addChildThread(this);
         }
         else
         {
            addToplevelThread(this);
         }
      }
      
      private function addChildThread(param1:Thread) : void
      {
         this.getChildren().push(param1);
      }
      
      internal function monitorWait(param1:Boolean, param2:IMonitor) : void
      {
         if(this._state != ThreadState.RUNNABLE && this._state != ThreadState.TERMINATING || this._waitMonitor != null)
         {
            throw new IllegalThreadStateError("Thread can not wait.");
         }
         this._state = param1 ? ThreadState.TIMED_WAITING : ThreadState.WAITING;
         this._waitMonitor = param2;
      }
      
      private function getChildren() : Array
      {
         return this._children || (this._children = []);
      }
      
      private function getErrorHandlerFrom(param1:Object, param2:Dictionary) : ErrorHandler
      {
         var className:String;
         var handler:ErrorHandler = null;
         var error:Object = param1;
         var handlers:Dictionary = param2;
         if(handlers == null)
         {
            return null;
         }
         className = getQualifiedClassName(error);
         while(className != null)
         {
            handler = handlers[className];
            if(handler != null)
            {
               return handler;
            }
            try
            {
               className = getQualifiedSuperclassName(getDefinitionByName(className));
            }
            catch(e:ReferenceError)
            {
               className = null;
            }
         }
         return null;
      }
      
      private function addErrorHandler(param1:Class, param2:Function, param3:Boolean, param4:Boolean) : void
      {
         this.getErrorHandlers()[getQualifiedClassName(param1)] = new ErrorHandler(param2,param3,param4);
      }
      
      private function getEventHandlers() : Array
      {
         return this._eventHandlers || (this._eventHandlers = []);
      }
      
      private function internalExecute(param1:Object, param2:Thread) : Boolean
      {
         var runHandler:Function;
         var errorHandler:ErrorHandler = null;
         var ev:Event = null;
         var eventHandler:EventHandler = null;
         var error:Object = param1;
         var errorThread:Thread = param2;
         if(this._state == ThreadState.WAITING || this._state == ThreadState.TIMED_WAITING)
         {
            if(error == null)
            {
               return true;
            }
            this._waitMonitor.leave(this);
            this._waitMonitor = null;
            this._state = this._runningState;
         }
         runHandler = null;
         errorHandler = null;
         if(error != null)
         {
            errorHandler = this.getErrorHandler(error);
            if(errorHandler != null)
            {
               if(errorThread != this)
               {
                  this._savedRunHandler = this._runHandler;
               }
               else
               {
                  this._error = null;
               }
               runHandler = errorHandler.handler;
            }
            else
            {
               if(this._runningState != ThreadState.TERMINATING)
               {
                  this._state = ThreadState.TERMINATING;
                  this._runningState = ThreadState.TERMINATING;
                  runHandler = this.finalize;
               }
               this._error = error;
               this._errorThread = errorThread;
            }
         }
         else
         {
            runHandler = this._runHandler;
         }
         this._runHandler = null;
         this._timeoutHandler = null;
         this.resetEventHandlers();
         this.resetErrorHandlers();
         this._interruptedHandler = null;
         if(errorHandler != null)
         {
            this._runHandler = this._savedRunHandler;
         }
         if(runHandler != null)
         {
            _currentThread = this;
            try
            {
               if(errorHandler != null)
               {
                  runHandler.apply(this,[error,errorThread]);
                  if(errorHandler.autoTermination)
                  {
                     next(null);
                  }
               }
               else if(this._event != null)
               {
                  ev = this._event;
                  this._event = null;
                  runHandler.apply(this,[ev]);
               }
               else
               {
                  runHandler.apply(this);
               }
            }
            catch(e:Object)
            {
               _error = e;
               if(errorHandler == null && getErrorHandler(e) != null)
               {
                  _savedRunHandler = _runHandler;
                  _runHandler = run;
               }
               else
               {
                  _errorThread = this;
                  _runHandler = null;
               }
            }
            finally
            {
               _currentThread = null;
            }
         }
         if(errorHandler != null && this._error == null)
         {
            this._savedRunHandler = null;
         }
         if(this._eventHandlers != null && this._eventHandlers.length > 0)
         {
            if(this._error == null)
            {
               for each(eventHandler in this._eventHandlers)
               {
                  eventHandler.register();
               }
               if(this._runHandler == null)
               {
                  if(this._waitMonitor == null)
                  {
                     try
                     {
                        _currentThread = this;
                        this.getEventMonitor().wait();
                     }
                     finally
                     {
                        _currentThread = null;
                     }
                  }
               }
            }
         }
         if(this._runHandler == null)
         {
            if(!(this._state == ThreadState.WAITING || this._state == ThreadState.TIMED_WAITING))
            {
               if(this._runningState == ThreadState.TERMINATING)
               {
                  if(this._children != null)
                  {
                     addToplevelThreads(this._children);
                     this._children = null;
                  }
                  this._state = ThreadState.TERMINATED;
                  this._runningState = ThreadState.TERMINATED;
                  if(this._joinMonitor != null)
                  {
                     this._joinMonitor.notifyAll();
                     this._joinMonitor = null;
                  }
                  return false;
               }
               this._state = ThreadState.TERMINATING;
               this._runningState = ThreadState.TERMINATING;
               this._runHandler = this.finalize;
            }
         }
         return true;
      }
   }
}


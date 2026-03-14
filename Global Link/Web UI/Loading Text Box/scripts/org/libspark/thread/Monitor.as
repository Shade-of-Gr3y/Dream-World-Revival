package org.libspark.thread
{
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Monitor implements IMonitor
   {
      
      private var _timeoutList:Dictionary;
      
      private var _waitors:Array;
      
      public function Monitor()
      {
         super();
      }
      
      private function timeoutHandler(param1:Thread) : void
      {
         if(this._waitors == null || this._waitors.length < 1)
         {
            return;
         }
         var _loc2_:int = int(this._waitors.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this._waitors.splice(_loc2_,1);
         param1.monitorTimeout(this);
      }
      
      public function wait(param1:uint = 0) : void
      {
         var _loc2_:Thread = Thread.getCurrentThread();
         _loc2_.monitorWait(param1 != 0,this);
         this.getWaitors().push(_loc2_);
         if(param1 != 0)
         {
            this.registerTimeout(_loc2_,param1);
         }
      }
      
      private function unregisterTimeout(param1:Thread) : void
      {
         if(this._timeoutList == null)
         {
            return;
         }
         var _loc2_:Object = this._timeoutList[param1];
         if(_loc2_ != null)
         {
            clearTimeout(uint(_loc2_));
            delete this._timeoutList[param1];
         }
      }
      
      private function getWaitors() : Array
      {
         return this._waitors || (this._waitors = []);
      }
      
      public function notify() : void
      {
         if(this._waitors == null || this._waitors.length < 1)
         {
            return;
         }
         var _loc1_:Thread = Thread(this._waitors.shift());
         this.unregisterTimeout(_loc1_);
         _loc1_.monitorWakeup(this);
      }
      
      public function leave(param1:Thread) : void
      {
         if(this._waitors == null || this._waitors.length < 1)
         {
            return;
         }
         var _loc2_:int = int(this._waitors.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this._waitors.splice(_loc2_,1);
         this.unregisterTimeout(param1);
      }
      
      private function registerTimeout(param1:Thread, param2:uint) : void
      {
         if(this._timeoutList == null)
         {
            this._timeoutList = new Dictionary();
         }
         this._timeoutList[param1] = setTimeout(this.timeoutHandler,param2,param1);
      }
      
      public function notifyAll() : void
      {
         var ex:Object = null;
         var thread:Thread = null;
         if(this._waitors == null || this._waitors.length < 1)
         {
            return;
         }
         ex = null;
         for each(thread in this._waitors)
         {
            this.unregisterTimeout(thread);
            try
            {
               thread.monitorWakeup(this);
            }
            catch(e:Object)
            {
               if(ex == null)
               {
                  ex = e;
               }
            }
         }
         this._waitors.length = 0;
         if(ex != null)
         {
            throw ex;
         }
      }
   }
}


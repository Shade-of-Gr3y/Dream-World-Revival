package org.libspark.betweenas3.core.utils
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class ClonableEventDispatcher extends EventDispatcher
   {
       
      
      private var _listeners:Dictionary;
      
      public function ClonableEventDispatcher(param1:IEventDispatcher = null)
      {
         this._listeners = new Dictionary();
         super(param1);
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         var _loc6_:ListenerData = new ListenerData();
         _loc6_.listener = param2;
         _loc6_.useCapture = param3;
         _loc6_.priority = param4;
         _loc6_.useWeakReference = param5;
         var _loc7_:Array = this._listeners[param1] as Array;
         if(_loc7_ == null)
         {
            this._listeners[param1] = _loc7_ = [];
         }
         _loc7_.push(_loc6_);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:ListenerData = null;
         super.removeEventListener(param1,param2,param3);
         var _loc4_:Array = this._listeners[param1] as Array;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_] as ListenerData;
               if(_loc7_.listener == param2 && _loc7_.useCapture == param3)
               {
                  _loc4_.splice(_loc6_,1);
                  _loc6_--;
                  _loc5_--;
               }
               _loc6_++;
            }
         }
      }
      
      public function copyFrom(param1:ClonableEventDispatcher) : void
      {
         var _loc3_:* = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:ListenerData = null;
         var _loc2_:Dictionary = param1._listeners;
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_] as Array;
            _loc5_ = _loc4_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_] as ListenerData;
               this.addEventListener(_loc3_,_loc7_.listener,_loc7_.useCapture,_loc7_.priority,_loc7_.useWeakReference);
               _loc6_++;
            }
         }
      }
   }
}

class ListenerData
{
    
   
   public var listener:Function;
   
   public var useCapture:Boolean;
   
   public var priority:int;
   
   public var useWeakReference:Boolean;
   
   function ListenerData()
   {
      super();
   }
}

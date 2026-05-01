package org.libspark.betweenas3.core.updaters
{
   import flash.utils.Dictionary;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   
   public class ObjectUpdater extends AbstractUpdater
   {
      
      protected var _target:Object = null;
      
      protected var _source:Dictionary = new Dictionary();
      
      protected var _destination:Dictionary = new Dictionary();
      
      protected var _relativeMap:Dictionary = new Dictionary();
      
      public function ObjectUpdater()
      {
         super();
      }
      
      public static function register(param1:ClassRegistry) : void
      {
         param1.registerClassWithTargetClassAndPropertyName(ObjectUpdater,Object,"*");
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      override public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         this._source[param1] = param2;
         this._relativeMap["source." + param1] = param3;
      }
      
      override public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         this._destination[param1] = param2;
         this._relativeMap["dest." + param1] = param3;
      }
      
      override public function getObject(param1:String) : Object
      {
         return this._target[param1];
      }
      
      override public function setObject(param1:String, param2:Object) : void
      {
         this._target[param1] = param2;
      }
      
      override protected function resolveValues() : void
      {
         var _loc1_:String = null;
         var _loc2_:Object = this._target;
         var _loc3_:Dictionary = this._source;
         var _loc4_:Dictionary = this._destination;
         var _loc5_:Dictionary = this._relativeMap;
         for(_loc1_ in _loc3_)
         {
            if(_loc4_[_loc1_] == undefined)
            {
               _loc4_[_loc1_] = _loc2_[_loc1_];
            }
            if(_loc5_["source." + _loc1_])
            {
               _loc3_[_loc1_] += _loc2_[_loc1_];
            }
         }
         for(_loc1_ in _loc4_)
         {
            if(_loc3_[_loc1_] == undefined)
            {
               _loc3_[_loc1_] = _loc2_[_loc1_];
            }
            if(_loc5_["dest." + _loc1_])
            {
               _loc4_[_loc1_] += _loc2_[_loc1_];
            }
         }
      }
      
      override protected function updateObject(param1:Number) : void
      {
         var _loc6_:String = null;
         var _loc2_:Number = 1 - param1;
         var _loc3_:Object = this._target;
         var _loc4_:Dictionary = this._destination;
         var _loc5_:Dictionary = this._source;
         for(_loc6_ in _loc4_)
         {
            _loc3_[_loc6_] = _loc5_[_loc6_] * _loc2_ + _loc4_[_loc6_] * param1;
         }
      }
      
      override protected function newInstance() : AbstractUpdater
      {
         return new ObjectUpdater();
      }
      
      override protected function copyFrom(param1:AbstractUpdater) : void
      {
         super.copyFrom(param1);
         var _loc2_:ObjectUpdater = param1 as ObjectUpdater;
         this._target = _loc2_._target;
         this.copyObject(this._source,_loc2_._source);
         this.copyObject(this._destination,_loc2_._destination);
         this.copyObject(this._relativeMap,_loc2_._relativeMap);
      }
      
      private function copyObject(param1:Object, param2:Object) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param2)
         {
            param1[_loc3_] = param2[_loc3_];
         }
      }
   }
}


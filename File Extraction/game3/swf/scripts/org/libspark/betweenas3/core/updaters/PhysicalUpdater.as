package org.libspark.betweenas3.core.updaters
{
   import flash.utils.Dictionary;
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   
   public class PhysicalUpdater implements IPhysicalUpdater
   {
      
      protected var _target:Object = null;
      
      protected var _source:Dictionary = new Dictionary();
      
      protected var _destination:Dictionary = new Dictionary();
      
      protected var _relativeMap:Dictionary = new Dictionary();
      
      protected var _easing:IPhysicalEasing = null;
      
      protected var _duration:Dictionary = new Dictionary();
      
      protected var _maxDuration:Number = 0;
      
      protected var _isResolved:Boolean = false;
      
      public function PhysicalUpdater()
      {
         super();
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      public function get easing() : IPhysicalEasing
      {
         return this._easing;
      }
      
      public function set easing(param1:IPhysicalEasing) : void
      {
         this._easing = param1;
      }
      
      public function get duration() : Number
      {
         if(!this._isResolved)
         {
            this.resolveValues();
         }
         return this._maxDuration;
      }
      
      public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         this._source[param1] = param2;
         this._relativeMap["source." + param1] = param3;
      }
      
      public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         this._destination[param1] = param2;
         this._relativeMap["dest." + param1] = param3;
      }
      
      public function getObject(param1:String) : Object
      {
         return this._target[param1];
      }
      
      public function setObject(param1:String, param2:Object) : void
      {
         this._target[param1] = param2;
      }
      
      protected function resolveValues() : void
      {
         var _loc1_:String = null;
         var _loc7_:Number = NaN;
         var _loc2_:Object = this._target;
         var _loc3_:Dictionary = this._source;
         var _loc4_:Dictionary = this._destination;
         var _loc5_:Dictionary = this._relativeMap;
         var _loc6_:Dictionary = this._duration;
         var _loc8_:Number = 0;
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
            _loc7_ = this._easing.getDuration(_loc3_[_loc1_],_loc4_[_loc1_] - _loc3_[_loc1_]);
            _loc6_[_loc1_] = _loc7_;
            if(_loc8_ < _loc7_)
            {
               _loc8_ = _loc7_;
            }
         }
         this._maxDuration = _loc8_;
         this._isResolved = true;
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:String = null;
         if(!this._isResolved)
         {
            this.resolveValues();
         }
         var _loc3_:Object = this._target;
         var _loc4_:IPhysicalEasing = this._easing;
         var _loc5_:Dictionary = this._destination;
         var _loc6_:Dictionary = this._source;
         var _loc8_:Dictionary = this._duration;
         for(_loc9_ in _loc5_)
         {
            if(param1 >= _loc8_[_loc9_])
            {
               _loc3_[_loc9_] = _loc5_[_loc9_];
            }
            else
            {
               _loc7_ = Number(_loc6_[_loc9_]);
               _loc3_[_loc9_] = _loc4_.calculate(param1,_loc7_,_loc5_[_loc9_] - _loc7_);
            }
         }
      }
      
      public function clone() : IUpdater
      {
         var _loc1_:PhysicalUpdater = this.newInstance();
         if(_loc1_ != null)
         {
            _loc1_.copyFrom(this);
         }
         return _loc1_;
      }
      
      protected function newInstance() : PhysicalUpdater
      {
         return new PhysicalUpdater();
      }
      
      protected function copyFrom(param1:PhysicalUpdater) : void
      {
         var _loc2_:PhysicalUpdater = param1 as PhysicalUpdater;
         this._target = _loc2_._target;
         this._easing = _loc2_._easing;
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


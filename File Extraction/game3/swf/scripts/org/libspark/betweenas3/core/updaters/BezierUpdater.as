package org.libspark.betweenas3.core.updaters
{
   import flash.utils.Dictionary;
   
   public class BezierUpdater extends AbstractUpdater
   {
      
      protected var _target:Object = null;
      
      protected var _source:Dictionary = new Dictionary();
      
      protected var _destination:Dictionary = new Dictionary();
      
      protected var _controlPoint:Dictionary = new Dictionary();
      
      protected var _relativeMap:Dictionary = new Dictionary();
      
      public function BezierUpdater()
      {
         super();
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      public function addControlPoint(param1:String, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:Array = this._controlPoint[param1] as Array;
         if(_loc4_ == null)
         {
            this._controlPoint[param1] = _loc4_ = [];
         }
         _loc4_.push(param2);
         this._relativeMap["cp." + param1 + "." + _loc4_.length] = param3;
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
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc2_:Object = this._target;
         var _loc3_:Dictionary = this._source;
         var _loc4_:Dictionary = this._destination;
         var _loc5_:Dictionary = this._controlPoint;
         var _loc9_:Dictionary = this._relativeMap;
         for(_loc1_ in _loc3_)
         {
            if(_loc4_[_loc1_] == undefined)
            {
               _loc4_[_loc1_] = _loc2_[_loc1_];
            }
            if(_loc9_["source." + _loc1_])
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
            if(_loc9_["dest." + _loc1_])
            {
               _loc4_[_loc1_] += _loc2_[_loc1_];
            }
         }
         for(_loc1_ in _loc5_)
         {
            _loc6_ = _loc5_[_loc1_] as Array;
            _loc7_ = _loc6_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               if(_loc9_["cp." + _loc1_ + "." + _loc8_])
               {
                  _loc6_[_loc8_] += _loc2_[_loc1_];
               }
               _loc8_++;
            }
         }
      }
      
      override protected function updateObject(param1:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:String = null;
         var _loc2_:Number = 1 - param1;
         var _loc3_:Object = this._target;
         var _loc4_:Dictionary = this._destination;
         var _loc5_:Dictionary = this._source;
         var _loc7_:Dictionary = this._controlPoint;
         for(_loc14_ in _loc4_)
         {
            _loc6_ = Number(_loc5_[_loc14_]);
            if(param1 != 1 && (_loc8_ = this._controlPoint[_loc14_] as Array) != null)
            {
               _loc9_ = _loc8_.length;
               if(_loc9_ == 1)
               {
                  _loc3_[_loc14_] = _loc6_ + param1 * (2 * _loc2_ * (_loc8_[0] - _loc6_) + param1 * (_loc4_[_loc14_] - _loc6_));
               }
               else
               {
                  _loc10_ = uint(param1 * _loc9_ >> 0);
                  _loc11_ = (param1 - _loc10_ * (1 / _loc9_)) * _loc9_;
                  if(_loc10_ == 0)
                  {
                     _loc12_ = _loc6_;
                     _loc13_ = (_loc8_[0] + _loc8_[1]) / 2;
                  }
                  else if(_loc10_ == _loc9_ - 1)
                  {
                     _loc12_ = (_loc8_[_loc10_ - 1] + _loc8_[_loc10_]) / 2;
                     _loc13_ = Number(_loc4_[_loc14_]);
                  }
                  else
                  {
                     _loc12_ = (_loc8_[_loc10_ - 1] + _loc8_[_loc10_]) / 2;
                     _loc13_ = (_loc8_[_loc10_] + _loc8_[_loc10_ + 1]) / 2;
                  }
                  _loc3_[_loc14_] = _loc12_ + _loc11_ * (2 * (1 - _loc11_) * (_loc8_[_loc10_] - _loc12_) + _loc11_ * (_loc13_ - _loc12_));
               }
            }
            else
            {
               _loc3_[_loc14_] = _loc6_ * _loc2_ + _loc4_[_loc14_] * param1;
            }
         }
      }
      
      override protected function newInstance() : AbstractUpdater
      {
         return new BezierUpdater();
      }
      
      override protected function copyFrom(param1:AbstractUpdater) : void
      {
         super.copyFrom(param1);
         var _loc2_:BezierUpdater = param1 as BezierUpdater;
         this._target = _loc2_._target;
         this.copyObject(this._source,_loc2_._source);
         this.copyObject(this._destination,_loc2_._destination);
         this.copyObject(this._controlPoint,_loc2_._controlPoint);
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


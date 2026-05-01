package org.libspark.betweenas3.core.updaters
{
   import flash.utils.Dictionary;
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   
   public class UpdaterFactory
   {
      
      private var _registry:ClassRegistry;
      
      private var _poolIndex:uint = 0;
      
      private var _mapPool:Array = [];
      
      private var _listPool:Array = [];
      
      public function UpdaterFactory(param1:ClassRegistry)
      {
         super();
         this._registry = param1;
      }
      
      public function create(param1:Object, param2:Object, param3:Object) : IUpdater
      {
         var _loc4_:Dictionary = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Boolean = false;
         var _loc9_:IUpdater = null;
         var _loc10_:IUpdater = null;
         var _loc11_:IUpdater = null;
         var _loc12_:* = undefined;
         if(this._poolIndex > 0)
         {
            --this._poolIndex;
            _loc4_ = this._mapPool[this._poolIndex] as Dictionary;
            _loc5_ = this._listPool[this._poolIndex] as Array;
         }
         else
         {
            _loc4_ = new Dictionary();
            _loc5_ = [];
         }
         if(param3 != null)
         {
            for(_loc6_ in param3)
            {
               _loc7_ = param3[_loc6_];
               if(_loc7_ is Number)
               {
                  _loc8_ = /^\$/.test(_loc6_);
                  if(_loc8_)
                  {
                     _loc6_ = _loc6_.substr(1);
                  }
                  this.getUpdaterFor(param1,_loc6_,_loc4_,_loc5_).setSourceValue(_loc6_,Number(_loc7_),_loc8_);
               }
               else
               {
                  _loc9_ = this.getUpdaterFor(param1,_loc6_,_loc4_,_loc5_);
                  _loc10_ = this.create(_loc9_.getObject(_loc6_),param2 != null ? param2[_loc6_] : null,_loc7_);
                  _loc5_.push(new UpdaterLadder(_loc9_,_loc10_,_loc6_));
               }
            }
         }
         if(param2 != null)
         {
            for(_loc6_ in param2)
            {
               _loc7_ = param2[_loc6_];
               if(_loc7_ is Number)
               {
                  _loc8_ = /^\$/.test(_loc6_);
                  if(_loc8_)
                  {
                     _loc6_ = _loc6_.substr(1);
                  }
                  this.getUpdaterFor(param1,_loc6_,_loc4_,_loc5_).setDestinationValue(_loc6_,Number(_loc7_),_loc8_);
               }
               else if(!(param3 != null && _loc6_ in param3))
               {
                  _loc9_ = this.getUpdaterFor(param1,_loc6_,_loc4_,_loc5_);
                  _loc10_ = this.create(_loc9_.getObject(_loc6_),_loc7_,param3 != null ? param3[_loc6_] : null);
                  _loc5_.push(new UpdaterLadder(_loc9_,_loc10_,_loc6_));
               }
            }
         }
         if(_loc5_.length == 1)
         {
            _loc11_ = _loc5_[0] as IUpdater;
         }
         else if(_loc5_.length > 1)
         {
            _loc11_ = new CompositeUpdater(param1,_loc5_);
         }
         for(_loc12_ in _loc4_)
         {
            delete _loc4_[_loc12_];
         }
         _loc5_.length = 0;
         this._mapPool[this._poolIndex] = _loc4_;
         this._listPool[this._poolIndex] = _loc5_;
         ++this._poolIndex;
         return _loc11_;
      }
      
      public function getUpdaterFor(param1:Object, param2:String, param3:Dictionary, param4:Array) : IUpdater
      {
         var _loc6_:IUpdater = null;
         var _loc5_:Class = this._registry.getClassByTargetClassAndPropertyName(param1.constructor,param2);
         if(_loc5_ != null)
         {
            _loc6_ = param3[_loc5_] as IUpdater;
            if(_loc6_ == null)
            {
               _loc6_ = new _loc5_();
               _loc6_.target = param1;
               param3[_loc5_] = _loc6_;
               if(param4 != null)
               {
                  param4.push(_loc6_);
               }
            }
            return _loc6_;
         }
         return null;
      }
      
      public function createBezier(param1:Object, param2:Object, param3:Object, param4:Object) : IUpdater
      {
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:Array = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:IUpdater = null;
         var _loc15_:IUpdater = null;
         var _loc5_:Dictionary = new Dictionary();
         var _loc6_:Array = [];
         var _loc7_:BezierUpdater = new BezierUpdater();
         _loc7_.target = param1;
         _loc6_.push(_loc7_);
         if(param3 != null)
         {
            for(_loc8_ in param3)
            {
               _loc9_ = param3[_loc8_];
               if(_loc9_ is Number)
               {
                  _loc10_ = /^\$/.test(_loc8_);
                  if(_loc10_)
                  {
                     _loc8_ = _loc8_.substr(1);
                  }
                  _loc7_.setSourceValue(_loc8_,Number(_loc9_),_loc10_);
               }
               else if(!_loc5_[_loc8_])
               {
                  _loc14_ = this.createBezier(_loc7_.getObject(_loc8_),param2 != null ? param2[_loc8_] : null,_loc9_,param4 != null ? param4[_loc8_] : null);
                  _loc6_.push(new UpdaterLadder(_loc7_,_loc14_,_loc8_));
                  _loc5_[_loc8_] = true;
               }
            }
         }
         if(param2 != null)
         {
            for(_loc8_ in param2)
            {
               _loc9_ = param2[_loc8_];
               if(_loc9_ is Number)
               {
                  _loc10_ = /^\$/.test(_loc8_);
                  if(_loc10_)
                  {
                     _loc8_ = _loc8_.substr(1);
                  }
                  _loc7_.setDestinationValue(_loc8_,Number(_loc9_),_loc10_);
               }
               else if(!_loc5_[_loc8_])
               {
                  _loc14_ = this.createBezier(_loc7_.getObject(_loc8_),null,param3 != null ? param3[_loc8_] : null,param4 != null ? param4[_loc8_] : null);
                  _loc6_.push(new UpdaterLadder(_loc7_,_loc14_,_loc8_));
                  _loc5_[_loc8_] = true;
               }
            }
         }
         if(param4 != null)
         {
            for(_loc8_ in param4)
            {
               _loc9_ = param4[_loc8_];
               if(_loc9_ is Number)
               {
                  _loc9_ = [_loc9_];
               }
               if(_loc9_ is Array)
               {
                  _loc10_ = /^\$/.test(_loc8_);
                  if(_loc10_)
                  {
                     _loc8_ = _loc8_.substr(1);
                  }
                  _loc11_ = _loc9_ as Array;
                  _loc12_ = _loc11_.length;
                  _loc13_ = 0;
                  while(_loc13_ < _loc12_)
                  {
                     _loc7_.addControlPoint(_loc8_,_loc11_[_loc13_],_loc10_);
                     _loc13_++;
                  }
               }
               else if(!_loc5_[_loc8_])
               {
                  _loc14_ = this.createBezier(_loc7_.getObject(_loc8_),param2 != null ? param2[_loc8_] : null,param3 != null ? param3[_loc8_] : null,_loc9_);
                  _loc6_.push(new UpdaterLadder(_loc7_,_loc14_,_loc8_));
                  _loc5_[_loc8_] = true;
               }
            }
         }
         if(_loc6_.length == 1)
         {
            _loc15_ = _loc6_[0] as IUpdater;
         }
         else if(_loc6_.length > 1)
         {
            _loc15_ = new CompositeUpdater(param1,_loc6_);
         }
         return _loc15_;
      }
      
      public function createPhysical(param1:Object, param2:Object, param3:Object, param4:IPhysicalEasing) : IPhysicalUpdater
      {
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:IPhysicalUpdater = null;
         var _loc12_:IPhysicalUpdater = null;
         var _loc5_:Dictionary = new Dictionary();
         var _loc6_:Array = [];
         var _loc7_:PhysicalUpdater = new PhysicalUpdater();
         _loc7_.target = param1;
         _loc7_.easing = param4;
         _loc6_.push(_loc7_);
         if(param3 != null)
         {
            for(_loc8_ in param3)
            {
               _loc9_ = param3[_loc8_];
               if(_loc9_ is Number)
               {
                  _loc10_ = /^\$/.test(_loc8_);
                  if(_loc10_)
                  {
                     _loc8_ = _loc8_.substr(1);
                  }
                  _loc7_.setSourceValue(_loc8_,Number(_loc9_),_loc10_);
               }
               else if(!_loc5_[_loc8_])
               {
                  _loc11_ = this.createPhysical(_loc7_.getObject(_loc8_),param2 != null ? param2[_loc8_] : null,_loc9_,param4);
                  _loc6_.push(new PhysicalUpdaterLadder(_loc7_,_loc11_,_loc8_));
                  _loc5_[_loc8_] = true;
               }
            }
         }
         if(param2 != null)
         {
            for(_loc8_ in param2)
            {
               _loc9_ = param2[_loc8_];
               if(_loc9_ is Number)
               {
                  _loc10_ = /^\$/.test(_loc8_);
                  if(_loc10_)
                  {
                     _loc8_ = _loc8_.substr(1);
                  }
                  _loc7_.setDestinationValue(_loc8_,Number(_loc9_),_loc10_);
               }
               else if(!_loc5_[_loc8_])
               {
                  _loc11_ = this.createPhysical(_loc7_.getObject(_loc8_),null,param3 != null ? param3[_loc8_] : null,param4);
                  _loc6_.push(new PhysicalUpdaterLadder(_loc7_,_loc11_,_loc8_));
                  _loc5_[_loc8_] = true;
               }
            }
         }
         if(_loc6_.length == 1)
         {
            _loc12_ = _loc6_[0] as IPhysicalUpdater;
         }
         else if(_loc6_.length > 1)
         {
            _loc12_ = new CompositePhysicalUpdater(param1,_loc6_);
         }
         return _loc12_;
      }
   }
}


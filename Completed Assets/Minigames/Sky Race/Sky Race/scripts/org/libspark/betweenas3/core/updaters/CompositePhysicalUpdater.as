package org.libspark.betweenas3.core.updaters
{
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   
   public class CompositePhysicalUpdater implements IPhysicalUpdater
   {
       
      
      private var _target:Object = null;
      
      private var _duration:Number = 0.0;
      
      private var _a:IPhysicalUpdater;
      
      private var _b:IPhysicalUpdater;
      
      private var _c:IPhysicalUpdater;
      
      private var _d:IPhysicalUpdater;
      
      private var _updaters:Array;
      
      public function CompositePhysicalUpdater(param1:Object, param2:Array)
      {
         var _loc4_:uint = 0;
         var _loc5_:IPhysicalUpdater = null;
         super();
         this._target = param1;
         var _loc3_:uint = param2.length;
         if(_loc3_ >= 1)
         {
            this._a = param2[0];
            if(this._duration < this._a.duration)
            {
               this._duration = this._a.duration;
            }
            if(_loc3_ >= 2)
            {
               this._b = param2[1];
               if(this._duration < this._b.duration)
               {
                  this._duration = this._b.duration;
               }
               if(_loc3_ >= 3)
               {
                  this._c = param2[2];
                  if(this._duration < this._c.duration)
                  {
                     this._duration = this._c.duration;
                  }
                  if(_loc3_ >= 4)
                  {
                     this._d = param2[3];
                     if(this._duration < this._d.duration)
                     {
                        this._duration = this._d.duration;
                     }
                     if(_loc3_ >= 5)
                     {
                        this._updaters = new Array(_loc3_ - 4);
                        _loc4_ = 4;
                        while(_loc4_ < _loc3_)
                        {
                           _loc5_ = param2[_loc4_] as IPhysicalUpdater;
                           this._updaters[_loc4_ - 4] = _loc5_;
                           if(this._duration < _loc5_.duration)
                           {
                              this._duration = _loc5_.duration;
                           }
                           _loc4_++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function getUpdaterAt(param1:uint) : IPhysicalUpdater
      {
         if(param1 == 0)
         {
            return this._a;
         }
         if(param1 == 1)
         {
            return this._b;
         }
         if(param1 == 2)
         {
            return this._c;
         }
         if(param1 == 3)
         {
            return this._d;
         }
         return this._updaters[param1 - 4];
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
         return null;
      }
      
      public function set easing(param1:IPhysicalEasing) : void
      {
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function getObject(param1:String) : Object
      {
         return null;
      }
      
      public function setObject(param1:String, param2:Object) : void
      {
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this._a != null)
         {
            this._a.update(param1);
            if(this._b != null)
            {
               this._b.update(param1);
               if(this._c != null)
               {
                  this._c.update(param1);
                  if(this._d != null)
                  {
                     this._d.update(param1);
                     if(this._updaters != null)
                     {
                        _loc2_ = this._updaters;
                        _loc3_ = _loc2_.length;
                        _loc4_ = 0;
                        while(_loc4_ < _loc3_)
                        {
                           (_loc2_[_loc4_] as IPhysicalUpdater).update(param1);
                           _loc4_++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function clone() : IUpdater
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Array = [];
         if(this._a != null)
         {
            _loc1_.push(this._a.clone());
            if(this._b != null)
            {
               _loc1_.push(this._b.clone());
               if(this._c != null)
               {
                  _loc1_.push(this._c.clone());
                  if(this._d != null)
                  {
                     _loc1_.push(this._d.clone());
                     if(this._updaters != null)
                     {
                        _loc2_ = this._updaters;
                        _loc3_ = _loc2_.length;
                        _loc4_ = 0;
                        while(_loc4_ < _loc3_)
                        {
                           _loc1_.push(_loc2_[_loc4_].clone());
                           _loc4_++;
                        }
                     }
                  }
               }
            }
         }
         return new CompositePhysicalUpdater(this._target,_loc1_);
      }
   }
}

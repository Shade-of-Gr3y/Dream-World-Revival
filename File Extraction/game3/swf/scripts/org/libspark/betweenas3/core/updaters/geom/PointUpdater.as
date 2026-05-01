package org.libspark.betweenas3.core.updaters.geom
{
   import flash.geom.Point;
   import org.libspark.betweenas3.core.updaters.AbstractUpdater;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   
   public class PointUpdater extends AbstractUpdater
   {
      
      public static const TARGET_PROPERTIES:Array = ["x","y"];
      
      protected var _target:Point = null;
      
      protected var _fx:Boolean = false;
      
      protected var _sx:Number;
      
      protected var _dx:Number;
      
      protected var _fy:Boolean = false;
      
      protected var _sy:Number;
      
      protected var _dy:Number;
      
      protected var _flags:uint = 0;
      
      public function PointUpdater()
      {
         super();
      }
      
      public static function register(param1:ClassRegistry) : void
      {
         param1.registerClassWithTargetClassAndPropertyNames(PointUpdater,Point,TARGET_PROPERTIES);
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function set target(param1:Object) : void
      {
         this._target = param1 as Point;
      }
      
      override public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "x")
         {
            this._fx = true;
            this._sx = param2;
            this._flags |= param3 ? 1 : 0;
         }
         else if(param1 == "y")
         {
            this._fy = true;
            this._sy = param2;
            this._flags |= param3 ? 4 : 0;
         }
      }
      
      override public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "x")
         {
            this._fx = true;
            this._dx = param2;
            this._flags |= param3 ? 2 : 0;
         }
         else if(param1 == "y")
         {
            this._fy = true;
            this._dy = param2;
            this._flags |= param3 ? 8 : 0;
         }
      }
      
      override protected function resolveValues() : void
      {
         var _loc1_:Point = this._target;
         if(this._fx)
         {
            if(isNaN(this._sx))
            {
               this._sx = _loc1_.x;
            }
            else if((this._flags & 1) != 0)
            {
               this._sx += _loc1_.x;
            }
            if(isNaN(this._dx))
            {
               this._dx = _loc1_.x;
            }
            else if((this._flags & 2) != 0)
            {
               this._dx += _loc1_.x;
            }
         }
         if(this._fy)
         {
            if(isNaN(this._sy))
            {
               this._sy = _loc1_.y;
            }
            else if((this._flags & 4) != 0)
            {
               this._sy += _loc1_.y;
            }
            if(isNaN(this._dy))
            {
               this._dy = _loc1_.y;
            }
            else if((this._flags & 8) != 0)
            {
               this._dy += _loc1_.y;
            }
         }
      }
      
      override protected function updateObject(param1:Number) : void
      {
         var _loc2_:Point = this._target;
         var _loc3_:Number = 1 - param1;
         if(this._fx)
         {
            _loc2_.x = this._sx * _loc3_ + this._dx * param1;
         }
         if(this._fy)
         {
            _loc2_.y = this._sy * _loc3_ + this._dy * param1;
         }
      }
      
      override protected function newInstance() : AbstractUpdater
      {
         return new PointUpdater();
      }
      
      override protected function copyFrom(param1:AbstractUpdater) : void
      {
         super.copyFrom(param1);
         var _loc2_:PointUpdater = param1 as PointUpdater;
         this._target = _loc2_._target;
         this._sx = _loc2_._sx;
         this._sy = _loc2_._sy;
         this._dx = _loc2_._dx;
         this._dy = _loc2_._dy;
         this._fx = _loc2_._fx;
         this._fy = _loc2_._fy;
         this._flags = _loc2_._flags;
      }
   }
}


package org.libspark.betweenas3.core.updaters.display
{
   import flash.display.MovieClip;
   import org.libspark.betweenas3.core.updaters.AbstractUpdater;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   
   public class MovieClipUpdater extends AbstractUpdater
   {
      
      public static const TARGET_PROPERTIES:Array = ["_frame"];
      
      protected var _target:MovieClip = null;
      
      protected var _source:MovieClipParameter = new MovieClipParameter();
      
      protected var _destination:MovieClipParameter = new MovieClipParameter();
      
      protected var _flags:uint = 0;
      
      public function MovieClipUpdater()
      {
         super();
      }
      
      public static function register(param1:ClassRegistry) : void
      {
         param1.registerClassWithTargetClassAndPropertyNames(MovieClipUpdater,MovieClip,TARGET_PROPERTIES);
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function set target(param1:Object) : void
      {
         this._target = param1 as MovieClip;
      }
      
      override public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "_frame")
         {
            this._flags |= 1;
            this._source.relativeFlags |= param3 ? 1 : 0;
            this._source.frame = param2;
         }
      }
      
      override public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "_frame")
         {
            this._flags |= 1;
            this._destination.relativeFlags |= param3 ? 1 : 0;
            this._destination.frame = param2;
         }
      }
      
      override protected function resolveValues() : void
      {
         var _loc1_:MovieClip = this._target;
         var _loc2_:MovieClipParameter = this._destination;
         var _loc3_:MovieClipParameter = this._source;
         var _loc4_:uint = this._flags;
         if((_loc4_ & 1) != 0)
         {
            if(isNaN(_loc3_.frame))
            {
               _loc3_.frame = _loc1_.currentFrame;
            }
            else if((_loc3_.relativeFlags & 1) != 0)
            {
               _loc3_.frame += _loc1_.currentFrame;
            }
            if(isNaN(_loc2_.frame))
            {
               _loc2_.frame = _loc1_.currentFrame;
            }
            else if((_loc2_.relativeFlags & 1) != 0)
            {
               _loc2_.frame += _loc1_.currentFrame;
            }
         }
      }
      
      override protected function updateObject(param1:Number) : void
      {
         var _loc2_:MovieClip = this._target;
         var _loc3_:MovieClipParameter = this._destination;
         var _loc4_:MovieClipParameter = this._source;
         var _loc5_:uint = this._flags;
         var _loc6_:Number = 1 - param1;
         if((_loc5_ & 1) != 0)
         {
            _loc2_.gotoAndStop(Math.round(_loc4_.frame * _loc6_ + _loc3_.frame * param1));
         }
      }
      
      override protected function newInstance() : AbstractUpdater
      {
         return new MovieClipUpdater();
      }
      
      override protected function copyFrom(param1:AbstractUpdater) : void
      {
         super.copyFrom(param1);
         var _loc2_:MovieClipUpdater = param1 as MovieClipUpdater;
         this._target = _loc2_._target;
         this._source.copyFrom(_loc2_._source);
         this._destination.copyFrom(_loc2_._destination);
         this._flags = _loc2_._flags;
      }
   }
}

class MovieClipParameter
{
   
   public var relativeFlags:uint = 0;
   
   public var frame:Number;
   
   public function MovieClipParameter()
   {
      super();
   }
   
   public function copyFrom(param1:MovieClipParameter) : void
   {
      this.relativeFlags = param1.relativeFlags;
      this.frame = param1.frame;
   }
}

package org.libspark.betweenas3.core.updaters.display
{
   import flash.display.DisplayObject;
   import flash.filters.BevelFilter;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ConvolutionFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientBevelFilter;
   import flash.filters.GradientGlowFilter;
   import org.libspark.betweenas3.core.updaters.AbstractUpdater;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   
   public class DisplayObjectUpdater extends AbstractUpdater
   {
      
      public static const TARGET_PROPERTIES:Array = ["x","y","scaleX","scaleY","rotation","alpha","width","height","_bevelFilter","_blurFilter","_colorMatrixFilter","_convolutionFilter","_displacementMapFilter","_dropShadowFilter","_glowFilter","_gradientBevelFilter","_gradientGlowFilter"];
       
      
      protected var _target:DisplayObject = null;
      
      protected var _source:DisplayObjectParameter;
      
      protected var _destination:DisplayObjectParameter;
      
      protected var _flags:uint = 0;
      
      public function DisplayObjectUpdater()
      {
         this._source = new DisplayObjectParameter();
         this._destination = new DisplayObjectParameter();
         super();
      }
      
      public static function register(param1:ClassRegistry) : void
      {
         param1.registerClassWithTargetClassAndPropertyNames(DisplayObjectUpdater,DisplayObject,TARGET_PROPERTIES);
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function set target(param1:Object) : void
      {
         this._target = param1 as DisplayObject;
      }
      
      override public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "x")
         {
            this._flags = this._flags | 1;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?1:0);
            this._source.x = param2;
         }
         else if(param1 == "y")
         {
            this._flags = this._flags | 2;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?2:0);
            this._source.y = param2;
         }
         else if(param1 == "scaleX")
         {
            this._flags = this._flags | 8;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?8:0);
            this._source.scaleX = param2;
         }
         else if(param1 == "scaleY")
         {
            this._flags = this._flags | 16;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?16:0);
            this._source.scaleY = param2;
         }
         else if(param1 == "rotation")
         {
            this._flags = this._flags | 64;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?64:0);
            this._source.rotation = param2;
         }
         else if(param1 == "alpha")
         {
            this._flags = this._flags | 1024;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?1024:0);
            this._source.alpha = param2;
         }
         else if(param1 == "width")
         {
            this._flags = this._flags | 2048;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?2048:0);
            this._source.width = param2;
         }
         else if(param1 == "height")
         {
            this._flags = this._flags | 4096;
            this._source.relativeFlags = this._source.relativeFlags | (!!param3?4096:0);
            this._source.height = param2;
         }
      }
      
      override public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(param1 == "x")
         {
            this._flags = this._flags | 1;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?1:0);
            this._destination.x = param2;
         }
         else if(param1 == "y")
         {
            this._flags = this._flags | 2;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?2:0);
            this._destination.y = param2;
         }
         else if(param1 == "scaleX")
         {
            this._flags = this._flags | 8;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?8:0);
            this._destination.scaleX = param2;
         }
         else if(param1 == "scaleY")
         {
            this._flags = this._flags | 16;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?16:0);
            this._destination.scaleY = param2;
         }
         else if(param1 == "rotation")
         {
            this._flags = this._flags | 64;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?64:0);
            this._destination.rotation = param2;
         }
         else if(param1 == "alpha")
         {
            this._flags = this._flags | 1024;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?1024:0);
            this._destination.alpha = param2;
         }
         else if(param1 == "width")
         {
            this._flags = this._flags | 2048;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?2048:0);
            this._destination.width = param2;
         }
         else if(param1 == "height")
         {
            this._flags = this._flags | 4096;
            this._destination.relativeFlags = this._destination.relativeFlags | (!!param3?4096:0);
            this._destination.height = param2;
         }
      }
      
      override public function getObject(param1:String) : Object
      {
         if(param1 == "_blurFilter")
         {
            return this.getFilterByClass(BlurFilter);
         }
         if(param1 == "_glowFilter")
         {
            return this.getFilterByClass(GlowFilter);
         }
         if(param1 == "_dropShadowFilter")
         {
            return this.getFilterByClass(DropShadowFilter);
         }
         if(param1 == "_colorMatrixFilter")
         {
            return this.getFilterByClass(ColorMatrixFilter);
         }
         if(param1 == "_bevelFilter")
         {
            return this.getFilterByClass(BevelFilter);
         }
         if(param1 == "_gradientGlowFilter")
         {
            return this.getFilterByClass(GradientGlowFilter);
         }
         if(param1 == "_gradientBevelFilter")
         {
            return this.getFilterByClass(GradientBevelFilter);
         }
         if(param1 == "_convolutionFilter")
         {
            return this.getFilterByClass(ConvolutionFilter);
         }
         if(param1 == "_displacementMapFilter")
         {
            return this.getFilterByClass(DisplacementMapFilter);
         }
         return null;
      }
      
      protected function getFilterByClass(param1:Class) : BitmapFilter
      {
         var _loc2_:BitmapFilter = null;
         var _loc3_:Array = this._target.filters;
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc2_ = _loc3_[_loc5_] as BitmapFilter) is param1)
            {
               return _loc2_;
            }
            _loc5_++;
         }
         _loc2_ = new param1();
         _loc3_.push(_loc2_);
         this._target.filters = _loc3_;
         return _loc2_;
      }
      
      override public function setObject(param1:String, param2:Object) : void
      {
         if(param1 == "_blurFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,BlurFilter);
            return;
         }
         if(param1 == "_glowFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,GlowFilter);
            return;
         }
         if(param1 == "_dropShadowFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,DropShadowFilter);
            return;
         }
         if(param1 == "_colorMatrixFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,ColorMatrixFilter);
            return;
         }
         if(param1 == "_bevelFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,BevelFilter);
            return;
         }
         if(param1 == "_gradientGlowFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,GradientGlowFilter);
            return;
         }
         if(param1 == "_gradientBevelFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,GradientBevelFilter);
            return;
         }
         if(param1 == "_convolutionFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,ConvolutionFilter);
            return;
         }
         if(param1 == "_displacementMapFilter")
         {
            this.setFilterByClass(param2 as BitmapFilter,DisplacementMapFilter);
            return;
         }
      }
      
      protected function setFilterByClass(param1:BitmapFilter, param2:Class) : void
      {
         var _loc3_:Array = this._target.filters;
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_] is param2)
            {
               _loc3_[_loc5_] = param1;
               this._target.filters = _loc3_;
               return;
            }
            _loc5_++;
         }
         _loc3_.push(param1);
         this._target.filters = _loc3_;
      }
      
      override protected function resolveValues() : void
      {
         var _loc1_:DisplayObject = this._target;
         var _loc2_:DisplayObjectParameter = this._destination;
         var _loc3_:DisplayObjectParameter = this._source;
         var _loc4_:uint = this._flags;
         if((_loc4_ & 1) != 0)
         {
            if(isNaN(_loc3_.x))
            {
               _loc3_.x = _loc1_.x;
            }
            else if((_loc3_.relativeFlags & 1) != 0)
            {
               _loc3_.x = _loc3_.x + _loc1_.x;
            }
            if(isNaN(_loc2_.x))
            {
               _loc2_.x = _loc1_.x;
            }
            else if((_loc2_.relativeFlags & 1) != 0)
            {
               _loc2_.x = _loc2_.x + _loc1_.x;
            }
         }
         if((_loc4_ & 2) != 0)
         {
            if(isNaN(_loc3_.y))
            {
               _loc3_.y = _loc1_.y;
            }
            else if((_loc3_.relativeFlags & 2) != 0)
            {
               _loc3_.y = _loc3_.y + _loc1_.y;
            }
            if(isNaN(_loc2_.y))
            {
               _loc2_.y = _loc1_.y;
            }
            else if((_loc2_.relativeFlags & 2) != 0)
            {
               _loc2_.y = _loc2_.y + _loc1_.y;
            }
         }
         if((_loc4_ & 8) != 0)
         {
            if(isNaN(_loc3_.scaleX))
            {
               _loc3_.scaleX = _loc1_.scaleX;
            }
            else if((_loc3_.relativeFlags & 8) != 0)
            {
               _loc3_.scaleX = _loc3_.scaleX + _loc1_.scaleX;
            }
            if(isNaN(_loc2_.scaleX))
            {
               _loc2_.scaleX = _loc1_.scaleX;
            }
            else if((_loc2_.relativeFlags & 8) != 0)
            {
               _loc2_.scaleX = _loc2_.scaleX + _loc1_.scaleX;
            }
         }
         if((_loc4_ & 16) != 0)
         {
            if(isNaN(_loc3_.scaleY))
            {
               _loc3_.scaleY = _loc1_.scaleY;
            }
            else if((_loc3_.relativeFlags & 16) != 0)
            {
               _loc3_.scaleY = _loc3_.scaleY + _loc1_.scaleY;
            }
            if(isNaN(_loc2_.scaleY))
            {
               _loc2_.scaleY = _loc1_.scaleY;
            }
            else if((_loc2_.relativeFlags & 16) != 0)
            {
               _loc2_.scaleY = _loc2_.scaleY + _loc1_.scaleY;
            }
         }
         if((_loc4_ & 64) != 0)
         {
            if(isNaN(_loc3_.rotation))
            {
               _loc3_.rotation = _loc1_.rotation;
            }
            else if((_loc3_.relativeFlags & 64) != 0)
            {
               _loc3_.rotation = _loc3_.rotation + _loc1_.rotation;
            }
            if(isNaN(_loc2_.rotation))
            {
               _loc2_.rotation = _loc1_.rotation;
            }
            else if((_loc2_.relativeFlags & 64) != 0)
            {
               _loc2_.rotation = _loc2_.rotation + _loc1_.rotation;
            }
         }
         if((_loc4_ & 1024) != 0)
         {
            if(isNaN(_loc3_.alpha))
            {
               _loc3_.alpha = _loc1_.alpha;
            }
            else if((_loc3_.relativeFlags & 1024) != 0)
            {
               _loc3_.alpha = _loc3_.alpha + _loc1_.alpha;
            }
            if(isNaN(_loc2_.alpha))
            {
               _loc2_.alpha = _loc1_.alpha;
            }
            else if((_loc2_.relativeFlags & 1024) != 0)
            {
               _loc2_.alpha = _loc2_.alpha + _loc1_.alpha;
            }
         }
         if((_loc4_ & 2048) != 0)
         {
            if(isNaN(_loc3_.width))
            {
               _loc3_.width = _loc1_.width;
            }
            else if((_loc3_.relativeFlags & 2048) != 0)
            {
               _loc3_.width = _loc3_.width + _loc1_.width;
            }
            if(isNaN(_loc2_.width))
            {
               _loc2_.width = _loc1_.width;
            }
            else if((_loc2_.relativeFlags & 2048) != 0)
            {
               _loc2_.width = _loc2_.width + _loc1_.width;
            }
         }
         if((_loc4_ & 4096) != 0)
         {
            if(isNaN(_loc3_.height))
            {
               _loc3_.height = _loc1_.height;
            }
            else if((_loc3_.relativeFlags & 4096) != 0)
            {
               _loc3_.height = _loc3_.height + _loc1_.height;
            }
            if(isNaN(_loc2_.height))
            {
               _loc2_.height = _loc1_.height;
            }
            else if((_loc2_.relativeFlags & 4096) != 0)
            {
               _loc2_.height = _loc2_.height + _loc1_.height;
            }
         }
      }
      
      override protected function updateObject(param1:Number) : void
      {
         var _loc2_:DisplayObject = this._target;
         var _loc3_:DisplayObjectParameter = this._destination;
         var _loc4_:DisplayObjectParameter = this._source;
         var _loc5_:uint = this._flags;
         var _loc6_:Number = 1 - param1;
         if((_loc5_ & 1) != 0)
         {
            _loc2_.x = _loc4_.x * _loc6_ + _loc3_.x * param1;
         }
         if((_loc5_ & 2) != 0)
         {
            _loc2_.y = _loc4_.y * _loc6_ + _loc3_.y * param1;
         }
         if((_loc5_ & 56) != 0)
         {
            if((_loc5_ & 8) != 0)
            {
               _loc2_.scaleX = _loc4_.scaleX * _loc6_ + _loc3_.scaleX * param1;
            }
            if((_loc5_ & 16) != 0)
            {
               _loc2_.scaleY = _loc4_.scaleY * _loc6_ + _loc3_.scaleY * param1;
            }
         }
         if((_loc5_ & 960) != 0)
         {
            if((_loc5_ & 64) != 0)
            {
               _loc2_.rotation = _loc4_.rotation * _loc6_ + _loc3_.rotation * param1;
            }
         }
         if((_loc5_ & 7168) != 0)
         {
            if((_loc5_ & 1024) != 0)
            {
               _loc2_.alpha = _loc4_.alpha * _loc6_ + _loc3_.alpha * param1;
            }
            if((_loc5_ & 2048) != 0)
            {
               _loc2_.width = _loc4_.width * _loc6_ + _loc3_.width * param1;
            }
            if((_loc5_ & 4096) != 0)
            {
               _loc2_.height = _loc4_.height * _loc6_ + _loc3_.height * param1;
            }
         }
      }
      
      override protected function newInstance() : AbstractUpdater
      {
         return new DisplayObjectUpdater();
      }
      
      override protected function copyFrom(param1:AbstractUpdater) : void
      {
         super.copyFrom(param1);
         var _loc2_:DisplayObjectUpdater = param1 as DisplayObjectUpdater;
         this._target = _loc2_._target;
         this._source.copyFrom(_loc2_._source);
         this._destination.copyFrom(_loc2_._destination);
         this._flags = _loc2_._flags;
      }
   }
}

class DisplayObjectParameter
{
    
   
   public var relativeFlags:uint = 0;
   
   public var x:Number;
   
   public var y:Number;
   
   public var scaleX:Number;
   
   public var scaleY:Number;
   
   public var rotation:Number;
   
   public var alpha:Number;
   
   public var width:Number;
   
   public var height:Number;
   
   function DisplayObjectParameter()
   {
      super();
   }
   
   public function copyFrom(param1:DisplayObjectParameter) : void
   {
      this.relativeFlags = param1.relativeFlags;
      this.x = param1.x;
      this.y = param1.y;
      this.scaleX = param1.scaleX;
      this.scaleY = param1.scaleY;
      this.rotation = param1.rotation;
      this.alpha = param1.alpha;
      this.width = param1.width;
      this.height = param1.height;
   }
}

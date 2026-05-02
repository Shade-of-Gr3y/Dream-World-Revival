package caurina.transitions.properties
{
   import caurina.transitions.AuxFunctions;
   import caurina.transitions.Tweener;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class ColorShortcuts
   {
      
      private static var LUMINANCE_R:Number = 0.212671;
      
      private static var LUMINANCE_G:Number = 0.71516;
      
      private static var LUMINANCE_B:Number = 0.072169;
      
      public function ColorShortcuts()
      {
         super();
         trace("This is an static class and should not be instantiated.");
      }
      
      public static function _color_splitter(param1:*, param2:Array) : Array
      {
         var _loc3_:Array = new Array();
         if(param1 == null)
         {
            _loc3_.push({
               "name":"_color_redMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_redOffset",
               "value":0
            });
            _loc3_.push({
               "name":"_color_greenMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_greenOffset",
               "value":0
            });
            _loc3_.push({
               "name":"_color_blueMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_blueOffset",
               "value":0
            });
         }
         else
         {
            _loc3_.push({
               "name":"_color_redMultiplier",
               "value":0
            });
            _loc3_.push({
               "name":"_color_redOffset",
               "value":AuxFunctions.numberToR(param1)
            });
            _loc3_.push({
               "name":"_color_greenMultiplier",
               "value":0
            });
            _loc3_.push({
               "name":"_color_greenOffset",
               "value":AuxFunctions.numberToG(param1)
            });
            _loc3_.push({
               "name":"_color_blueMultiplier",
               "value":0
            });
            _loc3_.push({
               "name":"_color_blueOffset",
               "value":AuxFunctions.numberToB(param1)
            });
         }
         return _loc3_;
      }
      
      public static function _contrast_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc5_ = param2 + 1;
         _loc6_ = Math.round(param2 * -128);
         var _loc7_:ColorTransform = new ColorTransform(_loc5_,_loc5_,_loc5_,1,_loc6_,_loc6_,_loc6_,0);
         param1.transform.colorTransform = _loc7_;
      }
      
      public static function _brightness_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc4_:Boolean = Boolean(param2[0]);
         var _loc5_:ColorTransform = param1.transform.colorTransform;
         var _loc6_:Number = 1 - (_loc5_.redMultiplier + _loc5_.greenMultiplier + _loc5_.blueMultiplier) / 3;
         var _loc7_:Number = (_loc5_.redOffset + _loc5_.greenOffset + _loc5_.blueOffset) / 3;
         if(_loc4_)
         {
            return _loc7_ > 0 ? _loc7_ / 255 : -_loc6_;
         }
         return _loc7_ / 100;
      }
      
      public static function _saturation_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc4_:Array = getObjectMatrix(param1);
         var _loc5_:Boolean = Boolean(param2[0]);
         var _loc6_:Number = _loc5_ ? 1 / 3 : LUMINANCE_R;
         var _loc7_:Number = _loc5_ ? 1 / 3 : LUMINANCE_G;
         var _loc8_:Number = _loc5_ ? 1 / 3 : LUMINANCE_B;
         var _loc9_:Number = ((_loc4_[0] - _loc6_) / (1 - _loc6_) + (_loc4_[6] - _loc7_) / (1 - _loc7_) + (_loc4_[12] - _loc8_) / (1 - _loc8_)) / 3;
         var _loc10_:Number = 1 - (_loc4_[1] / _loc7_ + _loc4_[2] / _loc8_ + _loc4_[5] / _loc6_ + _loc4_[7] / _loc8_ + _loc4_[10] / _loc6_ + _loc4_[11] / _loc7_) / 6;
         return (_loc9_ + _loc10_) / 2;
      }
      
      public static function _oldColor_property_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return param1.transform.colorTransform[param2[0]] * 100;
      }
      
      public static function _brightness_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Boolean = Boolean(param3[0]);
         if(_loc5_)
         {
            _loc6_ = 1 - Math.abs(param2);
            _loc7_ = param2 > 0 ? Math.round(param2 * 255) : 0;
         }
         else
         {
            _loc6_ = 1;
            _loc7_ = Math.round(param2 * 100);
         }
         var _loc8_:ColorTransform = new ColorTransform(_loc6_,_loc6_,_loc6_,1,_loc7_,_loc7_,_loc7_,0);
         param1.transform.colorTransform = _loc8_;
      }
      
      public static function _saturation_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc5_:Boolean = Boolean(param3[0]);
         var _loc6_:Number = _loc5_ ? 1 / 3 : LUMINANCE_R;
         var _loc7_:Number = _loc5_ ? 1 / 3 : LUMINANCE_G;
         var _loc8_:Number = _loc5_ ? 1 / 3 : LUMINANCE_B;
         var _loc9_:Number = param2;
         var _loc10_:Number = 1 - _loc9_;
         var _loc11_:Number = _loc6_ * _loc10_;
         var _loc12_:Number = _loc7_ * _loc10_;
         var _loc13_:Number = _loc8_ * _loc10_;
         var _loc14_:Array = [_loc11_ + _loc9_,_loc12_,_loc13_,0,0,_loc11_,_loc12_ + _loc9_,_loc13_,0,0,_loc11_,_loc12_,_loc13_ + _loc9_,0,0,0,0,0,1,0];
         setObjectMatrix(param1,_loc14_);
      }
      
      private static function getObjectMatrix(param1:Object) : Array
      {
         var _loc2_:Number = 0;
         while(_loc2_ < param1.filters.length)
         {
            if(param1.filters[_loc2_] is ColorMatrixFilter)
            {
               return param1.filters[_loc2_].matrix.concat();
            }
            _loc2_++;
         }
         return [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      }
      
      public static function getHueDistance(param1:Array, param2:Array) : Number
      {
         return Math.abs(param1[0] - param2[0]) + Math.abs(param1[1] - param2[1]) + Math.abs(param1[2] - param2[2]);
      }
      
      public static function _hue_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         setObjectMatrix(param1,getHueMatrix(param2));
      }
      
      public static function _hue_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Array = getObjectMatrix(param1);
         var _loc5_:Array = [];
         _loc5_[0] = {
            "angle":-179.9,
            "matrix":getHueMatrix(-179.9)
         };
         _loc5_[1] = {
            "angle":180,
            "matrix":getHueMatrix(180)
         };
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc5_[_loc6_].distance = getHueDistance(_loc4_,_loc5_[_loc6_].matrix);
            _loc6_++;
         }
         var _loc7_:Number = 15;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(_loc5_[0].distance < _loc5_[1].distance)
            {
               _loc8_ = 1;
            }
            else
            {
               _loc8_ = 0;
            }
            _loc5_[_loc8_].angle = (_loc5_[0].angle + _loc5_[1].angle) / 2;
            _loc5_[_loc8_].matrix = getHueMatrix(_loc5_[_loc8_].angle);
            _loc5_[_loc8_].distance = getHueDistance(_loc4_,_loc5_[_loc8_].matrix);
            _loc6_++;
         }
         return _loc5_[_loc8_].angle;
      }
      
      public static function getHueMatrix(param1:Number) : Array
      {
         var _loc2_:Number = param1 * Math.PI / 180;
         var _loc3_:Number = LUMINANCE_R;
         var _loc4_:Number = LUMINANCE_G;
         var _loc5_:Number = LUMINANCE_B;
         var _loc6_:Number = Math.cos(_loc2_);
         var _loc7_:Number = Math.sin(_loc2_);
         return [_loc3_ + _loc6_ * (1 - _loc3_) + _loc7_ * -_loc3_,_loc4_ + _loc6_ * -_loc4_ + _loc7_ * -_loc4_,_loc5_ + _loc6_ * -_loc5_ + _loc7_ * (1 - _loc5_),0,0,_loc3_ + _loc6_ * -_loc3_ + _loc7_ * 0.143,_loc4_ + _loc6_ * (1 - _loc4_) + _loc7_ * 0.14,_loc5_ + _loc6_ * -_loc5_ + _loc7_ * -0.283,0,0,_loc3_ + _loc6_ * -_loc3_ + _loc7_ * -(1 - _loc3_),_loc4_ + _loc6_ * -_loc4_ + _loc7_ * _loc4_,_loc5_ + _loc6_ * (1 - _loc5_) + _loc7_ * _loc5_,0,0,0,0,0,1,0];
      }
      
      public static function _color_property_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return param1.transform.colorTransform[param2[0]];
      }
      
      public static function init() : void
      {
         Tweener.registerSpecialProperty("_color_ra",_oldColor_property_get,_oldColor_property_set,["redMultiplier"]);
         Tweener.registerSpecialProperty("_color_rb",_color_property_get,_color_property_set,["redOffset"]);
         Tweener.registerSpecialProperty("_color_ga",_oldColor_property_get,_oldColor_property_set,["greenMultiplier"]);
         Tweener.registerSpecialProperty("_color_gb",_color_property_get,_color_property_set,["greenOffset"]);
         Tweener.registerSpecialProperty("_color_ba",_oldColor_property_get,_oldColor_property_set,["blueMultiplier"]);
         Tweener.registerSpecialProperty("_color_bb",_color_property_get,_color_property_set,["blueOffset"]);
         Tweener.registerSpecialProperty("_color_aa",_oldColor_property_get,_oldColor_property_set,["alphaMultiplier"]);
         Tweener.registerSpecialProperty("_color_ab",_color_property_get,_color_property_set,["alphaOffset"]);
         Tweener.registerSpecialProperty("_color_redMultiplier",_color_property_get,_color_property_set,["redMultiplier"]);
         Tweener.registerSpecialProperty("_color_redOffset",_color_property_get,_color_property_set,["redOffset"]);
         Tweener.registerSpecialProperty("_color_greenMultiplier",_color_property_get,_color_property_set,["greenMultiplier"]);
         Tweener.registerSpecialProperty("_color_greenOffset",_color_property_get,_color_property_set,["greenOffset"]);
         Tweener.registerSpecialProperty("_color_blueMultiplier",_color_property_get,_color_property_set,["blueMultiplier"]);
         Tweener.registerSpecialProperty("_color_blueOffset",_color_property_get,_color_property_set,["blueOffset"]);
         Tweener.registerSpecialProperty("_color_alphaMultiplier",_color_property_get,_color_property_set,["alphaMultiplier"]);
         Tweener.registerSpecialProperty("_color_alphaOffset",_color_property_get,_color_property_set,["alphaOffset"]);
         Tweener.registerSpecialPropertySplitter("_color",_color_splitter);
         Tweener.registerSpecialPropertySplitter("_colorTransform",_colorTransform_splitter);
         Tweener.registerSpecialProperty("_brightness",_brightness_get,_brightness_set,[false]);
         Tweener.registerSpecialProperty("_tintBrightness",_brightness_get,_brightness_set,[true]);
         Tweener.registerSpecialProperty("_contrast",_contrast_get,_contrast_set);
         Tweener.registerSpecialProperty("_hue",_hue_get,_hue_set);
         Tweener.registerSpecialProperty("_saturation",_saturation_get,_saturation_set,[false]);
         Tweener.registerSpecialProperty("_dumbSaturation",_saturation_get,_saturation_set,[true]);
      }
      
      private static function setObjectMatrix(param1:Object, param2:Array) : void
      {
         var _loc6_:ColorMatrixFilter = null;
         var _loc3_:Array = param1.filters.concat();
         var _loc4_:Boolean = false;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_] is ColorMatrixFilter)
            {
               _loc3_[_loc5_].matrix = param2.concat();
               _loc4_ = true;
            }
            _loc5_++;
         }
         if(!_loc4_)
         {
            _loc6_ = new ColorMatrixFilter(param2);
            _loc3_[_loc3_.length] = _loc6_;
         }
         param1.filters = _loc3_;
      }
      
      public static function _color_property_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc5_:ColorTransform = param1.transform.colorTransform;
         _loc5_[param3[0]] = param2;
         param1.transform.colorTransform = _loc5_;
      }
      
      public static function _oldColor_property_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc5_:ColorTransform = param1.transform.colorTransform;
         _loc5_[param3[0]] = param2 / 100;
         param1.transform.colorTransform = _loc5_;
      }
      
      public static function _contrast_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:ColorTransform = param1.transform.colorTransform;
         _loc5_ = (_loc4_.redMultiplier + _loc4_.greenMultiplier + _loc4_.blueMultiplier) / 3 - 1;
         _loc6_ = (_loc4_.redOffset + _loc4_.greenOffset + _loc4_.blueOffset) / 3 / -128;
         return (_loc5_ + _loc6_) / 2;
      }
      
      public static function _colorTransform_splitter(param1:Object, param2:Array) : Array
      {
         var _loc3_:Array = new Array();
         if(param1 == null)
         {
            _loc3_.push({
               "name":"_color_redMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_redOffset",
               "value":0
            });
            _loc3_.push({
               "name":"_color_greenMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_greenOffset",
               "value":0
            });
            _loc3_.push({
               "name":"_color_blueMultiplier",
               "value":1
            });
            _loc3_.push({
               "name":"_color_blueOffset",
               "value":0
            });
         }
         else
         {
            _loc3_.push({
               "name":"_color_redMultiplier",
               "value":param1.redMultiplier
            });
            _loc3_.push({
               "name":"_color_redOffset",
               "value":param1.redOffset
            });
            _loc3_.push({
               "name":"_color_blueMultiplier",
               "value":param1.blueMultiplier
            });
            _loc3_.push({
               "name":"_color_blueOffset",
               "value":param1.blueOffset
            });
            _loc3_.push({
               "name":"_color_greenMultiplier",
               "value":param1.greenMultiplier
            });
            _loc3_.push({
               "name":"_color_greenOffset",
               "value":param1.greenOffset
            });
            _loc3_.push({
               "name":"_color_alphaMultiplier",
               "value":param1.alphaMultiplier
            });
            _loc3_.push({
               "name":"_color_alphaOffset",
               "value":param1.alphaOffset
            });
         }
         return _loc3_;
      }
   }
}


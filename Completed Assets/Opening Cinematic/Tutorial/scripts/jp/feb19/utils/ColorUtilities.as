package jp.feb19.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class ColorUtilities
   {
       
      
      public function ColorUtilities()
      {
         super();
      }
      
      public static function paint(param1:DisplayObject, param2:int = 16711680) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redMultiplier = 0;
         _loc3_.greenMultiplier = 0;
         _loc3_.blueMultiplier = 0;
         _loc3_.redOffset = param2 >> 16 & 255;
         _loc3_.greenOffset = param2 >> 8 & 255;
         _loc3_.blueOffset = param2 & 255;
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function paintOffset(param1:DisplayObject, param2:int = 16711680) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redMultiplier = 1;
         _loc3_.greenMultiplier = 1;
         _loc3_.blueMultiplier = 1;
         _loc3_.redOffset = param2 >> 16 & 255;
         _loc3_.greenOffset = param2 >> 8 & 255;
         _loc3_.blueOffset = param2 & 255;
         param1.transform.colorTransform = _loc3_;
      }
      
      public static function setColorTransform(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : void
      {
         var _loc10_:ColorTransform;
         (_loc10_ = param1.transform.colorTransform).redMultiplier = param2;
         _loc10_.greenMultiplier = param4;
         _loc10_.blueMultiplier = param6;
         _loc10_.alphaMultiplier = param8;
         _loc10_.redOffset = param3;
         _loc10_.greenOffset = param5;
         _loc10_.blueOffset = param7;
         _loc10_.alphaOffset = param9;
         param1.transform.colorTransform = _loc10_;
      }
      
      public static function reset(param1:DisplayObject) : void
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         _loc2_.redMultiplier = 1;
         _loc2_.greenMultiplier = 1;
         _loc2_.blueMultiplier = 1;
         _loc2_.redOffset = 0;
         _loc2_.greenOffset = 0;
         _loc2_.blueOffset = 0;
         param1.transform.colorTransform = _loc2_;
      }
      
      public static function avarage(param1:BitmapData, param2:Rectangle) : uint
      {
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = param2.bottom;
         var _loc7_:uint = param2.right;
         var _loc8_:int = param2.top;
         while(_loc8_ < _loc6_)
         {
            _loc9_ = param2.left;
            while(_loc9_ < _loc7_)
            {
               _loc10_ = param1.getPixel(_loc9_,_loc8_);
               _loc3_ += 255 & _loc10_ >> 16;
               _loc4_ += 255 & _loc10_ >> 8;
               _loc5_ += 255 & _loc10_ >> 0;
               _loc9_++;
            }
            _loc8_++;
         }
         _loc3_ /= param2.width * param2.height;
         _loc4_ /= param2.width * param2.height;
         _loc5_ /= param2.width * param2.height;
         return int(_loc3_) << 16 | int(_loc4_) << 8 | int(_loc5_);
      }
   }
}

package bfp.pdw.common_y.effect
{
   import bfp.PDWBridge;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public class BtnEffect
   {
      
      public function BtnEffect()
      {
         super();
      }
      
      public static function bgOver(param1:MovieClip) : *
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         _loc2_.redMultiplier = 0;
         _loc2_.greenMultiplier = 0;
         _loc2_.blueMultiplier = 0;
         _loc2_.redOffset = PDWBridge.ROLLOVER_R;
         _loc2_.greenOffset = PDWBridge.ROLLOVER_G;
         _loc2_.blueOffset = PDWBridge.ROLLOVER_B;
         param1.transform.colorTransform = _loc2_;
      }
      
      public static function bgOut(param1:MovieClip) : *
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
      
      public static function bgReset(param1:MovieClip) : *
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
   }
}


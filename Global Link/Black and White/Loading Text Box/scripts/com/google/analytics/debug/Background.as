package com.google.analytics.debug
{
   import flash.display.Graphics;
   
   public class Background
   {
      
      public function Background()
      {
         super();
      }
      
      public static function drawRounded(param1:*, param2:Graphics, param3:uint = 0, param4:uint = 0) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc7_ = uint(Style.roundedCorner);
         if(param3 > 0 && param4 > 0)
         {
            _loc5_ = param3;
            _loc6_ = param4;
         }
         else
         {
            _loc5_ = uint(param1.width);
            _loc6_ = uint(param1.height);
         }
         if(Boolean(param1.stickToEdge) && param1.alignement != Align.none)
         {
            switch(param1.alignement)
            {
               case Align.top:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,0,0,_loc7_,_loc7_);
                  break;
               case Align.topLeft:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,0,0,0,_loc7_);
                  break;
               case Align.topRight:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,0,0,_loc7_,0);
                  break;
               case Align.bottom:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,_loc7_,_loc7_,0,0);
                  break;
               case Align.bottomLeft:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,0,_loc7_,0,0);
                  break;
               case Align.bottomRight:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,_loc7_,0,0,0);
                  break;
               case Align.left:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,0,_loc7_,0,_loc7_);
                  break;
               case Align.right:
                  param2.drawRoundRectComplex(0,0,_loc5_,_loc6_,_loc7_,0,_loc7_,0);
                  break;
               case Align.center:
                  param2.drawRoundRect(0,0,_loc5_,_loc6_,_loc7_,_loc7_);
            }
         }
         else
         {
            param2.drawRoundRect(0,0,_loc5_,_loc6_,_loc7_,_loc7_);
         }
      }
   }
}


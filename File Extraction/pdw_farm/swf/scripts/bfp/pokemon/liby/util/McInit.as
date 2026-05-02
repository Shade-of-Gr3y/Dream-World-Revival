package bfp.pokemon.liby.util
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class McInit
   {
      
      public function McInit()
      {
         super();
      }
      
      public static function initParam(param1:MovieClip) : *
      {
         param1.dx = param1.x;
         param1.dy = param1.y;
         param1.dw = param1.width;
         param1.dh = param1.height;
      }
   }
}


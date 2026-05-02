package bfp.pokemon.liby.util
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class BtnSetting
   {
      
      public function BtnSetting()
      {
         super();
      }
      
      public static function addBtn(param1:MovieClip, param2:Object) : *
      {
         if(!(param2.click == null || param2.click == undefined))
         {
            param1.addEventListener(MouseEvent.CLICK,param2.click);
         }
         if(!(param2.over == null || param2.over == undefined))
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,param2.over);
         }
         if(!(param2.out == null || param2.out == undefined))
         {
            param1.addEventListener(MouseEvent.MOUSE_OUT,param2.out);
         }
         if(!(param2.down == null || param2.down == undefined))
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,param2.down);
         }
         if(!(param2.up == null || param2.up == undefined))
         {
            param1.addEventListener(MouseEvent.MOUSE_UP,param2.up);
         }
         if(!(param2.buttonMode == null || param2.buttonMode == undefined))
         {
            param1.buttonMode = param2.buttonMode;
         }
      }
      
      public static function removeBtn(param1:MovieClip, param2:Object) : *
      {
         if(!(param2.click == null || param2.click == undefined))
         {
            param1.removeEventListener(MouseEvent.CLICK,param2.click);
         }
         if(!(param2.over == null || param2.over == undefined))
         {
            param1.removeEventListener(MouseEvent.MOUSE_OVER,param2.over);
         }
         if(!(param2.out == null || param2.out == undefined))
         {
            param1.removeEventListener(MouseEvent.MOUSE_OUT,param2.out);
         }
         if(!(param2.down == null || param2.down == undefined))
         {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,param2.down);
         }
         if(!(param2.up == null || param2.up == undefined))
         {
            param1.removeEventListener(MouseEvent.MOUSE_UP,param2.up);
         }
         if(!(param2.buttonMode == null || param2.buttonMode == undefined))
         {
            param1.buttonMode = param2.buttonMode;
         }
      }
   }
}


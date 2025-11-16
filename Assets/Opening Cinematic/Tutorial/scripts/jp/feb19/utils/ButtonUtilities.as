package jp.feb19.utils
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ButtonUtilities
   {
       
      
      public function ButtonUtilities()
      {
         super();
      }
      
      public static function setBtn(param1:DisplayObject, param2:Object, param3:Boolean = true, param4:Boolean = false) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.addEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.addEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.addEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.addEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = true;
               param1.addEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
      
      public static function unsetBtn(param1:DisplayObject, param2:Object, param3:Boolean = false, param4:Boolean = true) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.removeEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = false;
               param1.removeEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
   }
}

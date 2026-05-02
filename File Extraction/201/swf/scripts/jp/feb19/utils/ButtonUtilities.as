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
      
      public static function setBtn(target:DisplayObject, handlers:Object, buttonMode:Boolean = true, mouseChildren:Boolean = false) : void
      {
         Sprite(target).buttonMode = buttonMode;
         Sprite(target).mouseChildren = mouseChildren;
         if(handlers)
         {
            if(handlers.over)
            {
               target.addEventListener(MouseEvent.MOUSE_OVER,handlers.over);
            }
            if(handlers.out)
            {
               target.addEventListener(MouseEvent.MOUSE_OUT,handlers.out);
            }
            if(handlers.down)
            {
               target.addEventListener(MouseEvent.MOUSE_DOWN,handlers.down);
            }
            if(handlers.up)
            {
               target.addEventListener(MouseEvent.MOUSE_UP,handlers.up);
            }
            if(handlers.click)
            {
               target.addEventListener(MouseEvent.CLICK,handlers.click);
            }
            if(handlers.doubleClick)
            {
               Sprite(target).doubleClickEnabled = true;
               target.addEventListener(MouseEvent.DOUBLE_CLICK,handlers.doubleClick);
            }
         }
      }
      
      public static function unsetBtn(target:DisplayObject, handlers:Object, buttonMode:Boolean = false, mouseChildren:Boolean = true) : void
      {
         Sprite(target).buttonMode = buttonMode;
         Sprite(target).mouseChildren = mouseChildren;
         if(handlers)
         {
            if(handlers.over)
            {
               target.removeEventListener(MouseEvent.MOUSE_OVER,handlers.over);
            }
            if(handlers.out)
            {
               target.removeEventListener(MouseEvent.MOUSE_OUT,handlers.out);
            }
            if(handlers.down)
            {
               target.removeEventListener(MouseEvent.MOUSE_DOWN,handlers.down);
            }
            if(handlers.up)
            {
               target.removeEventListener(MouseEvent.MOUSE_UP,handlers.up);
            }
            if(handlers.click)
            {
               target.removeEventListener(MouseEvent.CLICK,handlers.click);
            }
            if(handlers.doubleClick)
            {
               Sprite(target).doubleClickEnabled = false;
               target.removeEventListener(MouseEvent.DOUBLE_CLICK,handlers.doubleClick);
            }
         }
      }
   }
}


package hivelocity.flight
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class flagCursor extends MovieClip
   {
      
      private var _moveflg:Boolean;
      
      public function flagCursor()
      {
         super();
         this.__init();
      }
      
      public function setFlag(param1:Boolean) : void
      {
         this._moveflg = param1;
         this.visible = this._moveflg;
      }
      
      private function __init() : void
      {
         this._moveflg = false;
         this.visible = false;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.__moveFlgCursor,false,0,true);
      }
      
      private function __moveFlgCursor(param1:MouseEvent) : void
      {
         if(this._moveflg)
         {
            this.x = stage.mouseX;
            this.y = stage.mouseY;
         }
      }
   }
}


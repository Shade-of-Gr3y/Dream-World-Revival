package core.ui
{
   import core.events.EventUI;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SimplePush extends EventUI
   {
      
      public var _container:MovieClip;
      
      public function SimplePush(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.stop();
      }
      
      private function mouseUpHandler(param1:MouseEvent) : void
      {
         this._container.removeEventListener(Event.ENTER_FRAME,this.mouseClickHandler);
         dispatchEvent(new Event(DEACTIVE));
      }
      
      public function btClose() : void
      {
         this._container.buttonMode = false;
         this._container.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
         this._container.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         this._container.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._container.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         if(this._container.hasEventListener(Event.ENTER_FRAME))
         {
            this._container.removeEventListener(Event.ENTER_FRAME,this.mouseClickHandler);
         }
      }
      
      private function mouseClickHandler(param1:Event) : void
      {
         dispatchEvent(new Event(ACTIVE));
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         this._container.addEventListener(Event.ENTER_FRAME,this.mouseClickHandler);
      }
      
      private function mouseRollOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(ROLLOVER));
      }
      
      public function btOpen() : void
      {
         this._container.buttonMode = true;
         this._container.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
         this._container.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         this._container.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._container.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      public function clear() : void
      {
         this._container = null;
      }
      
      private function mouseRollOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(ROLLOUT));
      }
   }
}


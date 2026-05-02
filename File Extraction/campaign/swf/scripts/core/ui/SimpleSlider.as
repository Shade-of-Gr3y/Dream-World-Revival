package core.ui
{
   import core.events.EventUI;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class SimpleSlider extends EventUI
   {
      
      private var _container:MovieClip;
      
      private var _rect:Rectangle;
      
      public function SimpleSlider(param1:MovieClip, param2:Rectangle)
      {
         super();
         this._container = param1;
         this._rect = param2;
      }
      
      public function get y() : Number
      {
         return this._container.y;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            dispatchEvent(new Event(ROLLOUT));
         }
      }
      
      public function mouseDownHandler(param1:MouseEvent) : void
      {
         this._container.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._container.startDrag(false,this._rect);
      }
      
      public function open() : void
      {
         this._container.buttonMode = true;
         this._container.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this._container.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this._container.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._container.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      public function clear() : void
      {
         this.close();
         this._container = null;
      }
      
      public function set x(param1:Number) : void
      {
         this._container.x = param1;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(ROLLOVER));
      }
      
      public function set y(param1:Number) : void
      {
         this._container.y = param1;
      }
      
      public function set scale(param1:Number) : void
      {
         this._container.scaleX = param1;
      }
      
      public function enterFrameHandler(param1:Event) : void
      {
         dispatchEvent(new Event(ACTIVE));
      }
      
      public function get scale() : Number
      {
         return this._container.scaleX;
      }
      
      public function close() : void
      {
         this._container.stopDrag();
         this._container.buttonMode = false;
         this._container.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this._container.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this._container.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._container.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this._container.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function mouseUpHandler(param1:MouseEvent) : void
      {
         if(this._container.hasEventListener(Event.ENTER_FRAME))
         {
            this._container.stopDrag();
            this._container.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            dispatchEvent(new Event(DEACTIVE));
            if(!this._container.hitTestPoint(param1.stageX,param1.stageY,false))
            {
               dispatchEvent(new Event(ROLLOUT));
            }
         }
      }
      
      public function get self() : MovieClip
      {
         return this._container;
      }
      
      public function get x() : Number
      {
         return this._container.x;
      }
   }
}


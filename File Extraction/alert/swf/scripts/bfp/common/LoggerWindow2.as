package bfp.common
{
   import fl.controls.Button;
   import fl.controls.TextArea;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol59")]
   public dynamic class LoggerWindow2 extends MovieClip
   {
      
      private var _shift:Boolean = false;
      
      private var _flag:Boolean = false;
      
      private var _back:MovieClip;
      
      public var bt:Button;
      
      public var back:MovieClip;
      
      public var txt:TextArea;
      
      private var _txt:TextArea;
      
      private var _bt:Button;
      
      public function LoggerWindow2()
      {
         super();
         this.visible = false;
         this._txt = this.txt;
         this._bt = this.bt;
         this._bt.addEventListener(MouseEvent.MOUSE_DOWN,this.clear);
         this._back = this.back;
         this._back.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._back.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.addEventListener(Event.ADDED_TO_STAGE,this.open);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.close);
         Logger2.addEventListener(Logger.LOG,this.log);
         this.clear(null);
         this.__setProp_bt_LoggerWindow2_();
         this.__setProp_txt_LoggerWindow2_();
      }
      
      internal function __setProp_bt_LoggerWindow2_() : *
      {
         try
         {
            this.bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.bt.emphasized = false;
         this.bt.enabled = true;
         this.bt.label = "close";
         this.bt.labelPlacement = "right";
         this.bt.selected = false;
         this.bt.toggle = false;
         this.bt.visible = true;
         try
         {
            this.bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      private function log(e:Event) : void
      {
         if(this._txt.length >= 10000)
         {
            this._txt.text = "";
         }
         this._txt.text += String(Logger2.text) + "\n";
         this._txt.verticalScrollPosition = this._txt.maxVerticalScrollPosition;
      }
      
      private function open(e:Event) : void
      {
         this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyHandler);
         this.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyHandler);
         this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseHandler);
      }
      
      private function mouseUpHandler(e:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function clear(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      internal function __setProp_txt_LoggerWindow2_() : *
      {
         try
         {
            this.txt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.txt.condenseWhite = false;
         this.txt.editable = false;
         this.txt.enabled = true;
         this.txt.horizontalScrollPolicy = "off";
         this.txt.htmlText = "";
         this.txt.maxChars = 0;
         this.txt.restrict = "";
         this.txt.text = "";
         this.txt.verticalScrollPolicy = "on";
         this.txt.visible = true;
         this.txt.wordWrap = true;
         try
         {
            this.txt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      private function mouseDownHandler(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function mouseHandler(e:MouseEvent) : void
      {
         switch(e.type)
         {
            case MouseEvent.MOUSE_DOWN:
               this._flag = true;
               break;
            case MouseEvent.MOUSE_UP:
               this._flag = false;
         }
      }
      
      private function keyHandler(e:KeyboardEvent) : void
      {
         this._shift = e.shiftKey;
         switch(e.keyCode)
         {
            case Keyboard.TAB:
               if(this._shift && this._flag)
               {
                  this.x = 0;
                  this.y = 0;
                  this.visible = true;
               }
         }
      }
      
      private function close(e:Event) : void
      {
         this._bt.removeEventListener(MouseEvent.MOUSE_DOWN,this.clear);
         this._back.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this._back.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.open);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.close);
         this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseHandler);
         this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyHandler);
         Logger2.removeEventListener(Logger.LOG,this.log);
         this._txt = null;
         this._bt = null;
      }
   }
}


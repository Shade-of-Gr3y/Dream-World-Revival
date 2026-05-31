package bfp.main
{
   import bfp.common.CustomEvent;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class MainAlert
   {
      
      private var _lines:MovieClip;
      
      private var _container:MovieClip;
      
      private var _back:MovieClip;
      
      private var _message:TextField;
      
      private var _bt:MovieClip;
      
      public function MainAlert(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._back = this._container.back;
         this._lines = this._container.lines;
         this._message = this._back.message;
         this._bt = this._back.bt;
         PokemonBridge.addEventListener(PokemonBridge.ERROR_WINDOW,this.errorHandler);
         ColorShortcuts.init();
      }
      
      private function nosyncidHandler(param1:MouseEvent = null) : void
      {
         PokemonBridge.mouseClickSound();
         this._bt.buttonMode = false;
         this._bt.removeEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.CLICK,this.nosyncidHandler);
         Tweener.addTween(this._bt,{
            "_brightness":0,
            "time":0.25,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "visible":false,
            "time":0,
            "delay":0.25,
            "transition":"linear"
         });
      }
      
      private function logoutHandler(param1:MouseEvent = null) : void
      {
         PokemonBridge.mouseClickSound();
         this._bt.buttonMode = false;
         this._bt.removeEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.CLICK,this.logoutHandler);
      }
      
      private function closeHandler(param1:MouseEvent = null) : void
      {
         PokemonBridge.mouseClickSound();
         this._bt.buttonMode = false;
         this._bt.removeEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.CLICK,this.closeHandler);
         Tweener.addTween(this._bt,{
            "_brightness":0,
            "time":0.25,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "visible":false,
            "time":0,
            "delay":0.25,
            "transition":"linear"
         });
         PokemonBridge.closeAlert();
      }
      
      private function buttonHandler(param1:MouseEvent = null) : void
      {
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._bt,{
                  "_brightness":0.5,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(this._bt,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
         }
      }
      
      private function errorHandler(param1:CustomEvent = null) : void
      {
         Logger.log(String(param1.data.message));
         this._bt.buttonName.y = 17;
         var _loc2_:Array = Font.enumerateFonts();
         if(_loc2_.length > 1)
         {
            FontManager.setTextAndFormatTag(this._message,FontManager.markupMultilingualText(String(param1.data.message)),"pg_ame_1");
            this._message.y = 85 - this._message.height / 2;
            if(param1.data.button)
            {
               FontManager.setTextAndFormatTag(this._bt.buttonName,FontManager.markupMultilingualText(String(param1.data.button)),"pg_ay_2");
            }
            else
            {
               FontManager.setAutoFontTextID(this._bt.buttonName,"pg_ay_2");
            }
         }
         else
         {
            this._message.text = String(param1.data.message);
            this._message.y = 85 - this._message.height / 2;
            if(param1.data.button)
            {
               this._bt.buttonName.text = String(param1.data.button);
            }
            else
            {
               this._bt.buttonName.text = FontManager.getIdText("pg_ay_2");
            }
         }
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._bt.buttonMode = true;
         this._bt.addEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.addEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         switch(Number(param1.data.id))
         {
            case PokemonBridge.WITH_FADEOUT:
               this._bt.addEventListener(MouseEvent.CLICK,this.closeHandler);
               break;
            case PokemonBridge.WITH_RELOAD:
               this._bt.addEventListener(MouseEvent.CLICK,this.reloadHandler);
               break;
            case PokemonBridge.WITH_LOGOUT:
               this._bt.addEventListener(MouseEvent.CLICK,this.logoutHandler);
               break;
            case PokemonBridge.WITH_SYNCID:
               this._bt.addEventListener(MouseEvent.CLICK,this.nosyncidHandler);
               break;
            case PokemonBridge.GOTO_PGL:
               this._bt.addEventListener(MouseEvent.CLICK,this.gotopglHandler);
         }
         Tweener.removeTweens(this._container);
         this._container.visible = true;
         this._lines.scaleX = this._lines.scaleY = 2;
         this._lines.alpha = 0;
         Tweener.addTween(this._container,{
            "alpha":1,
            "time":0.15,
            "transition":"linear"
         });
         Tweener.addTween(this._lines,{
            "alpha":1,
            "time":0.25,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this._lines,{
            "scaleX":1,
            "scaleY":1,
            "time":0.25,
            "delay":0,
            "transition":"easeOutSine"
         });
         Tweener.addTween(this._lines,{
            "alpha":0,
            "time":0.25,
            "delay":0.3,
            "transition":"linear"
         });
         MaskEffectManager.MaskInImage(this._back,{
            "time":0.25,
            "delay":0.3
         });
      }
      
      private function reloadHandler(param1:MouseEvent = null) : void
      {
         PokemonBridge.mouseClickSound();
         this._bt.buttonMode = false;
         this._bt.removeEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._bt.removeEventListener(MouseEvent.CLICK,this.reloadHandler);
         PokemonBridge.reload();
      }
      
      private function gotopglHandler(param1:MouseEvent = null) : void
      {
         PokemonBridge.mouseClickSound();
         PokemonBridge.href("/");
      }
   }
}


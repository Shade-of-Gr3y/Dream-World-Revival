package bfp.main.alert
{
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class AlertSleepless extends EventDispatcher
   {
      
      private var _bt1:MovieClip;
      
      private var _container:MovieClip;
      
      private var _message:TextField;
      
      private var _copy:MovieClip;
      
      private var _title:TextField;
      
      private var _btf1:TextField;
      
      public function AlertSleepless(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._copy = this._container.copy;
         this._title = this._copy.title;
         this._message = this._copy.message;
         this._bt1 = this._container.bt1;
         this._btf1 = this._bt1.buttonName;
      }
      
      private function closeButtonHandler(e:MouseEvent = null) : void
      {
         var mc:MovieClip = MovieClip(e.currentTarget);
         switch(e.type)
         {
            case MouseEvent.CLICK:
               PDWEnterBridge.enterAlert(PDWEnterBridge.REMOVED_SITE_PDW);
               PokemonBridge.mouseClickSound();
               Tweener.addTween(mc,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(mc,{
                  "_brightness":0.5,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(mc,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
         }
      }
      
      public function open() : void
      {
         if(!this._container.visible)
         {
            this.init();
            PokemonBridge.alertSound();
            MaskEffectManager.MaskInImage(this._container,{
               "time":0.25,
               "delay":0
            });
            this._bt1.buttonMode = true;
            this._bt1.addEventListener(MouseEvent.CLICK,this.closeButtonHandler);
            this._bt1.addEventListener(MouseEvent.ROLL_OVER,this.closeButtonHandler);
            this._bt1.addEventListener(MouseEvent.ROLL_OUT,this.closeButtonHandler);
         }
      }
      
      public function clear() : void
      {
         this._container = null;
         this._copy = null;
         this._title = null;
         this._message = null;
         this._bt1 = null;
         this._btf1 = null;
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._title.mouseWheelEnabled = false;
         this._message.mouseWheelEnabled = false;
         this._btf1.mouseWheelEnabled = false;
         this._title.y = 0;
         FontManager.setAutoFontTextID(this._title,"pg_amd_1");
         FontManager.setAutoFontTextID(this._message,"pg_amd_3");
         this._btf1.y = 8;
         this._btf1.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._btf1,"pg_amd_2");
         this._title.autoSize = TextFieldAutoSize.LEFT;
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._message.y = Math.floor(this._title.height) + 15 + this._title.y;
         this._copy.y = 200 - Math.floor(this._copy.height / 2);
      }
      
      public function close() : void
      {
         if(this._container.visible)
         {
            MaskEffectManager.MaskOutImage(this._container,{
               "time":0.25,
               "delay":0
            });
            this._bt1.buttonMode = false;
            this._bt1.removeEventListener(MouseEvent.CLICK,this.closeButtonHandler);
            this._bt1.removeEventListener(MouseEvent.ROLL_OVER,this.closeButtonHandler);
            this._bt1.removeEventListener(MouseEvent.ROLL_OUT,this.closeButtonHandler);
         }
      }
   }
}


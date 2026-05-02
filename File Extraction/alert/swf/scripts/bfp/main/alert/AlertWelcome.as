package bfp.main.alert
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class AlertWelcome extends EventDispatcher
   {
      
      private var _bt1:MovieClip;
      
      private var _container:MovieClip;
      
      private var _message1:TextField;
      
      private var _message2:TextField;
      
      private var _connector:ConnectorDataBase;
      
      private var _title:TextField;
      
      private var _copy:MovieClip;
      
      private var _btf1:TextField;
      
      public function AlertWelcome(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._copy = this._container.copy;
         this._title = this._copy.title;
         this._message1 = this._copy.message1;
         this._message2 = this._copy.message2;
         this._bt1 = this._container.bt1;
         this._btf1 = this._bt1.buttonName;
      }
      
      public function clear() : void
      {
         this._container = null;
         this._copy = null;
         this._title = null;
         this._message1 = null;
         this._message2 = null;
         this._bt1 = null;
         this._btf1 = null;
      }
      
      private function closeButtonHandler(e:MouseEvent = null) : void
      {
         switch(e.type)
         {
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               PDWEnterBridge.enterAlert(PDWEnterBridge.ENTER_ALERT_CLOSE);
               PokemonBridge.siteChange(PokemonBridge.SITE_PDW);
               Tweener.addTween(this._bt1,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._bt1,{
                  "_brightness":0.5,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(this._bt1,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
         }
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._message1.mouseWheelEnabled = false;
         this._message2.mouseWheelEnabled = false;
         this._title.mouseWheelEnabled = false;
         this._btf1.mouseWheelEnabled = false;
         this._title.y = 0;
         FontManager.setAutoFontTextID(this._title,"pg_amh_1");
         this._message1.y = 36;
         FontManager.setAutoFontTextID(this._message1,"pg_amh_2");
         this._message2.y = 78;
         FontManager.setAutoFontTextID(this._message2,"pg_amh_3");
         this._btf1.y = 8;
         this._btf1.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._btf1,"pg_amh_4");
         this._title.autoSize = TextFieldAutoSize.LEFT;
         this._title.autoSize = TextFieldAutoSize.CENTER;
         this._message1.autoSize = TextFieldAutoSize.LEFT;
         this._message1.autoSize = TextFieldAutoSize.CENTER;
         this._message1.y = Math.floor(this._title.height + this._title.y) + 15;
         this._message2.autoSize = TextFieldAutoSize.LEFT;
         this._message2.y = Math.floor(this._message1.height + this._message1.y) + 15;
         this._copy.y = 200 - Math.floor(this._copy.height / 2);
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
      
      public function close() : void
      {
         if(this._container.visible)
         {
            PokemonBridge.pdwAlertFlag = false;
            PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
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


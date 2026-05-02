package bfp.main.alert
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class AlertGamedata extends EventDispatcher
   {
      
      private var _container:MovieClip;
      
      private var _buttonTf:TextField;
      
      private var _connector:ConnectorDataBase;
      
      private var _bt:MovieClip;
      
      private var _messageTf:TextField;
      
      private var _copy:MovieClip;
      
      private var _infoTf:TextField;
      
      public function AlertGamedata(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._copy = this._container.copy;
         this._messageTf = this._copy.message;
         this._infoTf = this._copy.info;
         this._bt = this._container.bt;
         this._buttonTf = this._bt.buttonName;
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
            this._bt.buttonMode = true;
            this._bt.addEventListener(MouseEvent.CLICK,this.closeButtonHandler);
            this._bt.addEventListener(MouseEvent.ROLL_OVER,this.closeButtonHandler);
            this._bt.addEventListener(MouseEvent.ROLL_OUT,this.closeButtonHandler);
         }
      }
      
      public function clear() : void
      {
         this._container = null;
         this._copy = null;
         this._bt = null;
         this._messageTf = null;
         this._infoTf = null;
         this._buttonTf = null;
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._buttonTf.mouseWheelEnabled = false;
         this._messageTf.mouseWheelEnabled = false;
         this._infoTf.mouseWheelEnabled = false;
         this._buttonTf.y = 8;
         this._buttonTf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._buttonTf,"pg_alg_3");
         this._messageTf.y = 0;
         this._messageTf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._messageTf,"pg_alg_1");
         this._infoTf.y = 60;
         this._infoTf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._infoTf,"pg_alg_2");
         this._messageTf.autoSize = TextFieldAutoSize.LEFT;
         this._infoTf.autoSize = TextFieldAutoSize.LEFT;
         this._infoTf.y = Math.floor(this._messageTf.height) + 10 + this._messageTf.y;
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
            this._bt.buttonMode = false;
            this._bt.removeEventListener(MouseEvent.CLICK,this.closeButtonHandler);
            this._bt.removeEventListener(MouseEvent.ROLL_OVER,this.closeButtonHandler);
            this._bt.removeEventListener(MouseEvent.ROLL_OUT,this.closeButtonHandler);
         }
      }
   }
}


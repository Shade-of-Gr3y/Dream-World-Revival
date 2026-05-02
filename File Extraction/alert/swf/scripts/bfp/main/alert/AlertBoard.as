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
   
   public class AlertBoard extends EventDispatcher
   {
      
      private var _container:MovieClip;
      
      private var _message:TextField;
      
      private var _connector:ConnectorDataBase;
      
      private var _bt:MovieClip;
      
      private var _btf:TextField;
      
      public function AlertBoard(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._bt = this._container.bt;
         this._btf = this._bt.buttonName;
         this._message = this._container.message;
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
               "delay":0.3
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
         this._bt = null;
         this._btf = null;
         this._message = null;
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._btf.y = 8;
         this._btf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._btf,"pg_alc_2");
         this._message.mouseWheelEnabled = false;
         this._btf.mouseWheelEnabled = false;
         this._message.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._message,"pg_alc_1");
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._message.y = 200 - Math.floor(this._message.height / 2);
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


package bfp.main.alert
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
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
   
   public class AlertOneDay extends EventDispatcher
   {
      
      private var _container:MovieClip;
      
      private var _message:TextField;
      
      private var _connector:ConnectorDataBase;
      
      private var _copy:MovieClip;
      
      private var _title:TextField;
      
      private var _bt0:MovieClip;
      
      private var _bt1:MovieClip;
      
      private var _bt2:MovieClip;
      
      private var _btf1:TextField;
      
      private var _btf2:TextField;
      
      public function AlertOneDay(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._copy = this._container.copy;
         this._title = this._copy.title;
         this._message = this._copy.message;
         this._bt1 = this._container.bt1;
         this._btf1 = this._bt1.buttonName;
         this._bt2 = this._container.bt2;
         this._btf2 = this._bt2.buttonName;
      }
      
      private function wakeButtonHandler2(e:Event = null) : void
      {
         switch(e.type)
         {
            case ConnectorDataBase.DB_ERROR:
               PokemonBridge.ClearConnect();
               PokemonBridge.alertWindow(FontManager.getIdText("pg_ame_1"),PokemonBridge.WITH_RELOAD);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.wakeButtonHandler2);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.wakeButtonHandler2);
               this._connector.disconnect();
               this._connector = null;
               break;
            case ConnectorDataBase.DB_SUCCESS:
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.wakeButtonHandler2);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.wakeButtonHandler2);
               this._connector.disconnect();
               this._connector = null;
               this._connector = new ConnectorDataBase();
               this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.connect(ConnectorPATH.DB_FINISH_PDW,null,false,"GET");
         }
      }
      
      private function connectHandler(e:Event = null) : void
      {
         switch(e.type)
         {
            case ConnectorDataBase.DB_ERROR:
               PokemonBridge.ClearConnect();
               PokemonBridge.alertWindow(FontManager.getIdText("pg_ame_1"),PokemonBridge.WITH_RELOAD);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
               break;
            case ConnectorDataBase.DB_SUCCESS:
               PokemonBridge.ClearConnect();
               PokemonBridge.alertWindow(FontManager.getIdText("pg_amk_1"),PokemonBridge.GOTO_PGL);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
               PokemonBridge.sleeping_flag = 0;
               PDWEnterBridge.removeSharedObject();
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
            this._bt2.buttonMode = true;
            this._bt2.addEventListener(MouseEvent.CLICK,this.wakeButtonHandler);
            this._bt2.addEventListener(MouseEvent.ROLL_OVER,this.wakeButtonHandler);
            this._bt2.addEventListener(MouseEvent.ROLL_OUT,this.wakeButtonHandler);
            if(PokemonBridge.sleeping_flag)
            {
               if(PokemonBridge.rom_id != 0)
               {
                  this._bt1.x = 166;
                  this._bt2.visible = true;
               }
               else
               {
                  this._bt1.x = 246;
                  this._bt2.visible = false;
               }
            }
            else
            {
               this._bt1.x = 246;
               this._bt2.visible = false;
            }
         }
      }
      
      public function clear() : void
      {
         this._container = null;
         this._copy = null;
         this._title = null;
         this._message = null;
         this._bt1 = null;
         this._bt2 = null;
         this._btf1 = null;
         this._btf2 = null;
      }
      
      private function init() : void
      {
         var tit:String = null;
         this._container.visible = true;
         this._title.mouseWheelEnabled = false;
         this._message.mouseWheelEnabled = false;
         this._btf1.mouseWheelEnabled = false;
         this._btf2.mouseWheelEnabled = false;
         this._btf1.y = 8;
         this._btf1.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._btf1,"pg_adi_6");
         this._btf2.y = 8;
         this._btf2.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._btf2,"pg_adi_7");
         var offset:Date = new Date(1970,0,1,0,0,0);
         var date:Date = new Date(1970,0,1,0,0,PokemonBridge.last_started_at_timezone - offset.timezoneOffset * 60);
         var hour:int = PDWEnterCheck.life / 60 / 60;
         var min:int = PDWEnterCheck.life / 60 % 60;
         if(hour == 0)
         {
            if(min == 0)
            {
               tit = FontManager.getIdText("pg_adi_3");
               tit = tit.replace(/\[MM\]/g,date.getMonth() + 1);
               tit = tit.replace(/\[DD\]/g,date.getDate());
               tit = tit.replace(/\[HH1\]/g,date.hours);
            }
            else
            {
               tit = FontManager.getIdText("pg_adi_2");
               tit = tit.replace(/\[MM\]/g,date.getMonth() + 1);
               tit = tit.replace(/\[DD\]/g,date.getDate());
               tit = tit.replace(/\[HH1\]/g,date.hours);
               tit = tit.replace(/\[HH2\]/g,min + 1);
            }
         }
         else
         {
            tit = FontManager.getIdText("pg_adi_1");
            tit = tit.replace(/\[MM\]/g,date.getMonth() + 1);
            tit = tit.replace(/\[DD\]/g,date.getDate());
            tit = tit.replace(/\[HH1\]/g,date.hours);
            tit = tit.replace(/\[HH2\]/g,hour + 1);
         }
         FontManager.setTextAndFormatTag(this._title,FontManager.markupMultilingualText(tit),"pg_adi_1");
         this._title.autoSize = TextFieldAutoSize.LEFT;
         this._title.autoSize = TextFieldAutoSize.CENTER;
         var _mes:String = "";
         if(PokemonBridge.sleeping_flag)
         {
            _mes = FontManager.getIdText("pg_adi_5");
         }
         else
         {
            _mes = FontManager.getIdText("pg_adi_4");
         }
         FontManager.setTextAndFormatTag(this._message,FontManager.markupMultilingualText(_mes),"pg_adi_4");
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._message.y = Math.floor(this._title.height) + 15;
         this._copy.y = 200 - Math.floor(this._copy.height / 2);
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
      
      private function wakeButtonHandler(e:MouseEvent = null) : void
      {
         var mc:MovieClip = MovieClip(e.currentTarget);
         switch(e.type)
         {
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               PDWEnterBridge.enterAlert(PDWEnterBridge.ENTER_ALERT_CLOSE);
               Tweener.addTween(mc,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               PokemonBridge.ApiConnect();
               if(this._connector)
               {
                  this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
                  this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
                  this._connector.disconnect();
                  this._connector = null;
               }
               this._connector = new ConnectorDataBase();
               this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.wakeButtonHandler2);
               this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.wakeButtonHandler2);
               this._connector.connect(ConnectorPATH.DB_CONITUE_LOGIN,null,false,"POST");
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
      
      public function close() : void
      {
         if(this._container.visible)
         {
            MaskEffectManager.MaskOutImage(this._container,{
               "time":0.25,
               "delay":0
            });
            PokemonBridge.pdwAlertFlag = false;
            PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
            this._bt1.buttonMode = false;
            this._bt1.removeEventListener(MouseEvent.CLICK,this.closeButtonHandler);
            this._bt1.removeEventListener(MouseEvent.ROLL_OVER,this.closeButtonHandler);
            this._bt1.removeEventListener(MouseEvent.ROLL_OUT,this.closeButtonHandler);
            this._bt2.buttonMode = false;
            this._bt2.removeEventListener(MouseEvent.CLICK,this.wakeButtonHandler);
            this._bt2.removeEventListener(MouseEvent.ROLL_OVER,this.wakeButtonHandler);
            this._bt2.removeEventListener(MouseEvent.ROLL_OUT,this.wakeButtonHandler);
            if(this._connector)
            {
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
            }
         }
      }
   }
}


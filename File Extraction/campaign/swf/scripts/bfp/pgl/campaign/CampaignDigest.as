package bfp.pgl.campaign
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.pgl.campaign.animator.*;
   import bfp.pgl.common.CampaignBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.properties.DisplayShortcuts;
   import caurina.transitions.properties.TextShortcuts;
   import core.events.EventUI;
   import core.ui.SimplePush;
   import core.ui.SimpleSlider;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CampaignDigest extends EventDispatcher
   {
      
      private var _slider:SimpleSlider;
      
      private var _container:MovieClip;
      
      private var _panel:MovieClip;
      
      private var _containerAnimator:ContainerAnimator;
      
      private var _panelAnimator:PanelAnimator;
      
      private var _helpBt:MovieClip;
      
      private var _sliderAnimator:BtAnimator;
      
      private var _sBackAnimator:GeneralAnimator;
      
      private var _arr:Array;
      
      private var _upBt:SimplePush;
      
      private var _downBt:SimplePush;
      
      private var _backBt:MovieClip;
      
      private var _downBtAnimator:BtAnimator;
      
      private var _backBtAnimator:BtAnimator;
      
      private var _contentAnimator:ContentAnimator;
      
      private var _json:Object;
      
      private var _upBtAnimator:BtAnimator;
      
      private var _connector:ConnectorDataBase;
      
      private var _wrapper:MovieClip;
      
      private var _titleAnimator:TitleAnimator;
      
      public function CampaignDigest(param1:MovieClip)
      {
         super();
         ColorShortcuts.init();
         DisplayShortcuts.init();
         TextShortcuts.init();
         this._container = param1;
         this._container.visible = false;
         this._upBt = new SimplePush(this._container.upBt);
         this._downBt = new SimplePush(this._container.downBt);
         this._slider = new SimpleSlider(this._container.slider,new Rectangle(843,106,0,190));
         this._wrapper = this._container.content.wrapper;
         this._panel = this._container.panel;
         this._backBt = this._container.backBt;
         this._helpBt = this._container.helpBt;
         this._helpBt.visible = false;
         this._containerAnimator = new ContainerAnimator(this._container);
         this._panelAnimator = new PanelAnimator(this._panel);
         this._titleAnimator = new TitleAnimator(this._container.title);
         this._contentAnimator = new ContentAnimator(this._container.content);
         this._backBtAnimator = new BtAnimator(this._backBt);
         this._sliderAnimator = new BtAnimator(this._container.slider);
         this._sBackAnimator = new GeneralAnimator(this._container.sBack);
         this._upBtAnimator = new BtAnimator(this._container.upBt);
         this._downBtAnimator = new BtAnimator(this._container.downBt);
         this._sliderAnimator.offset = 20;
         this._backBt.mouseChildren = false;
         this._container.upBt.mouseChildren = false;
         this._container.downBt.mouseChildren = false;
         this._container.slider.mouseChildren = false;
      }
      
      private function connectHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case ConnectorDataBase.DB_PROGRESS:
               break;
            case ConnectorDataBase.DB_ERROR:
               PokemonBridge.ClearConnect();
               PokemonBridge.alertWindow(this._connector.error,PokemonBridge.WITH_RELOAD);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
               break;
            case ConnectorDataBase.DB_SUCCESS:
               PokemonBridge.ClearConnect();
               this._json = this._connector.json;
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
               this.start();
         }
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._backBt.visible = false;
         this._container.slider.visible = false;
         this._container.sBack.visible = false;
         this._container.upBt.visible = false;
         this._container.downBt.visible = false;
         this._container.title.tf.mouseEnabled = false;
         this._container.title.tf.y = 0;
         FontManager.setAutoFontTextID(this._container.title.tf,"c_ad_1");
         this._helpBt.buttonName.mouseEnabled = false;
         this._helpBt.buttonName.y = 8;
         FontManager.setAutoFontTextID(this._helpBt.buttonName,"c_ad_11");
         this._container.content.header.item1.mouseEnabled = false;
         this._container.content.header.item1.y = 1;
         FontManager.setAutoFontTextID(this._container.content.header.item1,"c_ad_2");
         this._container.content.header.item2.mouseEnabled = false;
         this._container.content.header.item2.y = 1;
         FontManager.setAutoFontTextID(this._container.content.header.item2,"c_ad_3");
         this._container.content.header.item3.mouseEnabled = false;
         this._container.content.header.item3.y = 1;
         FontManager.setAutoFontTextID(this._container.content.header.item3,"c_ad_4");
      }
      
      private function outHandler(param1:Event) : void
      {
         switch(param1.currentTarget)
         {
            case this._upBt:
               this._upBtAnimator.out();
               break;
            case this._downBt:
               this._downBtAnimator.out();
               break;
            case this._slider:
               this._sliderAnimator.out();
               break;
            case this._backBt:
               this._backBtAnimator.out();
         }
      }
      
      private function onPlayFinish(param1:Event) : *
      {
         this._containerAnimator.stop();
         this._panelAnimator.stop();
         this._titleAnimator.stop();
         this._contentAnimator.stop();
         this._backBtAnimator.stop();
         this._sliderAnimator.stop();
         this._sBackAnimator.stop();
         this._upBtAnimator.stop();
         this._downBtAnimator.stop();
         this._containerAnimator.reset();
         this._panelAnimator.reset();
         this._titleAnimator.reset();
         this._contentAnimator.reset();
         this._backBtAnimator.reset();
         this._sliderAnimator.reset();
         this._sBackAnimator.reset();
         this._upBtAnimator.reset();
         this._downBtAnimator.reset();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               this._backBtAnimator.over();
               break;
            case MouseEvent.ROLL_OUT:
               this._backBtAnimator.out();
               break;
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
         }
      }
      
      private function scrollHandler(param1:Event = null) : void
      {
         if(param1)
         {
            switch(param1.currentTarget)
            {
               case this._upBt:
                  PokemonBridge.mouseClickSound();
                  this._wrapper.y += 15;
                  break;
               case this._downBt:
                  PokemonBridge.mouseClickSound();
                  this._wrapper.y -= 15;
                  break;
               case this._slider:
                  this._wrapper.y = (-this._wrapper.height + 332) * (this._slider.y - 106) / 190 + 20;
            }
         }
         if(this._wrapper.y < -this._wrapper.height + 332 + 20)
         {
            this._wrapper.y = -this._wrapper.height + 332 + 20;
         }
         if(this._wrapper.y > 20)
         {
            this._wrapper.y = 20;
         }
         this._slider.y = (this._wrapper.y - 20) * 190 / (332 - this._wrapper.height) + 106;
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._helpBt,{
                  "_brightness":0.5,
                  "time":0.5,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(this._helpBt,{
                  "_brightness":0,
                  "time":0.5,
                  "transition":"linear"
               });
               break;
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               switch(PokemonBridge.lang)
               {
                  case "ko":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "ja":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "en":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "fr":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "it":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "de":
                     PokemonBridge.href("/support/help/campaign/701/");
                     break;
                  case "es":
                     PokemonBridge.href("/support/help/campaign/701/");
               }
         }
      }
      
      public function open() : void
      {
         this._upBt.addEventListener(EventUI.ACTIVE,this.scrollHandler);
         this._upBt.addEventListener(EventUI.ROLLOVER,this.overHandler);
         this._upBt.addEventListener(EventUI.ROLLOUT,this.outHandler);
         this._upBt.btOpen();
         this._downBt.addEventListener(EventUI.ACTIVE,this.scrollHandler);
         this._downBt.addEventListener(EventUI.ROLLOVER,this.overHandler);
         this._downBt.addEventListener(EventUI.ROLLOUT,this.outHandler);
         this._downBt.btOpen();
         this._slider.addEventListener(EventUI.ACTIVE,this.scrollHandler);
         this._slider.addEventListener(EventUI.ROLLOVER,this.overHandler);
         this._slider.addEventListener(EventUI.ROLLOUT,this.outHandler);
         this._slider.open();
         this._backBt.buttonMode = true;
         this._backBt.addEventListener(MouseEvent.ROLL_OVER,this.clickHandler);
         this._backBt.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this._backBt.addEventListener(MouseEvent.ROLL_OUT,this.clickHandler);
         this._helpBt.buttonMode = true;
         this._helpBt.addEventListener(MouseEvent.CLICK,this.helpHandler);
         this._helpBt.addEventListener(MouseEvent.ROLL_OVER,this.helpHandler);
         this._helpBt.addEventListener(MouseEvent.ROLL_OUT,this.helpHandler);
         this._container.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.wheelHandler);
         this.init();
         PokemonBridge.ApiConnect();
         this._connector = new ConnectorDataBase();
         this._connector.addEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
         this._connector.connect(ConnectorPATH.DB_CAMPAIGN_LIST,null,false,"GET");
      }
      
      private function overHandler(param1:Event = null) : void
      {
         switch(param1.currentTarget)
         {
            case this._upBt:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._container.upBt.arrow,{
                  "y":8,
                  "time":0.1,
                  "delay":0,
                  "transition":"linear"
               });
               Tweener.addTween(this._container.upBt.arrow,{
                  "y":10,
                  "time":0.2,
                  "delay":0.1,
                  "transition":"linear"
               });
               this._upBtAnimator.over();
               break;
            case this._downBt:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._container.downBt.arrow,{
                  "y":14,
                  "time":0.1,
                  "delay":0,
                  "transition":"linear"
               });
               Tweener.addTween(this._container.downBt.arrow,{
                  "y":12,
                  "time":0.2,
                  "delay":0.1,
                  "transition":"linear"
               });
               this._downBtAnimator.over();
               break;
            case this._slider:
               PokemonBridge.mouseOverSound();
               this._sliderAnimator.over();
         }
      }
      
      private function start() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:CampaignDigestItem = null;
         this._arr = new Array();
         for(_loc1_ in this._json.campaign_list)
         {
            _loc2_ = new CampaignDigestItem(this._json.campaign_list[_loc1_],this._arr.length);
            _loc2_.y = this._arr.length * 50;
            this._wrapper.addChild(_loc2_);
            this._arr.push(_loc2_);
         }
         this._wrapper.y = 20;
         if(this._wrapper.height >= 332)
         {
            this._sliderAnimator.play(0.6);
            this._sBackAnimator.play(0.6);
            this._upBtAnimator.play(0.6);
            this._downBtAnimator.play(0.6);
            this._upBt.addEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._upBt.addEventListener(EventUI.ROLLOVER,this.overHandler);
            this._upBt.addEventListener(EventUI.ROLLOUT,this.outHandler);
            this._upBt.btOpen();
            this._downBt.addEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._downBt.addEventListener(EventUI.ROLLOVER,this.overHandler);
            this._downBt.addEventListener(EventUI.ROLLOUT,this.outHandler);
            this._downBt.btOpen();
            this._slider.addEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._slider.addEventListener(EventUI.ROLLOVER,this.overHandler);
            this._slider.addEventListener(EventUI.ROLLOUT,this.outHandler);
            this._slider.open();
         }
         else
         {
            this._upBt.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._upBt.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._upBt.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._upBt.btClose();
            this._downBt.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._downBt.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._downBt.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._downBt.btClose();
            this._slider.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._slider.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._slider.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._slider.close();
            Tweener.addTween(this._container.slider,{
               "alpha":0.5,
               "time":0.25,
               "delay":0,
               "transition":"linear"
            });
            Tweener.addTween(this._container.upBt,{
               "alpha":0.5,
               "time":0.25,
               "delay":0,
               "transition":"linear"
            });
            Tweener.addTween(this._container.downBt,{
               "alpha":0.5,
               "time":0.25,
               "delay":0,
               "transition":"linear"
            });
            Tweener.addTween(this._container.sBack,{
               "alpha":0.5,
               "time":0.25,
               "delay":0,
               "transition":"linear"
            });
         }
         this.scrollHandler(null);
         this._panelAnimator.play();
         this._titleAnimator.play(0.5);
         this._titleAnimator.play(0.5);
         this._contentAnimator.play(0.6);
         this._helpBt.visible = true;
         this._helpBt.alpha = 0;
         Tweener.addTween(this._helpBt,{
            "alpha":1,
            "time":0.5,
            "delay":0.5,
            "transition":"linear"
         });
      }
      
      private function wheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(this._container.mouseX,this._container.mouseY);
         var _loc3_:Rectangle = this._panel.getRect(this._container);
         if(_loc3_.containsPoint(_loc2_))
         {
            this._wrapper.y += Number(param1.delta) * 5;
            if(this._wrapper.y < -this._wrapper.height + 332 + 20)
            {
               this._wrapper.y = -this._wrapper.height + 332 + 20;
            }
            if(this._wrapper.y > 20)
            {
               this._wrapper.y = 20;
            }
            this._slider.y = (this._wrapper.y - 20) * 190 / (332 - this._wrapper.height) + 106;
         }
      }
      
      public function close(param1:Event = null) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:CampaignDigestItem = null;
         if(this._container.visible)
         {
            Tweener.addTween(this._helpBt,{
               "alpha":0,
               "time":0.25,
               "delay":0,
               "transition":"linear"
            });
            this._containerAnimator.addEventListener(ContainerAnimator.PLAY_FINISH,this.onPlayFinish);
            this._containerAnimator.play(ContainerAnimator.PLAY_TYPE_CLOSE);
            this._upBt.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._upBt.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._upBt.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._upBt.btClose();
            this._downBt.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._downBt.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._downBt.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._downBt.btClose();
            this._slider.removeEventListener(EventUI.ACTIVE,this.scrollHandler);
            this._slider.removeEventListener(EventUI.ROLLOVER,this.overHandler);
            this._slider.removeEventListener(EventUI.ROLLOUT,this.outHandler);
            this._slider.close();
            this._backBt.buttonMode = false;
            this._backBt.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this._backBt.removeEventListener(MouseEvent.ROLL_OVER,this.clickHandler);
            this._backBt.removeEventListener(MouseEvent.ROLL_OUT,this.clickHandler);
            this._helpBt.buttonMode = false;
            this._helpBt.removeEventListener(MouseEvent.CLICK,this.helpHandler);
            this._helpBt.removeEventListener(MouseEvent.ROLL_OVER,this.helpHandler);
            this._helpBt.removeEventListener(MouseEvent.ROLL_OUT,this.helpHandler);
            this._container.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.wheelHandler);
            for(_loc2_ in this._arr)
            {
               _loc3_ = CampaignDigestItem(this._arr[_loc2_]);
               _loc3_.clear();
               this._wrapper.removeChild(_loc3_);
            }
            this._arr = null;
         }
      }
   }
}


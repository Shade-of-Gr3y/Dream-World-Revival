package bfp.pgl.campaign
{
   import bfp.HelpBridge;
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
   import bfp.common.FontManager;
   import bfp.common.ImageParser;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pgl.campaign.animator.*;
   import bfp.pgl.common.CampaignBridge;
   import bfp.pgl.common.CampaignSelectBridge;
   import caurina.transitions.Tweener;
   import core.events.EventUI;
   import core.ui.SimplePush;
   import core.ui.SimpleSlider;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class CampaignDetail extends EventDispatcher
   {
      
      private var _slider:SimpleSlider;
      
      private var _returnBt:MovieClip;
      
      private var _container:MovieClip;
      
      private var _panelAnimator:PanelAnimator;
      
      private var _containerAnimator:ContainerAnimator;
      
      private var _entryBt:MovieClip;
      
      private var _explainBt:MovieClip;
      
      private var _closeBt:MovieClip;
      
      private var _upBt:SimplePush;
      
      private var _loader:Loader;
      
      private var _summaryTf:TextField;
      
      private var _downBt:SimplePush;
      
      private var _contentAnimator:GeneralAnimator;
      
      private var _mainimage:ImageParser;
      
      private var _nextBt:MovieClip;
      
      private var _because:MovieClip;
      
      private var _titleTf:TextField;
      
      private var _json:Object;
      
      private var _inputword:MovieClip;
      
      private var _buttonURL:String;
      
      private var _dateTf:TextField;
      
      private var _connector:ConnectorDataBase;
      
      private var _viewBt:MovieClip;
      
      private var _subimage:ImageParser;
      
      private var _inputserial:MovieClip;
      
      public function CampaignDetail(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._closeBt = this._container.content.closeBt;
         this._viewBt = this._container.content.viewBt;
         this._because = this._container.content.because;
         this._because.stop();
         this._explainBt = this._container.content.explainBt;
         this._entryBt = this._container.content.entryBt;
         this._returnBt = this._container.content.returnBt;
         this._inputserial = this._container.content.inputserial;
         this._inputword = this._container.content.inputword;
         this._nextBt = this._container.content.nextBt;
         this._titleTf = this._container.content.titleTf;
         this._dateTf = this._container.content.dateTf;
         this._summaryTf = this._container.content.summaryTf;
         this._upBt = new SimplePush(this._container.content.upBt);
         this._downBt = new SimplePush(this._container.content.downBt);
         this._slider = new SimpleSlider(this._container.content.slider,new Rectangle(592,131,0,64));
         this._mainimage = new ImageParser(this._container.content.mainimage);
         this._subimage = new ImageParser(this._container.content.subimage);
         this._containerAnimator = new ContainerAnimator(this._container);
         this._contentAnimator = new GeneralAnimator(this._container.content);
         this._panelAnimator = new PanelAnimator(this._container.panel);
      }
      
      private function error(param1:Number) : void
      {
         Logger.log("// ---------------------------------------------");
         Logger.log("// CAMPAIGN ERROR : " + String(param1));
         this._because.visible = true;
         var _loc2_:String = "";
         switch(param1)
         {
            case 2:
               _loc2_ = "c_bd_1";
               break;
            case 3:
               _loc2_ = "c_be_1";
               break;
            case 4:
               _loc2_ = "c_bj_1";
               break;
            case 5:
               _loc2_ = "c_bk_1";
               break;
            case 6:
               _loc2_ = "c_bi_1";
               break;
            case 7:
               _loc2_ = "c_bg_1";
               break;
            case 8:
               _loc2_ = "c_bh_1";
               break;
            case 9:
               _loc2_ = "c_bf_1";
               break;
            case 10:
               _loc2_ = "c_bb_1";
               break;
            case 11:
               _loc2_ = "c_bi_4";
               break;
            case 12:
               _loc2_ = "c_bi_2";
               break;
            case 13:
               _loc2_ = "c_bi_3";
               break;
            case 14:
               _loc2_ = "c_bi_5";
         }
         this._because.tf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._because.tf,_loc2_);
         this._because.tf.autoSize = TextFieldAutoSize.LEFT;
         this._because.tf.autoSize = TextFieldAutoSize.CENTER;
         this._because.tf.y = 40 - Math.floor(this._because.tf.height / 2);
         if(param1 == 9)
         {
            if(String(this._json.campaign.visual_result) != "みせってい")
            {
               this._because.visible = false;
               this._subimage.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img" + this._json.campaign.visual_result,false);
            }
         }
         this._returnBt.visible = true;
         this._returnBt.buttonMode = true;
         this._returnBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._returnBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._returnBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
      }
      
      private function init() : void
      {
         CampaignSelectBridge.id = 0;
         this._container.visible = true;
         this._because.visible = false;
         this._entryBt.visible = false;
         this._explainBt.visible = false;
         this._viewBt.visible = false;
         this._inputword.visible = false;
         this._inputserial.visible = false;
         this._nextBt.visible = false;
         this._returnBt.visible = false;
         this._container.content.subimage.visible = false;
         this._container.content.slider.visible = false;
         this._container.content.sBack.visible = false;
         this._container.content.upBt.visible = false;
         this._container.content.downBt.visible = false;
         this._buttonURL = "";
         this._inputserial.passwordTf.text = "";
         this._inputword.passwordTf.text = "";
         this._summaryTf.y = 108;
         this._slider.y = 131;
         this._container.content.subitem.mouseEnabled = false;
         this._container.content.subitem.y = 271;
         FontManager.setAutoFontTextID(this._container.content.subitem,"c_aa_4");
         this._viewBt.buttonName.mouseEnabled = false;
         this._viewBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._viewBt.buttonName,"c_aa_1");
         this._nextBt.buttonName.mouseEnabled = false;
         this._nextBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._nextBt.buttonName,"c_aa_3");
         this._inputword.nextBt.buttonName.mouseEnabled = false;
         this._inputword.nextBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._inputword.nextBt.buttonName,"c_aa_3");
         this._inputserial.nextBt.buttonName.mouseEnabled = false;
         this._inputserial.nextBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._inputserial.nextBt.buttonName,"c_aa_3");
         this._returnBt.buttonName.mouseEnabled = false;
         this._returnBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._returnBt.buttonName,"c_bb_7");
         this._explainBt.buttonName.mouseEnabled = false;
         this._explainBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._explainBt.buttonName,"c_ba_2");
         this._entryBt.buttonName.mouseEnabled = false;
         this._entryBt.buttonName.y = 2;
         FontManager.setAutoFontTextID(this._entryBt.buttonName,"c_ba_3");
      }
      
      private function connectHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case ConnectorDataBase.DB_PROGRESS:
               break;
            case ConnectorDataBase.DB_ERROR:
               PokemonBridge.ClearConnect();
               PokemonBridge.alertWindow(this._connector.error,PokemonBridge.WITH_FADEOUT);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
               this._connector.disconnect();
               this._connector = null;
               CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
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
      
      private function outHandler(param1:Event = null) : void
      {
         switch(param1.currentTarget)
         {
            case this._upBt:
               MouseAnimator.out(this._container.content.upBt.bg);
               break;
            case this._downBt:
               MouseAnimator.out(this._container.content.downBt.bg);
               break;
            case this._slider:
               MouseAnimator.out(this._container.content.slider.bg);
         }
      }
      
      private function onPlayFinish(param1:Event) : *
      {
         this._containerAnimator.stop();
         this._contentAnimator.stop();
         this._panelAnimator.stop();
         this._containerAnimator.reset();
         this._contentAnimator.reset();
         this._panelAnimator.reset();
      }
      
      private function loaderHandler(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
         this._loader.x = this._container.content.subimage.x;
         this._loader.y = this._container.content.subimage.y;
         this._container.content.addChild(this._loader);
      }
      
      private function doCampaign() : void
      {
         var _loc1_:String = null;
         switch(Number(this._json.campaign.campaign_type))
         {
            case 1:
               this._inputword.visible = true;
               this._inputword.nextBt.buttonMode = true;
               this._inputword.nextBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
               this._inputword.nextBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
               this._inputword.nextBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
               break;
            case 2:
               this._inputserial.visible = true;
               this._inputserial.nextBt.buttonMode = true;
               this._inputserial.nextBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
               this._inputserial.nextBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
               this._inputserial.nextBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
               break;
            case 3:
               this._nextBt.visible = true;
               this._nextBt.buttonMode = true;
               this._nextBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
               this._nextBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
               this._nextBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
               break;
            case 4:
               this._nextBt.visible = true;
               this._nextBt.buttonMode = true;
               this._nextBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
               this._nextBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
               this._nextBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
         }
         if(this._json.campaign.selection != "みせってい")
         {
            CampaignSelectBridge.id = undefined;
            _loc1_ = PokemonBridge.PATH + "../../../campaign/assets/select" + this._json.campaign.selection;
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderHandler);
            this._loader.load(new URLRequest(_loc1_));
         }
         else
         {
            this._subimage.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img" + this._json.campaign.visual_info,false);
         }
      }
      
      private function scrollHandler(param1:Event = null) : void
      {
         if(param1)
         {
            switch(param1.currentTarget)
            {
               case this._upBt:
                  this._summaryTf.y += 15;
                  break;
               case this._downBt:
                  this._summaryTf.y -= 15;
                  break;
               case this._slider:
                  this._summaryTf.y = (-this._summaryTf.height + 140) * (this._slider.y - 131) / 64 + 108;
            }
         }
         if(this._summaryTf.y < -this._summaryTf.height + 140 + 108)
         {
            this._summaryTf.y = -this._summaryTf.height + 140 + 108;
         }
         if(this._summaryTf.y > 108)
         {
            this._summaryTf.y = 108;
         }
         this._slider.y = (this._summaryTf.y - 108) * 64 / (140 - this._summaryTf.height) + 131;
      }
      
      private function judgeHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         switch(param1.type)
         {
            case ConnectorDataBase.DB_PROGRESS:
               break;
            case ConnectorDataBase.DB_ERROR:
               PokemonBridge.ClearConnect();
               _loc2_ = this._connector.code;
               _loc3_ = String(this._connector.error);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.disconnect();
               this._connector = null;
               PokemonBridge.alertWindow(_loc3_,PokemonBridge.WITH_FADEOUT);
               break;
            case ConnectorDataBase.DB_SUCCESS:
               PokemonBridge.ClearConnect();
               _loc4_ = this._connector.json;
               _loc4_.serial_key = this._inputserial.passwordTf.text;
               _loc4_.word = this._inputword.passwordTf.text;
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.disconnect();
               this._connector = null;
               CampaignBridge.change(CampaignBridge.CAMPAIGN_GAME,_loc4_);
         }
      }
      
      public function open(param1:Number) : void
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
         this._closeBt.buttonMode = true;
         this._closeBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._closeBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._closeBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._container.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.wheelHandler);
         PokemonBridge.ApiConnect();
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.campaign_id = param1;
         this._connector = new ConnectorDataBase();
         this._connector.addEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
         this._connector.connect(ConnectorPATH.DB_CAMPAIGN_DETAIL,_loc2_,false,"GET");
      }
      
      private function notMember() : void
      {
         this._because.visible = true;
         this._because.tf.mouseEnabled = false;
         FontManager.setAutoFontTextID(this._because.tf,"c_ba_1");
         this._because.tf.autoSize = TextFieldAutoSize.LEFT;
         this._because.tf.autoSize = TextFieldAutoSize.CENTER;
         this._because.tf.y = 40 - Math.floor(this._because.tf.height / 2);
         this._entryBt.visible = true;
         this._entryBt.buttonMode = true;
         this._entryBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._entryBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._entryBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._explainBt.visible = true;
         this._explainBt.buttonMode = true;
         this._explainBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._explainBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._explainBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
      }
      
      private function start() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:Array = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         this.init();
         Logger.log("// ---------------------------------------------");
         Logger.log("// CAMPAIGN DETAIL");
         for(_loc1_ in this._json.campaign)
         {
            if(this._json.campaign[_loc1_] == null)
            {
               this._json.campaign[_loc1_] = "みせってい";
            }
            Logger.log(_loc1_ + " / " + this._json.campaign[_loc1_]);
         }
         Logger.log("\n");
         this._titleTf.text = this._json.campaign.campaign_name;
         _loc2_ = FontManager.getIdText("c_bb_3");
         if(this._json.campaign.open_date_from != "みせってい")
         {
            _loc4_ = String(this._json.campaign.open_date_from);
            _loc5_ = _loc4_.split(" ");
            _loc6_ = _loc5_[0].split("-");
            _loc7_ = _loc6_[0];
            _loc8_ = _loc6_[1].slice(0,_loc6_[1].length);
            _loc9_ = _loc6_[2].slice(0,_loc6_[2].length);
            if(_loc8_.length == 1)
            {
               _loc8_ = "0" + _loc8_;
            }
            if(_loc9_.length == 1)
            {
               _loc9_ = "0" + _loc9_;
            }
            _loc10_ = _loc5_[1].split(":");
            _loc11_ = _loc10_[0];
            _loc12_ = _loc10_[1].slice(0,_loc10_[1].length);
            if(_loc11_.length == 1)
            {
               _loc11_ = "0" + _loc11_;
            }
            if(_loc12_.length == 1)
            {
               _loc12_ = "0" + _loc12_;
            }
            _loc2_ = _loc2_.replace(/\[YYYY1\]/g,_loc7_);
            _loc2_ = _loc2_.replace(/\[MM1\]/g,_loc8_);
            _loc2_ = _loc2_.replace(/\[DD1\]/g,_loc9_);
            _loc2_ = _loc2_.replace(/\[hh1\]/g,_loc11_);
            _loc2_ = _loc2_.replace(/\[mm1\]/g,_loc12_);
         }
         if(this._json.campaign.open_date_to != "みせってい")
         {
            _loc13_ = String(this._json.campaign.open_date_to);
            _loc14_ = _loc13_.split(" ");
            _loc15_ = _loc14_[0].split("-");
            _loc16_ = _loc15_[0];
            _loc17_ = _loc15_[1].slice(0,_loc15_[1].length);
            _loc18_ = _loc15_[2].slice(0,_loc15_[2].length);
            if(_loc17_.length == 1)
            {
               _loc17_ = "0" + _loc17_;
            }
            if(_loc18_.length == 1)
            {
               _loc18_ = "0" + _loc18_;
            }
            _loc19_ = _loc14_[1].split(":");
            _loc20_ = _loc19_[0];
            _loc21_ = _loc19_[1].slice(0,_loc19_[1].length);
            if(_loc20_.length == 1)
            {
               _loc20_ = "0" + _loc20_;
            }
            if(_loc21_.length == 1)
            {
               _loc21_ = "0" + _loc21_;
            }
            _loc2_ = _loc2_.replace(/\[YYYY2\]/g,_loc16_);
            _loc2_ = _loc2_.replace(/\[MM2\]/g,_loc17_);
            _loc2_ = _loc2_.replace(/\[DD2\]/g,_loc18_);
            _loc2_ = _loc2_.replace(/\[hh2\]/g,_loc20_);
            _loc2_ = _loc2_.replace(/\[mm2\]/g,_loc21_);
         }
         this._dateTf.text = _loc2_;
         var _loc3_:String = this._json.campaign.campaign_body;
         _loc3_ = _loc3_.replace(/\r\n/g,"\n");
         this._summaryTf.text = _loc3_;
         this._summaryTf.autoSize = "left";
         this._mainimage.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img" + this._json.campaign.visual_main,false);
         if(Number(this._json.campaign.url_flag) == 1)
         {
            this._buttonURL = "/?p=campaignlink&campaign_id=" + this._json.campaign.campaign_id;
            this._viewBt.visible = true;
            this._viewBt.buttonMode = true;
            this._viewBt.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
            this._viewBt.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
            this._viewBt.addEventListener(MouseEvent.CLICK,this.mouseHandler);
         }
         if(PokemonBridge.member_id)
         {
            if(Number(this._json.campaign.is_open) == 0)
            {
               switch(Number(this._json.campaign.days_to))
               {
                  case -2:
                     this.error(2);
                     break;
                  case -1:
                     this.error(3);
                     break;
                  default:
                     this.error(2);
               }
            }
            else if(Number(this._json.campaign.is_challengable) == 0)
            {
               switch(Number(this._json.campaign.cause))
               {
                  case 10:
                     this.error(4);
                     break;
                  case 11:
                     this.error(5);
                     break;
                  case 20:
                     this.error(6);
                     break;
                  case 21:
                     this.error(7);
                     break;
                  case 22:
                     this.error(8);
                     break;
                  case 23:
                     this.error(11);
                     break;
                  case 24:
                     this.error(12);
                     break;
                  case 25:
                     this.error(13);
                     break;
                  case 26:
                     this.error(14);
                     break;
                  case 30:
                     this.error(9);
                     break;
                  case 41:
                     this.error(10);
                     break;
                  case 99:
                     this.notMember();
               }
            }
            else
            {
               this.doCampaign();
            }
         }
         else
         {
            this.notMember();
         }
         if(this._summaryTf.textHeight > 140)
         {
            this._container.content.slider.visible = true;
            this._container.content.sBack.visible = true;
            this._container.content.upBt.visible = true;
            this._container.content.downBt.visible = true;
         }
         this._panelAnimator.stop();
         this._panelAnimator.reset();
         this._panelAnimator.play();
         this._contentAnimator.play(0.6);
      }
      
      private function mouseHandler(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:URLVariables = new URLVariables();
         var _loc3_:MovieClip = MovieClip(param1.currentTarget);
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               switch(param1.currentTarget)
               {
                  case this._closeBt:
                  case this._returnBt:
                  case this._nextBt:
                  case this._inputword.nextBt:
                  case this._inputserial.nextBt:
                  case this._viewBt:
                  case this._entryBt:
                     MouseAnimator.over(_loc3_.bg);
                     break;
                  case this._explainBt:
                     MouseAnimator.over(_loc3_);
               }
               break;
            case MouseEvent.ROLL_OUT:
               switch(param1.currentTarget)
               {
                  case this._closeBt:
                  case this._returnBt:
                  case this._nextBt:
                  case this._inputword.nextBt:
                  case this._inputserial.nextBt:
                  case this._viewBt:
                  case this._entryBt:
                     MouseAnimator.out(_loc3_.bg);
                     break;
                  case this._explainBt:
                     MouseAnimator.out(_loc3_);
               }
               break;
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               switch(param1.currentTarget)
               {
                  case this._closeBt:
                     CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
                     break;
                  case this._returnBt:
                     CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
                     break;
                  case this._explainBt:
                     HelpBridge.forceId = "040";
                     PokemonBridge.callHelp();
                     break;
                  case this._nextBt:
                     _loc2_.campaign_id = this._json.campaign.campaign_id;
                     this.connect(_loc2_);
                     break;
                  case this._inputword.nextBt:
                     _loc2_.campaign_id = this._json.campaign.campaign_id;
                     _loc2_.word = this._inputword.passwordTf.text;
                     this.connect(_loc2_);
                     break;
                  case this._inputserial.nextBt:
                     PokemonBridge.tag("pgl.campaign_serial_next");
                     if(this._json.campaign.selection != "みせってい")
                     {
                        if(CampaignSelectBridge.id)
                        {
                           _loc2_.sub_id = CampaignSelectBridge.id;
                           _loc2_.campaign_id = this._json.campaign.campaign_id;
                           _loc2_.serial_key = this._inputserial.passwordTf.text;
                           this.connect(_loc2_);
                           break;
                        }
                        PokemonBridge.alertWindow(FontManager.getIdText("c_bi_6"),PokemonBridge.WITH_FADEOUT);
                        break;
                     }
                     _loc2_.campaign_id = this._json.campaign.campaign_id;
                     _loc2_.serial_key = this._inputserial.passwordTf.text;
                     this.connect(_loc2_);
                     break;
                  case this._viewBt:
                     _loc4_ = "_self";
                     if(Number(this._json.campaign.url_link_type) == 2)
                     {
                        _loc4_ = "_brank";
                     }
                     PokemonBridge.href(this._buttonURL,_loc4_);
                     break;
                  case this._entryBt:
                     _loc5_ = "";
                     switch(PokemonBridge.lang)
                     {
                        case "en":
                           _loc5_ = "https://www.pokemon.com/us/account/pgl/signup/";
                           break;
                        case "es":
                        case "fr":
                        case "it":
                        case "de":
                           _loc5_ = "https://www.pokemon.com/" + PokemonBridge.lang + "/account/pgl/signup/";
                           break;
                        case "ko":
                           _loc5_ = "http://pokemonkorea.co.kr/PGL/footer/about_entry.asp";
                           break;
                        case "ja":
                           _loc5_ = "https://members.pokemon.jp/about_entry/index.html";
                     }
                     PokemonBridge.href(_loc5_,"_brank");
               }
         }
      }
      
      private function connect(param1:URLVariables) : void
      {
         PokemonBridge.ApiConnect();
         this._connector = new ConnectorDataBase();
         this._connector.addEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
         this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
         this._connector.connect(ConnectorPATH.DB_CAMPAIGN_CHECK,param1,false,"POST");
      }
      
      private function overHandler(param1:Event = null) : void
      {
         switch(param1.currentTarget)
         {
            case this._upBt:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._container.content.upBt.arrow,{
                  "y":2,
                  "time":0.1,
                  "delay":0,
                  "transition":"linear"
               });
               Tweener.addTween(this._container.content.upBt.arrow,{
                  "y":4,
                  "time":0.2,
                  "delay":0.1,
                  "transition":"linear"
               });
               MouseAnimator.over(this._container.content.upBt.bg);
               break;
            case this._downBt:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._container.content.downBt.arrow,{
                  "y":7,
                  "time":0.1,
                  "delay":0,
                  "transition":"linear"
               });
               Tweener.addTween(this._container.content.downBt.arrow,{
                  "y":5,
                  "time":0.2,
                  "delay":0.1,
                  "transition":"linear"
               });
               MouseAnimator.over(this._container.content.downBt.bg);
               break;
            case this._slider:
               PokemonBridge.mouseOverSound();
         }
      }
      
      private function wheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(this._container.mouseX,this._container.mouseY);
         var _loc3_:Rectangle = this._container.panel.getRect(this._container);
         if(_loc3_.containsPoint(_loc2_) && this._summaryTf.height > 140)
         {
            this._summaryTf.y += Number(param1.delta) * 5;
            if(this._summaryTf.y < -this._summaryTf.height + 140 + 108)
            {
               this._summaryTf.y = -this._summaryTf.height + 140 + 108;
            }
            if(this._summaryTf.y > 108)
            {
               this._summaryTf.y = 108;
            }
            this._slider.y = (this._summaryTf.y - 108) * 64 / (140 - this._summaryTf.height) + 131;
         }
      }
      
      public function close() : void
      {
         if(this._connector)
         {
            this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.connectHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.connectHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.connectHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
            this._connector.disconnect();
            this._connector = null;
         }
         this._containerAnimator.addEventListener(ContainerAnimator.PLAY_FINISH,this.onPlayFinish);
         this._containerAnimator.play(ContainerAnimator.PLAY_TYPE_CLOSE);
         MouseAnimator.reset(this._closeBt.bg);
         MouseAnimator.reset(this._returnBt.bg);
         MouseAnimator.reset(this._nextBt.bg);
         MouseAnimator.reset(this._inputword.nextBt.bg);
         MouseAnimator.reset(this._inputserial.nextBt.bg);
         MouseAnimator.reset(this._viewBt.bg);
         MouseAnimator.reset(this._entryBt.bg);
         MouseAnimator.reset(this._explainBt);
         if(this._loader)
         {
            if(this._loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
            {
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
               this._container.content.removeChild(this._loader);
            }
            this._loader.unloadAndStop();
            this._loader = null;
         }
         this._mainimage.close();
         this._subimage.close();
         this._container.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.wheelHandler);
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
         this._closeBt.buttonMode = false;
         this._closeBt.buttonMode = false;
         this._closeBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._closeBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._closeBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._viewBt.buttonMode = false;
         this._viewBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._viewBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._viewBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._entryBt.buttonMode = false;
         this._entryBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._entryBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._entryBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._explainBt.buttonMode = false;
         this._explainBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._explainBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._explainBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._inputword.nextBt.buttonMode = false;
         this._inputword.nextBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._inputword.nextBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._inputword.nextBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         this._inputserial.nextBt.buttonMode = false;
         this._inputserial.nextBt.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._inputserial.nextBt.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._inputserial.nextBt.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
      }
   }
}


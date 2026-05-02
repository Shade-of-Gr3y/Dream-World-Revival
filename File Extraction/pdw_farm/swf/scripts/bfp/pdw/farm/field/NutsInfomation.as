package bfp.pdw.farm.field
{
   import bfp.PDWBridge;
   import bfp.common.FukidashiAnimator;
   import bfp.common.Logger;
   import bfp.common.kinomiLoader;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.common_y.effect.BtnEffect;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import bfp.pokemon.liby.event.CustomEvent;
   import bfp.pokemon.liby.util.BtnSetting;
   import caurina.transitions.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol132")]
   public class NutsInfomation extends MovieClip
   {
      
      public var areaMC:MovieClip;
      
      public var inner:MovieClip;
      
      public var inner2:NutsInfomationFukidashi;
      
      private var innerMC:MovieClip;
      
      private var innerMC2:NutsInfomationFukidashi;
      
      private var nutsNameTxt:TextField;
      
      private var nutsArea:MovieClip;
      
      private var hitareaMC:MovieClip;
      
      private var detailBtn:MovieClip;
      
      private var detailBtnTxt:TextField;
      
      private var btnInner:MovieClip;
      
      private var frameMC:MovieClip;
      
      private var maskMC:MovieClip;
      
      private var bgMC:MovieClip;
      
      private var tunoMC:MovieClip;
      
      private var noWaterMC:MovieClip;
      
      private var noWaterTxt:TextField;
      
      private var loader:kinomiLoader;
      
      private var fukidashiAnimator:FukidashiAnimator;
      
      private var fukidashiAnimator2:FukidashiAnimator;
      
      private var nutsID:*;
      
      private var nutsName:*;
      
      private var uneID:*;
      
      private var fieldID:*;
      
      private var type:String = "watering";
      
      private var isHit:Boolean = false;
      
      private var isOldHit:Boolean = false;
      
      private var isTutorial:Boolean = false;
      
      private var minWid:Number = 100;
      
      private var paddingX:Number = 5;
      
      private var nutsMessageObj:Object;
      
      private var hitTimer:Timer;
      
      private var filePath:FarmFilePath;
      
      private var data:FarmData;
      
      private var detailBtnTxtY:Number = 0;
      
      private var nutsNameTxtY:Number = 0;
      
      private var noWaterTxtY:Number = 0;
      
      public function NutsInfomation()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.filePath = FarmFilePath.getInstance();
         this.data = FarmData.getInstance();
         this.innerMC = this.inner;
         this.nutsArea = this.innerMC.nutsArea;
         this.hitareaMC = this.areaMC;
         this.hitareaMC.alpha = 0;
         this.hitareaMC.visible = false;
         this.hitareaMC.scaleY = 0;
         this.detailBtn = this.innerMC.detailBtn;
         this.detailBtn.mouseChildren = false;
         this.detailBtnTxt = this.detailBtn.txt.t;
         this.detailBtnTxtY = 0;
         this.btnInner = this.hitareaMC.btnInner;
         this.nutsNameTxt = this.innerMC.nutsNameTxt;
         this.nutsNameTxt.autoSize = TextFieldAutoSize.CENTER;
         this.nutsNameTxt.selectable = false;
         this.nutsNameTxt.multiline = true;
         this.nutsNameTxt.wordWrap = false;
         this.nutsNameTxtY = -69;
         this.frameMC = this.innerMC.frame_mc;
         this.maskMC = this.innerMC.mask_mc;
         this.bgMC = this.innerMC.bg_mc;
         this.tunoMC = this.innerMC.tuno_mc;
         this.noWaterMC = this.innerMC.noWaterTxtMC;
         this.noWaterTxt = this.noWaterMC.txt;
         this.noWaterTxtY = 0;
         this.bgMC.mask = this.maskMC;
         this.innerMC2 = this.inner2;
         this.innerMC2.mouseEnabled = false;
         this.innerMC2.mouseChildren = false;
         this.loader = new kinomiLoader(this.filePath.getNutsImgPath35());
         this.hitTimer = new Timer(1000 / 30);
         this.hitTimer.addEventListener(TimerEvent.TIMER,this.onHitTimerLoop);
         this.fukidashiAnimator = new FukidashiAnimator(this.innerMC);
         this.fukidashiAnimator2 = new FukidashiAnimator(this.innerMC2);
         this.resetContent();
      }
      
      public function resetContent() : *
      {
         this.visible = false;
         this.alpha = 0;
         this.nutsNameTxt.text = "";
         this.isHit = this.isOldHit = false;
      }
      
      public function stopContent() : *
      {
         Tweener.removeTweens(this);
         Tweener.removeTweens(this.innerMC);
         this.stopHitTimer();
         if(this.loader.content != null)
         {
            this.loader.unloadSwf();
         }
      }
      
      public function runContent() : *
      {
         this.detailBtnTxt.y = this.detailBtnTxtY;
         Localize.setText(this.detailBtnTxt,"k_ag_1");
         this.detailBtnTxt.autoSize = TextFieldAutoSize.CENTER;
         this.detailBtnTxt.selectable = false;
         this.detailBtnTxt.multiline = false;
         this.detailBtnTxt.wordWrap = false;
      }
      
      public function show(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:* = 0, param10:* = "") : *
      {
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         this.type = param1;
         this.nutsID = param2;
         this.nutsMessageObj = param3;
         this.uneID = param4;
         this.fieldID = param5;
         this.x = Math.floor(param6);
         this.y = Math.floor(param7);
         this.visible = false;
         this.alpha = 0;
         var _loc15_:String = "";
         switch(param1)
         {
            case this.data.FUKIDASHI_TYPE_NONE:
               this.innerMC.visible = false;
               this.innerMC.width = this.innerMC2.width;
               this.innerMC.height = this.innerMC2.height;
               this.innerMC2.visible = true;
               this.innerMC2.scaleX = this.innerMC2.scaleY = 1;
               break;
            case this.data.FUKIDASHI_TYPE_WATERING:
            case this.data.FUKIDASHI_TYPE_HARVEST:
               this.innerMC.visible = true;
               this.innerMC.scaleX = this.innerMC.scaleY = 1;
               this.innerMC2.visible = false;
               this.innerMC.x = 0;
               this.innerMC.y = -10;
               _loc15_ = this.getInfomationID(this.nutsMessageObj.plantStatus);
               this.nutsNameTxt.y = this.nutsNameTxtY;
               Localize.setAutoFontTextString(this.nutsNameTxt,_loc15_,this.nutsMessageObj.nutsName);
               this.nutsNameTxt.height = this.nutsNameTxt.textHeight + 4;
               this.nutsNameTxt.autoSize = TextFieldAutoSize.CENTER;
               this.noWaterTxt.y = this.noWaterTxtY;
               Localize.setText(this.noWaterTxt,"k_aha_1");
               if(param10 == "")
               {
                  this.noWaterTxt.text = "";
               }
               this.noWaterTxt.height = this.noWaterTxt.textHeight + 4;
               this.noWaterTxt.autoSize = TextFieldAutoSize.CENTER;
               _loc14_ = Math.floor(Math.max(this.nutsNameTxt.textWidth,this.noWaterTxt.textWidth));
               _loc11_ = Math.floor(Math.max(_loc14_,this.minWid) + this.paddingX * 2);
               _loc12_ = _loc11_ % 2;
               if(_loc12_ == 1)
               {
                  _loc11_ += 1;
               }
               if(param10 == "")
               {
                  param8 = 128;
                  this.noWaterMC.visible = false;
               }
               else
               {
                  param8 = 168;
                  this.noWaterMC.visible = true;
               }
               this.frameMC.width = _loc11_;
               this.frameMC.height = param8;
               this.maskMC.width = _loc11_ - 2;
               this.maskMC.height = param8 - 2;
               this.bgMC.width = _loc11_ - 2;
               this.bgMC.height = param8 - 2;
               this.innerMC2.width = this.innerMC.width;
               this.loadImg();
         }
         Tweener.addTween(this,{
            "delay":param9,
            "onComplete":this.showAnime
         });
      }
      
      public function showNone(param1:*, param2:*, param3:*, param4:* = 0) : *
      {
         this.type = param1;
         this.x = Math.floor(param2);
         this.y = Math.floor(param3);
         this.visible = false;
         this.alpha = 0;
         this.innerMC.visible = false;
         this.innerMC2.visible = true;
         if(this.data.isFriendMode)
         {
            this.innerMC2.setMessage("k_ada_1");
         }
         else
         {
            this.innerMC2.setMessage("k_ae_2");
         }
         this.innerMC.width = this.innerMC2.width;
         this.innerMC.height = this.innerMC2.height;
         this.innerMC2.scaleX = this.innerMC2.scaleY = 1;
         Tweener.addTween(this,{
            "delay":param4,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.visible = true;
         this.alpha = 1;
         switch(this.type)
         {
            case this.data.FUKIDASHI_TYPE_NONE:
               this.fukidashiAnimator2.addEventListener(FukidashiAnimator.SHOW_FINISH,this.onShowFinish2);
               this.fukidashiAnimator2.show();
               break;
            case this.data.FUKIDASHI_TYPE_WATERING:
            case this.data.FUKIDASHI_TYPE_HARVEST:
               this.fukidashiAnimator.addEventListener(FukidashiAnimator.SHOW_FINISH,this.onShowFinish);
               this.fukidashiAnimator.show();
         }
      }
      
      private function onShowFinish(param1:Event) : *
      {
         this.fukidashiAnimator.removeEventListener(FukidashiAnimator.SHOW_FINISH,this.onShowFinish);
         this.showEnd();
      }
      
      private function showEnd() : *
      {
         this.setBtnFunc();
      }
      
      private function onShowFinish2(param1:Event) : *
      {
         this.fukidashiAnimator2.removeEventListener(FukidashiAnimator.SHOW_FINISH,this.onShowFinish2);
      }
      
      public function hide(param1:* = 0) : *
      {
         this.clearBtnFunc();
         this.stopHitTimer();
         Tweener.addTween(this,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         this.fukidashiAnimator.hide();
         this.fukidashiAnimator2.hide();
         this.hideEnd();
      }
      
      private function hideEnd() : *
      {
         this.stopContent();
         this.resetContent();
         dispatchEvent(new CustomEvent("onFukidashiHideEnd"));
      }
      
      private function getInfomationID(param1:*) : *
      {
         var _loc2_:* = "";
         switch(param1)
         {
            case this.data.PLANT_STATUS_SOIL:
               _loc2_ = "k_ag_2";
               break;
            case this.data.PLANT_STATUS_SPROUT:
               _loc2_ = "k_ai_1";
               break;
            case this.data.PLANT_STATUS_TRUNK:
               _loc2_ = "k_aj_1";
               break;
            case this.data.PLANT_STATUS_FLOWER:
               _loc2_ = "k_ak_1";
               break;
            case this.data.PLANT_STATUS_FRUIT:
               _loc2_ = "k_al_1";
         }
         return _loc2_;
      }
      
      private function setBtnFunc() : *
      {
         BtnSetting.addBtn(this.detailBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
      }
      
      private function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.detailBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":false
         });
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.detailBtn:
               PDWBridge.sfxClick();
               dispatchEvent(new CustomEvent("onFukidashiDetailClick"));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.detailBtn:
               PDWBridge.sfxMouseOver();
               BtnEffect.bgOver(this.detailBtn.bg);
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.detailBtn:
               BtnEffect.bgOut(this.detailBtn.bg);
         }
      }
      
      public function ovarAnime() : *
      {
      }
      
      public function clickAnime() : *
      {
         switch(this.type)
         {
            case this.data.FUKIDASHI_TYPE_WATERING:
               dispatchEvent(new CustomEvent("onFukidashiWateringClick"));
               break;
            case this.data.FUKIDASHI_TYPE_HARVEST:
               dispatchEvent(new CustomEvent("onFukidashiHarvestClick"));
         }
      }
      
      private function startHitTiemr() : *
      {
         this.isHit = this.isOldHit = true;
         this.hitTimer.reset();
         this.hitTimer.start();
      }
      
      private function stopHitTimer() : *
      {
         this.hitTimer.stop();
         this.hitTimer.reset();
      }
      
      private function onHitTimerLoop(param1:TimerEvent) : *
      {
         this.isOldHit = this.isHit;
         this.isHit = this.hitareaMC.hitTestPoint(this.root.mouseX,this.root.mouseY,true);
         if(!this.isHit && this.isOldHit)
         {
            dispatchEvent(new CustomEvent("onFukidashiClose"));
         }
      }
      
      private function loadImg() : *
      {
         if(this.loader.content != null)
         {
            this.loader.unload();
         }
         this.loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
         this.loader.loadSwf(this.nutsID);
      }
      
      private function onLoadComplete(param1:Event) : *
      {
         this.loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
         this.loader.x = -Math.floor(this.loader.width / 2);
         this.loader.y = -Math.floor(this.loader.height / 2);
         this.nutsArea.addChild(this.loader);
      }
      
      private function onLoadError(param1:IOErrorEvent) : *
      {
         Logger.log("はたけ　情報フキダシ　きのみイメージロードエラー");
      }
   }
}


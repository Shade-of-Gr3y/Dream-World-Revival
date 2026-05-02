package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.common.Logger;
   import bfp.common.PanelScaleAnimator;
   import bfp.common.kinomiLoader;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.common_y.PanelBg;
   import bfp.pdw.common_y.effect.BtnEffect;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import bfp.pokemon.liby.event.CustomEvent;
   import bfp.pokemon.liby.util.BtnSetting;
   import bfp.pokemon.liby.util.McInit;
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
   
   public class DetailPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var closeBtn:MovieClip;
      
      private var closeBtnTxt:TextField;
      
      private var descriptionMC:MovieClip;
      
      private var descriptionTxt:TextField;
      
      private var nutsArea:MovieClip;
      
      private var nutsNameMC:MovieClip;
      
      private var nutsNameTxt:TextField;
      
      private var loader:kinomiLoader;
      
      private var bgObj:PanelBg;
      
      private var panelAnimator:PanelScaleAnimator;
      
      private var nutsID:*;
      
      private var nutsName:String = "";
      
      private var nutsDescription:String = "";
      
      private var wid:Number = 352;
      
      private var hei:Number = 232;
      
      private var filePath:FarmFilePath;
      
      private var data:FarmData;
      
      private var closeBtnTxtY:Number = 0;
      
      private var descriptionTxtY:Number = 0;
      
      private var nutsNameTxtY:Number = 0;
      
      public function DetailPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.filePath = FarmFilePath.getInstance();
         this.data = FarmData.getInstance();
         McInit.initParam(this.targetMC);
         this.closeBtn = this.targetMC.closeBtn;
         this.closeBtn.mouseChildren = false;
         this.closeBtnTxt = this.closeBtn.txt.t;
         this.closeBtnTxt.y = 0;
         this.nutsArea = this.targetMC.nutsArea;
         this.descriptionMC = this.targetMC.descriptionMC;
         this.descriptionTxt = this.descriptionMC.descriptionTxt;
         this.descriptionTxt.y = 0;
         this.nutsNameMC = this.targetMC.nutsNameMC;
         this.nutsNameTxt = this.nutsNameMC.nutsNameTxt;
         this.nutsNameTxt.y = 0;
         this.loader = new kinomiLoader(this.filePath.getNutsImgPath57());
         this.bgObj = new PanelBg(this.wid,this.hei);
         this.targetMC.addChildAt(this.bgObj,0);
         this.panelAnimator = new PanelScaleAnimator(this.targetMC,this.wid,this.hei);
         this.reset();
      }
      
      public function reset() : *
      {
         this.panelAnimator.reset();
         BtnEffect.bgReset(this.closeBtn.bg);
         this.descriptionTxt.text = "";
         this.nutsNameTxt.text = "";
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         if(this.loader != null)
         {
            if(this.loader.content != null)
            {
               this.loader.unloadSwf();
               this.loader.unload();
            }
         }
         this.panelAnimator.removeEventListener(PanelScaleAnimator.HIDE_FINISH,this.onHideFinish);
         this.panelAnimator.removeEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowFinish);
      }
      
      public function run() : *
      {
         this.closeBtnTxt.y = this.closeBtnTxtY;
         Localize.setText(this.closeBtnTxt,"s_ad_2");
         this.closeBtnTxt.selectable = false;
         this.closeBtnTxt.multiline = false;
         this.closeBtnTxt.wordWrap = false;
      }
      
      public function show(param1:*, param2:*, param3:*, param4:* = 0) : *
      {
         this.nutsID = param1;
         this.nutsName = param2;
         this.nutsDescription = param3;
         this.descriptionTxt.y = this.descriptionTxtY;
         Localize.setTextAndFormatTag(this.descriptionTxt,param3,"k_det_2");
         this.descriptionTxt.autoSize = TextFieldAutoSize.CENTER;
         this.descriptionTxt.width = 330;
         this.descriptionTxt.selectable = false;
         this.descriptionTxt.multiline = true;
         this.descriptionTxt.wordWrap = true;
         this.descriptionTxt.height = this.descriptionTxt.textHeight + 4;
         this.nutsNameTxt.y = this.nutsNameTxtY;
         Localize.setTextAndFormatTag(this.nutsNameTxt,param2,"k_det_1");
         this.nutsNameTxt.autoSize = TextFieldAutoSize.CENTER;
         this.nutsNameTxt.selectable = false;
         this.nutsNameTxt.multiline = false;
         this.nutsNameTxt.wordWrap = false;
         this.nutsNameTxt.height = this.nutsNameTxt.textHeight + 4;
         this.loadImg();
         this.bgObj.setSize(this.wid,this.hei);
         this.targetMC.x = Math.floor((this.data.STAGE_WID - this.wid) / 2);
         this.targetMC.y = Math.floor((this.data.HEIGHT - this.hei) / 2);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.wid;
         this.panelAnimator.defaultH = this.hei;
         this.panelAnimator.reset();
         this.nutsArea.x = Math.floor(this.wid / 2);
         this.nutsNameMC.x = Math.floor(this.wid / 2);
         this.descriptionMC.x = Math.floor(this.wid / 2);
         this.closeBtn.x = Math.floor((this.wid - this.closeBtn.width) / 2);
         Tweener.addTween(this.targetMC,{
            "delay":param4,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.panelAnimator.addEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowFinish);
         this.panelAnimator.show();
      }
      
      private function onShowFinish(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowFinish);
         this.showEnd();
      }
      
      private function showEnd() : *
      {
         this.setBtnFunc();
      }
      
      public function hide(param1:* = 0) : *
      {
         this.clearBtnFunc();
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         this.panelAnimator.addEventListener(PanelScaleAnimator.HIDE_FINISH,this.onHideFinish);
         this.panelAnimator.hide();
      }
      
      private function onHideFinish(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelScaleAnimator.HIDE_FINISH,this.onHideFinish);
         this.hideEnd();
      }
      
      private function hideEnd() : *
      {
         this.stop();
         this.reset();
      }
      
      private function setBtnFunc() : *
      {
         BtnSetting.addBtn(this.closeBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
      }
      
      private function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.closeBtn,{
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
            case this.closeBtn:
               PDWBridge.sfxClick();
               dispatchEvent(new CustomEvent("onDetailPanelCloseClick"));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.closeBtn:
               PDWBridge.sfxMouseOver();
               BtnEffect.bgOver(this.closeBtn.bg);
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.closeBtn:
               BtnEffect.bgOut(this.closeBtn.bg);
         }
      }
      
      private function loadImg() : *
      {
         if(this.loader.content != null)
         {
            this.loader.unloadSwf();
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
         Logger.log("はたけ　詳細情報パネル　きのみイメージロードエラー");
      }
   }
}


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
   
   public class PlantFinishPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var closeBtn:MovieClip;
      
      private var closeBtnTxt:TextField;
      
      private var dialogMC:MovieClip;
      
      private var dialogTxt:TextField;
      
      private var nutsNameMC:MovieClip;
      
      private var nutsNameTxt:TextField;
      
      private var nutsArea:MovieClip;
      
      private var loader:kinomiLoader;
      
      private var bgObj:PanelBg;
      
      private var panelAnimator:PanelScaleAnimator;
      
      private var nutsID:*;
      
      private var nutsName:*;
      
      private var wid:Number = 352;
      
      private var hei:Number = 232;
      
      private var filePath:FarmFilePath;
      
      private var data:FarmData;
      
      private var dialogTxtY:Number = 0;
      
      private var nutsNameTxtY:Number = 0;
      
      private var closeBtnTxtY:Number = 0;
      
      public function PlantFinishPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.filePath = FarmFilePath.getInstance();
         McInit.initParam(this.targetMC);
         this.closeBtn = this.targetMC.closeBtn;
         this.closeBtn.mouseChildren = false;
         this.closeBtnTxt = this.closeBtn.txt.t;
         this.closeBtnTxtY = 0;
         this.dialogMC = this.targetMC.dialogMC;
         this.dialogTxt = this.dialogMC.dialogTxt;
         this.dialogTxtY = 0;
         this.nutsNameMC = this.targetMC.nutsNameMC;
         this.nutsNameTxt = this.nutsNameMC.nutsNameTxt;
         this.nutsNameTxtY = 0;
         this.nutsArea = this.targetMC.nutsArea;
         this.loader = new kinomiLoader(this.filePath.getNutsImgPath57());
         this.bgObj = new PanelBg(this.wid,this.hei);
         this.targetMC.addChildAt(this.bgObj,0);
         this.panelAnimator = new PanelScaleAnimator(this.targetMC,this.targetMC.width,this.targetMC.height);
         this.reset();
      }
      
      public function reset() : *
      {
         this.panelAnimator.reset();
         BtnEffect.bgReset(this.closeBtn.bg);
         this.dialogTxt.text = "";
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
         this.panelAnimator.removeEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowFinish);
         this.panelAnimator.removeEventListener(PanelScaleAnimator.HIDE_FINISH,this.onHideFinish);
      }
      
      public function run() : *
      {
         this.closeBtnTxt.y = this.closeBtnTxtY;
         Localize.setText(this.closeBtnTxt,"s_ad_2");
         this.closeBtnTxt.autoSize = TextFieldAutoSize.CENTER;
         this.closeBtnTxt.selectable = false;
         this.closeBtnTxt.multiline = false;
         this.closeBtnTxt.wordWrap = false;
      }
      
      public function show(param1:*, param2:*, param3:* = 0) : *
      {
         this.nutsID = param1;
         this.nutsName = param2;
         this.dialogTxt.y = this.dialogTxtY;
         Localize.setAutoFontTextString(this.dialogTxt,"k_afff_1",param2);
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.dialogTxt.selectable = false;
         this.dialogTxt.multiline = false;
         this.dialogTxt.wordWrap = false;
         this.nutsNameTxt.y = this.nutsNameTxtY;
         Localize.setTextAndFormatTag(this.nutsNameTxt,param2,"K_afff_2");
         this.nutsNameTxt.autoSize = TextFieldAutoSize.CENTER;
         this.nutsNameTxt.selectable = false;
         this.nutsNameTxt.multiline = false;
         this.nutsNameTxt.wordWrap = false;
         this.loadImg();
         this.bgObj.setSize(this.wid,this.hei);
         this.dialogMC.x = Math.floor(this.wid / 2);
         this.nutsArea.x = Math.floor(this.wid / 2);
         this.nutsNameMC.x = Math.floor(this.wid / 2);
         this.closeBtn.x = Math.floor((this.wid - this.closeBtn.width) / 2);
         this.targetMC.x = Math.floor((this.data.STAGE_WID - this.wid) / 2);
         this.targetMC.y = Math.floor((this.data.HEIGHT - this.hei) / 2);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.wid;
         this.panelAnimator.defaultH = this.hei;
         this.panelAnimator.reset();
         Tweener.addTween(this.targetMC,{
            "delay":param3,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.panelAnimator.addEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowFinish);
         this.panelAnimator.reset();
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
               dispatchEvent(new CustomEvent("onPlantFinishPanelCloseClick"));
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
         Logger.log("はたけ　植えた後確認パネル　きのみイメージロードエラー");
      }
   }
}


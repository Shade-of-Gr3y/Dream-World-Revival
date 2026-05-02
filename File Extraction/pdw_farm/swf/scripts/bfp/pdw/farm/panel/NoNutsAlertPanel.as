package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.common_y.PanelBg;
   import bfp.pdw.common_y.animation.PanelRotationAnimator;
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
   
   public class NoNutsAlertPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var copy1MC:MovieClip;
      
      private var copy1Txt:TextField;
      
      private var copy2MC:MovieClip;
      
      private var copy2Txt:TextField;
      
      private var closeBtn:MovieClip;
      
      private var closeBtnTxt:TextField;
      
      private var bgObj:PanelBg;
      
      private var _bm:Bitmap;
      
      private var _bmd:BitmapData;
      
      private var panelAnimator:PanelRotationAnimator;
      
      private var nutsID:*;
      
      private var wid:Number = 354;
      
      private var hei:Number = 192;
      
      private var delayTimer:Timer;
      
      private var data:FarmData;
      
      private var copy1TxtY:Number = 0;
      
      private var copy2TxtY:Number = 0;
      
      private var closeBtnTxtY:Number = 0;
      
      public function NoNutsAlertPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         McInit.initParam(this.targetMC);
         this.closeBtn = this.targetMC.closeBtn;
         this.closeBtn.mouseChildren = false;
         this.closeBtnTxt = this.closeBtn.txt.t;
         this.closeBtnTxtY = 0;
         this._bm = new Bitmap(null,"auto",true);
         this.copy1MC = this.targetMC.copy1MC;
         this.copy1MC.x = Math.floor(this.wid / 2);
         this.copy1MC.dy = this.copy1MC.y;
         this.copy1Txt = this.copy1MC.txt;
         this.copy1TxtY = 0;
         this.copy2MC = this.targetMC.copy2MC;
         this.copy2MC.x = Math.floor(this.wid / 2);
         this.copy2MC.dy = this.copy2MC.y;
         this.copy2Txt = this.copy2MC.txt;
         this.copy2TxtY = 0;
         this.bgObj = new PanelBg(this.wid,this.hei);
         this.targetMC.addChildAt(this.bgObj,0);
         this.targetMC.x = Math.floor((this.data.STAGE_WID - this.wid) / 2);
         this.targetMC.y = Math.floor((this.data.HEIGHT - this.hei) / 2);
         this.delayTimer = new Timer(5000,1);
         this.panelAnimator = new PanelRotationAnimator(this.targetMC,this.wid,this.hei);
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc1_.contains(this.panelAnimator.display))
         {
            _loc1_.removeChild(this.panelAnimator.display);
         }
         this.panelAnimator.reset();
         BtnEffect.bgReset(this.closeBtn.bg);
         if(this._bmd != null)
         {
            this._bmd.dispose();
            this._bmd = null;
         }
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowAnime);
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish);
         this.panelAnimator.stop();
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
      
      private function initalizeNoNuts() : *
      {
         this.copy1Txt.y = this.copy1TxtY;
         Localize.setText(this.copy1Txt,"k_ca_1");
         this.copy1Txt.autoSize = TextFieldAutoSize.CENTER;
         this.copy1Txt.selectable = false;
         this.copy1Txt.multiline = false;
         this.copy1Txt.wordWrap = false;
         this.copy2MC.y = this.copy2MC.dy;
         this.copy2Txt.y = this.copy2TxtY;
         Localize.setText(this.copy2Txt,"k_ca_2");
         this.copy2Txt.width = 340;
         this.copy2Txt.selectable = false;
         this.copy2Txt.multiline = true;
         this.copy2Txt.wordWrap = true;
         this.copy2MC.y = this.copy2MC.dy;
         this.closeBtn.visible = true;
      }
      
      private function initalizeNoWater() : *
      {
         this.copy1Txt.y = this.copy1TxtY;
         Localize.setText(this.copy1Txt,"k_ahb_1");
         this.copy1Txt.autoSize = TextFieldAutoSize.CENTER;
         this.copy1Txt.width = 330;
         this.copy1Txt.selectable = false;
         this.copy1Txt.multiline = true;
         this.copy1Txt.wordWrap = true;
         this.copy1MC.y = 50;
         this.copy2Txt.y = this.copy2TxtY;
         Localize.setText(this.copy2Txt,"k_ahb_2");
         this.copy2Txt.width = 330;
         this.copy2Txt.selectable = false;
         this.copy2Txt.multiline = true;
         this.copy2Txt.wordWrap = true;
         this.copy2MC.y = 118;
         this.closeBtn.visible = false;
      }
      
      public function show(param1:* = 0, param2:* = "") : *
      {
         this.targetMC.visible = false;
         var _loc3_:* = this.wid;
         var _loc4_:* = this.hei;
         switch(param2)
         {
            case this.data.ALERT_TYPE_NO_NUTS:
               this.initalizeNoNuts();
               break;
            case this.data.ALERT_TYPE_NO_WATER:
               this.initalizeNoWater();
               _loc3_ = 340;
               _loc4_ = 192;
               this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayTimerComplete);
               this.delayTimer.reset();
               this.delayTimer.start();
         }
         this.copy1MC.x = Math.floor(_loc3_ / 2);
         this.copy2MC.x = Math.floor(_loc3_ / 2);
         this.closeBtn.x = Math.floor((_loc3_ - this.closeBtn.width) / 2);
         this.bgObj.setSize(_loc3_,this.hei);
         this.targetMC.x = Math.floor((this.data.STAGE_WID - _loc3_) / 2);
         this.targetMC.y = Math.floor((this.data.HEIGHT - _loc4_) / 2);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = _loc3_;
         this.panelAnimator.defaultH = _loc4_;
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         PokemonBridge.alertSound();
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowAnime);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.show();
      }
      
      private function onShowAnime(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowAnime);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
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
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.addEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish);
         this.panelAnimator.hide();
         this.targetMC.visible = false;
      }
      
      private function onHideFinish(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.hideEnd();
      }
      
      private function hideEnd() : *
      {
         this.stop();
         this.reset();
      }
      
      private function onDelayTimerComplete(param1:TimerEvent) : *
      {
         this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayTimerComplete);
         dispatchEvent(new CustomEvent("onNoNutsAlertPanelCloseClick"));
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
         PDWBridge.sfxClick();
         switch(_loc2_)
         {
            case this.closeBtn:
               dispatchEvent(new CustomEvent("onNoNutsAlertPanelCloseClick"));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         PDWBridge.sfxMouseOver();
         switch(_loc2_)
         {
            case this.closeBtn:
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
   }
}


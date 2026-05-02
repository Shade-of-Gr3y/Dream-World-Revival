package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
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
   
   public class AddFurrowAlertPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var closeBtn:MovieClip;
      
      private var closeBtnTxt:TextField;
      
      private var dialogTxt:TextField;
      
      private var bgObj:PanelBg;
      
      private var panelAnimator:PanelRotationAnimator;
      
      private var data:FarmData;
      
      public const MESSAGE_SHOWDIGDA:String = "showDigda";
      
      public const MESSAGE_PLOW:String = "plow";
      
      public const MESSAGE_BACKDIGDA:String = "backDigda";
      
      public const MESSAGE_ADD:String = "addFlow";
      
      public const MESSAGE_RESULT:String = "result";
      
      public const WID:* = 1003;
      
      public const HEI:* = 518;
      
      private var marginTop:Number = 35;
      
      private var marginBottom:Number = 35;
      
      private var marginLeft:Number = 50;
      
      private var marginRight:Number = 50;
      
      private var spaceH:Number = 20;
      
      private var closeBtnTxtY:Number = 0;
      
      private var dialogTxtY:Number = 0;
      
      public function AddFurrowAlertPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         McInit.initParam(this.targetMC);
         this.bgObj = new PanelBg();
         this.targetMC.addChildAt(this.bgObj,0);
         this.closeBtn = this.targetMC.closeBtn;
         this.closeBtn.mouseChildren = false;
         this.closeBtnTxt = this.closeBtn.txt.t;
         this.closeBtnTxtY = 0;
         this.dialogTxt = this.targetMC.dialogTxt;
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.targetMC.addChild(this.dialogTxt);
         this.panelAnimator = new PanelRotationAnimator(this.targetMC,this.targetMC.width,this.targetMC.height);
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         BtnEffect.bgReset(this.closeBtn.bg);
         this.panelAnimator.reset();
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         this.panelAnimator.stop();
      }
      
      public function run() : *
      {
         this.setTF(this.dialogTxt);
         Localize.setText(this.closeBtnTxt,"s_ad_2");
         this.closeBtnTxt.selectable = false;
         this.closeBtnTxt.multiline = false;
         this.closeBtnTxt.wordWrap = false;
      }
      
      public function show(param1:* = 0) : *
      {
         Localize.setText(this.dialogTxt,"k_as_1");
         this.setTF(this.dialogTxt);
         this.updatePanel();
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
         this.targetMC.visible = false;
      }
      
      private function showAnime() : *
      {
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.targetMC.width;
         this.panelAnimator.defaultH = this.targetMC.height;
         this.panelAnimator.show();
      }
      
      private function onShowFinish(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":1,
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
         this.showAnime2();
      }
      
      private function showAnime2() : *
      {
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         Localize.setAutoFontTextString(this.dialogTxt,"k_at_1",PDWHomeData.myPGLName);
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.updatePanel();
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish2);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.targetMC.width;
         this.panelAnimator.defaultH = this.targetMC.height;
         this.panelAnimator.show();
      }
      
      private function onShowFinish2(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish2);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":1,
            "onComplete":this.hideAnime2
         });
      }
      
      private function hideAnime2() : *
      {
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.addEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish2);
         this.panelAnimator.hide();
         this.targetMC.visible = false;
      }
      
      private function onHideFinish2(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish2);
         dispatchEvent(new CustomEvent("onNextCutAddFurrow",{"cutNum":1}));
      }
      
      public function showAnime3() : *
      {
         Localize.setText(this.dialogTxt,"k_au_1");
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.updatePanel();
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish3);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.targetMC.width;
         this.panelAnimator.defaultH = this.targetMC.height;
         this.panelAnimator.show();
      }
      
      private function onShowFinish3(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish3);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":1,
            "onComplete":this.hideAnime3
         });
      }
      
      private function hideAnime3() : *
      {
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.addEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish3);
         this.panelAnimator.hide();
         this.targetMC.visible = false;
      }
      
      private function onHideFinish3(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish3);
         this.showAnime4();
      }
      
      private function showAnime4() : *
      {
         Localize.setText(this.dialogTxt,"k_ar_1");
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.updatePanel();
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish4);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.targetMC.width;
         this.panelAnimator.defaultH = this.targetMC.height;
         this.panelAnimator.show();
      }
      
      private function onShowFinish4(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish4);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":1,
            "onComplete":this.hideAnime4
         });
      }
      
      private function hideAnime4() : *
      {
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.addEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish4);
         this.panelAnimator.hide();
         this.targetMC.visible = false;
      }
      
      private function onHideFinish4(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish4);
         this.showAnime5();
      }
      
      private function showAnime5() : *
      {
         Localize.setAutoFontTextString(this.dialogTxt,"k_asa_1",this.data.numFurrows);
         this.updatePanel(true);
         this.panelAnimator.addEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish5);
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.defaultX = this.targetMC.x;
         this.panelAnimator.defaultY = this.targetMC.y;
         this.panelAnimator.defaultW = this.targetMC.width;
         this.panelAnimator.defaultH = this.targetMC.height;
         this.panelAnimator.show();
      }
      
      private function onShowFinish5(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.SHOW_FINISH,this.onShowFinish5);
         var _loc2_:MovieClip = MovieClip(this.targetMC.parent);
         if(_loc2_.contains(this.panelAnimator.display))
         {
            _loc2_.removeChild(this.panelAnimator.display);
         }
         this.targetMC.visible = true;
         this.setBtnFunc();
      }
      
      private function hideAnime5() : *
      {
         var _loc1_:MovieClip = MovieClip(this.targetMC.parent);
         _loc1_.addChild(this.panelAnimator.display);
         this.panelAnimator.addEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish5);
         this.panelAnimator.hide();
         this.targetMC.visible = false;
      }
      
      private function onHideFinish5(param1:Event) : *
      {
         this.panelAnimator.removeEventListener(PanelRotationAnimator.HIDE_FINISH,this.onHideFinish5);
         this.hideEnd();
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
            "onComplete":this.hideAnime5
         });
      }
      
      private function hideEnd() : *
      {
         this.stop();
         this.reset();
      }
      
      private function updatePanel(param1:Boolean = false) : *
      {
         var _loc2_:* = Math.floor(this.dialogTxt.width + this.marginLeft + this.marginRight);
         var _loc3_:* = Math.floor(this.dialogTxt.height + this.marginTop + this.marginBottom);
         if(param1)
         {
            this.closeBtn.visible = true;
            _loc3_ = _loc3_ + this.closeBtn.height + this.spaceH;
            this.closeBtn.x = Math.floor((_loc2_ - this.closeBtn.width) / 2);
            this.closeBtn.y = Math.floor(this.marginTop + this.dialogTxt.height + this.spaceH);
         }
         else
         {
            this.closeBtn.visible = false;
            this.closeBtn.x = 0;
            this.closeBtn.y = 0;
         }
         this.dialogTxt.x = Math.floor((_loc2_ - this.dialogTxt.width) / 2);
         this.dialogTxt.y = Math.floor(this.marginTop);
         this.bgObj.setSize(_loc2_,_loc3_);
         var _loc4_:* = this.bgObj.width - _loc2_;
         var _loc5_:* = this.bgObj.height - _loc3_;
         var _loc6_:* = Math.floor(_loc4_ / 2);
         var _loc7_:* = Math.floor(_loc5_ / 2);
         this.dialogTxt.x += _loc6_;
         this.dialogTxt.y += _loc7_;
         if(param1)
         {
            this.closeBtn.x += _loc6_;
            this.closeBtn.y += _loc7_;
         }
         this.targetMC.x = Math.floor((this.WID - this.bgObj.width) / 2);
         this.targetMC.y = Math.floor((this.HEI - this.bgObj.height) / 2);
      }
      
      private function setTF(param1:TextField) : *
      {
         param1.selectable = false;
         param1.mouseEnabled = false;
         param1.multiline = true;
         param1.wordWrap = false;
         param1.textColor = this.data.FONT_COLOR;
         param1.autoSize = TextFieldAutoSize.CENTER;
         var _loc2_:TextFormat = param1.getTextFormat();
         param1.autoSize = TextFieldAutoSize.CENTER;
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
               dispatchEvent(new CustomEvent("onAddFurrowAlertPanelCloseClick"));
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
   }
}


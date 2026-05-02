package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.common.PanelScaleAnimator;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.Localize;
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
   
   public class DialogPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var closeBtn:MovieClip;
      
      private var txt1:TextField;
      
      private var txt2:TextField;
      
      private var panelAnimator:PanelScaleAnimator;
      
      private var nutsID:*;
      
      public function DialogPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         McInit.initParam(this.targetMC);
         this.closeBtn = this.targetMC.closeBtn;
         this.txt1 = this.targetMC.txt1;
         this.txt1.autoSize = TextFieldAutoSize.CENTER;
         this.txt1.multiline = false;
         this.txt1.wordWrap = false;
         this.txt1.selectable = false;
         this.txt2 = this.targetMC.txt2;
         this.txt2.autoSize = TextFieldAutoSize.CENTER;
         this.txt2.multiline = true;
         this.txt2.wordWrap = true;
         this.txt2.selectable = false;
         this.panelAnimator = new PanelScaleAnimator(this.targetMC,this.targetMC.width,this.targetMC.height);
         this.reset();
      }
      
      public function reset() : *
      {
         this.panelAnimator.reset();
         BtnEffect.bgReset(this.closeBtn.bg);
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         this.panelAnimator.removeEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowAnime);
         this.panelAnimator.removeEventListener(PanelScaleAnimator.HIDE_FINISH,this.onHideFinish);
      }
      
      public function run() : *
      {
         Localize.setTextM(this.txt1);
         Localize.setTextM(this.txt2);
      }
      
      public function show(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.panelAnimator.addEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowAnime);
         this.panelAnimator.reset();
         this.panelAnimator.show();
      }
      
      private function onShowAnime(param1:Event) : *
      {
         PokemonBridge.alertSound();
         this.panelAnimator.removeEventListener(PanelScaleAnimator.SHOW_FINISH,this.onShowAnime);
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


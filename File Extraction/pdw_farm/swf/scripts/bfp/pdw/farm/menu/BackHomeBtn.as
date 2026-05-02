package bfp.pdw.farm.menu
{
   import bfp.PDWBridge;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.common_y.effect.BtnEffect;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
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
   
   public class BackHomeBtn extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var inner:MovieClip;
      
      private var labelTxt:TextField;
      
      private var distanceX:Number = 250;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var labelTxtY:Number = 0;
      
      public function BackHomeBtn(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
         McInit.initParam(this.targetMC);
         this.inner = this.targetMC.inner;
         McInit.initParam(this.inner);
         this.inner.mouseChildren = false;
         this.labelTxt = this.inner.txt.t;
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.x = this.targetMC.dx - this.distanceX;
         this.targetMC.y = this.targetMC.dy;
         BtnEffect.bgReset(this.inner.bg);
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.inner);
         Tweener.removeTweens(this.targetMC);
      }
      
      public function run() : *
      {
         this.labelTxt.y = this.labelTxtY;
         Localize.setText(this.labelTxt,"h_da_3");
         this.labelTxt.autoSize = TextFieldAutoSize.CENTER;
         this.labelTxt.selectable = false;
         this.labelTxt.multiline = false;
         this.labelTxt.wordWrap = false;
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
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.6,
            "transition":"easeOutCubic",
            "x":this.targetMC.dx,
            "onComplete":this.showEnd
         });
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
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.6,
            "transition":"easeOutCubic",
            "x":this.targetMC.dx - this.distanceX,
            "onComplete":this.hideEnd
         });
      }
      
      private function hideEnd() : *
      {
         this.stop();
         this.reset();
      }
      
      private function setBtnFunc() : *
      {
         BtnSetting.addBtn(this.inner,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
      }
      
      private function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.inner,{
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
            case this.inner:
               PDWBridge.sfxClick();
               dispatchEvent(new CustomEvent("onClickBackHomeBtn"));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.inner:
               PDWBridge.sfxMouseOver();
               BtnEffect.bgOver(this.inner.bg);
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.inner:
               BtnEffect.bgOut(this.inner.bg);
         }
      }
   }
}


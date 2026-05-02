package bfp.pdw.farm.ui
{
   import bfp.PDWBridge;
   import bfp.pdw.common_y.effect.BtnEffect;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
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
   
   public class ArrowBtnUnit extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var topBtn:MovieClip;
      
      private var bottomBtn:MovieClip;
      
      private var areaMC:MovieClip;
      
      private var upCover:MovieClip;
      
      private var bottomCover:MovieClip;
      
      private var oldHit:Boolean = false;
      
      private var nowHit:Boolean = false;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function ArrowBtnUnit(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.topBtn = this.targetMC.topBtn;
         this.topBtn.mouseChildren = false;
         this.bottomBtn = this.targetMC.bottomBtn;
         this.bottomBtn.mouseChildren = false;
         this.areaMC = this.targetMC.areaMC;
         this.upCover = this.targetMC.upCover;
         this.upCover.alpha = 0;
         this.bottomCover = this.targetMC.bottomCover;
         this.bottomCover.alpha = 0;
         this.reset();
      }
      
      public function stop() : *
      {
         this.clearTopBtnFunc();
         this.clearBottomBtnFunc();
         Tweener.removeTweens(this.topBtn);
         Tweener.removeTweens(this.bottomBtn);
      }
      
      public function reset() : *
      {
         this.topBtn.visible = true;
         this.topBtn.alpha = 0.5;
         this.bottomBtn.visible = true;
         this.bottomBtn.alpha = 0.5;
         BtnEffect.bgReset(this.topBtn.bg);
         BtnEffect.bgReset(this.bottomBtn.bg);
         this.upCover.visible = false;
         this.bottomCover.visible = false;
      }
      
      public function run() : *
      {
      }
      
      public function enable(param1:*) : *
      {
         switch(param1)
         {
            case "top":
               this.setTopBtnFunc();
               break;
            case "bottom":
               this.setBottomBtnFunc();
               break;
            default:
               this.setTopBtnFunc();
               this.setBottomBtnFunc();
         }
      }
      
      public function disable(param1:*) : *
      {
         switch(param1)
         {
            case "top":
               this.clearTopBtnFunc();
               break;
            case "bottom":
               this.clearBottomBtnFunc();
               break;
            default:
               this.clearTopBtnFunc();
               this.clearBottomBtnFunc();
         }
      }
      
      public function banish() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":0
         });
      }
      
      public function appear() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.15,
            "transition":"linear",
            "alpha":1
         });
      }
      
      private function setTopBtnFunc() : *
      {
         BtnSetting.addBtn(this.topBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
         Tweener.addTween(this.topBtn,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":1
         });
      }
      
      private function setBottomBtnFunc() : *
      {
         BtnSetting.addBtn(this.bottomBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
         Tweener.addTween(this.bottomBtn,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":1
         });
      }
      
      private function clearTopBtnFunc() : *
      {
         BtnEffect.bgOut(this.topBtn.bg);
         BtnSetting.removeBtn(this.topBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":false
         });
         Tweener.addTween(this.topBtn,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":0.5
         });
      }
      
      private function clearBottomBtnFunc() : *
      {
         BtnEffect.bgOut(this.bottomBtn.bg);
         BtnSetting.removeBtn(this.bottomBtn,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":false
         });
         Tweener.addTween(this.bottomBtn,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":0.5
         });
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         PDWBridge.sfxClick();
         switch(_loc2_)
         {
            case this.topBtn:
               dispatchEvent(new CustomEvent("onArrowBtnClick",{"key":"top"}));
               break;
            case this.bottomBtn:
               dispatchEvent(new CustomEvent("onArrowBtnClick",{"key":"bottom"}));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         PDWBridge.sfxMouseOver();
         switch(_loc2_)
         {
            case this.topBtn:
               BtnEffect.bgOver(this.topBtn.bg);
               break;
            case this.bottomBtn:
               BtnEffect.bgOver(this.bottomBtn.bg);
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.topBtn:
               BtnEffect.bgOut(this.topBtn.bg);
               break;
            case this.bottomBtn:
               BtnEffect.bgOut(this.bottomBtn.bg);
         }
      }
   }
}


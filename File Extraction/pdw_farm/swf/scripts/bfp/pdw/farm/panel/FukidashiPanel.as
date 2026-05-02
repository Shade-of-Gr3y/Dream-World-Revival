package bfp.pdw.farm.panel
{
   import bfp.common.kinomiLoader;
   import bfp.pdw.common_y.Localize;
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
   
   public class FukidashiPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var inner:MovieClip;
      
      private var dialogTxt:TextField;
      
      private var nutsNameTxt:TextField;
      
      private var nutsArea:MovieClip;
      
      private var areaMC:MovieClip;
      
      private var detailBtn:MovieClip;
      
      private var btnInner:MovieClip;
      
      private var loader:kinomiLoader;
      
      private var messageObj:Message;
      
      private var nutsID:*;
      
      private var nutsName:*;
      
      private var uneID:*;
      
      private var fieldID:*;
      
      private var type:String = "watering";
      
      private var isHit:Boolean = false;
      
      private var isOldHit:Boolean = false;
      
      private var isTutorial:Boolean = false;
      
      private var hitTimer:Timer;
      
      private var filePath:FarmFilePath;
      
      private var data:FarmData;
      
      public function FukidashiPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.filePath = FarmFilePath.getInstance();
         this.data = FarmData.getInstance();
         this.inner = this.targetMC.inner;
         this.nutsArea = this.inner.nutsArea;
         this.areaMC = this.targetMC.areaMC;
         this.areaMC.alpha = 0;
         this.detailBtn = this.inner.detailBtn;
         this.btnInner = this.areaMC.btnInner;
         this.dialogTxt = this.inner.dialogTxt;
         this.nutsNameTxt = this.inner.nutsNameTxt;
         this.loader = new kinomiLoader(this.filePath.getNutsImgPath57());
         this.hitTimer = new Timer(1000 / 30);
         this.hitTimer.addEventListener(TimerEvent.TIMER,this.onHitTimerLoop);
         this.messageObj = new Message();
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.alpha = 0;
         this.dialogTxt.text = "";
         this.nutsNameTxt.text = "";
         this.isHit = this.isOldHit = false;
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         Tweener.removeTweens(this.inner);
         this.stopHitTimer();
         if(this.loader.content != null)
         {
            this.loader.unloadSwf();
         }
      }
      
      public function run() : *
      {
      }
      
      public function show(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:* = 0) : *
      {
         this.type = param1;
         this.nutsID = param2;
         this.nutsName = param3;
         this.uneID = param4;
         this.fieldID = param5;
         this.inner.x = 0;
         this.inner.y = -10;
         this.targetMC.x = param6;
         this.targetMC.y = param7;
         this.targetMC.visible = false;
         this.targetMC.alpha = 0;
         this.btnInner.height = param8 + 20;
         var _loc10_:* = this.messageObj.getWaterCheckPanelMessage(param4,param5);
         this.dialogTxt.text = _loc10_;
         Localize.setTextM(this.dialogTxt);
         this.dialogTxt.autoSize = TextFieldAutoSize.CENTER;
         this.dialogTxt.selectable = false;
         this.dialogTxt.multiline = false;
         this.dialogTxt.wordWrap = false;
         this.dialogTxt.height = this.dialogTxt.textHeight + 4;
         this.nutsNameTxt.text = param3;
         Localize.setTextM(this.nutsNameTxt);
         this.nutsNameTxt.autoSize = TextFieldAutoSize.CENTER;
         this.nutsNameTxt.selectable = false;
         this.nutsNameTxt.multiline = false;
         this.nutsNameTxt.wordWrap = false;
         this.nutsNameTxt.height = this.nutsNameTxt.textHeight + 4;
         this.loadImg();
         switch(param1)
         {
            case this.data.FUKIDASHI_TYPE_WATERING:
            case this.data.FUKIDASHI_TYPE_HARVEST:
         }
         Tweener.addTween(this.targetMC,{
            "delay":param9,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         if(!this.data.isFirstTutorial)
         {
            this.startHitTiemr();
         }
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":1
         });
         Tweener.addTween(this.inner,{
            "delay":0,
            "time":0.5,
            "transition":"easeOutBounce",
            "y":0,
            "onComplete":this.showEnd
         });
      }
      
      private function showEnd() : *
      {
         if(!this.data.isFirstTutorial)
         {
            this.setBtnFunc();
         }
      }
      
      public function hide(param1:* = 0) : *
      {
         this.clearBtnFunc();
         this.stopHitTimer();
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0,
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
               dispatchEvent(new CustomEvent("onFukidashiDetailClick"));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.detailBtn:
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.detailBtn:
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
         this.isHit = this.areaMC.hitTestPoint(this.targetMC.root.mouseX,this.targetMC.root.mouseY,true);
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
         this.loader.loadSwf(this.nutsID);
      }
      
      private function onLoadComplete(param1:Event) : *
      {
         this.loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this.loader.x = -Math.floor(this.loader.width / 2);
         this.loader.y = -Math.floor(this.loader.height / 2);
         this.nutsArea.addChild(this.loader);
      }
   }
}


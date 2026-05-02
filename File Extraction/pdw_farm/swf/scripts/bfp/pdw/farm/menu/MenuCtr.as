package bfp.pdw.farm.menu
{
   import bfp.*;
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
   
   public class MenuCtr extends EventDispatcher
   {
      
      private var backHomeBtnObj:BackHomeBtn;
      
      private var sprinklerInfoBoxObj:SprinklerInfoBox;
      
      private var menuCoverObj:MenuCover;
      
      private var sprinklerLoaderObj:SelectSprinklerLoader;
      
      private var selectInteriorID:Number = 0;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      public function MenuCtr(param1:BackHomeBtn, param2:SprinklerInfoBox, param3:MenuCover)
      {
         super();
         this.backHomeBtnObj = param1;
         this.sprinklerInfoBoxObj = param2;
         this.menuCoverObj = param3;
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
         this.sprinklerLoaderObj = new SelectSprinklerLoader();
      }
      
      public function reset() : *
      {
         this.backHomeBtnObj.reset();
         this.sprinklerInfoBoxObj.reset();
         this.menuCoverObj.reset();
      }
      
      public function stop() : *
      {
         this.backHomeBtnObj.stop();
         this.sprinklerInfoBoxObj.stop();
         this.menuCoverObj.stop();
         this.clearEvent();
      }
      
      public function run() : *
      {
         this.backHomeBtnObj.run();
         this.sprinklerInfoBoxObj.run();
         this.menuCoverObj.run();
      }
      
      public function show(param1:* = 0) : *
      {
         if(!this.data.isFriendMode)
         {
            this.backHomeBtnObj.show(param1);
         }
         this.sprinklerInfoBoxObj.show(param1);
         this.setEvent();
      }
      
      private function showAnime() : *
      {
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         this.backHomeBtnObj.hide(param1);
         this.sprinklerInfoBoxObj.hide(param1);
      }
      
      private function hideAnime() : *
      {
      }
      
      private function hideEnd() : *
      {
      }
      
      private function setEvent() : *
      {
         this.bridge.addEventListener("onUpdateNowUneCount",this.onUpdateNowUneCount);
         this.bridge.addEventListener("onUpDateWateringCountView",this.onUpDateWateringCountView);
         this.backHomeBtnObj.addEventListener("onClickBackHomeBtn",this.onClickBackHomeBtn);
         this.sprinklerInfoBoxObj.addEventListener("onSprinklerBtnClick",this.onSprinklerBtnClick);
         this.sprinklerInfoBoxObj.addEventListener("onOpenMenu",this.onOpenMenu);
         this.sprinklerInfoBoxObj.addEventListener("onCloseMenu",this.onCloseMenu);
         this.menuCoverObj.addEventListener("onCoverClick",this.onCoverClick);
      }
      
      private function clearEvent() : *
      {
         this.bridge.removeEventListener("onUpDateWateringCountView",this.onUpDateWateringCountView);
         this.backHomeBtnObj.removeEventListener("onClickBackHomeBtn",this.onClickBackHomeBtn);
         this.sprinklerInfoBoxObj.removeEventListener("onSprinklerBtnClick",this.onSprinklerBtnClick);
         this.sprinklerInfoBoxObj.removeEventListener("onOpenMenu",this.onOpenMenu);
         this.sprinklerInfoBoxObj.removeEventListener("onCloseMenu",this.onCloseMenu);
         this.menuCoverObj.removeEventListener("onCoverClick",this.onCoverClick);
      }
      
      private function onTutorialFinish(param1:CustomEvent) : *
      {
         this.sprinklerInfoBoxObj.setFunc();
      }
      
      private function onUpdateNowUneCount(param1:CustomEvent) : *
      {
         this.sprinklerInfoBoxObj.updateUneCount(param1.obj.value);
      }
      
      private function onUpDateWateringCountView(param1:CustomEvent) : *
      {
         this.sprinklerInfoBoxObj.updateWateringCount(param1.obj.num);
      }
      
      private function onClickBackHomeBtn(param1:CustomEvent) : *
      {
         PDWBridge.backToHome();
      }
      
      private function onSprinklerBtnClick(param1:CustomEvent) : *
      {
         this.selectInteriorID = param1.obj.interior_id;
         this.menuCoverObj.banish();
         this.bridge.addEventListener("onResponseSelectSprinkler",this.onResponseSelectSprinkler);
         this.bridge.sendSelectSprinkler(this.selectInteriorID);
      }
      
      private function onResponseSelectSprinkler(param1:CustomEvent) : *
      {
         this.bridge.removeEventListener("onResponseSelectSprinkler",this.onResponseSelectSprinkler);
         this.sprinklerLoaderObj.addEventListener("onSprinklerLoadComplete",this.onSprinklerLoadComplete);
         this.sprinklerLoaderObj.load(this.selectInteriorID);
      }
      
      private function onSprinklerLoadComplete(param1:CustomEvent) : *
      {
         this.sprinklerLoaderObj.removeEventListener("onSprinklerLoadComplete",this.onSprinklerLoadComplete);
         this.sprinklerInfoBoxObj.changeSprinkler();
         this.bridge.changeSprinkler();
      }
      
      private function onOpenMenu(param1:CustomEvent) : *
      {
         this.menuCoverObj.appear(true);
      }
      
      private function onCloseMenu(param1:CustomEvent) : *
      {
         this.menuCoverObj.banish();
      }
      
      private function onCoverClick(param1:CustomEvent) : *
      {
         this.menuCoverObj.banish();
         this.sprinklerInfoBoxObj.closeMenu();
      }
   }
}


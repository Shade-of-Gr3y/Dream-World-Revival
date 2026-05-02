package bfp.pdw.farm.cursor
{
   import bfp.PDWBridge;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
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
   
   public class CursorCtr extends EventDispatcher
   {
      
      private var cursorObj:Cursor;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var selectUneID:Number = -1;
      
      private var selectFieldID:Number = -1;
      
      public function CursorCtr(param1:Cursor)
      {
         super();
         this.cursorObj = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
      }
      
      public function reset() : *
      {
         this.cursorObj.reset();
      }
      
      public function stop() : *
      {
         this.cursorObj.stop();
         this.bridge.removeEventListener("onShowSprinkling",this.onShowSprinkling);
         this.bridge.removeEventListener("onHideSprinkling",this.onHideSprinkling);
         this.bridge.removeEventListener("onStartWater",this.onStartWater);
         this.bridge.removeEventListener("onStopWater",this.onStopWater);
         this.bridge.removeEventListener("onChangeSprinkler",this.onChangeSprinkler);
         this.cursorObj.removeEventListener("onWaterFinish",this.onWaterFinish);
         Tweener.removeTweens(this);
      }
      
      public function run() : *
      {
         this.cursorObj.run();
         this.bridge.addEventListener("onShowSprinkling",this.onShowSprinkling);
         this.bridge.addEventListener("onHideSprinkling",this.onHideSprinkling);
         this.bridge.addEventListener("onStartWater",this.onStartWater);
         this.bridge.addEventListener("onStopWater",this.onStopWater);
         this.bridge.addEventListener("onChangeSprinkler",this.onChangeSprinkler);
         this.cursorObj.addEventListener("onWaterFinish",this.onWaterFinish);
      }
      
      private function onShowSprinkling(param1:CustomEvent) : *
      {
         this.cursorObj.show(param1.obj.x,param1.obj.y,param1.obj.h);
      }
      
      private function onHideSprinkling(param1:CustomEvent) : *
      {
         this.cursorObj.hide();
      }
      
      private function onStartWater(param1:CustomEvent) : *
      {
         this.selectUneID = param1.obj.uneID;
         this.selectFieldID = param1.obj.fieldID;
         this.cursorObj.startWater();
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "delay":0.2,
            "onComplete":this.delayWaterSound
         });
      }
      
      private function delayWaterSound() : *
      {
         PDWBridge.sfx(PDWBridge.SFX_ID_WATER);
      }
      
      private function onStopWater(param1:CustomEvent) : *
      {
         this.cursorObj.stopWater();
      }
      
      private function onChangeSprinkler(param1:CustomEvent) : *
      {
         this.cursorObj.change();
      }
      
      private function onWaterFinish(param1:CustomEvent) : *
      {
         this.data.isWaterAnime = false;
         this.bridge.hideCover();
         this.bridge.restoreSoil(this.selectUneID,this.selectFieldID);
         this.bridge.growthNuts(this.selectUneID,this.selectFieldID);
      }
   }
}


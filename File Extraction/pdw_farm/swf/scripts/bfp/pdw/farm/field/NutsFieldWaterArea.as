package bfp.pdw.farm.field
{
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
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
   
   public class NutsFieldWaterArea extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var waterList:Array = [];
      
      private var isSprink:Boolean = false;
      
      private var tx:Number = 0;
      
      private var ty:Number = 0;
      
      private var waterLength:Number = 100;
      
      private var waterNum:Number = 1;
      
      private var waterTimer:Timer;
      
      private var waterLimitTimer:Timer;
      
      private var data:FarmData;
      
      public function NutsFieldWaterArea(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.targetMC.mouseChildren = false;
         this.targetMC.mouseEnabled = false;
         this.waterTimer = new Timer(30 / 1000);
         this.waterTimer.addEventListener(TimerEvent.TIMER,this.onWaterTimer);
         this.waterLimitTimer = new Timer(1000,1);
         this.waterLimitTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onWaterLimitTimerComplete);
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.alpha = 0;
         this.isSprink = false;
      }
      
      public function stop() : *
      {
         this.waterLimitTimer.stop();
         this.waterLimitTimer.reset();
         this.waterTimer.stop();
         this.waterTimer.reset();
      }
      
      public function run() : *
      {
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
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":1,
            "onComplete":this.showEnd
         });
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideEnd
         });
      }
      
      private function hideEnd() : *
      {
      }
      
      public function startWater(param1:* = 0, param2:* = 0, param3:* = 100) : *
      {
         this.tx = param1;
         this.ty = param2;
         this.waterLength = param3;
         this.isSprink = true;
         this.startWaterTimer();
         this.waterLimitTimer.reset();
         this.waterLimitTimer.start();
      }
      
      public function stopWater() : *
      {
         this.isSprink = false;
         this.waterLimitTimer.stop();
         this.waterLimitTimer.reset();
         this.stopEnd();
      }
      
      private function stopEnd() : *
      {
         this.hide();
         dispatchEvent(new CustomEvent("onWaterFinish",{}));
      }
      
      private function startWaterTimer() : *
      {
         this.waterTimer.reset();
         this.waterTimer.start();
      }
      
      private function stopWaterTimer() : *
      {
         this.waterTimer.stop();
         this.waterTimer.reset();
      }
      
      private function onWaterTimer(param1:TimerEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Water = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc4_:* = 20;
         if(this.isSprink)
         {
            _loc2_ = 0;
            while(_loc2_ < this.waterNum)
            {
               _loc5_ = this.tx + Math.random() * 20 - 10;
               _loc6_ = this.ty + Math.random() * 20 - 10;
               _loc3_ = new Water();
               _loc3_.scaleX = _loc3_.scaleY = Math.random() * 0.5 + 0.5;
               _loc3_.endDistance = this.waterLength;
               _loc3_.start(_loc5_,_loc6_);
               this.targetMC.addChild(_loc3_);
               this.waterList.push(_loc3_);
               _loc2_++;
            }
         }
         else if(this.waterList.length == 0)
         {
            this.stopWaterTimer();
         }
         _loc2_ = this.waterList.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.waterList[_loc2_];
            if(!_loc3_.visible)
            {
               _loc7_ = this.waterList.indexOf(_loc3_);
               this.waterList.splice(_loc7_,1);
               _loc3_.stopContent();
               if(this.targetMC.contains(_loc3_))
               {
                  this.targetMC.removeChild(_loc3_);
               }
               _loc3_ = null;
            }
            _loc2_--;
         }
      }
      
      private function onWaterLimitTimerComplete(param1:TimerEvent) : *
      {
         this.stopWater();
      }
   }
}


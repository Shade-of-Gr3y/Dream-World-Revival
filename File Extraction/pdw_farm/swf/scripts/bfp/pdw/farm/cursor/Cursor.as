package bfp.pdw.farm.cursor
{
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
   
   public class Cursor extends EventDispatcher
   {
      
      private var cursorArea:MovieClip;
      
      private var cursorOverArea:MovieClip;
      
      private var cursorMC:MovieClip;
      
      private var container:MovieClip;
      
      private var waterArea:MovieClip;
      
      private var loader:Loader;
      
      private var waterTimer:Timer;
      
      private var waterLimitTimer:Timer;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var isDown:Boolean = false;
      
      private var isSprink:Boolean = false;
      
      private var waterNum:Number = 1;
      
      private var waterLength:Number = 0;
      
      private var sprinklerType:String = "";
      
      private var wid:Number = 0;
      
      private var hei:Number = 0;
      
      private var waterList:Array = [];
      
      public function Cursor(param1:MovieClip, param2:MovieClip)
      {
         super();
         this.cursorArea = param1;
         this.cursorOverArea = param2;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.cursorArea.mouseEnabled = false;
         this.cursorArea.mouseChildren = false;
         this.cursorMC = new MovieClip();
         this.cursorMC.mouseChildren = false;
         this.cursorMC.mouseEnabled = false;
         this.cursorArea.addChild(this.cursorMC);
         this.waterArea = new MovieClip();
         this.cursorArea.addChild(this.waterArea);
         this.waterTimer = new Timer(30 / 1000);
         this.waterTimer.addEventListener(TimerEvent.TIMER,this.onWaterTimer);
         this.waterLimitTimer = new Timer(1000,1);
         this.waterLimitTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onWaterLimitTimerComplete);
         this.reset();
      }
      
      public function reset() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Water = null;
         _loc1_ = 0;
         while(_loc1_ < this.waterList.length)
         {
            _loc2_ = this.waterList[_loc1_];
            if(this.waterArea.contains(_loc2_))
            {
               this.waterArea.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.waterList = [];
         this.cursorMC.visible = false;
         this.cursorMC.alpha = 0;
         this.cursorMC.rotation = 0;
         this.waterArea.visible = false;
         this.waterArea.alpha = 0;
      }
      
      public function stop() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Water = null;
         this.stopWaterTimer();
         this.waterLimitTimer.stop();
         this.waterLimitTimer.reset();
         _loc1_ = 0;
         while(_loc1_ < this.waterList.length)
         {
            _loc2_ = this.waterList[_loc1_];
            _loc2_.stopContent();
            _loc1_++;
         }
         Tweener.removeTweens(this.cursorMC);
         Tweener.removeTweens(this.waterArea);
      }
      
      public function run() : *
      {
         this.removeAllSprinkler();
         this.addSprinkler();
      }
      
      public function show(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = Math.floor(this.wid / 2) - 5;
         var _loc5_:* = param3 + 30;
         this.cursorMC.x = param1 + _loc4_ + 30;
         this.cursorMC.y = param2 - _loc5_ - 30;
         this.cursorMC.tx = param1 + _loc4_;
         this.cursorMC.ty = param2 - _loc5_;
         this.cursorMC.alpha = 0;
         this.cursorMC.visible = true;
         this.waterLength = _loc5_;
         Tweener.removeTweens(this.cursorMC);
         Tweener.addTween(this.cursorMC,{
            "delay":0,
            "time":0.2,
            "transition":"easeOutQuad",
            "x":this.cursorMC.tx,
            "y":this.cursorMC.ty
         });
         Tweener.addTween(this.cursorMC,{
            "delay":0,
            "time":0.2,
            "transition":"linear",
            "alpha":1
         });
         Tweener.removeTweens(this.waterArea);
         Tweener.addTween(this.waterArea,{
            "delay":0,
            "time":0.2,
            "transition":"linear",
            "_autoAlpha":1
         });
      }
      
      public function hide() : *
      {
         Tweener.removeTweens(this.cursorMC);
         Tweener.addTween(this.cursorMC,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0
         });
         Tweener.removeTweens(this.waterArea);
         Tweener.addTween(this.waterArea,{
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
      
      public function get visible() : *
      {
         return this.cursorMC.visible;
      }
      
      private function addSprinkler() : *
      {
         this.loader = this.data.selectSprinklerData.imgLoader;
         var _loc1_:MovieClip = MovieClip(this.loader.content);
         _loc1_.gotoAndStop(2);
         this.wid = this.loader.width;
         this.hei = this.loader.height;
         this.loader.x = -Math.floor(this.wid / 2);
         this.loader.y = -Math.floor(this.hei / 2);
         this.cursorMC.addChild(this.loader);
      }
      
      private function removeAllSprinkler() : *
      {
         var _loc1_:* = undefined;
         _loc1_ = this.cursorMC.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.cursorMC.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      public function startWater() : *
      {
         this.isSprink = true;
         Tweener.addTween(this.cursorMC,{
            "delay":0,
            "time":0.3,
            "transition":"easeInOutQuad",
            "rotation":-10
         });
         this.startWaterTimer();
         this.waterLimitTimer.reset();
         this.waterLimitTimer.start();
         switch(this.data.selectSprinklerData.interior_id)
         {
            case this.data.SPRINKLER_ID_NORMAL:
            case this.data.SPRINKLER_ID_DELIBIRD:
            case this.data.SPRINKLER_ID_ZENIGAME:
            case this.data.SPRINKLER_ID_DONFAN:
            case this.data.SPRINKLER_ID_KAIOUGA:
            case this.data.SPRINKLER_ID_KODAK:
         }
      }
      
      public function stopWater() : *
      {
         this.isSprink = false;
         Tweener.addTween(this.cursorMC,{
            "delay":0,
            "time":0.3,
            "transition":"easeInOutQuad",
            "rotation":0,
            "onComplete":this.stopEnd
         });
         this.waterLimitTimer.stop();
         this.waterLimitTimer.reset();
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
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         if(this.isSprink)
         {
            _loc2_ = 0;
            while(_loc2_ < this.waterNum)
            {
               _loc4_ = this.cursorMC.rotation + 155;
               _loc5_ = this.cursorMC.width / 2 * 0.7;
               _loc6_ = _loc4_ / 180 * Math.PI;
               _loc7_ = Math.cos(_loc6_) * _loc5_ + Math.random() * 20 - 10;
               _loc8_ = Math.sin(_loc6_) * _loc5_ + Math.random() * 20 - 10;
               _loc3_ = new Water();
               _loc3_.scaleX = _loc3_.scaleY = Math.random() * 0.5 + 0.5;
               _loc3_.endDistance = this.waterLength;
               _loc3_.start(this.cursorMC.x + _loc7_,this.cursorMC.y + _loc8_);
               this.waterArea.addChild(_loc3_);
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
               _loc9_ = this.waterList.indexOf(_loc3_);
               this.waterList.splice(_loc9_,1);
               _loc3_.stopContent();
               if(this.waterArea.contains(_loc3_))
               {
                  this.waterArea.removeChild(_loc3_);
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
      
      public function change() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = this.cursorMC.numChildren - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.cursorMC.removeChildAt(_loc1_);
            if(_loc2_ is Loader)
            {
               if(_loc2_.content != null)
               {
                  _loc2_.unload();
               }
            }
            _loc1_--;
         }
         this.addSprinkler();
      }
   }
}


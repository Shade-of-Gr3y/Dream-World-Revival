package bfp.pdw.farm.field
{
   import bfp.common.Logger;
   import bfp.pdw.farm.FarmData;
   import bfp.pdw.farm.panel.Message;
   import bfp.pokemon.liby.event.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class NutsInfomationCtr extends EventDispatcher
   {
      
      private var data:FarmData;
      
      private var fukidashiArea:MovieClip;
      
      private var btnMC:MovieClip;
      
      private var fukidashiObj:NutsInfomation;
      
      private var messageObj:Message;
      
      private var isOver:Boolean = false;
      
      private var isOldOver:Boolean = false;
      
      private var globalX:Number = 0;
      
      private var globalY:Number = 0;
      
      private var hitRect:Rectangle;
      
      private var overTimer:Timer;
      
      private var delayOutTimer:Timer;
      
      public function NutsInfomationCtr(param1:*, param2:*)
      {
         super();
         this.fukidashiArea = param1;
         this.btnMC = param2;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.messageObj = new Message();
         this.overTimer = new Timer(1000 / 30);
         this.overTimer.addEventListener(TimerEvent.TIMER,this.onOverTimerLoop);
         this.delayOutTimer = new Timer(120,1);
         this.delayOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayOutTimerComplete);
         this.hitRect = new Rectangle();
      }
      
      public function reset() : *
      {
         if(this.fukidashiObj != null)
         {
            this.fukidashiObj.resetContent();
            this.hideFukidashiFinish();
         }
      }
      
      public function stop() : *
      {
         if(this.fukidashiObj != null)
         {
            this.fukidashiObj.stopContent();
         }
         this.stopDelayOutTimer();
         this.stopOverCheck();
      }
      
      public function run() : *
      {
      }
      
      public function show(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*) : *
      {
         if(this.fukidashiObj == null)
         {
            this.hideFukidashi();
            this.removeFukidashi();
            this.showFukidashi(param1,param2,param3,param4,param5,param6,param7);
         }
         this.stopDelayOutTimer();
         this.startOverCheck();
      }
      
      public function showFukidashi(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*) : *
      {
         this.fukidashiArea.visible = false;
         this.fukidashiArea.alpha = 0;
         var _loc8_:* = "";
         var _loc9_:* = "";
         var _loc10_:* = this.btnMC.height;
         var _loc11_:Point = this.btnMC.parent.parent.localToGlobal(new Point(this.btnMC.parent.x,this.btnMC.parent.y));
         this.globalX = _loc11_.x;
         this.globalY = _loc11_.y;
         var _loc12_:* = {};
         switch(param1)
         {
            case this.data.FIELD_STATUS_NONE:
               if(this.fukidashiObj == null)
               {
                  this.fukidashiObj = new NutsInfomation();
                  this.fukidashiObj.runContent();
               }
               this.fukidashiArea.addChild(this.fukidashiObj);
               this.fukidashiArea.visible = true;
               this.fukidashiArea.alpha = 1;
               this.fukidashiObj.showNone(this.data.FUKIDASHI_TYPE_NONE,this.globalX,this.globalY - this.btnMC.height + 20);
               break;
            case this.data.FIELD_STATUS_NUTS:
               if(this.fukidashiObj == null)
               {
                  this.fukidashiObj = new NutsInfomation();
                  this.fukidashiObj.runContent();
               }
               this.fukidashiObj.addEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
               this.fukidashiArea.addChild(this.fukidashiObj);
               this.fukidashiArea.visible = true;
               this.fukidashiArea.alpha = 1;
               _loc12_ = {
                  "plantStatus":param2,
                  "nutsName":param3
               };
               this.fukidashiObj.show(this.data.FUKIDASHI_TYPE_WATERING,param4,_loc12_,param5,param6,this.globalX,this.globalY - this.btnMC.height + 20,this.btnMC.height);
               break;
            case this.data.FIELD_STATUS_PLANT:
               if(this.fukidashiObj == null)
               {
                  this.fukidashiObj = new NutsInfomation();
                  this.fukidashiObj.runContent();
               }
               this.fukidashiObj.addEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
               this.fukidashiArea.addChild(this.fukidashiObj);
               this.fukidashiArea.visible = true;
               this.fukidashiArea.alpha = 1;
               Logger.log("はたけ　soilStatus:" + param7);
               switch(param7)
               {
                  case this.data.SOIL_STATUS_SAFE:
                     _loc9_ = "k_aha_1";
                     break;
                  default:
                     _loc9_ = "";
               }
               _loc12_ = {
                  "plantStatus":param2,
                  "nutsName":param3
               };
               this.fukidashiObj.show(this.data.FUKIDASHI_TYPE_HARVEST,param4,_loc12_,param5,param6,this.globalX,this.globalY - this.btnMC.height + 20,this.btnMC.height,0,_loc9_);
         }
      }
      
      private function onFukidashiDetailClick(param1:CustomEvent) : *
      {
         this.fukidashiObj.removeEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
         this.stopDelayOutTimer();
         this.stopOverCheck();
         this.hideFukidashi();
         dispatchEvent(new CustomEvent("onFukidashiDetailClick"));
      }
      
      public function hide() : *
      {
         if(this.fukidashiObj != null)
         {
            this.fukidashiObj.removeEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
         }
         this.stopDelayOutTimer();
         this.stopOverCheck();
         this.hideFukidashi();
      }
      
      public function hideFukidashi(param1:* = 0.06, param2:* = 0) : *
      {
         if(this.fukidashiObj)
         {
            this.fukidashiObj.addEventListener("onFukidashiHideEnd",this.onFukidashiHideEnd);
            this.fukidashiObj.hide();
         }
      }
      
      private function onFukidashiHideEnd(param1:CustomEvent) : *
      {
         this.fukidashiObj.removeEventListener("onFukidashiHideEnd",this.onFukidashiHideEnd);
         this.hideFukidashiFinish();
      }
      
      private function hideFukidashiFinish() : *
      {
         if(this.fukidashiObj != null)
         {
            if(this.fukidashiArea.contains(this.fukidashiObj))
            {
               this.fukidashiArea.removeChild(this.fukidashiObj);
            }
            this.fukidashiObj.stopContent();
            this.fukidashiObj.removeEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
            this.fukidashiObj = null;
         }
      }
      
      private function removeFukidashi() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:* = this.fukidashiArea.numChildren;
         _loc2_ = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            this.fukidashiArea.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      public function startOverCheck() : *
      {
         this.overTimer.reset();
         this.overTimer.start();
      }
      
      public function stopOverCheck() : *
      {
         this.overTimer.stop();
         this.overTimer.reset();
      }
      
      private function onOverTimerLoop(param1:TimerEvent) : *
      {
         this.isOldOver = this.isOver;
         this.isOver = this.fukidashiArea.hitTestPoint(this.btnMC.root.mouseX,this.btnMC.root.mouseY,true);
         if(this.isOver && !this.isOldOver)
         {
            this.stopDelayOutTimer();
         }
         else if(!this.isOver && this.isOldOver)
         {
            this.startDelayOutTimer();
         }
      }
      
      public function startDelayOutTimer() : *
      {
         this.delayOutTimer.reset();
         this.delayOutTimer.start();
      }
      
      public function stopDelayOutTimer() : *
      {
         this.delayOutTimer.stop();
         this.delayOutTimer.reset();
      }
      
      private function onDelayOutTimerComplete(param1:TimerEvent) : *
      {
         if(!this.btnMC.hitTestPoint(this.btnMC.root.mouseX,this.btnMC.root.mouseY,true) && !this.fukidashiArea.hitTestPoint(this.btnMC.root.mouseX,this.btnMC.root.mouseY,true))
         {
            this.stopOverCheck();
            this.hideFukidashi();
            this.stopOverCheck();
         }
      }
   }
}


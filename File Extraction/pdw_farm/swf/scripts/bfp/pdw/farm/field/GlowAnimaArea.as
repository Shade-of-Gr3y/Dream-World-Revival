package bfp.pdw.farm.field
{
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
   
   public class GlowAnimaArea extends MovieClip
   {
      
      private var numKirakira:Number = 10;
      
      private var kirakiraList:Array = [];
      
      private var kirakiraList2:Array = [];
      
      private var playTimer:Timer;
      
      private var delayTime:Number;
      
      private var count:Number = 0;
      
      public function GlowAnimaArea(param1:Number = 700)
      {
         super();
         this.delayTime = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.playTimer = new Timer(this.delayTime,1);
         this.playTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayTimerComplete);
      }
      
      private function onAddToStage(param1:Event) : *
      {
         this.create();
      }
      
      private function onRemovedFromStage(param1:Event) : *
      {
         this.remove();
      }
      
      private function onPlayTimerComplete(param1:TimerEvent) : *
      {
      }
      
      public function resetContent() : *
      {
         this.remove();
      }
      
      public function stopContent() : *
      {
      }
      
      public function runContent() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Kirakira = null;
         this.count = 0;
         _loc1_ = 0;
         while(_loc1_ < this.kirakiraList.length)
         {
            _loc2_ = this.kirakiraList[_loc1_];
            _loc2_.startRender();
            _loc2_.visible = true;
            Tweener.addTween(_loc2_,{
               "delay":this.delayTime / 1000,
               "time":0.3,
               "transition":"linear",
               "alpha":0,
               "onComplete":this.out,
               "onCompleteParams":[_loc2_]
            });
            _loc1_++;
         }
      }
      
      private function out(param1:Kirakira) : *
      {
         param1.stopContent();
         if(this.contains(param1))
         {
            this.removeChild(param1);
         }
         ++this.count;
         if(this.count == this.numKirakira)
         {
            dispatchEvent(new CustomEvent("kirakiraFinish"));
         }
      }
      
      private function create() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Kirakira = null;
         this.kirakiraList = [];
         _loc1_ = 0;
         while(_loc1_ < this.numKirakira)
         {
            _loc2_ = new Kirakira();
            this.addChild(_loc2_);
            _loc2_.deg = 360 / this.numKirakira * _loc1_;
            _loc2_.speed = 3.8;
            _loc2_.friction = 0.95;
            _loc2_.scaleX = _loc2_.scaleY = 0.6;
            this.kirakiraList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function remove() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Kirakira = null;
         _loc1_ = 0;
         while(_loc1_ < this.kirakiraList.length)
         {
            _loc2_ = this.kirakiraList[_loc1_];
            _loc2_.stopRender();
            if(this.contains(_loc2_))
            {
               this.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.kirakiraList = [];
      }
   }
}


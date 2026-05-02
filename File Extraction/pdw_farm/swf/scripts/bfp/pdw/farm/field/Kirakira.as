package bfp.pdw.farm.field
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol104")]
   public class Kirakira extends MovieClip
   {
      
      private var vx:Number = 0;
      
      private var vy:Number = 0;
      
      private var ax:Number = 0;
      
      private var ay:Number = 0;
      
      public var deg:Number = 0;
      
      private var rad:Number = 0;
      
      public var speed:Number = 0;
      
      private var startX:Number = 0;
      
      private var startY:Number = 0;
      
      private var alSpeed:Number = 0;
      
      public var frictionX:Number = 1;
      
      public var frictionY:Number = 1;
      
      public var friction:Number = 1;
      
      private var limit:Number = 120;
      
      private var offset:Number = 90;
      
      public var speedLimit:Number = 0.1;
      
      private var gravity:Number = 0.986;
      
      public var endDistance:Number = 100;
      
      private var timer:Timer;
      
      public function Kirakira()
      {
         super();
         visible = false;
         this.timer = new Timer(30 / 1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimerLoop);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : *
      {
         this.stopRender();
      }
      
      public function resetContent() : *
      {
      }
      
      public function stopContent() : *
      {
         this.stopRender();
      }
      
      public function startRender() : *
      {
         this.timer.reset();
         this.timer.start();
      }
      
      public function stopRender() : *
      {
         this.timer.stop();
         this.timer.reset();
      }
      
      private function onTimerLoop(param1:TimerEvent) : *
      {
         this.speed *= this.friction;
         this.rad = this.deg * Math.PI / 180;
         this.vx = Math.cos(this.rad) * this.speed;
         this.vy = Math.sin(this.rad) * this.speed;
         this.vx *= this.frictionX;
         this.vy *= this.frictionY;
         this.x += this.vx;
         this.y += this.vy;
      }
   }
}


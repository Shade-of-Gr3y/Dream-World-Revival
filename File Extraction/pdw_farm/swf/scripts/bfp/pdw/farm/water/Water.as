package bfp.pdw.farm.water
{
   import bfp.pokemon.liby.event.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3")]
   public class Water extends MovieClip
   {
      
      private var vx:Number = 0;
      
      private var vy:Number = 0;
      
      private var ax:Number = 0;
      
      private var ay:Number = 0;
      
      private var deg:Number = 0;
      
      private var rad:Number = 0;
      
      private var speed:Number = 0;
      
      private var startX:Number = 0;
      
      private var startY:Number = 0;
      
      private var alSpeed:Number = 0;
      
      private var limit:Number = 120;
      
      private var offset:Number = 90;
      
      private var speedLimit:Number = 1;
      
      private var gravity:Number = 0.92;
      
      public var endDistance:Number = 100;
      
      private var timer:Timer;
      
      public function Water()
      {
         super();
         visible = false;
         this.timer = new Timer(1000 / 30);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimerLoop);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : *
      {
         this.stopRender();
      }
      
      public function start(param1:*, param2:*) : *
      {
         this.x = param1;
         this.y = param2;
         this.startX = param1;
         this.startY = param2;
         this.deg = Math.random() * this.limit - this.limit / 2 + this.offset;
         this.speed = Math.random() * this.speedLimit + 2;
         this.rad = this.deg * Math.PI / 180;
         this.vx = Math.cos(this.rad) * this.speed;
         this.vy = Math.sin(this.rad) * this.speed;
         this.alSpeed = Math.random() * 0.01 + 0.99;
         visible = true;
         this.startRender();
      }
      
      public function resetContent() : *
      {
      }
      
      public function stopContent() : *
      {
      }
      
      private function startRender() : *
      {
         this.timer.reset();
         this.timer.start();
      }
      
      private function stopRender() : *
      {
         this.timer.stop();
         this.timer.reset();
      }
      
      private function onTimerLoop(param1:TimerEvent) : *
      {
         this.vy /= this.gravity;
         this.x += this.vx;
         this.y += this.vy;
         this.alpha *= this.alSpeed;
         if(this.y > this.startY + this.endDistance)
         {
            this.stopRender();
            this.visible = false;
            dispatchEvent(new CustomEvent("onWaterEnd"));
         }
      }
   }
}


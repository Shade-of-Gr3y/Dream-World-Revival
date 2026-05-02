package bfp.pdw.farm.field
{
   import bfp.pokemon.liby.event.CustomEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol101")]
   public class Light extends MovieClip
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
      
      private var speedLimit:Number = 0.1;
      
      private var gravity:Number = 0.986;
      
      public var endDistance:Number = 100;
      
      private var timer:Timer;
      
      public function Light()
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
      
      public function start(param1:*, param2:*) : *
      {
         this.x = param1;
         this.y = param2;
         this.alpha = 0;
         this.startX = param1;
         this.startY = param2;
         this.deg = Math.random() * 360;
         this.speed = Math.random() * this.speedLimit;
         this.rad = this.deg * Math.PI / 180;
         this.vx = Math.cos(this.rad) * this.speed;
         this.vy = Math.sin(this.rad) * this.speed;
         this.alSpeed = Math.random() * 0.01 + 0.99;
         visible = true;
         this.startRender();
         Tweener.addTween(this,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "alpha":1
         });
         Tweener.addTween(this,{
            "delay":0.2,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.finish
         });
      }
      
      private function finish() : *
      {
         this.stopRender();
         dispatchEvent(new CustomEvent("onLightEnd"));
      }
      
      public function resetContent() : *
      {
      }
      
      public function stopContent() : *
      {
         this.stopRender();
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
         this.x += this.vx;
         this.y += this.vy;
      }
   }
}


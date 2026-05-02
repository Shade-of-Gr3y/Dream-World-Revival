package bfp.pdw.farm.net
{
   import bfp.pdw.farm.FarmBridge;
   import bfp.pdw.farm.FarmData;
   import bfp.pokemon.liby.event.CustomEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class LoadCheck extends EventDispatcher
   {
      
      private var timer:Timer;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function LoadCheck()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.timer = new Timer(1000 / 30);
         this.timer.addEventListener(TimerEvent.TIMER,this.onLoadTimerLoop);
      }
      
      public function reset() : *
      {
      }
      
      public function stop() : *
      {
         this.stopCheck();
      }
      
      public function run() : *
      {
      }
      
      public function startCheck() : *
      {
         this.timer.reset();
         this.timer.start();
      }
      
      public function stopCheck() : *
      {
         this.timer.stop();
         this.timer.reset();
      }
      
      private function onLoadTimerLoop(param1:TimerEvent) : *
      {
         if(this.data.isLoaded)
         {
            this.stopCheck();
            dispatchEvent(new CustomEvent("onLoadCheckFinish"));
         }
      }
   }
}


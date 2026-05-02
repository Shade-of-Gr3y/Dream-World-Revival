package bfp.pdw.farm.net
{
   import bfp.common.Logger;
   import bfp.pdw.farm.FarmBridge;
   import bfp.pdw.farm.FarmData;
   import bfp.pokemon.liby.event.CustomEvent;
   import flash.events.EventDispatcher;
   
   public class LoadCtr extends EventDispatcher
   {
      
      private var firstDataLoaderObj:FirstDataLoader;
      
      private var sprinklerListLoaderObj:SprinklerListLoader;
      
      private var isFirstDataLoaded:Boolean = false;
      
      private var isSprinklerLoaded:Boolean = false;
      
      private var nutsID:*;
      
      private var uneID:*;
      
      private var fieldID:*;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function LoadCtr()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.firstDataLoaderObj = new FirstDataLoader();
         this.sprinklerListLoaderObj = new SprinklerListLoader();
      }
      
      public function reset() : *
      {
         this.firstDataLoaderObj.reset();
         this.sprinklerListLoaderObj.reset();
      }
      
      public function stop() : *
      {
         this.firstDataLoaderObj.stop();
         this.sprinklerListLoaderObj.stop();
         this.clearEvent();
      }
      
      public function run() : *
      {
         Logger.log("はたけ　初期情報ロード開始");
         this.isFirstDataLoaded = false;
         this.isSprinklerLoaded = false;
         this.firstDataLoaderObj.run();
         this.firstDataLoaderObj.load();
         this.setEvent();
      }
      
      private function setEvent() : *
      {
         this.firstDataLoaderObj.addEventListener("onFirstDataLoadComplete",this.onFirstDataLoadComplete);
         this.sprinklerListLoaderObj.addEventListener("onSprinklerListLoadComplete",this.onSprinklerListLoadComplete);
      }
      
      private function clearEvent() : *
      {
         this.firstDataLoaderObj.removeEventListener("onFirstDataLoadComplete",this.onFirstDataLoadComplete);
         this.sprinklerListLoaderObj.removeEventListener("onSprinklerListLoadComplete",this.onSprinklerListLoadComplete);
      }
      
      private function onFirstDataLoadComplete(param1:CustomEvent) : *
      {
         Logger.log("はたけ　初期情報ロード完了");
         this.isFirstDataLoaded = true;
         Logger.log("はたけ　じょうろデータロード開始");
         this.sprinklerListLoaderObj.run();
         this.sprinklerListLoaderObj.load();
      }
      
      private function onSprinklerListLoadComplete(param1:CustomEvent) : *
      {
         Logger.log("はたけ　じょうろデータロード完了");
         this.isSprinklerLoaded = true;
         this.checkLoaded();
      }
      
      private function checkLoaded() : *
      {
         if(this.isFirstDataLoaded && this.isSprinklerLoaded)
         {
            this.data.isLoaded = true;
         }
      }
   }
}


package bfp.pdw.farm.net
{
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
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
   
   public class SelectSprinklerLoader extends EventDispatcher
   {
      
      private var data:FarmData;
      
      private var filePath:FarmFilePath;
      
      private var iconLoader:Loader;
      
      private var imgLoader:Loader;
      
      private var infoObj:*;
      
      private var loadCount:Number = 0;
      
      public function SelectSprinklerLoader()
      {
         super();
         this.data = FarmData.getInstance();
         this.filePath = FarmFilePath.getInstance();
      }
      
      public function load(param1:*) : *
      {
         var _loc2_:* = undefined;
         this.loadCount = 0;
         this.infoObj = this.getInfo(param1);
         this.iconLoader = new Loader();
         _loc2_ = this.filePath.getSprinklerIconImgPath(this.infoObj.interior_id);
         this.iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoadComplete);
         this.iconLoader.load(new URLRequest(_loc2_));
         this.imgLoader = new Loader();
         _loc2_ = this.filePath.getSprinklerImgPath(this.infoObj.interior_id);
         this.imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImgLoadComplete);
         this.imgLoader.load(new URLRequest(_loc2_));
      }
      
      private function onIconLoadComplete(param1:Event) : *
      {
         ++this.loadCount;
         this.checkLoaded();
      }
      
      private function onImgLoadComplete(param1:Event) : *
      {
         ++this.loadCount;
         this.checkLoaded();
      }
      
      private function checkLoaded() : *
      {
         if(this.loadCount >= 2)
         {
            this.data.selectSprinklerData.my_interior_id = this.infoObj.my_interior_id;
            this.data.selectSprinklerData.interior_id = this.infoObj.interior_id;
            this.data.selectSprinklerData.selected_flag = 1;
            this.data.selectSprinklerData.interior_name = this.infoObj.interior_name;
            this.data.selectSprinklerData.iconLoader = this.iconLoader;
            this.data.selectSprinklerData.imgLoader = this.imgLoader;
            dispatchEvent(new CustomEvent("onSprinklerLoadComplete"));
         }
      }
      
      private function getInfo(param1:*) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < this.data.sprinklerList.length)
         {
            if(param1 == this.data.sprinklerList[_loc2_].interior_id)
            {
               return this.data.sprinklerList[_loc2_];
            }
            _loc2_++;
         }
      }
   }
}


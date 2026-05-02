package bfp.pdw.farm.net
{
   import bfp.common.Logger;
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
   
   public class NaeLoader extends EventDispatcher
   {
      
      public static const ON_NAE_LOAD_COMPLETE:String = "onNaeLoadComplete";
      
      public static const ON_NAE_LOAD_ERROR:String = "onNaeLoadError";
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var filePath:FarmFilePath;
      
      private var nutsID:Number;
      
      private var uneID:Number;
      
      private var fieldID:Number;
      
      private var loadCount:Number = 0;
      
      private var loader:Loader;
      
      private var btnLoader:Loader;
      
      public function NaeLoader()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.filePath = FarmFilePath.getInstance();
      }
      
      public function reset() : *
      {
      }
      
      public function stop() : *
      {
      }
      
      public function run() : *
      {
      }
      
      public function load(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = undefined;
         this.loadCount = 0;
         this.nutsID = Number(param1);
         this.uneID = Number(param2);
         this.fieldID = Number(param3);
         _loc4_ = this.filePath.getNaeImgPath(param1);
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onNaeLoadComplete);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onNaeLoadError);
         this.loader.load(new URLRequest(_loc4_));
      }
      
      private function onNaeLoadComplete(param1:Event) : *
      {
         if(this.data.uneParamList[this.uneID][this.fieldID].naeLoader != undefined)
         {
            if(this.data.uneParamList[this.uneID][this.fieldID].naeLoader != null)
            {
               if(this.data.uneParamList[this.uneID][this.fieldID].naeLoader.content == null)
               {
                  this.data.uneParamList[this.uneID][this.fieldID].naeLoader = null;
               }
               else
               {
                  this.data.uneParamList[this.uneID][this.fieldID].naeLoader.unload();
                  this.data.uneParamList[this.uneID][this.fieldID].naeLoader = null;
               }
            }
         }
         this.data.uneParamList[this.uneID][this.fieldID].naeLoader = this.loader;
         this.startNaeOutlineData();
      }
      
      private function onNaeLoadError(param1:IOErrorEvent) : *
      {
         Logger.log("はたけ　なえイメージ画像ロードエラー uneID:" + this.uneID + "  fieldID:" + this.fieldID + "  kinomiID:" + this.nutsID);
         dispatchEvent(new CustomEvent("onNaeLoadError"));
      }
      
      private function startNaeOutlineData() : *
      {
         var _loc1_:* = this.filePath.getNaeImgBtnPath(this.nutsID);
         this.btnLoader = new Loader();
         this.btnLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBtnLoadComplete);
         this.btnLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBtnloadError);
         this.btnLoader.load(new URLRequest(_loc1_));
      }
      
      private function onBtnLoadComplete(param1:Event) : *
      {
         if(this.data.uneParamList[this.uneID][this.fieldID].btnLoader != undefined)
         {
            if(this.data.uneParamList[this.uneID][this.fieldID].btnLoader != null)
            {
               if(this.data.uneParamList[this.uneID][this.fieldID].btnLoader.content == null)
               {
                  this.data.uneParamList[this.uneID][this.fieldID].btnLoader = null;
               }
               else
               {
                  this.data.uneParamList[this.uneID][this.fieldID].btnLoader.unload();
                  this.data.uneParamList[this.uneID][this.fieldID].btnLoader = null;
               }
            }
         }
         this.data.uneParamList[this.uneID][this.fieldID].btnLoader = this.btnLoader;
         this.sendFinishEvent();
      }
      
      private function onBtnloadError(param1:IOErrorEvent) : *
      {
         Logger.log("はたけ　なえアウトラインデータロードエラー　uneID:" + this.uneID + "  fieldID:" + this.fieldID + "  kinomiID:" + this.nutsID);
         dispatchEvent(new CustomEvent("onNaeLoadError"));
      }
      
      private function sendFinishEvent() : *
      {
         dispatchEvent(new CustomEvent("onNaeLoadComplete"));
      }
   }
}


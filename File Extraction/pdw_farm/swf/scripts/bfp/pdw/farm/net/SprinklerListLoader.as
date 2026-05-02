package bfp.pdw.farm.net
{
   import bfp.PDWBridge;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.JSONLoader;
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
   
   public class SprinklerListLoader extends EventDispatcher
   {
      
      private var jsonLoader:JSONLoader;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var filePath:FarmFilePath;
      
      private var loadCount:* = 0;
      
      private var totalCount:* = 0;
      
      public function SprinklerListLoader()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.filePath = FarmFilePath.getInstance();
         this.jsonLoader = new JSONLoader();
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
      
      public function load() : *
      {
         this.loadCount = 0;
         var _loc1_:* = this.filePath.getSprinklerListAPI();
         this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
         this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onJSONLoadError);
         this.jsonLoader.load(_loc1_);
      }
      
      private function onJSONLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:* = undefined;
         this.jsonLoader.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
         this.data.sprinklerList = param1.obj.waterpot_list;
         Logger.log("はたけ　じょうろ個数：" + this.data.sprinklerList.length);
         if(this.data.sprinklerList.length == 0)
         {
            Logger.log("はたけ　じょうろデータエラー　じょうろが0個です。");
         }
         this.data.selectSprinklerData = {};
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.data.sprinklerList.length)
         {
            this.data.sprinklerList[_loc2_].my_interior_id = Number(this.data.sprinklerList[_loc2_].my_interior_id);
            this.data.sprinklerList[_loc2_].interior_id = Number(this.data.sprinklerList[_loc2_].interior_id);
            this.data.sprinklerList[_loc2_].selected_flag = Number(this.data.sprinklerList[_loc2_].selected_flag);
            if(this.data.sprinklerList[_loc2_].selected_flag == 1)
            {
               _loc3_ = true;
               this.data.selectSprinklerData = {};
               this.data.selectSprinklerData.my_interior_id = this.data.sprinklerList[_loc2_].my_interior_id;
               this.data.selectSprinklerData.interior_id = this.data.sprinklerList[_loc2_].interior_id;
               this.data.selectSprinklerData.selected_flag = this.data.sprinklerList[_loc2_].selected_flag;
               this.data.selectSprinklerData.interior_name = this.data.sprinklerList[_loc2_].interior_name;
            }
            _loc2_++;
         }
         if(_loc3_)
         {
            this.totalCount = this.data.sprinklerList.length + 2;
            this.loadIcon();
         }
         else
         {
            this.data.selectSprinklerData = {};
            this.data.selectSprinklerData.my_interior_id = this.data.sprinklerList[0].my_interior_id;
            this.data.selectSprinklerData.interior_id = this.data.sprinklerList[0].interior_id;
            this.data.selectSprinklerData.selected_flag = this.data.sprinklerList[0].selected_flag;
            this.data.selectSprinklerData.interior_name = this.data.sprinklerList[0].interior_name;
            this.sendSelectSprinkler();
         }
      }
      
      private function onJSONLoadError(param1:CustomEvent) : *
      {
         var _loc6_:* = undefined;
         Logger.log("はたけ　じょうろデータエラー");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onJSONLoadError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　じょうろデータエラー error code:" + _loc3_.error.code);
         for(_loc6_ in _loc3_.error.details)
         {
            Logger.log("はたけ　じょうろデータエラー　error detail " + _loc6_ + ":" + _loc3_.error.details[_loc6_]);
            _loc5_ += _loc3_.error.details[_loc6_] + " ";
         }
         switch(_loc4_)
         {
            case 400:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 401:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 403:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 404:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 500:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 502:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 503:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 888:
               PDWBridge.dialogError(_loc4_ + ":" + _loc5_,PDWBridge.DIALOG_ERROR_BACK_HOME);
               break;
            case 999:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
         }
      }
      
      private function sendSelectSprinkler() : *
      {
         var _loc1_:JSONLoader = new JSONLoader();
         _loc1_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectJsonLoadComplete);
         _loc1_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectJsonLoadError);
         var _loc2_:* = this.filePath.getSelectWaterPot();
         _loc1_.load(_loc2_,URLRequestMethod.POST,{"interior_id":this.data.selectSprinklerData.interior_id});
      }
      
      private function onSelectJsonLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectJsonLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectJsonLoadError);
         this.totalCount = this.data.sprinklerList.length + 2;
         this.loadIcon();
      }
      
      private function onSelectJsonLoadError(param1:CustomEvent) : *
      {
         var _loc6_:* = undefined;
         Logger.log("はたけ　じょうろ選択データエラー");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectJsonLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectJsonLoadError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　じょうろ選択データエラー error code:" + _loc3_.error.code);
         for(_loc6_ in _loc3_.error.details)
         {
            Logger.log("はたけ　じょうろ選択データエラー　error detail " + _loc6_ + ":" + _loc3_.error.details[_loc6_]);
            _loc5_ += _loc3_.error.details[_loc6_] + " ";
         }
         switch(_loc4_)
         {
            case 400:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 401:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 403:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 404:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 500:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 502:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 503:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
               break;
            case 888:
               PDWBridge.dialogError(_loc4_ + ":" + _loc5_,PDWBridge.DIALOG_ERROR_BACK_HOME);
               break;
            case 999:
               PokemonBridge.alertWindow(_loc4_ + ":" + _loc5_);
         }
      }
      
      private function loadIcon() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Loader = null;
         var _loc3_:* = undefined;
         var _loc7_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < this.data.sprinklerList.length)
         {
            _loc7_ = this.data.sprinklerList[_loc1_];
            _loc2_ = new Loader();
            _loc3_ = this.filePath.getSprinklerIconImgPath(_loc7_.interior_id);
            _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoadComplete);
            _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoadError);
            _loc2_.load(new URLRequest(_loc3_));
            this.data.sprinklerList[_loc1_].iconLoader = _loc2_;
            _loc1_++;
         }
         var _loc4_:Loader = new Loader();
         var _loc5_:Loader = new Loader();
         var _loc6_:* = 1;
         if(this.data.selectSprinklerData.interior_id != undefined)
         {
            _loc6_ = this.data.selectSprinklerData.interior_id;
         }
         else
         {
            this.data.selectSprinklerData.my_interior_id = 283;
            this.data.selectSprinklerData.interior_id = 1;
            this.data.selectSprinklerData.selected_flag = 1;
            this.data.selectSprinklerData.interior_name = "ふつうのじょうろ";
            this.data.sprinklerList[0].selected_flag = 1;
         }
         _loc3_ = this.filePath.getSprinklerIconImgPath(_loc6_);
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoadComplete);
         _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoadError);
         _loc4_.load(new URLRequest(_loc3_));
         this.data.selectSprinklerData.iconLoader = _loc4_;
         _loc3_ = this.filePath.getSprinklerImgPath(_loc6_);
         _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoadComplete);
         _loc5_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoadError);
         _loc5_.load(new URLRequest(_loc3_));
         this.data.selectSprinklerData.imgLoader = _loc5_;
      }
      
      private function onIconLoadComplete(param1:Event) : *
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         var _loc3_:Loader = _loc2_.loader;
         ++this.loadCount;
         if(this.loadCount >= this.totalCount)
         {
            this.sendFinishEvent();
         }
      }
      
      private function onIconLoadError(param1:IOErrorEvent) : *
      {
         Logger.log("はたけ　じょうろ画像ロードエラー");
      }
      
      private function sendFinishEvent() : *
      {
         dispatchEvent(new CustomEvent("onSprinklerListLoadComplete"));
      }
   }
}


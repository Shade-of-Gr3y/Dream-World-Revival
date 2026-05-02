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
   
   public class APICtr extends EventDispatcher
   {
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var filePath:FarmFilePath;
      
      private var errorBehaviorObj:ErrorBehavior;
      
      public function APICtr()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
         this.filePath = FarmFilePath.getInstance();
      }
      
      public function reset() : *
      {
      }
      
      public function stop() : *
      {
         this.clearEvent();
      }
      
      public function run() : *
      {
         this.setEvent();
      }
      
      private function setEvent() : *
      {
         this.bridge.addEventListener("onSendPlantNutsData",this.onSendPlantNutsData);
         this.bridge.addEventListener("onSendWater",this.onSendWater);
         this.bridge.addEventListener("onSendHarvest",this.onSendHarvest);
         this.bridge.addEventListener("onSendSelectSprinkler",this.onSendSelectSprinkler);
         this.bridge.addEventListener("onSendFriendWater",this.onSendFriendWater);
         this.bridge.addEventListener("onSendEndTutorial",this.onSendEndTutorial);
         this.bridge.addEventListener("onSendMyFarmData",this.onSendMyFarmData);
      }
      
      private function clearEvent() : *
      {
         this.bridge.removeEventListener("onSendPlantNutsData",this.onSendPlantNutsData);
         this.bridge.removeEventListener("onSendWater",this.onSendWater);
         this.bridge.removeEventListener("onSendHarvest",this.onSendHarvest);
         this.bridge.removeEventListener("onSendSelectSprinkler",this.onSendSelectSprinkler);
         this.bridge.removeEventListener("onSendFriendWater",this.onSendFriendWater);
         this.bridge.removeEventListener("onSendEndTutorial",this.onSendEndTutorial);
         this.bridge.removeEventListener("onSendMyFarmData",this.onSendMyFarmData);
      }
      
      private function onSendPlantNutsData(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting();
         Logger.log("はたけ　種植え送信");
         var _loc2_:* = param1.obj.myCroftID;
         var _loc3_:* = param1.obj.pokeItemID;
         var _loc4_:* = this.filePath.getSowAPI();
         var _loc5_:JSONLoader = new JSONLoader();
         _loc5_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendPlantNutsDataComplete);
         _loc5_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendPlantNutsDataError);
         var _loc6_:* = {};
         _loc6_.my_croft_id = _loc2_;
         _loc6_.pokeitem_id = _loc3_;
         _loc5_.load(_loc4_,"POST",_loc6_);
      }
      
      private function onSendPlantNutsDataComplete(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　種植え送信完了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendPlantNutsDataComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendPlantNutsDataError);
         var _loc3_:* = param1.obj;
         this.bridge.resposePlantNutsData(_loc3_);
      }
      
      private function onSendPlantNutsDataError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendPlantNutsDataComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendPlantNutsDataError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　種植え送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　種植え送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendWater(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting();
         Logger.log("はたけ　水まき送信");
         var _loc2_:* = param1.obj.myCroftID;
         var _loc3_:* = this.filePath.getWatringAPI();
         var _loc4_:JSONLoader = new JSONLoader();
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onWatringComplete);
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onWatringError);
         var _loc5_:* = {};
         _loc5_.my_croft_id = _loc2_;
         _loc4_.load(_loc3_,"POST",_loc5_);
      }
      
      private function onWatringComplete(param1:CustomEvent) : *
      {
         PokemonBridge.tag("pdw.farm_kinomi_watering_my");
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　水まき送信完了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onWatringComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onWatringError);
         var _loc3_:* = param1.obj;
         this.bridge.responseWater(_loc3_);
      }
      
      private function onWatringError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onWatringComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onWatringError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　水まき送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　水まき送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendFriendWater(param1:CustomEvent) : *
      {
         PokemonBridge.tag("pdw.farm_kinomi_watering_other");
         PDWBridge.showConnecting();
         Logger.log("はたけ　フレンド水まき送信");
         var _loc2_:* = param1.obj.myCroftID;
         var _loc3_:* = this.filePath.getFriendWatringAPI();
         var _loc4_:JSONLoader = new JSONLoader();
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onFriendWatringComplete);
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onFriendWatringError);
         var _loc5_:* = {};
         _loc5_.my_croft_id = _loc2_;
         _loc5_.member_savedata_id = param1.obj.memberSavedataID;
         _loc4_.load(_loc3_,"POST",_loc5_);
      }
      
      private function onFriendWatringComplete(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　フレンド水まき送信完了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onFriendWatringComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onFriendWatringError);
         var _loc3_:* = param1.obj;
         this.bridge.responseFriendWater(_loc3_);
      }
      
      private function onFriendWatringError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onFriendWatringComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onFriendWatringError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　フレンド水まき送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　フレンド水まき送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendHarvest(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting();
         Logger.log("はたけ　収穫送信");
         var _loc2_:* = param1.obj.myCroftID;
         var _loc3_:* = this.filePath.getHarvestAPI();
         var _loc4_:JSONLoader = new JSONLoader();
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onHarvestComplete);
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onHarvestError);
         var _loc5_:* = {};
         _loc5_.my_croft_id = _loc2_;
         _loc4_.load(_loc3_,"POST",_loc5_);
      }
      
      private function onHarvestComplete(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　収穫送信完了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onHarvestComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onHarvestError);
         var _loc3_:* = param1.obj;
         this.bridge.responseHarvest(_loc3_);
      }
      
      private function onHarvestError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onHarvestComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onHarvestError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　収穫送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　収穫送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendSelectSprinkler(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting();
         Logger.log("はたけ　じょうろ変更送信");
         var _loc2_:* = param1.obj.interiorID;
         var _loc3_:* = this.filePath.getSelectWaterPot();
         var _loc4_:JSONLoader = new JSONLoader();
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectSprinklerComplete);
         _loc4_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectSprinklerError);
         var _loc5_:* = {};
         _loc5_.interior_id = _loc2_;
         _loc4_.load(_loc3_,"POST",_loc5_);
      }
      
      private function onSelectSprinklerComplete(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　じょうろ変更送信完了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectSprinklerComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectSprinklerError);
         var _loc3_:* = param1.obj;
         this.bridge.responseSelectSprinkler(_loc3_);
      }
      
      private function onSelectSprinklerError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSelectSprinklerComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSelectSprinklerError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　じょうろ変更送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　じょうろ変更送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendEndTutorial(param1:CustomEvent) : *
      {
         var _loc2_:* = this.filePath.getEndTutorialAPI();
         var _loc3_:JSONLoader = new JSONLoader();
         _loc3_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendEndTutorialComplete);
         _loc3_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendEndTutorialError);
         _loc3_.load(_loc2_,URLRequestMethod.GET);
      }
      
      private function onSendEndTutorialComplete(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendEndTutorialComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendEndTutorialError);
         var _loc3_:* = param1.obj;
         this.bridge.responseEndTutorial(_loc3_);
      }
      
      private function onSendEndTutorialError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendEndTutorialComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendEndTutorialError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　チュートリアル終了送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　チュートリアル終了送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function onSendMyFarmData(param1:CustomEvent) : *
      {
         var _loc2_:* = this.filePath.getMyCroftListAPI();
         var _loc3_:JSONLoader = new JSONLoader();
         _loc3_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendMyFarmDataComplete);
         _loc3_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendMyFarmDataError);
         _loc3_.load(_loc2_,URLRequestMethod.GET);
      }
      
      private function onSendMyFarmDataComplete(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendMyFarmDataComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendMyFarmDataError);
         var _loc3_:* = param1.obj;
         this.bridge.responseMyFarmData(_loc3_);
      }
      
      private function onSendMyFarmDataError(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onSendMyFarmDataComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onSendMyFarmDataError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　自分のはたけ送信エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　自分のはたけ送信エラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getSowAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
   }
}


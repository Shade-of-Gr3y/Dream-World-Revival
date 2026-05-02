package bfp.pdw.farm.net
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.common.Logger;
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
   
   public class FirstDataLoader extends EventDispatcher
   {
      
      private var jsonLoader:JSONLoader;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var filePath:FarmFilePath;
      
      private var loadCount:* = 0;
      
      private var totalCount:* = 0;
      
      private var count:* = 0;
      
      private var loaderList:Array = [];
      
      private var errorBehaviorObj:ErrorBehavior;
      
      public function FirstDataLoader()
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
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         this.loaderList = [];
         this.count = 0;
         this.loadCount = 0;
         this.totalCount = 0;
         if(this.data.isFriendMode)
         {
            Logger.log("はたけ　ともだち情報取得開始");
            _loc1_ = this.filePath.getFriendCroftListAPI();
            _loc2_ = {};
            _loc2_.member_savedata_id = PDWHomeData.anotherMemberSaveDataId;
            this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
            this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onJSONLoadError);
            this.jsonLoader.load(_loc1_,URLRequestMethod.GET,_loc2_);
         }
         else
         {
            Logger.log("はたけ　うね情報取得開始");
            _loc1_ = this.filePath.getMyCroftListAPI();
            this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
            this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onJSONLoadError);
            this.jsonLoader.load(_loc1_,URLRequestMethod.GET);
         }
      }
      
      private function onJSONLoadComplete(param1:CustomEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Array = param1.obj.croft_list;
         if(this.data.isFriendMode)
         {
            this.data.isUneIncreaseAnime = false;
            PDWHomeData.anotherWateringCount = Number(param1.obj.remains_watering);
         }
         else
         {
            switch(Number(param1.obj.diglett_flag))
            {
               case 0:
                  this.data.isUneIncreaseAnime = false;
                  break;
               default:
                  this.data.isUneIncreaseAnime = true;
            }
         }
         var _loc5_:* = 0;
         if(_loc2_.length > 1)
         {
            this.data.isFirstTutorial = false;
            this.data.uneParamList = [];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(Number(_loc2_[_loc3_].y) > _loc5_)
               {
                  _loc5_ = Number(_loc2_[_loc3_].y);
               }
               _loc3_++;
            }
            this.data.numFurrows = _loc5_;
            _loc3_ = 0;
            while(_loc3_ < this.data.numFurrows)
            {
               this.data.uneParamList[_loc3_] = [];
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc6_ = {};
               _loc6_.myCroftID = _loc2_[_loc3_].my_croft_id;
               _loc6_.pokeItemID = _loc2_[_loc3_].pokeitem_id;
               _loc6_.nutsName = _loc2_[_loc3_].kinomi;
               _loc6_.nutsID = _loc2_[_loc3_].kinomi_id;
               _loc6_.f_HP = _loc2_[_loc3_].dirt_hp;
               switch(_loc2_[_loc3_].kinomi_state)
               {
                  case 0:
                     _loc6_.p_status = this.data.PLANT_STATUS_SOIL;
                     _loc6_.f_status = this.data.FIELD_STATUS_PLANT;
                     break;
                  case 1:
                     _loc6_.p_status = this.data.PLANT_STATUS_SPROUT;
                     _loc6_.f_status = this.data.FIELD_STATUS_PLANT;
                     break;
                  case 2:
                     _loc6_.p_status = this.data.PLANT_STATUS_TRUNK;
                     _loc6_.f_status = this.data.FIELD_STATUS_PLANT;
                     break;
                  case 3:
                     _loc6_.p_status = this.data.PLANT_STATUS_FLOWER;
                     _loc6_.f_status = this.data.FIELD_STATUS_PLANT;
                     break;
                  case 4:
                     _loc6_.p_status = this.data.PLANT_STATUS_FRUIT;
                     _loc6_.f_status = this.data.FIELD_STATUS_NUTS;
                     break;
                  default:
                     _loc6_.p_status = this.data.PLANT_STATUS_NONE;
                     _loc6_.f_status = this.data.FIELD_STATUS_NONE;
               }
               _loc7_ = "";
               if(_loc2_[_loc3_].desc1 != null)
               {
                  _loc7_ += _loc2_[_loc3_].desc1;
               }
               if(_loc2_[_loc3_].desc2 != null)
               {
                  _loc7_ = _loc7_ + "\n" + _loc2_[_loc3_].desc2;
               }
               if(_loc2_[_loc3_].desc3 != null)
               {
                  _loc7_ = _loc7_ + "\n" + _loc2_[_loc3_].desc3;
               }
               _loc6_.nutsDescription = _loc7_;
               this.data.uneParamList[Number(_loc2_[_loc3_].y) - 1][Number(_loc2_[_loc3_].x) - 1] = _loc6_;
               if(_loc6_.nutsID != null)
               {
                  this.totalCount += 1;
               }
               _loc3_++;
            }
            this.naeLoad();
         }
         else if(this.data.isFriendMode)
         {
            this.data.isFirstTutorial = false;
            this.data.uneParamList = [];
            this.data.numFurrows = 0;
            this.noneCroftAlert();
         }
         else
         {
            this.debugTutorialSkip();
         }
      }
      
      private function onJSONLoadError(param1:CustomEvent) : *
      {
         var _loc7_:* = undefined;
         var _loc2_:* = param1.obj;
         var _loc3_:* = Number(_loc2_.error.code);
         var _loc4_:* = "";
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　うね情報取得エラー error code:" + _loc2_.error.code);
         _loc4_ = _loc2_.error.details.message;
         _loc5_ = _loc2_.error.details.keys;
         Logger.log("はたけ　うね情報取得エラー　error detail message:" + _loc4_ + "  keys:" + _loc5_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc5_[0] == undefined)
         {
            _loc5_[0] = "none";
         }
         if(this.data.isFriendMode)
         {
            _loc7_ = this.filePath.getFriendCroftListAPI();
         }
         else
         {
            _loc7_ = this.filePath.getMyCroftListAPI();
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(_loc7_,_loc3_,_loc5_[0]);
         PDWBridge.dialogError(_loc4_,_loc8_);
      }
      
      private function noneCroftAlert() : *
      {
         Logger.log("はたけ　ともだちのしま　うね0個");
         PDWBridge.showConnecting(false);
         var _loc1_:* = "";
         PDWBridge.dialogError(_loc1_,PDWBridge.DIALOG_ERROR_BACK_HOME);
      }
      
      private function startTutorial() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this.data.isFirstTutorial = true;
         this.data.uneParamList = [];
         this.data.numFurrows = 2;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            this.data.uneParamList[_loc1_] = [];
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_ = {};
               _loc3_.myCroftID = -1;
               _loc3_.pokeItemID = null;
               _loc3_.nutsName = null;
               _loc3_.nutsID = null;
               _loc3_.f_HP = 100;
               _loc3_.p_status = this.data.PLANT_STATUS_NONE;
               _loc3_.f_status = this.data.FIELD_STATUS_NONE;
               _loc3_.nutsDescription = "";
               this.data.uneParamList[_loc1_][_loc2_] = _loc3_;
               _loc2_++;
            }
            _loc1_++;
         }
         this.callTutorial();
      }
      
      private function debugTutorialSkip() : *
      {
         Logger.log("はたけ　初期フラグ開始");
         var _loc1_:* = this.filePath.getStartTutorialAPI();
         var _loc2_:JSONLoader = new JSONLoader();
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialStartJSONLoadComplete);
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialStartJSONLoadError);
         _loc2_.load(_loc1_,URLRequestMethod.GET);
      }
      
      private function onTutorialStartJSONLoadComplete(param1:CustomEvent) : *
      {
         Logger.log("はたけ　初期フラグ終了");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialStartJSONLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialStartJSONLoadError);
         this.startTutorialEnd();
      }
      
      private function onTutorialStartJSONLoadError(param1:CustomEvent) : *
      {
         Logger.log("はたけ　初期フラグエラー");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialStartJSONLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialStartJSONLoadError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　初期フラグエラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　初期フラグエラー　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getStartTutorialAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function startTutorialEnd() : *
      {
         Logger.log("はたけ　初期フラグ開始2");
         var _loc1_:* = this.filePath.getEndTutorialAPI();
         var _loc2_:JSONLoader = new JSONLoader();
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialEndJSONLoadComplete);
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialEndJSONLoadError);
         _loc2_.load(_loc1_,URLRequestMethod.GET);
      }
      
      private function onTutorialEndJSONLoadComplete(param1:CustomEvent) : *
      {
         Logger.log("はたけ　初期フラグ終了2");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialEndJSONLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialEndJSONLoadError);
         Logger.log("はたけ　初期フラグ終了後　うね情報取得開始");
         var _loc3_:* = this.filePath.getMyCroftListAPI();
         this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onJSONLoadComplete);
         this.jsonLoader.addEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onJSONLoadError);
         this.jsonLoader.load(_loc3_,URLRequestMethod.GET);
         this.data.isFirstTutorial = false;
      }
      
      private function onTutorialEndJSONLoadError(param1:CustomEvent) : *
      {
         Logger.log("はたけ　初期フラグ開始2 エラー");
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onTutorialEndJSONLoadComplete);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_ERROR,this.onTutorialEndJSONLoadError);
         var _loc3_:* = param1.obj;
         var _loc4_:* = Number(_loc3_.error.code);
         var _loc5_:* = "";
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         PDWBridge.showConnecting(false);
         Logger.log("はたけ　初期フラグ開始2 エラー error code:" + _loc3_.error.code);
         _loc5_ = _loc3_.error.details.message;
         _loc6_ = _loc3_.error.details.keys;
         Logger.log("はたけ　初期フラグ開始2　error detail message:" + _loc5_ + "  keys:" + _loc6_);
         if(this.errorBehaviorObj == null)
         {
            this.errorBehaviorObj = new ErrorBehavior();
         }
         if(_loc6_[0] == undefined)
         {
            _loc6_[0] = "none";
         }
         var _loc8_:* = this.errorBehaviorObj.getErrorAfterBehavior(this.filePath.getEndTutorialAPI(),_loc4_,_loc6_[0]);
         PDWBridge.dialogError(_loc5_,_loc8_);
      }
      
      private function naeLoad() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:NaeLoader = null;
         var _loc4_:* = undefined;
         this.loaderList = [];
         if(this.totalCount > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.data.uneParamList.length)
            {
               _loc2_ = 0;
               while(_loc2_ < this.data.uneParamList[_loc1_].length)
               {
                  if(this.data.uneParamList[_loc1_][_loc2_].nutsID != null)
                  {
                     _loc3_ = new NaeLoader();
                     _loc4_ = {};
                     _loc4_.nutsID = this.data.uneParamList[_loc1_][_loc2_].nutsID;
                     _loc4_.uneID = _loc1_;
                     _loc4_.fieldID = _loc2_;
                     _loc4_.naeLoader = _loc3_;
                     this.loaderList.push(_loc4_);
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
            this.startRepeatNaeLoad();
         }
         else
         {
            this.sendFinishEvent();
         }
      }
      
      private function startRepeatNaeLoad() : *
      {
         this.count = 0;
         this.repeatNaeLoad();
      }
      
      private function repeatNaeLoad() : *
      {
         var _loc1_:NaeLoader = this.loaderList[this.count].naeLoader;
         _loc1_.addEventListener("onNaeLoadComplete",this.onNaeLoadComplete);
         _loc1_.addEventListener("onNaeLoadError",this.onNaeLoadError);
         _loc1_.load(this.loaderList[this.count].nutsID,this.loaderList[this.count].uneID,this.loaderList[this.count].fieldID);
      }
      
      private function onNaeLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:NaeLoader = NaeLoader(param1.currentTarget);
         _loc2_.removeEventListener("onNaeLoadComplete",this.onNaeLoadComplete);
         ++this.loadCount;
         ++this.count;
         if(this.loadCount >= this.totalCount)
         {
            this.sendFinishEvent();
         }
         else
         {
            this.repeatNaeLoad();
         }
      }
      
      private function onNaeLoadError(param1:CustomEvent) : *
      {
      }
      
      private function callTutorial() : *
      {
         var _loc1_:* = this.filePath.getStartTutorialAPI();
         var _loc2_:JSONLoader = new JSONLoader();
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onStartTutorialComplete);
         _loc2_.load(_loc1_,URLRequestMethod.GET);
      }
      
      private function onStartTutorialComplete(param1:CustomEvent) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:NaeLoader = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:JSONLoader = JSONLoader(param1.currentTarget);
         _loc2_.removeEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onStartTutorialComplete);
         var _loc3_:* = param1.obj;
         for(_loc4_ in _loc3_)
         {
         }
         _loc5_ = 0;
         _loc6_ = 1;
         this.loaderList = [];
         _loc7_ = new NaeLoader();
         _loc8_ = {};
         _loc8_.nutsID = _loc3_.kinomi_id;
         _loc8_.uneID = _loc5_;
         _loc8_.fieldID = _loc6_;
         _loc8_.naeLoader = _loc7_;
         this.loaderList.push(_loc8_);
         _loc9_ = "";
         if(_loc3_.desc1 != null)
         {
            _loc9_ += _loc3_.desc1;
         }
         if(_loc3_.desc2 != null)
         {
            _loc9_ = _loc9_ + "\n" + _loc3_.desc2;
         }
         if(_loc3_.desc3 != null)
         {
            _loc9_ = _loc9_ + "\n" + _loc3_.desc3;
         }
         this.data.uneParamList[_loc5_][_loc6_].nutsID = _loc3_.kinomi_id;
         this.data.uneParamList[_loc5_][_loc6_].pokeItemID = _loc3_.pokeitem_id;
         this.data.uneParamList[_loc5_][_loc6_].p_status = this.data.PLANT_STATUS_FRUIT;
         this.data.uneParamList[_loc5_][_loc6_].f_status = this.data.FIELD_STATUS_NUTS;
         this.data.uneParamList[_loc5_][_loc6_].nutsName = _loc3_.kinomi;
         this.data.uneParamList[_loc5_][_loc6_].nutsDescription = _loc9_;
         this.totalCount = 1;
         this.startRepeatNaeLoad();
      }
      
      private function sendFinishEvent() : *
      {
         dispatchEvent(new CustomEvent("onFirstDataLoadComplete"));
      }
   }
}


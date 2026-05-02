package bfp.pdw.farm
{
   import flash.events.EventDispatcher;
   
   public class FarmFilePath extends EventDispatcher
   {
      
      private static var _instance:FarmFilePath = null;
      
      public var basePath:String = "";
      
      private const PATH_TYPE_LOCAL:String = "local";
      
      private const PATH_TYPE_ABSOLUTE:String = "absolute";
      
      private const PATH_TYPE_RELATIVE:String = "relative";
      
      private var pathType:String = "relative";
      
      private var isLocal:Boolean = false;
      
      private var protocol:String = "http";
      
      private var domain:String = "pokemon-www.basementfactorysystems.com";
      
      public function FarmFilePath(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function getInstance() : *
      {
         if(_instance == null)
         {
            _instance = new FarmFilePath(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function getNaeImgPath(param1:*) : *
      {
         var _loc2_:* = String(Number(param1) + 1000).substring(1);
         return this.basePath + "../../theme/assets/global/parts/plant/nae_" + _loc2_ + ".swf";
      }
      
      public function getNaeImgBtnPath(param1:*) : *
      {
         var _loc2_:* = String(Number(param1) + 1000).substring(1);
         return this.basePath + "../../theme/assets/global/parts/plant/nae_" + _loc2_ + "_shape.swf";
      }
      
      public function getNutsImgPath(param1:*) : *
      {
         return this.basePath + "../../theme/assets/global/parts/nuts/nuts_" + param1 + ".swf";
      }
      
      public function getNutsImgPath57() : *
      {
         return this.basePath + "../../theme/assets/global/parts/nuts/57/";
      }
      
      public function getNutsImgPath35() : *
      {
         return this.basePath + "../../theme/assets/global/parts/nuts/35/";
      }
      
      public function getNutsImgPath28() : *
      {
         return this.basePath + "../../theme/assets/global/parts/nuts/28/";
      }
      
      public function getSprinklerImgPath(param1:*) : *
      {
         return this.basePath + "../../theme/assets/global/parts/interior/" + param1 + ".swf";
      }
      
      public function getSprinklerIconImgPath(param1:*) : *
      {
         return this.basePath + "../../theme/assets/global/parts/interior/" + param1 + ".swf";
      }
      
      public function getStartTutorialAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/tutorial_start.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.tutorial_start";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.tutorial_start";
         }
         return _loc1_;
      }
      
      public function getEndTutorialAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/tutorial_end.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.tutorial_end";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.tutorial_end";
         }
         return _loc1_;
      }
      
      public function getMyCroftListAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/myCroftList.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.my_croft_list";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.my_croft_list";
         }
         return _loc1_;
      }
      
      public function getFriendCroftListAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/friendCroftList.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.friend_croft_list";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.friend_croft_list";
         }
         return _loc1_;
      }
      
      public function getSprinklerListAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/waterpot_list.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.waterpot_list";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.waterpot_list";
         }
         return _loc1_;
      }
      
      public function getSowAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/kinomi_sowing.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.kinomi_sowing";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.kinomi_sowing";
         }
         return _loc1_;
      }
      
      public function getWatringAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/kinomi_watering.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.kinomi_watering";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.kinomi_watering";
         }
         return _loc1_;
      }
      
      public function getFriendWatringAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/friend_kinomi_watering.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.friend_kinomi_watering";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.friend_kinomi_watering";
         }
         return _loc1_;
      }
      
      public function getHarvestAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/kinomi_harvesting.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.kinomi_harvesting";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.kinomi_harvesting";
         }
         return _loc1_;
      }
      
      public function getSelectWaterPot() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/waterpot_select.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.croft.waterpot_select";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.croft.waterpot_select";
         }
         return _loc1_;
      }
      
      public function getItemListAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/farm/item_list.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.item.item_list";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.item.item_list";
         }
         return _loc1_;
      }
      
      public function getHomeDataAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/interior/pdw.home.my_island.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.home.my_island";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.home.my_island";
         }
         return _loc1_;
      }
      
      public function getFriendHomeDataAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/interior/pdw.home.my_island.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.home.friend_island";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.home.friend_island";
         }
         return _loc1_;
      }
      
      public function getPDWStartAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/interior/pdw_start.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pdw.home.pdw_start";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pdw.home.pdw_start";
         }
         return _loc1_;
      }
      
      public function getPGLStartAPI() : *
      {
         var _loc1_:* = undefined;
         switch(this.pathType)
         {
            case this.PATH_TYPE_LOCAL:
               _loc1_ = this.basePath + "dummydata/api/interior/pgl_start.txt";
               break;
            case this.PATH_TYPE_ABSOLUTE:
               _loc1_ = this.protocol + "://" + this.domain + "/api/?p=pgl.top.init";
               break;
            case this.PATH_TYPE_RELATIVE:
               _loc1_ = "pgl.top.init";
         }
         return _loc1_;
      }
      
      public function getItemToNuts(param1:*) : *
      {
         return Number(param1) - 148;
      }
      
      public function getNutsToItem(param1:*) : *
      {
         return Number(param1) + 148;
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}

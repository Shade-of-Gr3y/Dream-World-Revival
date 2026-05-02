package bfp.pdw.farm
{
   import flash.display.Loader;
   
   public class FarmData
   {
      
      private static var _instance:FarmData = null;
      
      public var isAlone:Boolean = false;
      
      public var isFriendMode:Boolean = false;
      
      public var currentHomeType:* = 0;
      
      public var isNoNuts:Boolean = false;
      
      public var basePath:String = "";
      
      public const STAGE_WID:Number = 1003;
      
      public const STAGE_HEI:Number = 557;
      
      public const HEIGHT:Number = 520;
      
      public var isLoaded:Boolean = false;
      
      public var isFirstTutorial:Boolean = false;
      
      public const PLANT_WID:Number = 84;
      
      public const PLANT_HEI:Number = 116;
      
      public var isUneIncreaseAnime:Boolean = false;
      
      public var numFurrows:Number = 5;
      
      public var uneY:* = 300;
      
      public var backSpaceZ:* = 100;
      
      public const BACKSPACE_Y:* = 40;
      
      public var frontSpaceZ:* = 50;
      
      public var unePosList:Array = [{
         "x":0,
         "y":this.uneY,
         "z":-200
      },{
         "x":0,
         "y":this.uneY,
         "z":-150
      },{
         "x":0,
         "y":this.uneY,
         "z":-100
      },{
         "x":0,
         "y":this.uneY,
         "z":-50
      },{
         "x":0,
         "y":this.uneY,
         "z":0
      },{
         "x":0,
         "y":this.uneY + 20,
         "z":70
      },{
         "x":0,
         "y":this.uneY + 45,
         "z":155
      },{
         "x":0,
         "y":this.uneY + 75,
         "z":255
      },{
         "x":0,
         "y":this.uneY + 110,
         "z":370
      }];
      
      public var uneParamList:Array = [[{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":0
      },{
         "f_status":"plant",
         "f_HP":100,
         "p_status":"sprout",
         "nutsID":0
      },{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":-1
      }],[{
         "f_status":"nuts",
         "f_HP":100,
         "p_status":"fruit",
         "nutsID":0
      },{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":-1
      },{
         "f_status":"plant",
         "f_HP":40,
         "p_status":"sprout",
         "nutsID":0
      }],[{
         "f_status":"plant",
         "f_HP":0,
         "p_status":"trunk",
         "nutsID":0
      },{
         "f_status":"plant",
         "f_HP":100,
         "p_status":"flower",
         "nutsID":0
      },{
         "f_status":"nuts",
         "f_HP":100,
         "p_status":"fruit",
         "nutsID":0
      }],[{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":-1
      },{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":-1
      },{
         "f_status":"plant",
         "f_HP":100,
         "p_status":"flower",
         "nutsID":0
      }],[{
         "f_status":"plant",
         "f_HP":100,
         "p_status":"soil",
         "nutsID":0
      },{
         "f_status":"plant",
         "f_HP":40,
         "p_status":"soil",
         "nutsID":0
      },{
         "f_status":"none",
         "f_HP":100,
         "p_status":"",
         "nutsID":-1
      }]];
      
      public const FIELD_STATUS_NONE:String = "none";
      
      public const FIELD_STATUS_PLANT:String = "plant";
      
      public const FIELD_STATUS_NUTS:String = "nuts";
      
      public const PLANT_STATUS_SOIL:String = "soil";
      
      public const PLANT_STATUS_SPROUT:String = "sprout";
      
      public const PLANT_STATUS_TRUNK:String = "trunk";
      
      public const PLANT_STATUS_FLOWER:String = "flower";
      
      public const PLANT_STATUS_FRUIT:String = "fruit";
      
      public const PLANT_STATUS_NONE:String = "none";
      
      public const SOIL_STATUS_DANGER:String = "danger";
      
      public const SOIL_STATUS_CAUTION:String = "caution";
      
      public const SOIL_STATUS_SAFE:String = "safe";
      
      public const SPIRINKLER_TYPE_0:String = "normal";
      
      public const SPIRINKLER_TYPE_1:String = "zenigame";
      
      public const SPIRINKLER_TYPE_2:String = "kodak";
      
      public const SPIRINKLER_TYPE_3:String = "donfan";
      
      public const SPIRINKLER_TYPE_4:String = "kaiouga";
      
      public const SPIRINKLER_TYPE_5:String = "amagoi";
      
      public const SPRINKLER_ID_NORMAL:Number = 1;
      
      public const SPRINKLER_ID_DELIBIRD:Number = 6;
      
      public const SPRINKLER_ID_ZENIGAME:Number = 2;
      
      public const SPRINKLER_ID_DONFAN:Number = 4;
      
      public const SPRINKLER_ID_KAIOUGA:Number = 5;
      
      public const SPRINKLER_ID_KODAK:Number = 3;
      
      private var _isWaterAnime:Boolean = false;
      
      public const SPRINKLER_POS_HEIGHT:Number = 110;
      
      public var sprinklerList:Array = [];
      
      public var selectSprinklerData:* = {};
      
      public var pokemonPlaceType:String = "";
      
      public var pokemonDisX:Number = -350;
      
      public var pokemonDisY:Number = 40;
      
      public var pokemonID:Number = 0;
      
      public var pokemonFormID:Number = 0;
      
      public var pokemonLoader:Loader;
      
      public var myPoint:Number = 0;
      
      public var digdaLoader:Loader;
      
      public const NORMAL_MODE:String = "normal";
      
      public const SPRINK_MODE:String = "sprink";
      
      public var farmMode:String = "normal";
      
      public const PANEL_TYPE_ITEMBOX:String = "itembox";
      
      public const PANEL_TYPE_PLANTCHECK:String = "plantcheck";
      
      public const PANEL_TYPE_PLANTFINISH:String = "plantfinish";
      
      public const PANEL_TYPE_WATERCHECK:String = "watercheck";
      
      public const PANEL_TYPE_HARVESTCHECK:String = "harvestcheck";
      
      public const PANEL_TYPE_HARVESTFINISH:String = "harvesetfinish";
      
      public const PANEL_TYPE_NONUTSALERT:String = "nonutsalert";
      
      public const PANEL_TYPE_ADDFURROWALERT:String = "addfurrowalertpanel";
      
      public const PANEL_TYPE_ADDFURROWALERT_SECOND:String = "addfurrowalertpanelSecond";
      
      public const PANEL_TYPE_POKEMONSTATUS:String = "pokemonStatus";
      
      public const FUKIDASHI_TYPE_NONE:String = "none";
      
      public const FUKIDASHI_TYPE_WATERING:String = "watering";
      
      public const FUKIDASHI_TYPE_HARVEST:String = "harvest";
      
      public const POKEMON_INFO_TYPE_MY:String = "my";
      
      public const POKEMON_INFO_TYPE_FRIEND:String = "friend";
      
      public const ALERT_TYPE_NO_NUTS:String = "alertTypeNoNuts";
      
      public const ALERT_TYPE_NO_WATER:String = "alertTypeNoWater";
      
      public const FIRST_TUTORIAL_GET_NUTS_COUNT:Number = 5;
      
      public const FONT_COLOR:uint = 4664077;
      
      public var itemBoxLoader:Loader;
      
      public function FarmData(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function getInstance() : *
      {
         if(_instance == null)
         {
            _instance = new FarmData(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function get isWaterAnime() : Boolean
      {
         return this._isWaterAnime;
      }
      
      public function set isWaterAnime(param1:Boolean) : *
      {
         this._isWaterAnime = param1;
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

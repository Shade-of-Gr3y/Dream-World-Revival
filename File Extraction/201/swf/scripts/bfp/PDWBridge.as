package bfp
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PDWBridge
   {
      
      public static var currentScene:String;
      
      private static var _statusWindow:IPDWPokemonStatus;
      
      private static var _newsdata:Array;
      
      private static var _newsBitmapData:Array;
      
      private static var _world0bmd:BitmapData;
      
      private static var _campaignIslandList:Object;
      
      protected static const _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var isLocal:Boolean = false;
      
      public static const SFX_ID_MOUSE_OVER:int = 0;
      
      public static const SFX_ID_CLICK:int = 1;
      
      public static const SFX_ID_ALERT:int = 2;
      
      public static const SFX_ID_DOOR:int = 3;
      
      public static const SFX_ID_MOVE_WORLD:int = 4;
      
      public static const SFX_ID_FRIENDLIST:int = 5;
      
      public static const SFX_ID_MOVESIGHT:int = 6;
      
      public static const SFX_ID_EXCHANGE:int = 7;
      
      public static const SFX_ID_HARVEST:int = 8;
      
      public static const SFX_ID_ANYONE_CHANGE:int = 9;
      
      public static const SFX_ID_BOARD:int = 10;
      
      public static const SFX_ID_FOOTPRINT:int = 11;
      
      public static const SFX_ID_FLIP_PAGE:int = 12;
      
      public static const SFX_ID_PLANT:int = 13;
      
      public static const SFX_ID_WATER:int = 14;
      
      public static const SFX_ID_NEWS:int = 15;
      
      public static const SFX_ID_SHARE:int = 16;
      
      public static const DIALOG_ERROR_REFRESH:int = -1;
      
      public static const DIALOG_ERROR_NONE:int = 0;
      
      public static const DIALOG_ERROR_CLOSE:int = 1;
      
      public static const DIALOG_ERROR_BACK_HOME:int = 2;
      
      public static const DIALOG_ERROR_BACK_MAP:int = 3;
      
      public static const DIALOG_ERROR_REMOVE_CAPTURE:int = 4;
      
      public static const ERROR_SPECIAL_TIMECHECK:int = 0;
      
      public static const ERROR_SPECIAL_TIMECHECK_SLEEP:int = 1;
      
      public static const ERROR_SPECIAL_COUNTCHECK:int = 2;
      
      public static const ERROR_SPECIAL_COUNTCHECK_SLEEP:int = 3;
      
      public static const SCENE_WORLD:String = "scene_world";
      
      public static const SCENE_MOVE:String = "scene_move";
      
      public static const SCENE_HOME:String = "scene_home";
      
      public static const SCENE_START:String = "scene_start";
      
      public static const SCENE_OPENING:String = "scene_opening";
      
      public static const SCENE_ISLAND:String = "scene_island";
      
      public static const SCENE_ENDING:String = "scene_ending";
      
      public static const SCENE_WORLD_CAMPAIGN:String = "scene_world_campaign";
      
      public static const SCENE_HOME_CAMPAIGN:String = "scene_home_campaign";
      
      public static const SCENE_HOME_DEFAULT:String = "scene_home_default";
      
      public static const TUTORIAL_START:uint = 0;
      
      public static const TUTORIAL_HOME_TOP:uint = 1;
      
      public static const TUTORIAL_HOME_BIRDVIEW:uint = 2;
      
      public static const TUTORIAL_HOME_INDOOR:uint = 3;
      
      public static const TUTORIAL_HOME_SHARE:uint = 4;
      
      public static const TUTORIAL_HOME_SHARE_ANOTHER:uint = 5;
      
      public static const TUTORIAL_ISLAND:uint = 6;
      
      public static const TUTORIAL_ISLAND_TREE:uint = 7;
      
      public static const TUTORIAL_ISLAND_SIGN:uint = 8;
      
      public static const TUTORIAL_ISLAND_NO_CANDIDATE:uint = 9;
      
      public static const TUTORIAL_HOME_ORCHARD:uint = 10;
      
      public static const TUTORIAL_HOME_ARC:uint = 11;
      
      public static const HELP_HOME_TOP:uint = 0;
      
      public static const HELP_HOME_BIRDVIEW:uint = 1;
      
      public static const HELP_HOME_INDOOR:uint = 2;
      
      public static const HELP_HOME_CATALOGUE:uint = 3;
      
      public static const HELP_HOME_CHEST:uint = 4;
      
      public static const HELP_HOME_BOARD:uint = 5;
      
      public static const HELP_HOME_SHARE:uint = 6;
      
      public static const HELP_HOME_SHARE_ANOTHER:uint = 7;
      
      public static const HELP_HOME_ORCHARD:uint = 8;
      
      public static const HELP_HOME_ARC:uint = 9;
      
      public static const HELP_ISLAND_TOP:uint = 10;
      
      public static const HELP_ISLAND_TREE:uint = 11;
      
      private static var _currentHelp:int = 0;
      
      public static const HELP:String = "help";
      
      public static const DIALOG_TYPE_ERROR:String = "dialog_error";
      
      public static const DIALOG_TYPE_RETRY:String = "dialog_retry";
      
      public static const DIALOG_TYPE_CLOSE:String = "dialog_close";
      
      public static const DIALOG_TYPE_WAKEUP:String = "dialog_wakeup";
      
      public static const DIALOG_TYPE_WAKEUP_TRIAL:String = "dialog_wakeupTrial";
      
      public static const DIALOG_TYPE_GOTOPGL:String = "dialog_gotopgl";
      
      public static const DIALOG_TYPE_GOTOGBU:String = "dialog_gotogbu";
      
      public static const DIALOG_TYPE_GOTOGTS:String = "dialog_gotogts";
      
      public static const DIALOG_TYPE_BECOME_FRIEND:String = "dialog_becomeFriend";
      
      public static const DIALOG_TYPE_BECAME_FRIEND:String = "dialog_becameFriend";
      
      public static const DIALOG_TYPE_INVITE_FRIEND:String = "dialog_inviteFriend";
      
      public static const DIALOG_TYPE_INVITED_FRIEND:String = "dialog_invitedFriend";
      
      public static const DIALOG_TYPE_BLOCK_CONFIRM:String = "dialog_blockConfirm";
      
      public static const DIALOG_TYPE_BLOCKED:String = "dialog_blocked";
      
      public static const DIALOG_TYPE_FOOTPRINT:String = "dialog_footprint";
      
      public static const DIALOG_TYPE_FOOTPRINT_INVITATION:String = "dialog_footprintInvitation";
      
      public static const DIALOG_TYPE_FOOTPRINT_STRANGER:String = "dialog_footprintStranger";
      
      public static const DIALOG_TYPE_FULL_OF_BOARD:String = "dialog_fullOfBoard";
      
      public static const DIALOG_TYPE_ARC_LIMIT24:String = "dialog_arcLimit24";
      
      public static const DIALOG_TYPE_ARC_FULLDS:String = "dialog_arcFullDS";
      
      public static const DIALOG_TYPE_GO_DREAM_ISLAND:String = "dialog_goDreamIsland";
      
      public static const DIALOG_TYPE_GO_BACK_HOME:String = "dialog_goBackHome";
      
      public static const DIALOG_TYPE_GO_USERS_HOME:String = "dialog_goUsersHome";
      
      public static const DIALOG_TYPE_GO_PROFILE:String = "dialog_goProfile";
      
      public static const DIALOG_TYPE_POKEMON_LIST:String = "dialog_pokemonList";
      
      public static const DIALOG_TYPE_ITEM_LIST:String = "dialog_itemList";
      
      public static const DIALOG_TYPE_TUTORIAL_GAMESYNCID:String = "dialog_gamesyncid";
      
      public static var loadingPercentage:int = 0;
      
      public static var isExitAPI:Boolean = false;
      
      public static var mistBitmapData:BitmapData = new BitmapData(1,1);
      
      public static var isFinal:Boolean = false;
      
      public static var focusClose:Boolean = false;
      
      public static var isTempClose:Boolean = false;
      
      public static const ROLLOVER_R:uint = 227;
      
      public static const ROLLOVER_G:uint = 131;
      
      public static const ROLLOVER_B:uint = 43;
      
      public static const ROLLOVER_COLOR:uint = 14910251;
      
      public function PDWBridge()
      {
         super();
      }
      
      public static function sfx(soundId:int) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":soundId}));
      }
      
      public static function sfxMouseOver() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":SFX_ID_MOUSE_OVER}));
      }
      
      public static function sfxClick() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":SFX_ID_CLICK}));
      }
      
      public static function anchor(href:String, target:String = "_blank", isClickToBack:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.ANCHOR,{
            "href":href,
            "target":target,
            "isClickToBack":isClickToBack
         }));
      }
      
      public static function exit() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.EXIT,{}));
      }
      
      public static function tag(id:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TAG,{"id":id}));
      }
      
      public static function changeBGMSet(id:int, fadeInTime:Number = 2, fadeOutTime:Number = 3, delayTime:Number = 0, isCutInStart:Boolean = false) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.BGM_CHANGE_SET,{
            "id":id,
            "fadeInTime":fadeInTime,
            "fadeOutTime":fadeOutTime,
            "delayTime":delayTime,
            "isCutInStart":isCutInStart
         }));
      }
      
      public static function changeBGMVolume(value:Number, time:Number = 1) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.BGM_CHANGE_VOLUME,{
            "value":value,
            "time":time
         }));
      }
      
      public static function restartBGM() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.RESTART_BGM,{}));
      }
      
      public static function closePDW(pageName:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.CLOSE_PDW,{"pageName":pageName}));
      }
      
      public static function awayPDW() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.AWAY_PDW,{}));
      }
      
      public static function dialogError(text:String = "", afterClose:int = 0, helpButtonMode:Boolean = false, tag:String = "") : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.ERROR,{
            "text":text,
            "afterClose":afterClose,
            "helpButtonMode":helpButtonMode,
            "tag":tag
         }));
      }
      
      public static function dialogErrorSpecial(type:int = 0) : void
      {
      }
      
      public static function startPDW() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.START_PDW,{}));
      }
      
      public static function changeScene(scene:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.CHANGE_SCENE,{"scene":scene}));
      }
      
      public static function backToHome() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.BACK_TO_HOME,{}));
      }
      
      public static function showMoveArrows() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_MOVE_ARROWS,{}));
      }
      
      public static function hideMoveArrows() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.HIDE_MOVE_ARROWS,{}));
      }
      
      public static function showMessageWindow(message:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_MESSAGE_WINDOW,{"message":message}));
      }
      
      public static function hideMessageWindow() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.HIDE_MESSAGE_WINDOW,{}));
      }
      
      public static function minigameHeader(bool:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.MINIGAME_HEADER,{"bool":bool}));
      }
      
      public static function showNews(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_NEWS,{"isShow":isShow}));
      }
      
      public static function showInfo(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_INFO,{"isShow":isShow}));
      }
      
      public static function checkAndShowInfo(isShow:Boolean = true, delayTime:Number = 0) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.CHECK_AND_SHOW_INFO,{
            "isShow":isShow,
            "delaytime":delayTime
         }));
      }
      
      public static function showInfoButton(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_INFO_BUTTON,{"isShow":isShow}));
      }
      
      public static function showHeader(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_HEADER,{"isShow":isShow}));
      }
      
      public static function tutorial(type:uint) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TUTORIAL_START,{"type":type}));
      }
      
      public static function get currentHelp() : uint
      {
         return _currentHelp;
      }
      
      public static function set currentHelp(value:uint) : void
      {
         HelpBridge.helpPDW = value;
         _currentHelp = value;
      }
      
      public static function showHelp(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_HELP,{
            "isShow":isShow,
            "type":PDWBridge.HELP
         }));
      }
      
      public static function dialog(type:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG,{"type":type}));
      }
      
      public static function showConnecting(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_CONNECTING,{"isShow":isShow}));
      }
      
      public static function showLoading(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_LOADING,{"isShow":isShow}));
      }
      
      public static function removeNotificationListeners() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.REMOVE_NOTIFICATION_LISTENERS,{}));
      }
      
      public static function dispose() : void
      {
         if(mistBitmapData)
         {
            mistBitmapData.dispose();
            mistBitmapData = null;
         }
      }
      
      public static function intoRoom() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.INTO_ROOM,{}));
      }
      
      public static function startMoviePanel() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.START_MOVIE_PANEL,{}));
      }
      
      public static function showFootprint(isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_FOOTPRINT,{"isShow":isShow}));
      }
      
      public static function moveIsland(uid:String = "") : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.MOVE_ISLAND,{"uid":uid}));
      }
      
      public static function get statusWindow() : IPDWPokemonStatus
      {
         return _statusWindow;
      }
      
      public static function set statusWindow(value:IPDWPokemonStatus) : void
      {
         _statusWindow = value;
      }
      
      public static function getStatusWindow(nickname:String, pglNickname:String, pokemonName:String, parentName:String, level:int, type:String, gender:int, personality:String, monsterball:String) : IPDWPokemonStatus
      {
         if(statusWindow)
         {
            statusWindow.nickname = nickname;
            statusWindow.pglNickname = pglNickname;
            statusWindow.pokemonName = pokemonName;
            statusWindow.parentName = parentName;
            statusWindow.level = level;
            statusWindow.type = type;
            statusWindow.gender = gender;
            statusWindow.personality = personality;
            statusWindow.monsterball = monsterball;
            return statusWindow;
         }
         return new PDWPokemonStatusDisplayObject();
      }
      
      public static function get newsdata() : Array
      {
         return _newsdata;
      }
      
      public static function set newsdata(value:Array) : void
      {
         _newsdata = value;
      }
      
      public static function get newsBitmapData() : Array
      {
         return _newsBitmapData;
      }
      
      public static function set newsBitmapData(value:Array) : void
      {
         _newsBitmapData = value;
      }
      
      public static function get world0bmd() : BitmapData
      {
         return _world0bmd;
      }
      
      public static function set world0bmd(value:BitmapData) : void
      {
         _world0bmd = value;
      }
      
      public static function get campaignIslandList() : Object
      {
         return _campaignIslandList;
      }
      
      public static function set campaignIslandList(value:Object) : void
      {
         _campaignIslandList = value;
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function dispatchEvent(event:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(event);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
   }
}


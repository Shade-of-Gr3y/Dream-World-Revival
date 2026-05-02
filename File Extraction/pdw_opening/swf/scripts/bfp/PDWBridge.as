package bfp
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PDWBridge
   {
      
      public static var currentScene:String;
      
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
      
      public static const SCENE_WORLD:String = "scene_world";
      
      public static const SCENE_MOVE:String = "scene_move";
      
      public static const SCENE_HOME:String = "scene_home";
      
      public static const SCENE_START:String = "scene_start";
      
      public static const SCENE_OPENING:String = "scene_opening";
      
      public static const SCENE_ISLAND:String = "scene_island";
      
      public static const SCENE_ENDING:String = "scene_ending";
      
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
      
      public static const DIALOG_TYPE_LOGOUT:String = "dialog_logout";
      
      public static const DIALOG_TYPE_CLOSE:String = "dialog_close";
      
      public static const DIALOG_TYPE_WAKEUP:String = "dialog_wakeup";
      
      public static const DIALOG_TYPE_WAKEUP_TRIAL:String = "dialog_wakeupTrial";
      
      public static const DIALOG_TYPE_WOKEUP:String = "dialog_wokeup";
      
      public static const DIALOG_TYPE_WOKEUP_ALREADY:String = "dialog_wokeupAlready";
      
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
      
      public static const DIALOG_TYPE_TUTORIAL_GAMESYNCID:String = "dialog_gamesyncid";
      
      public static var loadingPercentage:int = 0;
      
      public static var isExitAPI:Boolean = false;
      
      public static var mistBitmapData:BitmapData = new BitmapData(1,1);
      
      public static var focusClose:Boolean = false;
      
      public static const ROLLOVER_R:uint = 227;
      
      public static const ROLLOVER_G:uint = 131;
      
      public static const ROLLOVER_B:uint = 43;
      
      public static const ROLLOVER_COLOR:uint = 14910251;
      
      public function PDWBridge()
      {
         super();
      }
      
      public static function sfx(param1:int) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":param1}));
      }
      
      public static function sfxMouseOver() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":SFX_ID_MOUSE_OVER}));
      }
      
      public static function sfxClick() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SFX,{"id":SFX_ID_CLICK}));
      }
      
      public static function anchor(param1:String, param2:String = "_blank", param3:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.ANCHOR,{
            "href":param1,
            "target":param2,
            "isClickToBack":param3
         }));
      }
      
      public static function exit() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.EXIT,{}));
      }
      
      public static function tag(param1:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TAG,{"id":param1}));
      }
      
      public static function changeBGMSet(param1:int, param2:Number = 2, param3:Number = 3, param4:Number = 0, param5:Boolean = false) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.BGM_CHANGE_SET,{
            "id":param1,
            "fadeInTime":param2,
            "fadeOutTime":param3,
            "delayTime":param4,
            "isCutInStart":param5
         }));
      }
      
      public static function changeBGMVolume(param1:Number, param2:Number = 1) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.BGM_CHANGE_VOLUME,{
            "value":param1,
            "time":param2
         }));
      }
      
      public static function restartBGM() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.RESTART_BGM,{}));
      }
      
      public static function closePDW(param1:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.CLOSE_PDW,{"pageName":param1}));
      }
      
      public static function awayPDW() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.AWAY_PDW,{}));
      }
      
      public static function dialogError(param1:String = "", param2:int = 0, param3:Boolean = false, param4:String = "") : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.ERROR,{
            "text":param1,
            "afterClose":param2,
            "helpButtonMode":param3,
            "tag":param4
         }));
      }
      
      public static function startPDW() : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.START_PDW,{}));
      }
      
      public static function changeScene(param1:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.CHANGE_SCENE,{"scene":param1}));
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
      
      public static function minigameHeader(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.MINIGAME_HEADER,{"bool":param1}));
      }
      
      public static function showNews(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_NEWS,{"isShow":param1}));
      }
      
      public static function showHeader(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_HEADER,{"isShow":param1}));
      }
      
      public static function tutorial(param1:uint) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TUTORIAL_START,{"type":param1}));
      }
      
      public static function get currentHelp() : uint
      {
         return _currentHelp;
      }
      
      public static function set currentHelp(param1:uint) : void
      {
         HelpBridge.helpPDW = param1;
         _currentHelp = param1;
      }
      
      public static function showHelp(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_HELP,{
            "isShow":param1,
            "type":PDWBridge.HELP
         }));
      }
      
      public static function dialog(param1:String) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG,{"type":param1}));
      }
      
      public static function showConnecting(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_CONNECTING,{"isShow":param1}));
      }
      
      public static function showLoading(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_LOADING,{"isShow":param1}));
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
      
      public static function showFootprint(param1:Boolean = true) : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.SHOW_FOOTPRINT,{"isShow":param1}));
      }
      
      public static function moveIsland(param1:String = "") : void
      {
         dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.MOVE_ISLAND,{"uid":param1}));
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
   }
}


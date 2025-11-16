package bfp
{
   import flash.events.Event;
   
   public class PDWBridgeEvent extends Event
   {
      
      public static const SFX:String = "pdwBridgeSfx";
      
      public static const BGM_CHANGE_SET:String = "pdwBridgeBGMChangeSet";
      
      public static const BGM_CHANGE_VOLUME:String = "pdwBridgeBGMChangeVolume";
      
      public static const ANCHOR:String = "pdwBridgeAnchor";
      
      public static const EXIT:String = "pdwBridgeExit";
      
      public static const TAG:String = "pdwBridgeTag";
      
      public static const CHANGE_SCENE:String = "pdwBridgeChangeScene";
      
      public static const DEEP_LINK:String = "pdwBridgeDeepLink";
      
      public static const RESTART_BGM:String = "pdwBridgeRestartBGM";
      
      public static const ERROR:String = "pdwBridgeError";
      
      public static const DIALOG:String = "pdwBridgeDialog";
      
      public static const DIALOG_OK:String = "pdwBridgeDialog_ok";
      
      public static const DIALOG_CANCEL:String = "pdwBridgeDialog_cancel";
      
      public static const DIALOG_CLOSE:String = "pdwBridgeDialog_close";
      
      public static const START_PDW:String = "pdwBridgeStartPDW";
      
      public static const SHOW_LOADING:String = "pdwBridgeShowLoading";
      
      public static const SHOW_CONNECTING:String = "pdwBridgeShowConnecting";
      
      public static const SHOW_FOOTPRINT:String = "pdwBridgeShowFootprint";
      
      public static const SHOW_HEADER:String = "pdwBridgeShowHeader";
      
      public static const SHOW_NEWS:String = "pdwBridgeShowNews";
      
      public static const SHOW_INFO:String = "pdwBridgeShowInfo";
      
      public static const SHOW_HELP:String = "pdwBridgeShowHelp";
      
      public static const SHOW_INFO_BUTTON:String = "pdwBridgeShowInfoButton";
      
      public static const CHECK_AND_SHOW_INFO:String = " pdwBridgeCheckAndShowInfo";
      
      public static const MOVE_ISLAND:String = "pdwBridgeMoveIsland";
      
      public static const INTO_ROOM:String = "pdwBridgeIntoRoom";
      
      public static const START_MOVIE_PANEL:String = "pdwBridgeStartMoviePanel";
      
      public static const CLOSE_PDW:String = "pdwBridgeClosePDW";
      
      public static const AWAY_PDW:String = "pdwBridgeAwayPDW";
      
      public static const BACK_TO_HOME:String = "pdwBridgeBackToHome";
      
      public static const TUTORIAL_START:String = "pdwBridgeTutorialStart";
      
      public static const TUTORIAL_COMPLETE:String = "pdwBridgeTutorialComplete";
      
      public static const SHOW_MOVE_ARROWS:String = "pdwBridgeShowMoveArrows";
      
      public static const HIDE_MOVE_ARROWS:String = "pdwBridgeHideMoveArrows";
      
      public static const SHOW_MESSAGE_WINDOW:String = "pdwBridgeShowMessageWindow";
      
      public static const HIDE_MESSAGE_WINDOW:String = "pdwBridgeHideMessageWindow";
      
      public static const MINIGAME_HEADER:String = "pdwBridgeMinigameHeader";
      
      public static const HOME_MOVE_START:String = "pdwBridgeHomeMoveStart";
      
      public static const REMOVE_NOTIFICATION_LISTENERS:String = "pdwBridgeRemoveNotificationListeners";
      
      public static const NOTIFICATION_CLOSE:String = "pdwBridgeNotificationClose";
      
      public static const ERROR_SPECIAL:String = "pdwBridgeErrorSpecial";
       
      
      private var _data:Object;
      
      public function PDWBridgeEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new PDWBridgeEvent(type,this.data,bubbles,cancelable);
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

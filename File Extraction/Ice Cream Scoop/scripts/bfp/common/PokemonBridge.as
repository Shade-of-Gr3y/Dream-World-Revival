package bfp.common
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class PokemonBridge
   {
      
      public static var PATH:String;
      
      public static var pokerender:Class;
      
      private static var _language:String;
      
      public static var rootMC:Sprite;
      
      public static var version:String = "standalone";
      
      public static const MIN_WIDTH:Number = 1003;
      
      public static const MIN_HEIGHT:Number = 570;
      
      public static const VOLUME_CHANGE:String = "VOLUME_CHANGE";
      
      public static const RETURN_TO_SWF:String = "RETURN_TO_SWF";
      
      public static const JUMP_FROM_SWF:String = "JUMP_FROM_SWF";
      
      public static const NOT_LOGIN:String = "NOT_LOGIN";
      
      public static const USER_LOGIN:String = "USER_LOGIN";
      
      public static const USER_LOGOUT:String = "USER_LOGOUT";
      
      public static const CHANGE_SITE:String = "CHANGE_SITE";
      
      public static const REQUEST_REMOVE:String = "REQUEST_REMOVE";
      
      public static const SITE_CLOSED:String = "SITE_CLOSED";
      
      public static const SELECTED_LANGUAGE:String = "SELECTED_LANGUAGE";
      
      public static const CALL_PRESENT:String = "CALL_PRESENT";
      
      public static const RETURN_PRESENT:String = "RETURN_PRESENT";
      
      public static var PresentFlag:Boolean = false;
      
      public static var CustomizeFlag:Boolean = false;
      
      public static var shortcut_campaign:Number = undefined;
      
      public static var check:Number = undefined;
      
      public static const SITE_PGL:String = "SITE_PGL";
      
      public static const SITE_PDW:String = "SITE_PDW";
      
      public static const SITE_GTS:String = "SITE_GTS";
      
      public static const SITE_GBU:String = "SITE_GBU";
      
      public static var member_id:Number = undefined;
      
      public static var pdc_member_id:Number = undefined;
      
      public static var pgl_name:String = null;
      
      public static var nickname:String = null;
      
      public static var country_id:Number = undefined;
      
      public static var country_name:String = null;
      
      public static var location_id:Number = undefined;
      
      public static var sex_id:Number = undefined;
      
      public static var sex_name:String = null;
      
      public static var birthday:String = null;
      
      public static var disclosure_flag:Number = undefined;
      
      public static var list_disclosure_flag:Number = undefined;
      
      public static var member_savedata_id:Number = 0;
      
      public static var special_flag:Number = undefined;
      
      public static var player_badge_num:Number = undefined;
      
      public static var shelf_id:Number = undefined;
      
      public static var member_created_at:String = null;
      
      public static var bridge_flag:Number = undefined;
      
      public static var rom_id:Number = undefined;
      
      public static var rom_name:String = null;
      
      public static var alter_rom_name:String = null;
      
      public static var pokemon_no:Number = undefined;
      
      public static var pokemon_name:String = null;
      
      public static var form_no:String = null;
      
      public static var type1:String = null;
      
      public static var type2:String = null;
      
      public static var point:Number = undefined;
      
      public static var experiment_point:Number = undefined;
      
      public static var sleep_time:String = null;
      
      public static var sleep_pokemon_count:Number = undefined;
      
      public static var send_pokemon_count:Number = undefined;
      
      public static var island_id:Number = undefined;
      
      public static var disable_flag:Number = undefined;
      
      public static var wateringpot_id:Number = undefined;
      
      public static var avator_id:Number = undefined;
      
      public static var avator_name:String = null;
      
      public static var first_flag:Number = undefined;
      
      public static var trial_flag:Number = undefined;
      
      public static var sleeping_flag:Number = undefined;
      
      public static var token:String = null;
      
      public static var last_started_at:Number = undefined;
      
      public static var nextstart_remaintime:Number = undefined;
      
      public static var gsid:String = null;
      
      public static var session_id:String = null;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var DEBUG:Boolean = false;
      
      public static var INIT_FLAG:Boolean = true;
      
      public static var lang:String = "ja";
      
      public static var API:String = "http://pokemon-www.basementfactorysystems.com/api/";
      
      public static var API_SSL:String = "https://pokemon-www.basementfactorysystems.com/api/";
      
      public static const RENDER_LOADED:String = "RENDER_LOADED";
      
      public static var POKEMONPATH:String = "";
      
      private static var _site:String = PokemonBridge.SITE_PGL;
      
      private static var _now:String = PokemonBridge.SITE_PGL;
      
      public static var alertFlag:Boolean = false;
      
      public static const ERROR_WINDOW:String = "ERROR_WINDOW";
      
      public static const WITH_SYNCID:Number = 3;
      
      public static const WITH_LOGOUT:Number = 2;
      
      public static const WITH_RELOAD:Number = 1;
      
      public static const WITH_FADEOUT:Number = 0;
      
      public static const ALERT_CLOSE:String = "ALERT_CLOSE";
      
      public static var requestBattleHistory:String = null;
      
      public static const GBU_REQUEST:String = "GBU_REQUEST";
      
      public static var welcomAlert:Boolean = false;
      
      public static var pdwAlertFlag:Boolean = false;
      
      public static const FOOTER_ON:String = "FOOTER_ON";
      
      public static const FOOTER_OFF:String = "FOOTER_OFF";
      
      public static const CALL_HELP:String = "CALL_HELP";
      
      public static const RETURN_HELP:String = "RETURN_HELP";
      
      public static const CLEARD_HELP:String = "CLEAR_HELP";
      
      public static const REMOVE_HELP:String = "REMOVE_HELP";
      
      public static const CALL_MYPAGE:String = "CALL_MYPAGE";
      
      public static const RETURN_MYPAGE:String = "RETURN_MYPAGE";
      
      public static var MypageRequest:* = null;
      
      public static var MypageFlag:Boolean = false;
      
      public static const CALL_MAILER:String = "CALL_MAILER";
      
      public static const RETURN_MAILER:String = "RETURN_MAILER";
      
      public static const MAILER_CLEARD:String = "MAILER_CLEARD";
      
      public static var MailerRequest:* = null;
      
      public static var MailerFlag:Boolean = false;
      
      public static const MINI_GAME_PAUSE:String = "MINI_GAME_PAUSE";
      
      public static const MINI_GAME_PLAY:String = "MINI_GAME_PLAY";
      
      public static const PDW_ONE_HOUR_ALERT:String = "PDW_ONE_HOUR_ALERT";
      
      public static const PDW_ONE_HOUR_ALERT_SLEEP:String = "PDW_ONE_HOUR_ALERT_SLEEP";
      
      public static const PDW_PRESSURE_ALERT:String = "PDW_PRESSURE_ALERT";
      
      public static const PDW_PRESSURE_ALERT_SLEEP:String = "PDW_PRESSURE_ALERT_SLEEP";
      
      public static const PDW_EXIT_ALERT:String = "PDW_EXIT_ALERT";
      
      public static const PDW_EXIT_ALERT_SLEEP:String = "PDW_EXIT_ALERT_SLEEP";
      
      public static const PDW_FINISH:String = "PDW_FINISH";
      
      public static const PDW_ENTER_DREAMLAND:String = "PDW_ENTER_DREAMLAND";
      
      public static const PDW_EXIT_DREAMLAND:String = "PDW_EXIT_DREAMLAND";
      
      public static const HOUR_24_TIMER_ALERT:String = "HOUR_24_TIMER_ALERT";
      
      public static const HOUR_24_TIMER_ALERT_SLEEP:String = "HOUR_24_TIMER_ALERT_SLEEP";
      
      public static const BUSY_PDW_ALERT:String = "BUSY_PDW_ALERT";
      
      public static const BUSY_PDW_ALERT_SLEEP:String = "BUSY_PDW_ALERT_SLEEP";
      
      public static const FLOATING_NO_SYNCID:String = "FLOATING_NO_SYNCID";
      
      public static const FLOATING_NOT_SYNC:String = "FLOATING_NOT_SYNC";
      
      public static const FLOATING_SET_ID:String = "FLOATING_SET_ID";
      
      public static const ENABLE_ACCESS_TO_PDW:String = "ENABLE_ACCESS_TO_PDW";
      
      public static const FINISH_ACCESS_TO_PDW:String = "FINISH_ACCESS_TO_PDW";
      
      public static const ENTER_ALERT_CLOSE:String = "ENTER_ALERT_CLOSE";
      
      public static const ENTER_ALERT:String = "ENTER_ALERT";
      
      private static var _enterPage:String = "";
      
      public static const ALERT_DIALOG:String = "DIALOG";
      
      public static const ALERT_LOADING:String = "ALERT_LOADING";
      
      public static const ALERT_CONNECTING:String = "ALERT_CONNECTING";
      
      public static const ALERT_CLEAR:String = "ALERT_CLEAR";
      
      private static var _alert:String = "";
      
      private static var _loadpercent:Number = 0;
      
      public static const RETURN_TO_PGL:String = "RETURN_TO_PGL";
      
      public static const GET_TIME_STAMP:String = "GET_TIME_STAMP";
      
      public static const CAMPAIGN_FLAG:String = "CAMPAIGN_FLAG";
      
      private static var campaignFlag:Boolean = true;
      
      public static const BUTTON_MODE:String = "BUTTON_MODE";
      
      private static var _buttonMode:Boolean = true;
      
      private static var _mailerButton:Boolean = true;
      
      public static const TAG:String = "TAG";
      
      public static const MOUSE_OVER_SOUND:String = "MOUSE_OVER_SOUND";
      
      public static const MOUSE_CLICK_SOUND:String = "MOUSE_CLICK_SOUND";
      
      public static const MOUSE_DRAG_SOUND:String = "MOUSE_DRAG_SOUND";
      
      public static const MOUSE_DROP_SOUND:String = "MOUSE_DROP_SOUND";
      
      public static const SE_ALERT_SOUND:String = "SE_ALERT_SOUND";
      
      public function PokemonBridge()
      {
         super();
      }
      
      public static function set buttonMode(param1:Boolean) : void
      {
         _buttonMode = param1;
         dispatchEvent(new Event(BUTTON_MODE));
      }
      
      public static function Error500() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "error.php?code=500";
         PokemonBridge.href(_loc1_);
      }
      
      public static function Error502() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "error.php?code=502";
         PokemonBridge.href(_loc1_);
      }
      
      public static function Error503() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "error.php?code=503";
         PokemonBridge.href(_loc1_);
      }
      
      public static function callMypage(param1:* = null) : void
      {
         dispatchEvent(new CustomEvent(CALL_MYPAGE,param1));
      }
      
      public static function gbuRequest() : void
      {
         dispatchEvent(new Event(GBU_REQUEST));
      }
      
      public static function loginError() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:String = "pokemon-login";
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.clear();
         var _loc3_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "html/ja/logout.html";
         PokemonBridge.href(_loc3_);
      }
      
      public static function mouseDropSound() : void
      {
         dispatchEvent(new Event(MOUSE_DROP_SOUND));
      }
      
      public static function closeAlert() : void
      {
         dispatchEvent(new Event(ALERT_CLOSE));
      }
      
      public static function standalone(param1:String) : void
      {
         if(PokemonBridge.version != "standalone")
         {
            param1 += "?appver=" + PokemonBridge.version;
         }
         var _loc2_:Loader = new Loader();
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext();
         _loc4_.applicationDomain = new ApplicationDomain();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,loadedHandler);
         _loc2_.load(_loc3_,_loc4_);
      }
      
      public static function Error403() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:String = "pokemon-login";
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.clear();
         var _loc3_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "error.php?code=403";
         PokemonBridge.href(_loc3_);
      }
      
      public static function Error404() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:String = "pokemon-login";
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.clear();
         var _loc3_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "error.php?code=404";
         PokemonBridge.href(_loc3_);
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function setAPI(param1:Sprite) : void
      {
      }
      
      public static function alertWindow(param1:String = "", param2:Number = 0) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.message = param1;
         _loc3_.id = param2;
         dispatchEvent(new Event(SE_ALERT_SOUND));
         dispatchEvent(new CustomEvent(ERROR_WINDOW,_loc3_));
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function PDWStartTimeStamp(param1:Number) : void
      {
         PokemonBridge.last_started_at = param1;
         dispatchEvent(new Event(GET_TIME_STAMP));
      }
      
      public static function set site(param1:String) : void
      {
         _site = param1;
      }
      
      public static function set percent(param1:Number) : void
      {
         LoadingBridge.percent = param1 * 0.5 + 0.5;
         if(param1 == 1)
         {
            if(PokemonBridge.INIT_FLAG)
            {
               LoadingBridge.finishFirstLoading();
            }
            else
            {
               LoadingBridge.hideLoading();
            }
         }
      }
      
      public static function callMailer(param1:* = null) : void
      {
         dispatchEvent(new CustomEvent(CALL_MAILER,param1));
      }
      
      public static function setAPIfromHTML(param1:String) : void
      {
         API = "http://" + param1 + "/api/";
      }
      
      public static function set alert(param1:String) : void
      {
         _alert = param1;
      }
      
      public static function callHelp() : void
      {
         dispatchEvent(new CustomEvent(CALL_HELP));
      }
      
      public static function set language(param1:String) : void
      {
         _language = param1;
      }
      
      public static function campaignMode(param1:Boolean) : void
      {
         campaignFlag = param1;
         dispatchEvent(new Event(CAMPAIGN_FLAG));
      }
      
      public static function get now() : String
      {
         return _now;
      }
      
      public static function PDWDreamLand(param1:Boolean) : void
      {
         if(param1)
         {
            dispatchEvent(new Event(PDW_ENTER_DREAMLAND));
         }
         else
         {
            dispatchEvent(new Event(PDW_EXIT_DREAMLAND));
         }
      }
      
      public static function mouseClickSound() : void
      {
         dispatchEvent(new Event(MOUSE_CLICK_SOUND));
      }
      
      public static function get mailerButton() : Boolean
      {
         return _mailerButton;
      }
      
      public static function get campaign() : Boolean
      {
         return campaignFlag;
      }
      
      public static function alertSound() : void
      {
         dispatchEvent(new Event(SE_ALERT_SOUND));
      }
      
      public static function mouseDragSound() : void
      {
         dispatchEvent(new Event(MOUSE_DRAG_SOUND));
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function PDWfinish() : void
      {
         dispatchEvent(new Event(PDW_FINISH));
      }
      
      public static function get site() : String
      {
         return _site;
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function get language() : String
      {
         return _language;
      }
      
      public static function get alert() : String
      {
         return _alert;
      }
      
      public static function href(param1:String, param2:String = "_self") : void
      {
         navigateToURL(new URLRequest(param1),param2);
         dispatchEvent(new Event(JUMP_FROM_SWF));
      }
      
      public static function mouseOverSound() : void
      {
         dispatchEvent(new Event(MOUSE_OVER_SOUND));
      }
      
      public static function enterAlert(param1:String) : void
      {
         _enterPage = param1;
         dispatchEvent(new Event(ENTER_ALERT));
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
      
      public static function logout() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:String = "pokemon-login";
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.clear();
         var _loc3_:String = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "?p=" + ConnectorPATH.DB_LOGOUT;
         PokemonBridge.href(_loc3_);
      }
      
      private static function loadedHandler(param1:Event) : void
      {
         var _loc2_:Loader = Loader(param1.currentTarget.loader);
         _loc2_.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadedHandler);
         pokerender = Class(_loc2_.contentLoaderInfo.applicationDomain.getDefinition("com.pokemon_gl.pdw.display.PokemonRenderer"));
         pokerender.imageDirectory = POKEMONPATH;
         dispatchEvent(new Event(RENDER_LOADED));
      }
      
      public static function returnHalp() : void
      {
         dispatchEvent(new CustomEvent(RETURN_HELP));
      }
      
      public static function cleardHelp() : void
      {
         dispatchEvent(new CustomEvent(CLEARD_HELP));
      }
      
      public static function reload() : void
      {
         Logger.log("////////////////// REFRESH - BROWSER");
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("reload");
      }
      
      public static function get enterPage() : String
      {
         return _enterPage;
      }
      
      public static function hideLoading() : void
      {
         if(LoadingBridge.percent != 1)
         {
            LoadingBridge.hideLoading();
         }
      }
      
      public static function acceseeError() : void
      {
         ExternalInterface.call("setpdw",false);
         var _loc1_:String = "pokemon-login";
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.clear();
         var _loc3_:* = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "html/ja/logout.html";
         PokemonBridge.href(_loc3_);
      }
      
      public static function tag(param1:String) : void
      {
         dispatchEvent(new CustomEvent(TAG,{"tag":param1}));
      }
      
      public static function set now(param1:String) : void
      {
         _now = param1;
      }
      
      public static function alertCloseClear() : void
      {
         if(alertFlag)
         {
            Logger.log("ALERT CLOSE");
            site = SITE_PDW;
            requestBattleHistory = null;
            alertFlag = false;
         }
      }
      
      public static function returntoPGL() : void
      {
         Logger.log(RETURN_TO_PGL);
         dispatchEvent(new Event(RETURN_TO_PGL));
      }
      
      public static function alertDialog(param1:String, param2:Object = null) : void
      {
         _alert = param1;
         dispatchEvent(new Event(ALERT_DIALOG));
      }
      
      public static function siteChange(param1:String) : void
      {
         _site = param1;
         dispatchEvent(new Event(CHANGE_SITE));
      }
      
      public static function createRenderer() : *
      {
         var _loc1_:* = undefined;
         if(pokerender)
         {
            _loc1_ = new pokerender();
         }
         return _loc1_;
      }
      
      public static function set mailerButton(param1:Boolean) : void
      {
         _mailerButton = param1;
      }
      
      public static function get buttonMode() : Boolean
      {
         return _buttonMode;
      }
   }
}


package bfp.common
{
   import bfp.main.alert.PDWEnterBridge;
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
      
      public static var lang:String = "ja";
      
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
      
      public static var requestBattleHistory:* = null;
      
      public static var infoRequest:* = null;
      
      public static var MailerRequest:* = null;
      
      public static var check:Number = undefined;
      
      public static const SITE_PGL:String = "SITE_PGL";
      
      public static const SITE_PDW:String = "SITE_PDW";
      
      public static const SITE_GTS:String = "SITE_GTS";
      
      public static const SITE_GBU:String = "SITE_GBU";
      
      public static const PAGE_INFORMATION:String = "PAGE_INFORMATION";
      
      public static const PAGE_CAMPAIGN:String = "PAGE_CAMPAIGN";
      
      public static const PAGE_CUSTOMIZE:String = "PAGE_CUSTOMIZE";
      
      public static const PAGE_MAIL:String = "PAGE_MAIL";
      
      public static const PAGE_HELP:String = "PAGE_HELP";
      
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
      
      public static var is_initializing:Number = undefined;
      
      public static var last_up_time:Number = undefined;
      
      public static var last_up_time_strict:String = undefined;
      
      public static var play_status:Number = undefined;
      
      public static var player_name:String = null;
      
      public static var langcode:Number = undefined;
      
      public static var deleted_at:Number = undefined;
      
      public static var last_logined_at:Number = undefined;
      
      public static var last_started_at_timezone:Number = undefined;
      
      public static var last_started_at:Number = undefined;
      
      public static var nextstart_remaintime:Number = undefined;
      
      public static var is_downloaded:Number = undefined;
      
      public static var pdw_copied_at:String = null;
      
      public static var gsid:String = null;
      
      public static var gscd:String = null;
      
      public static var session_id:String = null;
      
      public static var world_id:String = null;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var DEBUG:Boolean = false;
      
      public static var INIT_FLAG:Boolean = true;
      
      public static var API:String = "http://pokemon-www.basementfactorysystems.com/api/";
      
      public static var API_SSL:String = "https://pokemon-www.basementfactorysystems.com/api/";
      
      public static var PDW_API:String = "http://pokemon-www.basementfactorysystems.com/api/";
      
      public static var PDW_API_SSL:String = "https://pokemon-www.basementfactorysystems.com/api/";
      
      public static const RENDER_LOADED:String = "RENDER_LOADED";
      
      public static var POKEMONPATH:String = "";
      
      private static var _site:String = PokemonBridge.SITE_PDW;
      
      private static var _now:String = PokemonBridge.SITE_PDW;
      
      public static const ALERT_CLOSE:String = "ALERT_CLOSE";
      
      public static const ERROR_WINDOW:String = "ERROR_WINDOW";
      
      public static const GOTO_PGL:Number = 4;
      
      public static const WITH_SYNCID:Number = 3;
      
      public static const WITH_LOGOUT:Number = 2;
      
      public static const WITH_RELOAD:Number = 1;
      
      public static const WITH_FADEOUT:Number = 0;
      
      public static const ALERT_DIALOG:String = "DIALOG";
      
      public static const ALERT_LOADING:String = "ALERT_LOADING";
      
      public static const ALERT_CONNECTING:String = "ALERT_CONNECTING";
      
      public static const ALERT_CLEAR:String = "ALERT_CLEAR";
      
      private static var _alert:String = "";
      
      private static var _loadpercent:Number = 0;
      
      public static const GBU_REQUEST:String = "GBU_REQUEST";
      
      public static const MINI_GAME_PAUSE:String = "MINI_GAME_PAUSE";
      
      public static const MINI_GAME_PLAY:String = "MINI_GAME_PLAY";
      
      public static const LOADING_API:String = "LOADING_API";
      
      public static const LOADING_DATA:String = "LOADING_DATA";
      
      public static const LOADING_CLEAR:String = "LOADING_CLEAR";
      
      public static const CAMPAIGN_FLAG:String = "CAMPAIGN_FLAG";
      
      private static var campaignFlag:Boolean = true;
      
      public static const FOOTER_ON:String = "FOOTER_ON";
      
      public static const FOOTER_OFF:String = "FOOTER_OFF";
      
      public static const BUTTON_MODE:String = "BUTTON_MODE";
      
      public static var welcomAlert:Boolean = false;
      
      public static var pdwAlertFlag:Boolean = false;
      
      public static var alertFlag:Boolean = true;
      
      private static var _buttonMode:Boolean = true;
      
      private static var _mailerButton:Boolean = true;
      
      public static const MOUSE_OVER_SOUND:String = "MOUSE_OVER_SOUND";
      
      public static const MOUSE_CLICK_SOUND:String = "MOUSE_CLICK_SOUND";
      
      public static const MOUSE_DRAG_SOUND:String = "MOUSE_DRAG_SOUND";
      
      public static const MOUSE_DROP_SOUND:String = "MOUSE_DROP_SOUND";
      
      public static const SOUND_FADEOUT:String = "SOUND_FADEOUT";
      
      public static const SOUND_FADEIN:String = "SOUND_FADEIN";
      
      public static const SE_ALERT_SOUND:String = "SE_ALERT_SOUND";
      
      public static const LOADED_CHILD:String = "LOADED_CHILD";
      
      private static var _percent:Number = 0;
      
      public static const TAG:String = "TAG";
      
      public function PokemonBridge()
      {
         super();
      }
      
      public static function set buttonMode(flag:Boolean) : void
      {
         _buttonMode = flag;
         dispatchEvent(new Event(BUTTON_MODE));
      }
      
      public static function Error500() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var str:String = "/error.php?code=500";
         PokemonBridge.href(str);
      }
      
      public static function Error502() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var str:String = "/error.php?code=502";
         PokemonBridge.href(str);
      }
      
      public static function loginError() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var soName:String = "pokemon-login";
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.clear();
         var str:String = "/error/logout/";
         PokemonBridge.href(str);
      }
      
      public static function Error503() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var str:String = "/error.php?code=503";
         PokemonBridge.href(str);
      }
      
      public static function gbuRequest() : void
      {
         dispatchEvent(new Event(GBU_REQUEST));
      }
      
      public static function mouseDropSound() : void
      {
         dispatchEvent(new Event(MOUSE_DROP_SOUND));
      }
      
      public static function dispatchEvent(e:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(e);
      }
      
      public static function closeAlert() : void
      {
         dispatchEvent(new Event(ALERT_CLOSE));
      }
      
      public static function standalone(path:String) : void
      {
         if(PokemonBridge.version != "standalone")
         {
            path += "?appver=" + PokemonBridge.version;
         }
         var loader:Loader = new Loader();
         var req:URLRequest = new URLRequest(path);
         var context:LoaderContext = new LoaderContext();
         context.applicationDomain = new ApplicationDomain();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadedHandler);
         loader.load(req,context);
      }
      
      public static function Error403() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var soName:String = "pokemon-login";
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.clear();
         var str:String = "/error.php?code=403";
         PokemonBridge.href(str);
      }
      
      public static function Error404() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var soName:String = "pokemon-login";
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.clear();
         var str:String = "/error.php?code=404";
         PokemonBridge.href(str);
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function setAPI(str:String) : void
      {
         PokemonBridge.API = str;
         if(PokemonBridge.PATH.indexOf("basement") != -1)
         {
            PDW_API = "http://pokemon-pdw" + world_id + ".basementfactorysystems.com/api/";
            PDW_API_SSL = "https://pokemon-pdw" + world_id + ".basementfactorysystems.com/api/";
         }
         else
         {
            PDW_API = "http://pdw" + world_id + ".pokemon-gl.com/api/";
            PDW_API_SSL = "https://pdw" + world_id + ".pokemon-gl.com/api/";
         }
         Logger.log("API : " + PDW_API);
      }
      
      public static function get percent() : Number
      {
         return _percent;
      }
      
      public static function alertWindow(str:String = "", id:Number = 0, button:String = null) : void
      {
         var obj:Object = new Object();
         obj.message = str;
         obj.id = id;
         obj.button = button;
         dispatchEvent(new Event(SE_ALERT_SOUND));
         dispatchEvent(new CustomEvent(ERROR_WINDOW,obj));
      }
      
      public static function set percent(num:Number) : void
      {
         _percent = num;
         if(_percent == 1)
         {
            dispatchEvent(new Event(LOADED_CHILD));
         }
      }
      
      public static function set site(str:String) : void
      {
         _site = str;
      }
      
      public static function PDWStartTimeStamp(num:Number) : void
      {
         PDWEnterBridge.PDWStartTimeStamp(num);
      }
      
      public static function set alert(str:String) : void
      {
         _alert = str;
      }
      
      public static function fadeIn() : void
      {
         dispatchEvent(new Event(SOUND_FADEIN));
      }
      
      public static function campaignMode(_flag:Boolean) : void
      {
         campaignFlag = _flag;
         dispatchEvent(new Event(CAMPAIGN_FLAG));
      }
      
      public static function callHelp(id:String = null) : void
      {
         var helpURL:String = "/help/";
         if(id)
         {
            helpURL += id;
         }
         href(helpURL);
      }
      
      public static function get now() : String
      {
         return _now;
      }
      
      public static function mouseClickSound() : void
      {
         dispatchEvent(new Event(MOUSE_CLICK_SOUND));
      }
      
      public static function get mailerButton() : Boolean
      {
         return _mailerButton;
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
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
      
      public static function href(path:String, target:String = "_self") : void
      {
         navigateToURL(new URLRequest(path),target);
         dispatchEvent(new Event(JUMP_FROM_SWF));
      }
      
      public static function get site() : String
      {
         return _site;
      }
      
      public static function fadeOut() : void
      {
         dispatchEvent(new Event(SOUND_FADEOUT));
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function mouseOverSound() : void
      {
         dispatchEvent(new Event(MOUSE_OVER_SOUND));
      }
      
      public static function get alert() : String
      {
         return _alert;
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
      
      public static function logout() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var soName:String = "pokemon-login";
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.clear();
         var path:String = PokemonBridge.API.slice(0,PokemonBridge.API.length - 4) + "?p=" + ConnectorPATH.DB_LOGOUT;
         PokemonBridge.href(path);
      }
      
      private static function loadedHandler(e:Event) : void
      {
         var loader:Loader = Loader(e.currentTarget.loader);
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadedHandler);
         pokerender = Class(loader.contentLoaderInfo.applicationDomain.getDefinition("com.pokemon_gl.pdw.display.PokemonRenderer"));
         pokerender.imageDirectory = POKEMONPATH;
         dispatchEvent(new Event(RENDER_LOADED));
      }
      
      public static function acceseeError() : void
      {
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         var soName:String = "pokemon-login";
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.clear();
         var str:String = "/error/logout_error/";
         PokemonBridge.href(str);
      }
      
      public static function reload() : void
      {
         Logger.log("////////////////// REFRESH - BROWSER");
         ExternalInterface.call("setpdw",false);
         ExternalInterface.call("setCustomize",false);
         ExternalInterface.call("reload");
      }
      
      public static function ApiConnect() : void
      {
         dispatchEvent(new CustomEvent(LOADING_API));
      }
      
      public static function hideLoading() : void
      {
         if(LoadingBridge.percent != 1)
         {
            LoadingBridge.hideLoading();
         }
      }
      
      public static function tag(tag:String) : void
      {
         dispatchEvent(new CustomEvent(TAG,{"tag":tag}));
      }
      
      public static function set now(str:String) : void
      {
         _now = str;
      }
      
      public static function alertCloseClear() : void
      {
      }
      
      public static function returntoPGL() : void
      {
         PDWEnterBridge.returntoPGL();
      }
      
      public static function returntoPGL2() : void
      {
         PDWEnterBridge.returntoPGL2();
      }
      
      public static function alertDialog(str:String, obj:Object = null) : void
      {
         _alert = str;
         dispatchEvent(new Event(ALERT_DIALOG));
      }
      
      public static function DataConnect() : void
      {
         dispatchEvent(new CustomEvent(LOADING_DATA));
      }
      
      public static function siteChange(str:String) : void
      {
         _site = str;
         dispatchEvent(new Event(CHANGE_SITE));
      }
      
      public static function createRenderer() : *
      {
         var dummy:* = undefined;
         if(pokerender)
         {
            dummy = new pokerender();
         }
         else
         {
            trace("standaloneしてね");
         }
         return dummy;
      }
      
      public static function set mailerButton(flag:Boolean) : void
      {
         _mailerButton = flag;
      }
      
      public static function get buttonMode() : Boolean
      {
         return _buttonMode;
      }
      
      public static function ClearConnect() : void
      {
         dispatchEvent(new CustomEvent(LOADING_CLEAR));
      }
   }
}


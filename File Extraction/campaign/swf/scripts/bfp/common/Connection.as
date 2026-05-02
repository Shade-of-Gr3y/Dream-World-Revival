package bfp.common
{
   import adobe.utils.*;
   import com.adobe.serialization.json.JSON;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   public class Connection extends EventDispatcher
   {
      
      public static const HTTP_API:String = "http://pokemon-ja.basementfactorysystems.com/api/";
      
      public static const HTTPS_API:String = "https://pokemon-ja.basementfactorysystems.com/api/";
      
      public static const HTTP_API_2:String = "http://www.pokemon-gl.com/api/";
      
      public static const HTTPS_API_2:String = "https://www.pokemon-gl.com/api/";
      
      private var _method:String;
      
      private var _downloadcheck:Boolean;
      
      public var dbgmc:*;
      
      private var _data:Object;
      
      private var _roomcheck:Boolean;
      
      private var _statusCode:int;
      
      private var _loader:URLLoader;
      
      private var _errordata:Object;
      
      private var _sleepingcheck:Boolean;
      
      private var _request:Object;
      
      private var _keys:Array;
      
      private var _api:String;
      
      private var _timecheck:Boolean;
      
      private var _sleepingflag:Number;
      
      public function Connection(param1:String = "", param2:String = "GET")
      {
         super();
         this._request = new Object();
         this._data = null;
         this._errordata = null;
         this._api = param1;
         this._method = param2;
      }
      
      public function get request() : Object
      {
         return this._request;
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         var _loc2_:int = 0;
         if(this._statusCode != 0)
         {
            _loc2_ = this._statusCode;
         }
         var _loc3_:String = this.statusMessage(_loc2_);
         var _loc4_:Object = {"error":{
            "code":_loc2_,
            "mess":_loc3_,
            "details":{}
         }};
         this.createErrorMessage(_loc4_);
      }
      
      public function get sleepingflag() : Number
      {
         return this._sleepingflag;
      }
      
      public function get api() : String
      {
         return this._api;
      }
      
      public function get sleepingCheck() : Boolean
      {
         return this._sleepingcheck;
      }
      
      public function set request(param1:Object) : void
      {
         this._request = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set api(param1:String) : void
      {
         this._api = param1;
      }
      
      private function statusMessage(param1:int) : String
      {
         switch(param1)
         {
            case 200:
               return "OK";
            case 304:
               return "Not Modified";
            case 400:
               return "BadRequest";
            case 401:
               return "Not Authorized";
            case 403:
               return "Forbidden";
            case 404:
               return "Not Found";
            case 500:
               return "Internal Server Error";
            case 502:
               return "Bad Gateway";
            case 503:
               return "Service Unavailable";
            default:
               return "ERROR";
         }
      }
      
      public function get errordata() : Object
      {
         return this._errordata;
      }
      
      public function get timeCheck() : Boolean
      {
         return this._timecheck;
      }
      
      public function set method(param1:String) : void
      {
         this._method = param1;
      }
      
      public function open(param1:String = "", param2:String = "", param3:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc6_:URLRequest = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:SharedObject = null;
         var _loc10_:int = 0;
         this._timecheck = false;
         this._roomcheck = false;
         this._downloadcheck = false;
         this._sleepingcheck = false;
         this._sleepingflag = 0;
         if(param1 != "")
         {
            this._api = param1;
         }
         if(param2 != "")
         {
            this._method = param2;
         }
         if(!(this._api == "debug.account.pdc.logintest" || this._api == "pgl.top.init" || this._api == "pgl.top.index" || this._api == "pgl.news.news_list" || this._api == "pgl.member.profile.pdw_login"))
         {
            if(PokemonBridge.token)
            {
               _loc8_ = "pokemon-login";
               _loc9_ = SharedObject.getLocal(_loc8_,"/");
               if(_loc9_.data.token != PokemonBridge.token)
               {
                  PokemonBridge.loginError();
                  return;
               }
            }
         }
         var _loc4_:URLVariables = new URLVariables();
         for(_loc5_ in this.request)
         {
            if(this.request[_loc5_] is Array)
            {
               _loc10_ = 0;
               while(_loc10_ < this.request[_loc5_].length)
               {
                  _loc4_[_loc5_ + "[" + _loc10_ + "]"] = this.request[_loc5_][_loc10_];
                  _loc10_++;
               }
            }
            else
            {
               _loc4_[_loc5_] = this.request[_loc5_];
            }
         }
         _loc4_["p"] = param1;
         _loc6_ = new URLRequest();
         _loc7_ = param1.split(".");
         if(_loc7_[0] == "pdw")
         {
            if(param1 == "pdw.campaign.campaign_list" || param1 == "pdw.campaign.campaign_detail" || param1 == "pdw.campaign.campaign_id_check" || param1 == "pdw.campaign.campaign_clear")
            {
               if(param3)
               {
                  _loc6_.url = PokemonBridge.API_SSL;
               }
               else
               {
                  _loc6_.url = PokemonBridge.API;
               }
            }
            else if(param3)
            {
               _loc6_.url = PokemonBridge.PDW_API_SSL;
            }
            else
            {
               _loc6_.url = PokemonBridge.PDW_API;
            }
         }
         else if(param1 == "pgl.news.information_list" || param1 == "pgl.member.profile.my_state")
         {
            if(param3)
            {
               _loc6_.url = PokemonBridge.PDW_API_SSL;
            }
            else
            {
               _loc6_.url = PokemonBridge.PDW_API;
            }
         }
         else if(param3)
         {
            _loc6_.url = PokemonBridge.API_SSL;
         }
         else
         {
            _loc6_.url = PokemonBridge.API;
         }
         Logger.log(param1);
         _loc6_.method = this._method;
         _loc6_.data = _loc4_;
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.completeHandler);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         this._loader.load(_loc6_);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var jsondata:Object;
         var st:int = 0;
         var mes:String = null;
         var event:Event = param1;
         this._data = this._loader.data;
         Logger.log(String(this._data));
         jsondata = {};
         try
         {
            jsondata = com.adobe.serialization.json.JSON.decode(String(this._data));
         }
         catch(error:Error)
         {
            st = 0;
            if(_statusCode != 0)
            {
               st = _statusCode;
            }
            mes = statusMessage(st);
            jsondata = {"error":{
               "code":st,
               "mess":mes,
               "details":{}
            }};
         }
         if(!jsondata.error)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.createErrorMessage(jsondata);
         }
         if(this._loader)
         {
            this._loader.removeEventListener(Event.COMPLETE,this.completeHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         }
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         this._statusCode = param1.status;
      }
      
      public function get downloadCheck() : Boolean
      {
         return this._downloadcheck;
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:int = 0;
         if(this._statusCode != 0)
         {
            _loc2_ = this._statusCode;
         }
         var _loc3_:String = this.statusMessage(_loc2_);
         var _loc4_:Object = {"error":{
            "code":_loc2_,
            "mess":_loc3_,
            "details":{}
         }};
         this.createErrorMessage(_loc4_);
      }
      
      public function get roomCheck() : Boolean
      {
         return this._roomcheck;
      }
      
      public function get keys() : Array
      {
         return this._keys;
      }
      
      public function close() : void
      {
         if(this._loader)
         {
            this._loader.removeEventListener(Event.COMPLETE,this.completeHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
            this._loader.close();
            this._loader = null;
         }
      }
      
      private function createErrorMessage(param1:Object) : void
      {
         var _loc7_:* = undefined;
         var _loc2_:Date = new Date();
         var _loc3_:Object = new Object();
         Logger.log("// 通信エラーが発生しました /////////////////////////////////////////////");
         Logger.log("[時間]");
         var _loc4_:String = String(_loc2_.getFullYear()) + "/" + String(_loc2_.getMonth() + 1) + "/" + String(_loc2_.getDate()) + " - ";
         _loc4_ = _loc4_ + (String(_loc2_.getHours()) + ":" + String(_loc2_.getMinutes()) + ":");
         _loc4_ = _loc4_ + (String(_loc2_.getSeconds()) + ":" + String(_loc2_.getMilliseconds()));
         Logger.log(_loc4_);
         Logger.log("[API]");
         Logger.log(String(this._api));
         Logger.log("code=" + param1.error.code);
         Logger.log("mess=" + param1.error.mess);
         Logger.log("////////////////////////////////////////////////////////////////////");
         this._statusCode = parseInt(param1.error.code,10);
         var _loc5_:String = "";
         var _loc6_:Array = [];
         for(_loc7_ in param1.error.details)
         {
            _loc6_.push(_loc7_);
            _loc5_ += param1.error.details[_loc7_] + "\n";
         }
         this._keys = _loc6_;
         if(param1.error.details["timecheck"])
         {
            this._timecheck = true;
         }
         if(param1.error.details["countcheck"])
         {
            this._roomcheck = true;
         }
         if(param1.error.details["downloadcheck"])
         {
            this._downloadcheck = true;
         }
         if(param1.error.details["sleeping_check"])
         {
            this._sleepingcheck = true;
         }
         if(param1.error.details["sleeping_flag"])
         {
            this._sleepingflag = param1.error.details["sleeping_flag"];
         }
         switch(this._statusCode)
         {
            case 0:
               PokemonBridge.acceseeError();
               break;
            case 404:
               if(!_loc7_)
               {
                  PokemonBridge.Error404();
                  return;
               }
               break;
            case 403:
               if(param1.error.details["is_pdw_timeout"] == 1)
               {
                  PokemonBridge.returntoPGL2();
                  return;
               }
               if(param1.error.details["is_session_timeout"] == "1")
               {
                  PokemonBridge.acceseeError();
                  return;
               }
               if(!_loc7_)
               {
                  PokemonBridge.Error403();
                  return;
               }
               break;
            case 500:
               PokemonBridge.Error500();
               return;
            case 502:
               PokemonBridge.Error502();
               return;
            case 503:
               PokemonBridge.Error503();
               return;
         }
         this._errordata = param1;
         dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,_loc5_));
         if(this._loader)
         {
            this._loader.removeEventListener(Event.COMPLETE,this.completeHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         }
      }
      
      public function get statusCode() : int
      {
         return this._statusCode;
      }
   }
}


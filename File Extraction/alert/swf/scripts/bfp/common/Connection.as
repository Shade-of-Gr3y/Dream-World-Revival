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
      
      public function Connection(api:String = "", method:String = "GET")
      {
         super();
         this._request = new Object();
         this._data = null;
         this._errordata = null;
         this._api = api;
         this._method = method;
      }
      
      public function get request() : Object
      {
         return this._request;
      }
      
      private function securityErrorHandler(event:SecurityErrorEvent) : void
      {
         trace("securityErrorHandler");
         var st:int = 0;
         if(this._statusCode != 0)
         {
            st = this._statusCode;
         }
         var mes:String = this.statusMessage(st);
         var o:Object = {"error":{
            "code":st,
            "mess":mes,
            "details":{}
         }};
         this.createErrorMessage(o);
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
      
      public function set request(value:Object) : void
      {
         this._request = value;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set api(value:String) : void
      {
         this._api = value;
      }
      
      private function statusMessage(code:int) : String
      {
         switch(code)
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
      
      public function set method(value:String) : void
      {
         this._method = value;
      }
      
      public function open(api:String = "", method:String = "", https:Boolean = false) : void
      {
         var s:String = null;
         var _req:URLRequest = null;
         var apidiv:Array = null;
         var soName:String = null;
         var _so:SharedObject = null;
         var i:int = 0;
         this._timecheck = false;
         this._roomcheck = false;
         this._downloadcheck = false;
         this._sleepingcheck = false;
         this._sleepingflag = 0;
         if(api != "")
         {
            this._api = api;
         }
         if(method != "")
         {
            this._method = method;
         }
         if(!(this._api == "debug.account.pdc.logintest" || this._api == "pgl.top.init" || this._api == "pgl.top.index" || this._api == "pgl.news.news_list" || this._api == "pgl.member.profile.pdw_login"))
         {
            if(PokemonBridge.token)
            {
               soName = "pokemon-login";
               _so = SharedObject.getLocal(soName,"/");
               if(_so.data.token != PokemonBridge.token)
               {
                  PokemonBridge.loginError();
                  return;
               }
            }
         }
         var variables:URLVariables = new URLVariables();
         for(s in this.request)
         {
            if(this.request[s] is Array)
            {
               for(i = 0; i < this.request[s].length; i++)
               {
                  variables[s + "[" + i + "]"] = this.request[s][i];
               }
            }
            else
            {
               variables[s] = this.request[s];
            }
         }
         variables["p"] = api;
         _req = new URLRequest();
         apidiv = api.split(".");
         if(apidiv[0] == "pdw")
         {
            if(api == "pdw.campaign.campaign_list" || api == "pdw.campaign.campaign_detail" || api == "pdw.campaign.campaign_id_check" || api == "pdw.campaign.campaign_clear")
            {
               if(https)
               {
                  _req.url = PokemonBridge.API_SSL;
               }
               else
               {
                  _req.url = PokemonBridge.API;
               }
            }
            else if(https)
            {
               _req.url = PokemonBridge.PDW_API_SSL;
            }
            else
            {
               _req.url = PokemonBridge.PDW_API;
            }
         }
         else if(api == "pgl.news.information_list" || api == "pgl.member.profile.my_state")
         {
            if(https)
            {
               _req.url = PokemonBridge.PDW_API_SSL;
            }
            else
            {
               _req.url = PokemonBridge.PDW_API;
            }
         }
         else if(https)
         {
            _req.url = PokemonBridge.API_SSL;
         }
         else
         {
            _req.url = PokemonBridge.API;
         }
         Logger.log(api);
         _req.method = this._method;
         _req.data = variables;
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.completeHandler);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         this._loader.load(_req);
      }
      
      private function completeHandler(event:Event) : void
      {
         var jsondata:Object;
         var st:int = 0;
         var mes:String = null;
         trace("completeHandler");
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
      
      private function httpStatusHandler(event:HTTPStatusEvent) : void
      {
         trace("httpStatusHandler " + event.status);
         this._statusCode = event.status;
      }
      
      public function get downloadCheck() : Boolean
      {
         return this._downloadcheck;
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      private function ioErrorHandler(event:IOErrorEvent) : void
      {
         trace("httpFaultHandler " + event.text + " " + event.target.data);
         var st:int = 0;
         if(this._statusCode != 0)
         {
            st = this._statusCode;
         }
         var mes:String = this.statusMessage(st);
         var o:Object = {"error":{
            "code":st,
            "mess":mes,
            "details":{}
         }};
         this.createErrorMessage(o);
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
      
      private function createErrorMessage(jsondata:Object) : void
      {
         var p:* = undefined;
         var date:Date = new Date();
         var err:Object = new Object();
         Logger.log("// 通信エラーが発生しました /////////////////////////////////////////////");
         Logger.log("[時間]");
         var time:String = String(date.getFullYear()) + "/" + String(date.getMonth() + 1) + "/" + String(date.getDate()) + " - ";
         time += String(date.getHours()) + ":" + String(date.getMinutes()) + ":";
         time += String(date.getSeconds()) + ":" + String(date.getMilliseconds());
         Logger.log(time);
         Logger.log("[API]");
         Logger.log(String(this._api));
         Logger.log("code=" + jsondata.error.code);
         Logger.log("mess=" + jsondata.error.mess);
         Logger.log("////////////////////////////////////////////////////////////////////");
         this._statusCode = parseInt(jsondata.error.code,10);
         var message:String = "";
         var keys:Array = [];
         for(p in jsondata.error.details)
         {
            keys.push(p);
            message += jsondata.error.details[p] + "\n";
         }
         this._keys = keys;
         if(jsondata.error.details["timecheck"])
         {
            this._timecheck = true;
         }
         if(jsondata.error.details["countcheck"])
         {
            this._roomcheck = true;
         }
         if(jsondata.error.details["downloadcheck"])
         {
            this._downloadcheck = true;
         }
         if(jsondata.error.details["sleeping_check"])
         {
            this._sleepingcheck = true;
         }
         if(jsondata.error.details["sleeping_flag"])
         {
            this._sleepingflag = jsondata.error.details["sleeping_flag"];
         }
         switch(this._statusCode)
         {
            case 0:
               PokemonBridge.acceseeError();
               break;
            case 404:
               if(!p)
               {
                  PokemonBridge.Error404();
                  return;
               }
               break;
            case 403:
               if(jsondata.error.details["is_pdw_timeout"] == 1)
               {
                  PokemonBridge.returntoPGL2();
                  return;
               }
               if(jsondata.error.details["is_session_timeout"] == "1")
               {
                  PokemonBridge.acceseeError();
                  return;
               }
               if(!p)
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
         this._errordata = jsondata;
         dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,message));
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


package bfp.common
{
   import com.adobe.serialization.json.JSON;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class ConnectorDataBase extends EventDispatcher
   {
      
      public static const DB_ERROR:String = "DB_ERROR";
      
      public static const DB_SUCCESS:String = "DB_SUCCESS";
      
      public static const DB_PROGRESS:String = "DB_PROGRESS";
      
      public var _json:Object;
      
      private var _error:String;
      
      private var _code:int;
      
      private var _num:Number = 0;
      
      private var _connect:Connection;
      
      private var _loader:URLLoader;
      
      public function ConnectorDataBase()
      {
         super();
         this._json = new Object();
      }
      
      public function get downloadcheck() : Boolean
      {
         return this._connect.downloadCheck;
      }
      
      public function get error() : String
      {
         return this._error;
      }
      
      private function progressConnectHandler(e:ProgressEvent) : void
      {
         this._num = Number(e.bytesLoaded / e.bytesTotal);
         dispatchEvent(new Event(DB_PROGRESS));
      }
      
      public function get roomcheck() : Boolean
      {
         return this._connect.roomCheck;
      }
      
      public function get sleepingflag() : Number
      {
         return this._connect.sleepingflag;
      }
      
      private function completeConnectHandler(e:Event) : void
      {
         if(this._loader)
         {
            this._loader.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._loader.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
            this._json = com.adobe.serialization.json.JSON.decode(this._loader.data);
         }
         if(this._connect)
         {
            this._connect.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
            this._connect.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._connect.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._json = com.adobe.serialization.json.JSON.decode(this._connect.data.toString());
         }
         dispatchEvent(new Event(DB_SUCCESS));
      }
      
      public function get timecheck() : Boolean
      {
         return this._connect.timeCheck;
      }
      
      public function disconnect() : void
      {
         if(this._loader)
         {
            this._loader.close();
            if(this._loader.hasEventListener(Event.COMPLETE))
            {
               this._loader.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
               this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
               this._loader.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            }
            this._loader = null;
         }
         if(this._connect)
         {
            this._connect.close();
            if(this._connect.hasEventListener(Event.COMPLETE))
            {
               this._connect.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
               this._connect.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
               this._connect.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            }
            this._connect = null;
         }
         this._json = null;
         this._error = null;
         this._code = undefined;
         this._num = undefined;
      }
      
      private function errorConnectHandler(e:IOErrorEvent) : void
      {
         if(this._loader)
         {
            this._loader.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._loader.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
         }
         if(this._connect)
         {
            this._code = this._connect.statusCode;
            this._connect.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
            this._connect.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._connect.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
         }
         this._error = e.text;
         Logger.log("// ERROR : " + e.text);
         dispatchEvent(new Event(DB_ERROR));
      }
      
      public function connect(DB:String, vars:URLVariables = null, flag:Boolean = true, method:String = "GET", https:Boolean = false) : void
      {
         var request:URLRequest = null;
         this._num = 0;
         if(flag)
         {
            request = new URLRequest();
            if(flag)
            {
               if(PokemonBridge.DEBUG)
               {
                  request.url = "../../" + "json/" + DB + ".json";
               }
               else
               {
                  request.url = PokemonBridge.PATH + "json/" + DB + ".json";
               }
            }
            else
            {
               request.url = ConnectorPATH.DB_JSONPATH + DB;
            }
            request.data = vars;
            request.method = method;
            this._loader = new URLLoader();
            this._loader.dataFormat = URLLoaderDataFormat.TEXT;
            this._loader.addEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._loader.addEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
            try
            {
               this._loader.load(request);
            }
            catch(e:*)
            {
               errorConnectHandler(null);
            }
         }
         else
         {
            if(vars)
            {
               if(PokemonBridge.token)
               {
                  vars.token = PokemonBridge.token;
               }
            }
            else
            {
               vars = new URLVariables();
               if(PokemonBridge.token)
               {
                  vars.token = PokemonBridge.token;
               }
            }
            this._connect = new Connection();
            this._connect.request = vars;
            this._connect.method = method;
            this._connect.addEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._connect.addEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._connect.addEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
            this._connect.open(DB,method,https);
            try
            {
            }
            catch(e:*)
            {
               errorConnectHandler(null);
            }
         }
      }
      
      public function get code() : int
      {
         return this._code;
      }
      
      public function get json() : Object
      {
         return this._json;
      }
      
      public function get progress() : Number
      {
         return this._num;
      }
      
      public function get sleepingcheck() : Boolean
      {
         return this._connect.sleepingCheck;
      }
   }
}


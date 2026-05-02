package bfp.common
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class ConnectorSource extends EventDispatcher
   {
      
      public static const SRC_ERROR:String = "SRC_ERROR";
      
      public static const SRC_SUCCESS:String = "SRC_SUCCESS";
      
      public static const SRC_PROGRESS:String = "SRC_PROGRESS";
      
      private var _loader:Loader;
      
      public function ConnectorSource()
      {
         super();
      }
      
      private function progressConnectHandler(param1:ProgressEvent) : void
      {
         dispatchEvent(new Event(SRC_PROGRESS));
      }
      
      private function errorConnectHandler(param1:IOErrorEvent) : void
      {
         Logger.log("// ERROR : " + param1.text);
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
         dispatchEvent(new Event(SRC_PROGRESS));
      }
      
      private function completeConnectHandler(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
         dispatchEvent(new Event(SRC_SUCCESS));
      }
      
      public function connect(param1:String) : void
      {
         var request:URLRequest;
         var path:String = param1;
         this._loader = new Loader();
         request = new URLRequest();
         request.url = path;
         request.method = URLRequestMethod.GET;
         Logger.log("// SOURSE : " + request.url);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeConnectHandler);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
         try
         {
            this._loader.load(request);
         }
         catch(e:*)
         {
            errorConnectHandler(null);
         }
      }
      
      public function get loader() : Loader
      {
         return this._loader;
      }
      
      public function disconnect() : void
      {
         this._loader.unload();
         if(this._loader.contentLoaderInfo.hasEventListener(Event.COMPLETE))
         {
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressConnectHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeConnectHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.errorConnectHandler);
         }
         this._loader = null;
      }
      
      public function clear() : void
      {
      }
   }
}


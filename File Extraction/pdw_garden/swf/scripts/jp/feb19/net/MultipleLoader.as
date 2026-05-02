package jp.feb19.net
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class MultipleLoader extends EventDispatcher
   {
      
      public static const LOAD_PROGRESS:String = "ml_loadProgress";
      
      public static const LOAD_FRAGMENT:String = "ml_loadFragment";
      
      public static const LOAD_COMPLETE:String = "ml_loadComplete";
      
      private var _items:Array;
      
      private var _loaders:Array;
      
      private var _timer:Sprite;
      
      private var _loadedItems:uint;
      
      private var _totalItems:uint;
      
      private var _fragmentPercent:Number;
      
      private var _fragmentLoadedBytes:uint;
      
      private var _fragmentTotalBytes:uint;
      
      private var _loadedBytes:uint;
      
      private var _totalBytes:uint;
      
      private var _loadedPercent:Number;
      
      public function MultipleLoader(items:Array)
      {
         super();
         this._items = items;
         this._timer = new Sprite();
      }
      
      public function start() : void
      {
         this._loadedItems = 0;
         this._totalItems = this._items.length;
         this._fragmentPercent = 100 / this._totalItems;
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         this._loadedBytes = 0;
         this._totalBytes = 0;
         this._loadedPercent = 0;
         this._loaders = new Array();
         this.loadItem();
         this._timer.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function stop() : void
      {
         this._loaders[this._loadedItems].removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
         this._loaders[this._loadedItems].removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._timer.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function get fragmentLoadedBytes() : uint
      {
         return this._fragmentLoadedBytes;
      }
      
      public function get fragmentTotalBytes() : uint
      {
         return this._fragmentTotalBytes;
      }
      
      public function get loadedFragments() : uint
      {
         return this._loadedItems;
      }
      
      public function get totalFragments() : uint
      {
         return this._totalItems;
      }
      
      public function get loadedBytes() : uint
      {
         return this._fragmentLoadedBytes + this._loadedBytes;
      }
      
      public function get totalBytes() : uint
      {
         return this._fragmentTotalBytes + this._totalBytes;
      }
      
      public function get percent() : Number
      {
         return this._loadedPercent;
      }
      
      public function get loaders() : Array
      {
         return this._loaders;
      }
      
      private function enterFrameHandler(event:Event) : void
      {
         dispatchEvent(new Event(LOAD_PROGRESS));
      }
      
      private function loadItem() : void
      {
         var urlLoader:URLLoader = null;
         var sound:Sound = null;
         var context:LoaderContext = null;
         var loader:Loader = null;
         var itemURL:String = this._items[this._loadedItems];
         trace("load: " + itemURL);
         var request:URLRequest = new URLRequest(itemURL);
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         if(itemURL.substr(-4) == ".txt" || itemURL.substr(-4) == ".xml" || itemURL.substr(-5) == ".json")
         {
            urlLoader = new URLLoader();
            urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
            urlLoader.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            urlLoader.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            urlLoader.load(request);
            this._loaders.push(urlLoader);
         }
         else if(itemURL.substr(-4) == ".mp3")
         {
            sound = new Sound();
            sound.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            sound.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            sound.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            sound.load(request);
            this._loaders.push(sound);
         }
         else
         {
            context = new LoaderContext();
            context.applicationDomain = ApplicationDomain.currentDomain;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            loader.load(request,context);
            this._loaders.push(loader);
         }
      }
      
      private function ioErrorHandler(event:IOErrorEvent) : void
      {
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         var target:Object = event.currentTarget;
         target.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         target.removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
         target.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._loadedPercent = this._loadedItems * this._fragmentPercent;
         this.loadItem();
      }
      
      private function loadProgressHandler(event:ProgressEvent) : void
      {
         var per:Number = event.bytesLoaded / event.bytesTotal;
         this._loadedPercent = (this._loadedItems + per) * this._fragmentPercent;
         this._fragmentLoadedBytes = event.bytesLoaded;
         this._fragmentTotalBytes = event.bytesTotal;
      }
      
      private function loadCompleteHandler(event:Event) : void
      {
         this._loadedBytes += this._fragmentTotalBytes;
         this._totalBytes += this._fragmentTotalBytes;
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         var target:Object = event.currentTarget;
         target.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         target.removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
         target.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         ++this._loadedItems;
         this._loadedPercent = this._loadedItems * this._fragmentPercent;
         dispatchEvent(new Event(LOAD_FRAGMENT));
         if(this._totalItems != this._loadedItems)
         {
            this.loadItem();
         }
         else
         {
            this.finish();
         }
      }
      
      private function finish() : void
      {
         this._timer.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         dispatchEvent(new Event(LOAD_COMPLETE));
      }
   }
}


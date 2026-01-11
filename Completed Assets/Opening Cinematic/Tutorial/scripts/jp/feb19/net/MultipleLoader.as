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
      
      public function MultipleLoader(param1:Array)
      {
         super();
         this._items = param1;
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
      
      private function enterFrameHandler(param1:Event) : void
      {
         dispatchEvent(new Event(LOAD_PROGRESS));
      }
      
      private function loadItem() : void
      {
         var _loc3_:URLLoader = null;
         var _loc4_:Sound = null;
         var _loc5_:LoaderContext = null;
         var _loc6_:Loader = null;
         var _loc1_:String = String(this._items[this._loadedItems]);
         trace("load: " + _loc1_);
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         if(_loc1_.substr(-4) == ".txt" || _loc1_.substr(-4) == ".xml" || _loc1_.substr(-5) == ".json")
         {
            _loc3_ = new URLLoader();
            _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc3_.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            _loc3_.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            _loc3_.load(_loc2_);
            this._loaders.push(_loc3_);
         }
         else if(_loc1_.substr(-4) == ".mp3")
         {
            (_loc4_ = new Sound()).addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            _loc4_.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            _loc4_.load(_loc2_);
            this._loaders.push(_loc4_);
         }
         else
         {
            (_loc5_ = new LoaderContext()).applicationDomain = ApplicationDomain.currentDomain;
            (_loc6_ = new Loader()).contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
            _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            _loc6_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            _loc6_.load(_loc2_,_loc5_);
            this._loaders.push(_loc6_);
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         var _loc2_:Object = param1.currentTarget;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._loadedPercent = this._loadedItems * this._fragmentPercent;
         this.loadItem();
      }
      
      private function loadProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         this._loadedPercent = (this._loadedItems + _loc2_) * this._fragmentPercent;
         this._fragmentLoadedBytes = param1.bytesLoaded;
         this._fragmentTotalBytes = param1.bytesTotal;
      }
      
      private function loadCompleteHandler(param1:Event) : void
      {
         this._loadedBytes += this._fragmentTotalBytes;
         this._totalBytes += this._fragmentTotalBytes;
         this._fragmentLoadedBytes = 0;
         this._fragmentTotalBytes = 0;
         var _loc2_:Object = param1.currentTarget;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
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

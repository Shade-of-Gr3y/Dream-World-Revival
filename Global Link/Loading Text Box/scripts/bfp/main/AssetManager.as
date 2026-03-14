package bfp.main
{
   import bfp.common.Logger;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AssetManager extends EventDispatcher
   {
      
      public static const COMPLETE_PRELOADING:String = "COMPLETE_PRELOADING";
      
      public static const COMPLETE_LOADING:String = "COMPLETE_LOADING";
      
      public static const PROGRESS_LOADING:String = "PROGRESS_LOADING";
      
      private var _path:String = "./";
      
      private var _total:int = 1;
      
      private var _num:int = 0;
      
      private var _scene:Sprite = null;
      
      private var _flag:Boolean = true;
      
      private var _lists:Array = null;
      
      private var _per:Number = 0;
      
      private var _assets:Array = null;
      
      public function AssetManager(param1:Sprite, param2:Array = null)
      {
         super();
         if(param2 != null)
         {
            this._assets = new Array();
            this._lists = param2;
            this._total = this._lists.length;
         }
         this._path = param1.loaderInfo.url.slice(0,param1.loaderInfo.url.lastIndexOf("/") + 1);
         this._scene = param1;
         this._scene.addEventListener(Event.ENTER_FRAME,this.preLoadingHandler);
      }
      
      public function loadAssets() : void
      {
         var path:String = null;
         var arr:Array = null;
         var req:URLRequest = null;
         var para:Array = null;
         var param:URLVariables = null;
         var i:* = undefined;
         var work:Array = null;
         var prop:String = null;
         var vale:String = null;
         var urlLoader:URLLoader = null;
         var media:LoaderContext = null;
         var mediaLoader:Loader = null;
         if(this._num == this._total)
         {
            this._flag = true;
            dispatchEvent(new Event(COMPLETE_LOADING));
         }
         else
         {
            this._flag = false;
            path = String(this._lists[this._num]);
            arr = path.split("?");
            req = new URLRequest(arr[0]);
            Logger.log(arr[0]);
            if(arr.length > 1)
            {
               para = arr[1].split("&");
               param = new URLVariables();
               for(i in para)
               {
                  work = para[i].split("=");
                  prop = work[0].slice(0,work[0].length);
                  vale = work[1].slice(0,work[1].length);
                  param[prop] = vale;
               }
               req.data = param;
            }
            path = arr[0];
            if(path.substr(-4) == ".xml")
            {
               urlLoader = new URLLoader();
               urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
               urlLoader.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
               urlLoader.addEventListener(Event.COMPLETE,this.completeHandler);
               urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
               try
               {
                  urlLoader.load(req);
               }
               catch(e:*)
               {
                  errorHandler(null);
               }
            }
            else
            {
               media = new LoaderContext();
               media.applicationDomain = ApplicationDomain.currentDomain;
               mediaLoader = new Loader();
               mediaLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
               mediaLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
               mediaLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
               try
               {
                  mediaLoader.load(req,media);
               }
               catch(e:*)
               {
                  errorHandler(null);
               }
            }
         }
      }
      
      public function addAssets(param1:Array = null) : void
      {
         if(param1 != null)
         {
            this._lists = this._lists.concat(param1);
            this._total += param1.length;
            if(this._flag)
            {
               this.loadAssets();
            }
         }
      }
      
      public function get percent() : Number
      {
         return this._per;
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(this._assets)
         {
            ++this._num;
            _loc2_ = Object(param1.currentTarget);
            _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
            _loc2_.removeEventListener(Event.COMPLETE,this.completeHandler);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
            this._assets.push(_loc2_);
            this.loadAssets();
         }
      }
      
      public function clear() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Object = null;
         this._scene.removeEventListener(Event.ENTER_FRAME,this.preLoadingHandler);
         for(_loc1_ in this._assets)
         {
            _loc2_ = Object(this._assets[_loc1_]);
            if(_loc2_.constructor == "[class LoaderInfo]")
            {
               _loc2_.loader.unloadAndStop();
            }
            this._assets[_loc1_] = null;
         }
         this._scene = null;
         this._path = null;
         this._lists = null;
         this._assets = null;
         this._total = NaN;
         this._num = NaN;
         this._per = NaN;
         this._flag = undefined;
      }
      
      public function get scene() : Sprite
      {
         return this._scene;
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded;
         var _loc3_:Number = param1.bytesTotal;
         this._per = (this._num + 1) / (this._total + 1) + _loc2_ / _loc3_ / (this._total + 1);
         dispatchEvent(new Event(PROGRESS_LOADING));
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
         Logger.log("MEDIA LOAD ERROR : " + String(this._lists[this._num]));
      }
      
      private function preLoadingHandler(param1:Event) : void
      {
         var _loc2_:Number = this._scene.loaderInfo.bytesLoaded;
         var _loc3_:Number = this._scene.loaderInfo.bytesTotal;
         if(_loc2_ / _loc3_ == 1 && _loc3_ > 4)
         {
            this._scene.removeEventListener(Event.ENTER_FRAME,this.preLoadingHandler);
            dispatchEvent(new Event(COMPLETE_PRELOADING));
         }
      }
      
      public function getAsset(param1:Object) : Object
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:Object = null;
         if(this._scene)
         {
            if(typeof param1 == "number")
            {
               _loc4_ = 0;
               while(_loc4_ < this._assets.length)
               {
                  _loc2_[_loc4_] = this._assets[_loc4_];
                  _loc4_++;
               }
               _loc3_ = Object(_loc2_[_loc5_]);
            }
            else if(typeof param1 == "string")
            {
               _loc5_ = -1;
               _loc6_ = this._lists.length;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  if(this._lists[_loc7_] == param1)
                  {
                     _loc5_ = _loc7_;
                  }
                  _loc7_++;
               }
               if(_loc5_ != -1)
               {
                  _loc8_ = 0;
                  while(_loc8_ < this._assets.length)
                  {
                     _loc2_[_loc8_] = this._assets[_loc8_];
                     _loc8_++;
                  }
                  _loc3_ = Object(_loc2_[_loc5_]);
               }
            }
         }
         return _loc3_;
      }
      
      public function unload(param1:Object) : void
      {
         var _loc2_:Loader = Loader(this.getAsset(param1).loader);
         _loc2_.unloadAndStop();
      }
   }
}


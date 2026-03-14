package com.google.analytics.core
{
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.VisualDebugMode;
   import com.google.analytics.utils.Environment;
   import com.google.analytics.utils.Protocols;
   import com.google.analytics.utils.Variables;
   import com.google.analytics.v4.Configuration;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class GIFRequest
   {
      
      private var _info:Environment;
      
      private var _count:int;
      
      private var _utmac:String;
      
      private var _alertcount:int;
      
      private var _debug:DebugConfiguration;
      
      private var _lastRequest:URLRequest;
      
      private var _buffer:Buffer;
      
      private var _config:Configuration;
      
      private var _requests:Array;
      
      public function GIFRequest(param1:Configuration, param2:DebugConfiguration, param3:Buffer, param4:Environment)
      {
         super();
         _config = param1;
         _debug = param2;
         _buffer = param3;
         _info = param4;
         _count = 0;
         _alertcount = 0;
         _requests = [];
      }
      
      public function get utmn() : String
      {
         return Utils.generate32bitRandom() as String;
      }
      
      public function onIOError(param1:IOErrorEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = null;
         _loc2_ = _lastRequest.url;
         _loc3_ = String(_requests.length - 1);
         _loc4_ = "Gif Request #" + _loc3_ + " failed";
         if(_debug.GIFRequests)
         {
            if(!_debug.verbose)
            {
               if(_loc2_.indexOf("?") > -1)
               {
                  _loc2_ = _loc2_.split("?")[0];
               }
               _loc2_ = _shortenURL(_loc2_);
            }
            if(int(_debug.mode) > int(VisualDebugMode.basic))
            {
               _loc4_ += " \"" + _loc2_ + "\" does not exists or is unreachable";
            }
            _debug.failure(_loc4_);
         }
         else
         {
            _debug.warning(_loc4_);
         }
         _removeListeners(param1.target);
      }
      
      public function send(param1:String, param2:Variables = null, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc6_:URLRequest = null;
         var _loc7_:URLRequest = null;
         _utmac = param1;
         if(!param2)
         {
            param2 = new Variables();
         }
         param2.URIencode = false;
         param2.pre = ["utmwv","utmn","utmhn","utmt","utme","utmcs","utmsr","utmsc","utmul","utmje","utmfl","utmdt","utmhid","utmr","utmp"];
         param2.post = ["utmcc"];
         if(_debug.verbose)
         {
            _debug.info("tracking: " + _buffer.utmb.trackCount + "/" + _config.trackingLimitPerSession,VisualDebugMode.geek);
         }
         if(_buffer.utmb.trackCount < _config.trackingLimitPerSession || param3)
         {
            if(param4)
            {
               updateToken();
            }
            if(param3 || !param4 || _buffer.utmb.token >= 1)
            {
               if(!param3 && param4)
               {
                  --_buffer.utmb.token;
               }
               _buffer.utmb.trackCount += 1;
               if(_debug.verbose)
               {
                  _debug.info(_buffer.utmb.toString(),VisualDebugMode.geek);
               }
               param2.utmwv = utmwv;
               param2.utmn = Utils.generate32bitRandom();
               if(_info.domainName != "")
               {
                  param2.utmhn = _info.domainName;
               }
               if(_config.sampleRate < 1)
               {
                  param2.utmsp = _config.sampleRate * 100;
               }
               if(_config.serverMode == ServerOperationMode.local || _config.serverMode == ServerOperationMode.both)
               {
                  _loc5_ = _info.locationSWFPath;
                  if(_loc5_.lastIndexOf("/") > 0)
                  {
                     _loc5_ = _loc5_.substring(0,_loc5_.lastIndexOf("/"));
                  }
                  _loc6_ = new URLRequest();
                  if(_config.localGIFpath.indexOf("http") == 0)
                  {
                     _loc6_.url = _config.localGIFpath;
                  }
                  else
                  {
                     _loc6_.url = _loc5_ + _config.localGIFpath;
                  }
                  _loc6_.url += "?" + param2.toString();
                  if(_debug.active && _debug.GIFRequests)
                  {
                     _debugSend(_loc6_);
                  }
                  else
                  {
                     sendRequest(_loc6_);
                  }
               }
               if(_config.serverMode == ServerOperationMode.remote || _config.serverMode == ServerOperationMode.both)
               {
                  _loc7_ = new URLRequest();
                  if(_info.protocol == Protocols.HTTPS)
                  {
                     _loc7_.url = _config.secureRemoteGIFpath;
                  }
                  else if(_info.protocol == Protocols.HTTP)
                  {
                     _loc7_.url = _config.remoteGIFpath;
                  }
                  else
                  {
                     _loc7_.url = _config.remoteGIFpath;
                  }
                  param2.utmac = utmac;
                  param2.utmcc = encodeURIComponent(utmcc);
                  _loc7_.url += "?" + param2.toString();
                  if(_debug.active && _debug.GIFRequests)
                  {
                     _debugSend(_loc7_);
                  }
                  else
                  {
                     sendRequest(_loc7_);
                  }
               }
            }
         }
      }
      
      public function onSecurityError(param1:SecurityErrorEvent) : void
      {
         if(_debug.GIFRequests)
         {
            _debug.failure(param1.text);
         }
      }
      
      public function get utmsp() : String
      {
         return _config.sampleRate * 100 as String;
      }
      
      public function get utmcc() : String
      {
         var _loc1_:Array = null;
         _loc1_ = [];
         if(_buffer.hasUTMA())
         {
            _loc1_.push(_buffer.utma.toURLString() + ";");
         }
         if(_buffer.hasUTMZ())
         {
            _loc1_.push(_buffer.utmz.toURLString() + ";");
         }
         if(_buffer.hasUTMV())
         {
            _loc1_.push(_buffer.utmv.toURLString() + ";");
         }
         return _loc1_.join("+");
      }
      
      public function get utmac() : String
      {
         return _utmac;
      }
      
      public function get utmwv() : String
      {
         return _config.version;
      }
      
      public function sendRequest(param1:URLRequest) : void
      {
         var loader:Loader = null;
         var context:LoaderContext = null;
         var request:URLRequest = param1;
         loader = new Loader();
         loader.name = String(_count++);
         context = new LoaderContext(false);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         _lastRequest = request;
         _requests[loader.name] = new RequestObject(request);
         try
         {
            loader.load(request,context);
         }
         catch(e:Error)
         {
            _debug.failure("\"Loader.load()\" could not instanciate Gif Request");
         }
      }
      
      private function _removeListeners(param1:Object) : void
      {
         param1.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         param1.removeEventListener(Event.COMPLETE,onComplete);
      }
      
      public function updateToken() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc1_ = Number(new Date().getTime());
         _loc2_ = (_loc1_ - _buffer.utmb.lastTime) * (_config.tokenRate / 1000);
         if(_debug.verbose)
         {
            _debug.info("tokenDelta: " + _loc2_,VisualDebugMode.geek);
         }
         if(_loc2_ >= 1)
         {
            _buffer.utmb.token = Math.min(Math.floor(_buffer.utmb.token + _loc2_),_config.bucketCapacity);
            _buffer.utmb.lastTime = _loc1_;
            if(_debug.verbose)
            {
               _debug.info(_buffer.utmb.toString(),VisualDebugMode.geek);
            }
         }
      }
      
      private function _shortenURL(param1:String) : String
      {
         var _loc2_:Array = null;
         if(param1.length > 60)
         {
            _loc2_ = param1.split("/");
            while(param1.length > 60)
            {
               _loc2_.shift();
               param1 = "../" + _loc2_.join("/");
            }
         }
         return param1;
      }
      
      public function get utmhn() : String
      {
         return _info.domainName;
      }
      
      private function _debugSend(param1:URLRequest) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         _loc2_ = "";
         switch(_debug.mode)
         {
            case VisualDebugMode.geek:
               _loc2_ = "Gif Request #" + _alertcount + ":\n" + param1.url;
               break;
            case VisualDebugMode.advanced:
               _loc3_ = param1.url;
               if(_loc3_.indexOf("?") > -1)
               {
                  _loc3_ = _loc3_.split("?")[0];
               }
               _loc3_ = _shortenURL(_loc3_);
               _loc2_ = "Send Gif Request #" + _alertcount + ":\n" + _loc3_ + " ?";
               break;
            case VisualDebugMode.basic:
            default:
               _loc2_ = "Send " + _config.serverMode.toString() + " Gif Request #" + _alertcount + " ?";
         }
         _debug.alertGifRequest(_loc2_,param1,this);
         ++_alertcount;
      }
      
      public function onComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         var _loc4_:String = null;
         _loc2_ = param1.target.loader.name;
         _requests[_loc2_].complete();
         _loc3_ = "Gif Request #" + _loc2_ + " sent";
         _loc4_ = _requests[_loc2_].request.url;
         if(_debug.GIFRequests)
         {
            if(!_debug.verbose)
            {
               if(_loc4_.indexOf("?") > -1)
               {
                  _loc4_ = _loc4_.split("?")[0];
               }
               _loc4_ = _shortenURL(_loc4_);
            }
            if(int(_debug.mode) > int(VisualDebugMode.basic))
            {
               _loc3_ += " to \"" + _loc4_ + "\"";
            }
            _debug.success(_loc3_);
         }
         else
         {
            _debug.info(_loc3_);
         }
         _removeListeners(param1.target);
      }
   }
}


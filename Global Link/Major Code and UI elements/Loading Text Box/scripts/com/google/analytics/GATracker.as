package com.google.analytics
{
   import com.google.analytics.core.Buffer;
   import com.google.analytics.core.EventTracker;
   import com.google.analytics.core.GIFRequest;
   import com.google.analytics.core.IdleTimer;
   import com.google.analytics.core.ServerOperationMode;
   import com.google.analytics.core.TrackerCache;
   import com.google.analytics.core.TrackerMode;
   import com.google.analytics.core.ga_internal;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.Layout;
   import com.google.analytics.events.AnalyticsEvent;
   import com.google.analytics.external.AdSenseGlobals;
   import com.google.analytics.external.HTMLDOM;
   import com.google.analytics.external.JavascriptProxy;
   import com.google.analytics.utils.Environment;
   import com.google.analytics.utils.Version;
   import com.google.analytics.v4.Bridge;
   import com.google.analytics.v4.Configuration;
   import com.google.analytics.v4.GoogleAnalyticsAPI;
   import com.google.analytics.v4.Tracker;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   use namespace ga_internal;
   
   public class GATracker implements AnalyticsTracker
   {
      
      public static var autobuild:Boolean = true;
      
      public static var version:Version = API.version;
      
      private var _adSense:AdSenseGlobals;
      
      private var _env:Environment;
      
      private var _visualDebug:Boolean;
      
      private var _idleTimer:IdleTimer;
      
      private var _debug:DebugConfiguration;
      
      private var _buffer:Buffer;
      
      private var _config:Configuration;
      
      private var _mode:String;
      
      private var _display:DisplayObject;
      
      private var _jsproxy:JavascriptProxy;
      
      private var _dom:HTMLDOM;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _ready:Boolean = false;
      
      private var _gifRequest:GIFRequest;
      
      private var _account:String;
      
      private var _tracker:GoogleAnalyticsAPI;
      
      public function GATracker(param1:DisplayObject, param2:String, param3:String = "AS3", param4:Boolean = false, param5:Configuration = null, param6:DebugConfiguration = null)
      {
         super();
         _display = param1;
         _eventDispatcher = new EventDispatcher(this);
         _tracker = new TrackerCache();
         this.account = param2;
         this.mode = param3;
         this.visualDebug = param4;
         if(!param6)
         {
            this.debug = new DebugConfiguration();
         }
         if(!param5)
         {
            this.config = new Configuration(param6);
         }
         if(autobuild)
         {
            _factory();
         }
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         _tracker.link(param1,param2);
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         _tracker.addOrganic(param1,param2);
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         _tracker.setAllowLinker(param1);
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         return _tracker.trackEvent(param1,param2,param3,param4);
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         _tracker.setCookieTimeout(param1);
      }
      
      public function trackTrans() : void
      {
         _tracker.trackTrans();
      }
      
      public function trackPageview(param1:String = "") : void
      {
         _tracker.trackPageview(param1);
      }
      
      public function getClientInfo() : Boolean
      {
         return _tracker.getClientInfo();
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         _tracker.setClientInfo(param1);
      }
      
      public function get account() : String
      {
         return _account;
      }
      
      public function linkByPost(param1:Object, param2:Boolean = false) : void
      {
         _tracker.linkByPost(param1,param2);
      }
      
      public function getDetectTitle() : Boolean
      {
         return _tracker.getDetectTitle();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _eventDispatcher.dispatchEvent(param1);
      }
      
      public function get config() : Configuration
      {
         return _config;
      }
      
      public function set mode(param1:String) : void
      {
         _mode = param1;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         _tracker.setDetectFlash(param1);
      }
      
      public function resetSession() : void
      {
         _tracker.resetSession();
      }
      
      public function setCampNameKey(param1:String) : void
      {
         _tracker.setCampNameKey(param1);
      }
      
      public function get debug() : DebugConfiguration
      {
         return _debug;
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         _tracker.addItem(param1,param2,param3,param4,param5,param6);
      }
      
      private function _bridgeFactory() : GoogleAnalyticsAPI
      {
         debug.info("GATracker (Bridge) v" + version + "\naccount: " + account);
         return new Bridge(account,_debug,_jsproxy);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function clearIgnoredOrganic() : void
      {
         _tracker.clearIgnoredOrganic();
      }
      
      public function set account(param1:String) : void
      {
         _account = param1;
      }
      
      public function setVar(param1:String) : void
      {
         _tracker.setVar(param1);
      }
      
      public function build() : void
      {
         if(!isReady())
         {
            _factory();
         }
      }
      
      public function setDomainName(param1:String) : void
      {
         _tracker.setDomainName(param1);
      }
      
      public function createEventTracker(param1:String) : EventTracker
      {
         return _tracker.createEventTracker(param1);
      }
      
      public function set config(param1:Configuration) : void
      {
         _config = param1;
      }
      
      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : Object
      {
         return _tracker.addTrans(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         _tracker.setCampSourceKey(param1);
      }
      
      public function setCampContentKey(param1:String) : void
      {
         _tracker.setCampContentKey(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _eventDispatcher.willTrigger(param1);
      }
      
      public function setLocalServerMode() : void
      {
         _tracker.setLocalServerMode();
      }
      
      public function isReady() : Boolean
      {
         return _ready;
      }
      
      public function getLocalGifPath() : String
      {
         return _tracker.getLocalGifPath();
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         _tracker.setAllowAnchor(param1);
      }
      
      public function clearIgnoredRef() : void
      {
         _tracker.clearIgnoredRef();
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function set debug(param1:DebugConfiguration) : void
      {
         _debug = param1;
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         _tracker.setLocalGifPath(param1);
      }
      
      public function getVersion() : String
      {
         return _tracker.getVersion();
      }
      
      public function setSampleRate(param1:Number) : void
      {
         _tracker.setSampleRate(param1);
      }
      
      public function setCookiePath(param1:String) : void
      {
         _tracker.setCookiePath(param1);
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         _tracker.setAllowHash(param1);
      }
      
      public function setCampNOKey(param1:String) : void
      {
         _tracker.setCampNOKey(param1);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         _tracker.addIgnoredOrganic(param1);
      }
      
      public function setLocalRemoteServerMode() : void
      {
         _tracker.setLocalRemoteServerMode();
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         _tracker.cookiePathCopy(param1);
      }
      
      private function _factory() : void
      {
         var _loc1_:GoogleAnalyticsAPI = null;
         var _loc2_:TrackerCache = null;
         _jsproxy = new JavascriptProxy(debug);
         if(visualDebug)
         {
            debug.layout = new Layout(debug,_display);
            debug.active = visualDebug;
         }
         _loc2_ = _tracker as TrackerCache;
         switch(mode)
         {
            case TrackerMode.BRIDGE:
               _loc1_ = _bridgeFactory();
               break;
            case TrackerMode.AS3:
            default:
               _loc1_ = _trackerFactory();
         }
         if(!_loc2_.isEmpty())
         {
            _loc2_.tracker = _loc1_;
            _loc2_.flush();
         }
         _tracker = _loc1_;
         _ready = true;
         dispatchEvent(new AnalyticsEvent(AnalyticsEvent.READY,this));
      }
      
      public function setCampTermKey(param1:String) : void
      {
         _tracker.setCampTermKey(param1);
      }
      
      private function _trackerFactory() : GoogleAnalyticsAPI
      {
         debug.info("GATracker (AS3) v" + version + "\naccount: " + account);
         _adSense = new AdSenseGlobals(debug);
         _dom = new HTMLDOM(debug);
         _dom.cacheProperties();
         _env = new Environment("","","",debug,_dom);
         _buffer = new Buffer(config,debug,false);
         _gifRequest = new GIFRequest(config,debug,_buffer,_env);
         _idleTimer = new IdleTimer(config,debug,_display,_buffer);
         _env.ga_internal::url = _display.stage.loaderInfo.url;
         return new Tracker(account,config,debug,_env,_buffer,_gifRequest,_adSense);
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         _tracker.setDetectTitle(param1);
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         return _tracker.getServiceMode();
      }
      
      public function clearOrganic() : void
      {
         _tracker.clearOrganic();
      }
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         _tracker.setCampaignTrack(param1);
      }
      
      public function addIgnoredRef(param1:String) : void
      {
         _tracker.addIgnoredRef(param1);
      }
      
      public function set visualDebug(param1:Boolean) : void
      {
         _visualDebug = param1;
      }
      
      public function setCampMediumKey(param1:String) : void
      {
         _tracker.setCampMediumKey(param1);
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         _tracker.setSessionTimeout(param1);
      }
      
      public function getDetectFlash() : Boolean
      {
         return _tracker.getDetectFlash();
      }
      
      public function get visualDebug() : Boolean
      {
         return _visualDebug;
      }
      
      public function getAccount() : String
      {
         return _tracker.getAccount();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _eventDispatcher.hasEventListener(param1);
      }
      
      public function setRemoteServerMode() : void
      {
         _tracker.setRemoteServerMode();
      }
   }
}

import com.google.analytics.core.ServerOperationMode;

ServerOperationMode;


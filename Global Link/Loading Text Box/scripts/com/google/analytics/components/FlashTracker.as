package com.google.analytics.components
{
   import com.google.analytics.API;
   import com.google.analytics.AnalyticsTracker;
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
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   use namespace ga_internal;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol66")]
   public class FlashTracker extends Sprite implements AnalyticsTracker
   {
      
      public static var version:Version = API.version;
      
      private var _adSense:AdSenseGlobals;
      
      private var _env:Environment;
      
      protected var _height:Number = 18;
      
      private var _idleTimer:IdleTimer;
      
      private var _config:Configuration;
      
      private var _mode:String = TrackerMode.AS3;
      
      private var _dom:HTMLDOM;
      
      private var _ready:Boolean = false;
      
      protected var _width:Number = 18;
      
      private var _account:String = "";
      
      protected var _componentInspectorSetting:Boolean;
      
      private var _visualDebug:Boolean = false;
      
      public var boundingBox_mc:DisplayObject;
      
      private var _debug:DebugConfiguration;
      
      private var _buffer:Buffer;
      
      private var _display:DisplayObject;
      
      protected var livePreviewHeight:Number;
      
      private var _jsproxy:JavascriptProxy;
      
      protected var isLivePreview:Boolean;
      
      protected var preview:MovieClip;
      
      private var _gifRequest:GIFRequest;
      
      protected var livePreviewWidth:Number;
      
      private var _tracker:GoogleAnalyticsAPI;
      
      public function FlashTracker()
      {
         super();
         _tracker = new TrackerCache();
         isLivePreview = _checkLivePreview();
         _componentInspectorSetting = false;
         if(boundingBox_mc)
         {
            boundingBox_mc.visible = false;
            removeChild(boundingBox_mc);
            boundingBox_mc = null;
         }
         if(isLivePreview)
         {
            _createLivePreview();
         }
         addEventListener(Event.ENTER_FRAME,_factory);
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         return _tracker.trackEvent(param1,param2,param3,param4);
      }
      
      public function trackTrans() : void
      {
         _tracker.trackTrans();
      }
      
      private function _createLivePreview() : void
      {
         var _loc1_:Graphics = null;
         var _loc2_:Class = null;
         preview = new MovieClip();
         _loc1_ = preview.graphics;
         _loc1_.beginFill(16777215);
         _loc1_.moveTo(0,0);
         _loc1_.lineTo(0,_width);
         _loc1_.lineTo(_width,_height);
         _loc1_.lineTo(_height,0);
         _loc1_.lineTo(0,0);
         _loc1_.endFill();
         _loc2_ = getDefinitionByName("com.google.analytics.components::Icon") as Class;
         preview.icon_mc = new _loc2_();
         preview.icon_mc.name = "icon_mc";
         preview.addChild(preview.icon_mc);
         addChild(preview);
      }
      
      public function trackPageview(param1:String = "") : void
      {
         _tracker.trackPageview(param1);
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
      
      public function setCampNameKey(param1:String) : void
      {
         _tracker.setCampNameKey(param1);
      }
      
      public function resetSession() : void
      {
         _tracker.resetSession();
      }
      
      public function set account(param1:String) : void
      {
         _account = param1;
      }
      
      public function get debug() : DebugConfiguration
      {
         if(!_debug)
         {
            _createDebugAndConfig();
         }
         return _debug;
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
      
      public function setLocalServerMode() : void
      {
         _tracker.setLocalServerMode();
      }
      
      public function getLocalGifPath() : String
      {
         return _tracker.getLocalGifPath();
      }
      
      public function clearIgnoredRef() : void
      {
         _tracker.clearIgnoredRef();
      }
      
      public function isReady() : Boolean
      {
         return _ready;
      }
      
      public function set debug(param1:DebugConfiguration) : void
      {
         _debug = param1;
      }
      
      public function getVersion() : String
      {
         return _tracker.getVersion();
      }
      
      public function setLocalRemoteServerMode() : void
      {
         _tracker.setLocalRemoteServerMode();
      }
      
      public function setCampNOKey(param1:String) : void
      {
         _tracker.setCampNOKey(param1);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         _tracker.addIgnoredOrganic(param1);
      }
      
      public function setCookiePath(param1:String) : void
      {
         _tracker.setCookiePath(param1);
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
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         _tracker.setCampaignTrack(param1);
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         return _tracker.getServiceMode();
      }
      
      public function set componentInspectorSetting(param1:Boolean) : void
      {
         _componentInspectorSetting = param1;
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         _tracker.setSessionTimeout(param1);
      }
      
      public function setRemoteServerMode() : void
      {
         _tracker.setRemoteServerMode();
      }
      
      public function get visualDebug() : Boolean
      {
         return _visualDebug;
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         _tracker.addOrganic(param1,param2);
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         _tracker.setCookieTimeout(param1);
      }
      
      public function getClientInfo() : Boolean
      {
         return _tracker.getClientInfo();
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         _tracker.setAllowLinker(param1);
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         _tracker.setClientInfo(param1);
      }
      
      private function _bridgeFactory() : GoogleAnalyticsAPI
      {
         debug.info("GATracker (Bridge) v" + version + "\naccount: " + account);
         return new Bridge(account,_debug,_jsproxy);
      }
      
      public function get config() : Configuration
      {
         if(!_config)
         {
            _createDebugAndConfig();
         }
         return _config;
      }
      
      public function set mode(param1:String) : void
      {
         _mode = param1;
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         _tracker.setDetectFlash(param1);
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         _tracker.addItem(param1,param2,param3,param4,param5,param6);
      }
      
      public function setVar(param1:String) : void
      {
         _tracker.setVar(param1);
      }
      
      public function clearIgnoredOrganic() : void
      {
         _tracker.clearIgnoredOrganic();
      }
      
      public function setDomainName(param1:String) : void
      {
         _tracker.setDomainName(param1);
      }
      
      private function _checkLivePreview() : Boolean
      {
         if(parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent")
         {
            return true;
         }
         return false;
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         _tracker.setCampSourceKey(param1);
      }
      
      public function setCampContentKey(param1:String) : void
      {
         _tracker.setCampContentKey(param1);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         _tracker.setAllowAnchor(param1);
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         _tracker.setLocalGifPath(param1);
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function setSampleRate(param1:Number) : void
      {
         _tracker.setSampleRate(param1);
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         _tracker.setAllowHash(param1);
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         _tracker.setDetectTitle(param1);
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         _tracker.cookiePathCopy(param1);
      }
      
      private function _factory(param1:Event) : void
      {
         var _loc2_:GoogleAnalyticsAPI = null;
         var _loc3_:TrackerCache = null;
         removeEventListener(Event.ENTER_FRAME,_factory);
         if(isLivePreview)
         {
            return;
         }
         _display = this;
         _createDebugAndConfig();
         if(visualDebug)
         {
            debug.layout = new Layout(debug,_display);
            debug.active = visualDebug;
         }
         _jsproxy = new JavascriptProxy(debug);
         _loc3_ = _tracker as TrackerCache;
         switch(mode)
         {
            case TrackerMode.BRIDGE:
               _loc2_ = _bridgeFactory();
               break;
            case TrackerMode.AS3:
            default:
               _loc2_ = _trackerFactory();
         }
         if(!_loc3_.isEmpty())
         {
            _loc3_.tracker = _loc2_;
            _loc3_.flush();
         }
         _tracker = _loc2_;
         _ready = true;
         dispatchEvent(new AnalyticsEvent(AnalyticsEvent.READY,this));
      }
      
      public function getDetectFlash() : Boolean
      {
         return _tracker.getDetectFlash();
      }
      
      public function clearOrganic() : void
      {
         _tracker.clearOrganic();
      }
      
      private function _createDebugAndConfig() : void
      {
         if(!_debug)
         {
            this.debug = new DebugConfiguration();
         }
         if(!_config)
         {
            this.config = new Configuration(debug);
         }
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
      
      public function getAccount() : String
      {
         return _tracker.getAccount();
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         _tracker.link(param1,param2);
      }
   }
}

import com.google.analytics.core.ServerOperationMode;

ServerOperationMode;


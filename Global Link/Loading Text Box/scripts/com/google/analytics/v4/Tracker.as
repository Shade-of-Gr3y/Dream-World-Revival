package com.google.analytics.v4
{
   import com.google.analytics.campaign.CampaignInfo;
   import com.google.analytics.campaign.CampaignManager;
   import com.google.analytics.core.BrowserInfo;
   import com.google.analytics.core.Buffer;
   import com.google.analytics.core.DocumentInfo;
   import com.google.analytics.core.DomainNameMode;
   import com.google.analytics.core.EventInfo;
   import com.google.analytics.core.EventTracker;
   import com.google.analytics.core.GIFRequest;
   import com.google.analytics.core.ServerOperationMode;
   import com.google.analytics.core.Utils;
   import com.google.analytics.data.X10;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.VisualDebugMode;
   import com.google.analytics.external.AdSenseGlobals;
   import com.google.analytics.utils.Environment;
   import com.google.analytics.utils.Protocols;
   import com.google.analytics.utils.URL;
   import com.google.analytics.utils.Variables;
   
   public class Tracker implements GoogleAnalyticsAPI
   {
      
      private var _adSense:AdSenseGlobals;
      
      private const EVENT_TRACKER_LABEL_KEY_NUM:int = 3;
      
      private var _eventTracker:X10;
      
      private const EVENT_TRACKER_VALUE_VALUE_NUM:int = 1;
      
      private var _noSessionInformation:Boolean = false;
      
      private var _browserInfo:BrowserInfo;
      
      private var _debug:DebugConfiguration;
      
      private var _isNewVisitor:Boolean = false;
      
      private var _buffer:Buffer;
      
      private var _config:Configuration;
      
      private var _x10Module:X10;
      
      private var _campaign:CampaignManager;
      
      private var _formatedReferrer:String;
      
      private var _timeStamp:Number;
      
      private var _info:Environment;
      
      private var _domainHash:Number;
      
      private const EVENT_TRACKER_PROJECT_ID:int = 5;
      
      private var _campaignInfo:CampaignInfo;
      
      private const EVENT_TRACKER_OBJECT_NAME_KEY_NUM:int = 1;
      
      private var _gifRequest:GIFRequest;
      
      private const EVENT_TRACKER_TYPE_KEY_NUM:int = 2;
      
      private var _hasInitData:Boolean = false;
      
      private var _account:String;
      
      public function Tracker(param1:String, param2:Configuration, param3:DebugConfiguration, param4:Environment, param5:Buffer, param6:GIFRequest, param7:AdSenseGlobals)
      {
         var _loc8_:* = null;
         _hasInitData = false;
         _isNewVisitor = false;
         _noSessionInformation = false;
         super();
         _account = param1;
         _config = param2;
         _debug = param3;
         _info = param4;
         _buffer = param5;
         _gifRequest = param6;
         _adSense = param7;
         if(!Utils.validateAccount(param1))
         {
            _loc8_ = "Account \"" + param1 + "\" is not valid.";
            _debug.warning(_loc8_);
            throw new Error(_loc8_);
         }
         _initData();
      }
      
      private function _doTracking() : Boolean
      {
         if(_info.protocol != Protocols.file && _info.protocol != Protocols.none && _isNotGoogleSearch())
         {
            return true;
         }
         if(_config.allowLocalTracking)
         {
            return true;
         }
         return false;
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         _debug.info("addOrganic( " + [param1,param2].join(", ") + " )");
         _config.organic.addSource(param1,param2);
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         _config.allowLinker = param1;
         _debug.info("setAllowLinker( " + _config.allowLinker + " )");
      }
      
      public function trackPageview(param1:String = "") : void
      {
         _debug.info("trackPageview( " + param1 + " )");
         if(_doTracking())
         {
            _initData();
            _trackMetrics(param1);
            _noSessionInformation = false;
         }
         else
         {
            _debug.warning("trackPageview( " + param1 + " ) failed");
         }
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         _config.conversionTimeout = param1;
         _debug.info("setCookieTimeout( " + _config.conversionTimeout + " )");
      }
      
      public function trackTrans() : void
      {
         _debug.warning("trackTrans() not implemented");
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         _loc5_ = true;
         _loc6_ = 2;
         if(param1 != "" && param2 != "")
         {
            _eventTracker.clearKey(EVENT_TRACKER_PROJECT_ID);
            _eventTracker.clearValue(EVENT_TRACKER_PROJECT_ID);
            _loc5_ = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_OBJECT_NAME_KEY_NUM,param1);
            _loc5_ = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_TYPE_KEY_NUM,param2);
            if(Boolean(param3) && param3 != "")
            {
               _loc5_ = _eventTracker.setKey(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_LABEL_KEY_NUM,param3);
               _loc6_ = 3;
               if(!isNaN(param4))
               {
                  _loc5_ = _eventTracker.setValue(EVENT_TRACKER_PROJECT_ID,EVENT_TRACKER_VALUE_VALUE_NUM,param4);
                  _loc6_ = 4;
               }
            }
            if(_loc5_)
            {
               _debug.info("valid event tracking call\ncategory: " + param1 + "\naction: " + param2,VisualDebugMode.geek);
               _sendXEvent(_eventTracker);
            }
         }
         else
         {
            _debug.warning("event tracking call is not valid, failed!\ncategory: " + param1 + "\naction: " + param2,VisualDebugMode.geek);
            _loc5_ = false;
         }
         switch(_loc6_)
         {
            case 4:
               _debug.info("trackEvent( " + [param1,param2,param3,param4].join(", ") + " )");
               break;
            case 3:
               _debug.info("trackEvent( " + [param1,param2,param3].join(", ") + " )");
               break;
            case 2:
            default:
               _debug.info("trackEvent( " + [param1,param2].join(", ") + " )");
         }
         return _loc5_;
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         _config.detectClientInfo = param1;
         _debug.info("setClientInfo( " + _config.detectClientInfo + " )");
      }
      
      public function linkByPost(param1:Object, param2:Boolean = false) : void
      {
         _debug.warning("linkByPost( " + [param1,param2].join(", ") + " ) not implemented");
      }
      
      private function _initData() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(!_hasInitData)
         {
            _updateDomainName();
            _domainHash = _getDomainHash();
            _timeStamp = Math.round(new Date().getTime() / 1000);
            if(_debug.verbose)
            {
               _loc1_ = "";
               _loc1_ += "_initData 0";
               _loc1_ += "\ndomain name: " + _config.domainName;
               _loc1_ += "\ndomain hash: " + _domainHash;
               _loc1_ += "\ntimestamp:   " + _timeStamp + " (" + new Date(_timeStamp * 1000) + ")";
               _debug.info(_loc1_,VisualDebugMode.geek);
            }
         }
         if(_doTracking())
         {
            _handleCookie();
         }
         if(!_hasInitData)
         {
            if(_doTracking())
            {
               _formatedReferrer = _formatReferrer();
               _browserInfo = new BrowserInfo(_config,_info);
               _debug.info("browserInfo: " + _browserInfo.toURLString(),VisualDebugMode.advanced);
               if(_config.campaignTracking)
               {
                  _campaign = new CampaignManager(_config,_debug,_buffer,_domainHash,_formatedReferrer,_timeStamp);
                  _campaignInfo = _campaign.getCampaignInformation(_info.locationSearch,_noSessionInformation);
                  _debug.info("campaignInfo: " + _campaignInfo.toURLString(),VisualDebugMode.advanced);
               }
            }
            _x10Module = new X10();
            _eventTracker = new X10();
            _hasInitData = true;
         }
         if(_config.hasSiteOverlay)
         {
            _debug.warning("Site Overlay is not supported");
         }
         if(_debug.verbose)
         {
            _loc2_ = "";
            _loc2_ += "_initData (misc)";
            _loc2_ += "\nflash version: " + _info.flashVersion.toString(4);
            _loc2_ += "\nprotocol: " + _info.protocol;
            _loc2_ += "\ndefault domain name (auto): \"" + _info.domainName + "\"";
            _loc2_ += "\nlanguage: " + _info.language;
            _loc2_ += "\ndomain hash: " + _getDomainHash();
            _loc2_ += "\nuser-agent: " + _info.userAgent;
            _debug.info(_loc2_,VisualDebugMode.geek);
         }
      }
      
      public function getDetectTitle() : Boolean
      {
         _debug.info("getDetectTitle()");
         return _config.detectTitle;
      }
      
      public function resetSession() : void
      {
         _debug.info("resetSession()");
         _buffer.resetCurrentSession();
      }
      
      private function _sendXEvent(param1:X10 = null) : void
      {
         var _loc2_:Variables = null;
         var _loc3_:EventInfo = null;
         var _loc4_:Variables = null;
         var _loc5_:Variables = null;
         _initData();
         if(_takeSample())
         {
            _loc2_ = new Variables();
            _loc2_.URIencode = true;
            _loc3_ = new EventInfo(true,_x10Module,param1);
            _loc4_ = _loc3_.toVariables();
            _loc5_ = _renderMetricsSearchVariables();
            _loc2_.join(_loc4_,_loc5_);
            _gifRequest.send(_account,_loc2_,false,true);
         }
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         _config.detectFlash = param1;
         _debug.info("setDetectFlash( " + _config.detectFlash + " )");
      }
      
      public function setCampNameKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCCN = param1;
         _loc2_ = "setCampNameKey( " + _config.campaignKey.UCCN + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCCN]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      private function _formatReferrer() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:URL = null;
         var _loc4_:URL = null;
         _loc1_ = _info.referrer;
         if(_loc1_ == "" || _loc1_ == "localhost")
         {
            _loc1_ = "-";
         }
         else
         {
            _loc2_ = _info.domainName;
            _loc3_ = new URL(_loc1_);
            _loc4_ = new URL("http://" + _loc2_);
            if(_loc3_.hostName == _loc2_)
            {
               return "-";
            }
            if(_loc4_.domain == _loc3_.domain)
            {
               if(_loc4_.subDomain != _loc3_.subDomain)
               {
                  _loc1_ = "0";
               }
            }
            if(_loc1_.charAt(0) == "[" && Boolean(_loc1_.charAt(_loc1_.length - 1)))
            {
               _loc1_ = "-";
            }
         }
         _debug.info("formated referrer: " + _loc1_,VisualDebugMode.advanced);
         return _loc1_;
      }
      
      private function _visitCode() : Number
      {
         if(_debug.verbose)
         {
            _debug.info("visitCode: " + _buffer.utma.sessionId,VisualDebugMode.geek);
         }
         return _buffer.utma.sessionId;
      }
      
      public function createEventTracker(param1:String) : EventTracker
      {
         _debug.info("createEventTracker( " + param1 + " )");
         return new EventTracker(param1,this);
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         _debug.warning("addItem( " + [param1,param2,param3,param4,param5,param6].join(", ") + " ) not implemented");
      }
      
      public function clearIgnoredOrganic() : void
      {
         _debug.info("clearIgnoredOrganic()");
         _config.organic.clearIgnoredKeywords();
      }
      
      public function setVar(param1:String) : void
      {
         var _loc2_:Variables = null;
         if(param1 != "" && _isNotGoogleSearch())
         {
            _initData();
            _buffer.utmv.domainHash = _domainHash;
            _buffer.utmv.value = param1;
            if(_debug.verbose)
            {
               _debug.info(_buffer.utmv.toString(),VisualDebugMode.geek);
            }
            _debug.info("setVar( " + param1 + " )");
            if(_takeSample())
            {
               _loc2_ = new Variables();
               _loc2_.utmt = "var";
               _gifRequest.send(_account,_loc2_);
            }
         }
         else
         {
            _debug.warning("setVar \"" + param1 + "\" is ignored");
         }
      }
      
      public function setDomainName(param1:String) : void
      {
         if(param1 == "auto")
         {
            _config.domain.mode = DomainNameMode.auto;
         }
         else if(param1 == "none")
         {
            _config.domain.mode = DomainNameMode.none;
         }
         else
         {
            _config.domain.mode = DomainNameMode.custom;
            _config.domain.name = param1;
         }
         _updateDomainName();
         _debug.info("setDomainName( " + _config.domainName + " )");
      }
      
      public function getClientInfo() : Boolean
      {
         _debug.info("getClientInfo()");
         return _config.detectClientInfo;
      }
      
      private function _updateDomainName() : void
      {
         var _loc1_:String = null;
         if(_config.domain.mode == DomainNameMode.auto)
         {
            _loc1_ = _info.domainName;
            if(_loc1_.substring(0,4) == "www.")
            {
               _loc1_ = _loc1_.substring(4);
            }
            _config.domain.name = _loc1_;
         }
         _config.domainName = _config.domain.name.toLowerCase();
         _debug.info("domain name: " + _config.domainName,VisualDebugMode.advanced);
      }
      
      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : Object
      {
         _debug.warning("addTrans( " + [param1,param2,param3,param4,param5,param6,param7,param8].join(", ") + " ) not implemented");
         return null;
      }
      
      public function setCampContentKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCCT = param1;
         _loc2_ = "setCampContentKey( " + _config.campaignKey.UCCT + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCCT]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      private function _handleCookie() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:Array = null;
         var _loc4_:* = null;
         if(_config.allowLinker)
         {
         }
         if(_buffer.hasUTMA() && !_buffer.utma.isEmpty())
         {
            if(!_buffer.hasUTMB() || !_buffer.hasUTMC())
            {
               _buffer.updateUTMA(_timeStamp);
               _noSessionInformation = true;
            }
            if(_debug.verbose)
            {
               _debug.info("from cookie " + _buffer.utma.toString(),VisualDebugMode.geek);
            }
         }
         else
         {
            _debug.info("create a new utma",VisualDebugMode.advanced);
            _buffer.utma.domainHash = _domainHash;
            _buffer.utma.sessionId = _getUniqueSessionId();
            _buffer.utma.firstTime = _timeStamp;
            _buffer.utma.lastTime = _timeStamp;
            _buffer.utma.currentTime = _timeStamp;
            _buffer.utma.sessionCount = 1;
            if(_debug.verbose)
            {
               _debug.info(_buffer.utma.toString(),VisualDebugMode.geek);
            }
            _noSessionInformation = true;
            _isNewVisitor = true;
         }
         if(Boolean(_adSense.gaGlobal) && _adSense.dh == String(_domainHash))
         {
            if(_adSense.sid)
            {
               _buffer.utma.currentTime = Number(_adSense.sid);
               if(_debug.verbose)
               {
                  _loc1_ = "";
                  _loc1_ += "AdSense sid found\n";
                  _loc1_ += "Override currentTime(" + _buffer.utma.currentTime + ") from AdSense sid(" + Number(_adSense.sid) + ")";
                  _debug.info(_loc1_,VisualDebugMode.geek);
               }
            }
            if(_isNewVisitor)
            {
               if(_adSense.sid)
               {
                  _buffer.utma.lastTime = Number(_adSense.sid);
                  if(_debug.verbose)
                  {
                     _loc2_ = "";
                     _loc2_ += "AdSense sid found (new visitor)\n";
                     _loc2_ += "Override lastTime(" + _buffer.utma.lastTime + ") from AdSense sid(" + Number(_adSense.sid) + ")";
                     _debug.info(_loc2_,VisualDebugMode.geek);
                  }
               }
               if(_adSense.vid)
               {
                  _loc3_ = _adSense.vid.split(".");
                  _buffer.utma.sessionId = Number(_loc3_[0]);
                  _buffer.utma.firstTime = Number(_loc3_[1]);
                  if(_debug.verbose)
                  {
                     _loc4_ = "";
                     _loc4_ = _loc4_ + "AdSense vid found (new visitor)\n";
                     _loc4_ = _loc4_ + ("Override sessionId(" + _buffer.utma.sessionId + ") from AdSense vid(" + Number(_loc3_[0]) + ")\n");
                     _loc4_ = _loc4_ + ("Override firstTime(" + _buffer.utma.firstTime + ") from AdSense vid(" + Number(_loc3_[1]) + ")");
                     _debug.info(_loc4_,VisualDebugMode.geek);
                  }
               }
               if(_debug.verbose)
               {
                  _debug.info("AdSense modified : " + _buffer.utma.toString(),VisualDebugMode.geek);
               }
            }
         }
         _buffer.utmb.domainHash = _domainHash;
         if(isNaN(_buffer.utmb.trackCount))
         {
            _buffer.utmb.trackCount = 0;
         }
         if(isNaN(_buffer.utmb.token))
         {
            _buffer.utmb.token = _config.tokenCliff;
         }
         if(isNaN(_buffer.utmb.lastTime))
         {
            _buffer.utmb.lastTime = _buffer.utma.currentTime;
         }
         _buffer.utmc.domainHash = _domainHash;
         if(_debug.verbose)
         {
            _debug.info(_buffer.utmb.toString(),VisualDebugMode.advanced);
            _debug.info(_buffer.utmc.toString(),VisualDebugMode.advanced);
         }
      }
      
      public function setLocalServerMode() : void
      {
         _config.serverMode = ServerOperationMode.local;
         _debug.info("setLocalServerMode()");
      }
      
      private function _renderMetricsSearchVariables(param1:String = "") : Variables
      {
         var _loc2_:Variables = null;
         var _loc3_:DocumentInfo = null;
         var _loc4_:Variables = null;
         var _loc5_:Variables = null;
         _loc2_ = new Variables();
         _loc2_.URIencode = true;
         _loc3_ = new DocumentInfo(_config,_info,_formatedReferrer,param1,_adSense);
         _debug.info("docInfo: " + _loc3_.toURLString(),VisualDebugMode.geek);
         if(_config.campaignTracking)
         {
            _loc4_ = _campaignInfo.toVariables();
         }
         _loc5_ = _browserInfo.toVariables();
         _loc2_.join(_loc3_.toVariables(),_loc5_,_loc4_);
         return _loc2_;
      }
      
      public function clearIgnoredRef() : void
      {
         _debug.info("clearIgnoredRef()");
         _config.organic.clearIgnoredReferrals();
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCSR = param1;
         _loc2_ = "setCampSourceKey( " + _config.campaignKey.UCSR + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCSR]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      public function getLocalGifPath() : String
      {
         _debug.info("getLocalGifPath()");
         return _config.localGIFpath;
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         _config.localGIFpath = param1;
         _debug.info("setLocalGifPath( " + _config.localGIFpath + " )");
      }
      
      public function getVersion() : String
      {
         _debug.info("getVersion()");
         return _config.version;
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         _config.allowAnchor = param1;
         _debug.info("setAllowAnchor( " + _config.allowAnchor + " )");
      }
      
      private function _isNotGoogleSearch() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         _loc1_ = _config.domainName;
         _loc2_ = _loc1_.indexOf("www.google.") < 0;
         _loc3_ = _loc1_.indexOf(".google.") < 0;
         _loc4_ = _loc1_.indexOf("google.") < 0;
         _loc5_ = _loc1_.indexOf("google.org") > -1;
         return _loc2_ || _loc3_ || _loc4_ || _config.cookiePath != "/" || _loc5_;
      }
      
      public function setSampleRate(param1:Number) : void
      {
         if(param1 < 0)
         {
            _debug.warning("sample rate can not be negative, ignoring value.");
         }
         else
         {
            _config.sampleRate = param1;
         }
         _debug.info("setSampleRate( " + _config.sampleRate + " )");
      }
      
      private function _takeSample() : Boolean
      {
         if(_debug.verbose)
         {
            _debug.info("takeSample: (" + _visitCode() % 10000 + ") < (" + _config.sampleRate * 10000 + ")",VisualDebugMode.geek);
         }
         return _visitCode() % 10000 < _config.sampleRate * 10000;
      }
      
      public function setCookiePath(param1:String) : void
      {
         _config.cookiePath = param1;
         _debug.info("setCookiePath( " + _config.cookiePath + " )");
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         _config.allowDomainHash = param1;
         _debug.info("setAllowHash( " + _config.allowDomainHash + " )");
      }
      
      private function _generateUserDataHash() : Number
      {
         var _loc1_:String = null;
         _loc1_ = "";
         _loc1_ += _info.appName;
         _loc1_ += _info.appVersion;
         _loc1_ += _info.language;
         _loc1_ += _info.platform;
         _loc1_ += _info.userAgent.toString();
         _loc1_ += _info.screenWidth + "x" + _info.screenHeight + _info.screenColorDepth;
         _loc1_ += _info.referrer;
         return Utils.generateHash(_loc1_);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         _debug.info("addIgnoredOrganic( " + param1 + " )");
         _config.organic.addIgnoredKeyword(param1);
      }
      
      public function setLocalRemoteServerMode() : void
      {
         _config.serverMode = ServerOperationMode.both;
         _debug.info("setLocalRemoteServerMode()");
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         _debug.warning("cookiePathCopy( " + param1 + " ) not implemented");
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         _config.detectTitle = param1;
         _debug.info("setDetectTitle( " + _config.detectTitle + " )");
      }
      
      public function setCampTermKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCTR = param1;
         _loc2_ = "setCampTermKey( " + _config.campaignKey.UCTR + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCTR]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         _debug.info("getServiceMode()");
         return _config.serverMode;
      }
      
      public function setCampNOKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCNO = param1;
         _loc2_ = "setCampNOKey( " + _config.campaignKey.UCNO + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCNO]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      private function _trackMetrics(param1:String = "") : void
      {
         var _loc2_:Variables = null;
         var _loc3_:Variables = null;
         var _loc4_:Variables = null;
         var _loc5_:EventInfo = null;
         if(_takeSample())
         {
            _loc2_ = new Variables();
            _loc2_.URIencode = true;
            if(Boolean(_x10Module) && _x10Module.hasData())
            {
               _loc5_ = new EventInfo(false,_x10Module);
               _loc3_ = _loc5_.toVariables();
            }
            _loc4_ = _renderMetricsSearchVariables(param1);
            _loc2_.join(_loc3_,_loc4_);
            _gifRequest.send(_account,_loc2_);
         }
      }
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         _config.campaignTracking = param1;
         _debug.info("setCampaignTrack( " + _config.campaignTracking + " )");
      }
      
      public function addIgnoredRef(param1:String) : void
      {
         _debug.info("addIgnoredRef( " + param1 + " )");
         _config.organic.addIgnoredReferral(param1);
      }
      
      public function clearOrganic() : void
      {
         _debug.info("clearOrganic()");
         _config.organic.clearEngines();
      }
      
      public function getDetectFlash() : Boolean
      {
         _debug.info("getDetectFlash()");
         return _config.detectFlash;
      }
      
      public function setCampMediumKey(param1:String) : void
      {
         var _loc2_:* = null;
         _config.campaignKey.UCMD = param1;
         _loc2_ = "setCampMediumKey( " + _config.campaignKey.UCMD + " )";
         if(_debug.mode == VisualDebugMode.geek)
         {
            _debug.info(_loc2_ + " [UCMD]");
         }
         else
         {
            _debug.info(_loc2_);
         }
      }
      
      private function _getUniqueSessionId() : Number
      {
         var _loc1_:Number = NaN;
         _loc1_ = (Utils.generate32bitRandom() ^ _generateUserDataHash()) * 2147483647;
         _debug.info("Session ID: " + _loc1_,VisualDebugMode.geek);
         return _loc1_;
      }
      
      private function _getDomainHash() : Number
      {
         if(!_config.domainName || _config.domainName == "" || _config.domain.mode == DomainNameMode.none)
         {
            _config.domainName = "";
            return 1;
         }
         _updateDomainName();
         if(_config.allowDomainHash)
         {
            return Utils.generateHash(_config.domainName);
         }
         return 1;
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         _config.sessionTimeout = param1;
         _debug.info("setSessionTimeout( " + _config.sessionTimeout + " )");
      }
      
      public function getAccount() : String
      {
         _debug.info("getAccount()");
         return _account;
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         _debug.warning("link( " + [param1,param2].join(", ") + " ) not implemented");
      }
      
      public function setRemoteServerMode() : void
      {
         _config.serverMode = ServerOperationMode.remote;
         _debug.info("setRemoteServerMode()");
      }
   }
}


package com.google.analytics.v4
{
   import com.google.analytics.core.EventTracker;
   import com.google.analytics.core.ServerOperationMode;
   import com.google.analytics.core.Utils;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.VisualDebugMode;
   import com.google.analytics.external.JavascriptProxy;
   
   public class Bridge implements GoogleAnalyticsAPI
   {
      
      private static var _checkGAJS_js:XML = <script>
            <![CDATA[
                function()
                {
                    if( _gat && _gat._getTracker )
                    {
                        return true;
                    }
                    return false;
                }
            ]]>
        </script>;
      
      private static var _checkValidTrackingObject_js:XML = <script>
            <![CDATA[
                function(acct)
                {
                    if( _GATracker[acct] && (_GATracker[acct]._getAccount) )
                    {
                        return true ;
                    }
                    else
                    {
                        return false;
                    }
                }
            ]]>
        </script>;
      
      private static var _createTrackingObject_js:XML = <script>
            <![CDATA[
                function( acct )
                {
                    _GATracker[acct] = _gat._getTracker(acct);
                }
            ]]>
        </script>;
      
      private static var _injectTrackingObject_js:XML = <script>
            <![CDATA[
                function()
                {
                    try 
                    {
                        _GATracker
                    }
                    catch(e) 
                    {
                        _GATracker = {};
                    }
                }
            ]]>
        </script>;
      
      private static var _linkTrackingObject_js:XML = <script>
            <![CDATA[
                function( container , target )
                {
                    var targets ;
                    var name ;
                    if( target.indexOf(".") > 0 )
                    {
                        targets = target.split(".");
                        name    = targets.pop();
                    }
                    else
                    {
                        targets = [];
                        name    = target;
                    }
                    var ref   = window;
                    var depth = targets.length;
                    for( var j = 0 ; j < depth ; j++ )
                    {
                        ref = ref[ targets[j] ] ;
                    }
                    window[container][target] = ref[name] ;
                }
            ]]>
        </script>;
      
      private var _debug:DebugConfiguration;
      
      private var _proxy:JavascriptProxy;
      
      private var _jsContainer:String = "_GATracker";
      
      private var _hasGATracker:Boolean = false;
      
      private var _account:String;
      
      public function Bridge(param1:String, param2:DebugConfiguration, param3:JavascriptProxy)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _hasGATracker = false;
         _jsContainer = "_GATracker";
         super();
         _account = param1;
         _debug = param2;
         _proxy = param3;
         if(!_checkGAJS())
         {
            _loc4_ = "";
            _loc4_ = _loc4_ + "ga.js not found, be sure to check if\n";
            _loc4_ = _loc4_ + "<script src=\"http://www.google-analytics.com/ga.js\"></script>\n";
            _loc4_ = _loc4_ + "is included in the HTML.";
            _debug.warning(_loc4_);
            throw new Error(_loc4_);
         }
         if(!_hasGATracker)
         {
            if(_debug.javascript && _debug.verbose)
            {
               _loc5_ = "";
               _loc5_ = _loc5_ + "The Google Analytics tracking code was not found on the container page\n";
               _loc5_ = _loc5_ + "we create it";
               _debug.info(_loc5_,VisualDebugMode.advanced);
            }
            _injectTrackingObject();
         }
         if(Utils.validateAccount(param1))
         {
            _createTrackingObject(param1);
         }
         else
         {
            if(!_checkTrackingObject(param1))
            {
               _loc6_ = "";
               _loc6_ = _loc6_ + ("JS Object \"" + param1 + "\" doesn\'t exist in DOM\n");
               _loc6_ = _loc6_ + "Bridge object not created.";
               _debug.warning(_loc6_);
               throw new Error(_loc6_);
            }
            _linkTrackingObject(param1);
         }
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         _debug.info("link( " + param1 + ", " + param2 + " )");
         _call("_link",param1,param2);
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         _debug.info("addOrganic( " + [param1,param2].join(", ") + " )");
         _call("_addOrganic",param1);
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         _debug.info("setAllowLinker( " + param1 + " )");
         _call("_setAllowLinker",param1);
      }
      
      private function _linkTrackingObject(param1:String) : void
      {
         _proxy.call(_linkTrackingObject_js,_jsContainer,param1);
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         _debug.info("setClientInfo( " + param1 + " )");
         _call("_setClientInfo",param1);
      }
      
      public function trackTrans() : void
      {
         _debug.info("trackTrans()");
         _call("_trackTrans");
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         var _loc5_:int = 0;
         _loc5_ = 2;
         if(Boolean(param3) && param3 != "")
         {
            _loc5_ = 3;
         }
         if(_loc5_ == 3 && !isNaN(param4))
         {
            _loc5_ = 4;
         }
         switch(_loc5_)
         {
            case 4:
               _debug.info("trackEvent( " + [param1,param2,param3,param4].join(", ") + " )");
               return _call("_trackEvent",param1,param2,param3,param4);
            case 3:
               _debug.info("trackEvent( " + [param1,param2,param3].join(", ") + " )");
               return _call("_trackEvent",param1,param2,param3);
            case 2:
         }
         _debug.info("trackEvent( " + [param1,param2].join(", ") + " )");
         return _call("_trackEvent",param1,param2);
      }
      
      public function trackPageview(param1:String = "") : void
      {
         _debug.info("trackPageview( " + param1 + " )");
         _call("_trackPageview",param1);
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         _debug.info("setCookieTimeout( " + param1 + " )");
         _call("_setCookieTimeout",param1);
      }
      
      private function _checkValidTrackingObject(param1:String) : Boolean
      {
         return _proxy.call(_checkValidTrackingObject_js,param1);
      }
      
      private function _checkGAJS() : Boolean
      {
         return _proxy.call(_checkGAJS_js);
      }
      
      public function linkByPost(param1:Object, param2:Boolean = false) : void
      {
         _debug.warning("linkByPost( " + param1 + ", " + param2 + " ) not implemented");
      }
      
      public function getClientInfo() : Boolean
      {
         _debug.info("getClientInfo()");
         return _call("_getClientInfo");
      }
      
      private function _call(param1:String, ... rest) : *
      {
         rest.unshift("window." + _jsContainer + "[\"" + _account + "\"]." + param1);
         return _proxy.call.apply(_proxy,rest);
      }
      
      public function hasGAJS() : Boolean
      {
         return _checkGAJS();
      }
      
      private function _checkTrackingObject(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc2_ = _proxy.hasProperty(param1);
         _loc3_ = _proxy.hasProperty(param1 + "._getAccount");
         return _loc2_ && _loc3_;
      }
      
      public function resetSession() : void
      {
         _debug.warning("resetSession() not implemented");
      }
      
      public function getDetectTitle() : Boolean
      {
         _debug.info("getDetectTitle()");
         return _call("_getDetectTitle");
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         _debug.info("setDetectFlash( " + param1 + " )");
         _call("_setDetectFlash",param1);
      }
      
      public function setCampNameKey(param1:String) : void
      {
         _debug.info("setCampNameKey( " + param1 + " )");
         _call("_setCampNameKey",param1);
      }
      
      public function createEventTracker(param1:String) : EventTracker
      {
         _debug.info("createEventTracker( " + param1 + " )");
         return new EventTracker(param1,this);
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         _debug.info("addItem( " + [param1,param2,param3,param4,param5,param6].join(", ") + " )");
         _call("_addItem",param1,param2,param3,param4,param5,param6);
      }
      
      public function clearIgnoredOrganic() : void
      {
         _debug.info("clearIgnoredOrganic()");
         _call("_clearIgnoreOrganic");
      }
      
      public function setVar(param1:String) : void
      {
         _debug.info("setVar( " + param1 + " )");
         _call("_setVar",param1);
      }
      
      public function setDomainName(param1:String) : void
      {
         _debug.info("setDomainName( " + param1 + " )");
         _call("_setDomainName",param1);
      }
      
      public function hasTrackingAccount(param1:String) : Boolean
      {
         if(Utils.validateAccount(param1))
         {
            return _checkValidTrackingObject(param1);
         }
         return _checkTrackingObject(param1);
      }
      
      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : Object
      {
         _debug.info("addTrans( " + [param1,param2,param3,param4,param5,param6,param7,param8].join(", ") + " )");
         _call("_addTrans",param1,param2,param3,param4,param5,param6,param7,param8);
         return null;
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         _debug.info("setCampSourceKey( " + param1 + " )");
         _call("_setCampSourceKey",param1);
      }
      
      public function setCampContentKey(param1:String) : void
      {
         _debug.info("setCampContentKey( " + param1 + " )");
         _call("_setCampContentKey",param1);
      }
      
      public function clearIgnoredRef() : void
      {
         _debug.info("clearIgnoredRef()");
         _call("_clearIgnoreRef");
      }
      
      public function setLocalServerMode() : void
      {
         _debug.info("setLocalServerMode()");
         _call("_setLocalServerMode");
      }
      
      public function getLocalGifPath() : String
      {
         _debug.info("getLocalGifPath()");
         return _call("_getLocalGifPath");
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         _debug.info("setAllowAnchor( " + param1 + " )");
         _call("_setAllowAnchor",param1);
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         _debug.info("setLocalGifPath( " + param1 + " )");
         _call("_setLocalGifPath",param1);
      }
      
      public function getVersion() : String
      {
         _debug.info("getVersion()");
         return _call("_getVersion");
      }
      
      private function _injectTrackingObject() : void
      {
         _proxy.executeBlock(_injectTrackingObject_js);
         _hasGATracker = true;
      }
      
      public function setCookiePath(param1:String) : void
      {
         _debug.info("setCookiePath( " + param1 + " )");
         _call("_setCookiePath",param1);
      }
      
      public function setSampleRate(param1:Number) : void
      {
         _debug.info("setSampleRate( " + param1 + " )");
         _call("_setSampleRate",param1);
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         _debug.info("setAllowHash( " + param1 + " )");
         _call("_setAllowHash",param1);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         _debug.info("addIgnoredOrganic( " + param1 + " )");
         _call("_addIgnoredOrganic",param1);
      }
      
      public function setCampNOKey(param1:String) : void
      {
         _debug.info("setCampNOKey( " + param1 + " )");
         _call("_setCampNOKey",param1);
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         _debug.info("cookiePathCopy( " + param1 + " )");
         _call("_cookiePathCopy",param1);
      }
      
      public function setLocalRemoteServerMode() : void
      {
         _debug.info("setLocalRemoteServerMode()");
         _call("_setLocalRemoteServerMode");
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         _debug.info("getServiceMode()");
         return _call("_getServiceMode");
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         _debug.info("setDetectTitle( " + param1 + " )");
         _call("_setDetectTitle",param1);
      }
      
      public function setCampTermKey(param1:String) : void
      {
         _debug.info("setCampTermKey( " + param1 + " )");
         _call("_setCampTermKey",param1);
      }
      
      private function _createTrackingObject(param1:String) : void
      {
         _proxy.call(_createTrackingObject_js,param1);
      }
      
      public function getDetectFlash() : Boolean
      {
         _debug.info("getDetectFlash()");
         return _call("_getDetectFlash");
      }
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         _debug.info("setCampaignTrack( " + param1 + " )");
         _call("_setCampaignTrack",param1);
      }
      
      public function clearOrganic() : void
      {
         _debug.info("clearOrganic()");
         _call("_clearOrganic");
      }
      
      public function addIgnoredRef(param1:String) : void
      {
         _debug.info("addIgnoredRef( " + param1 + " )");
         _call("_addIgnoredRef",param1);
      }
      
      public function setCampMediumKey(param1:String) : void
      {
         _debug.info("setCampMediumKey( " + param1 + " )");
         _call("_setCampMediumKey",param1);
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         _debug.info("setSessionTimeout( " + param1 + " )");
         _call("_setSessionTimeout",param1);
      }
      
      public function setRemoteServerMode() : void
      {
         _debug.info("setRemoteServerMode()");
         _call("_setRemoteServerMode");
      }
      
      public function getAccount() : String
      {
         _debug.info("getAccount()");
         return _call("_getAccount");
      }
   }
}


package com.google.analytics.v4
{
   import com.google.analytics.core.EventTracker;
   import com.google.analytics.core.ServerOperationMode;
   
   public interface GoogleAnalyticsAPI
   {
      
      function getServiceMode() : ServerOperationMode;
      
      function setLocalRemoteServerMode() : void;
      
      function setCampSourceKey(param1:String) : void;
      
      function setCampContentKey(param1:String) : void;
      
      function addOrganic(param1:String, param2:String) : void;
      
      function setDetectFlash(param1:Boolean) : void;
      
      function resetSession() : void;
      
      function setCampTermKey(param1:String) : void;
      
      function setCampNameKey(param1:String) : void;
      
      function addIgnoredOrganic(param1:String) : void;
      
      function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void;
      
      function setAllowLinker(param1:Boolean) : void;
      
      function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : Object;
      
      function getDetectFlash() : Boolean;
      
      function setCampaignTrack(param1:Boolean) : void;
      
      function createEventTracker(param1:String) : EventTracker;
      
      function setCookieTimeout(param1:int) : void;
      
      function setAllowAnchor(param1:Boolean) : void;
      
      function trackTrans() : void;
      
      function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean;
      
      function trackPageview(param1:String = "") : void;
      
      function setLocalGifPath(param1:String) : void;
      
      function getVersion() : String;
      
      function getLocalGifPath() : String;
      
      function setVar(param1:String) : void;
      
      function clearIgnoredOrganic() : void;
      
      function setCampMediumKey(param1:String) : void;
      
      function addIgnoredRef(param1:String) : void;
      
      function setClientInfo(param1:Boolean) : void;
      
      function setCookiePath(param1:String) : void;
      
      function setSampleRate(param1:Number) : void;
      
      function setSessionTimeout(param1:int) : void;
      
      function setRemoteServerMode() : void;
      
      function clearIgnoredRef() : void;
      
      function linkByPost(param1:Object, param2:Boolean = false) : void;
      
      function setLocalServerMode() : void;
      
      function setDetectTitle(param1:Boolean) : void;
      
      function setAllowHash(param1:Boolean) : void;
      
      function clearOrganic() : void;
      
      function getAccount() : String;
      
      function setDomainName(param1:String) : void;
      
      function link(param1:String, param2:Boolean = false) : void;
      
      function setCampNOKey(param1:String) : void;
      
      function getClientInfo() : Boolean;
      
      function cookiePathCopy(param1:String) : void;
      
      function getDetectTitle() : Boolean;
   }
}


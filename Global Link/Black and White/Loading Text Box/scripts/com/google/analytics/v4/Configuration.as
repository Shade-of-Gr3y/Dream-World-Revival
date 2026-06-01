package com.google.analytics.v4
{
   import com.google.analytics.campaign.CampaignKey;
   import com.google.analytics.core.Domain;
   import com.google.analytics.core.DomainNameMode;
   import com.google.analytics.core.Organic;
   import com.google.analytics.core.ServerOperationMode;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.utils.Timespan;
   
   public class Configuration
   {
      
      public var serverMode:ServerOperationMode = ServerOperationMode.remote;
      
      public var detectFlash:Boolean = true;
      
      public var allowLocalTracking:Boolean = true;
      
      public var secureRemoteGIFpath:String = "https://ssl.google-analytics.com/__utm.gif";
      
      public var hasSiteOverlay:Boolean = false;
      
      private var _version:String = "4.3as";
      
      public var allowDomainHash:Boolean = true;
      
      public var detectClientInfo:Boolean = true;
      
      public var idleLoop:Number = 30;
      
      public var isTrackOutboundSubdomains:Boolean = false;
      
      public var cookiePath:String = "/";
      
      public var transactionFieldDelim:String = "|";
      
      private var _organic:Organic = new Organic();
      
      private var _cookieName:String = "analytics";
      
      public var campaignKey:CampaignKey = new CampaignKey();
      
      public var google:String = "google";
      
      public var googleCsePath:String = "cse";
      
      public var bucketCapacity:Number = 10;
      
      private var _sampleRate:Number = 1;
      
      public var remoteGIFpath:String = "http://www.google-analytics.com/__utm.gif";
      
      public var googleSearchParam:String = "q";
      
      public var allowLinker:Boolean = false;
      
      public var maxOutboundLinkExamined:Number = 1000;
      
      private var _debug:DebugConfiguration;
      
      private var _trackingLimitPerSession:int = 500;
      
      private var _domain:Domain;
      
      public var allowAnchor:Boolean = false;
      
      public var tokenCliff:int = 10;
      
      public var sessionTimeout:Number = Timespan.thirtyminutes;
      
      public var idleTimeout:Number = 60;
      
      public var campaignTracking:Boolean = true;
      
      public var domainName:String = "";
      
      public var detectTitle:Boolean = true;
      
      public var tokenRate:Number = 0.2;
      
      public var conversionTimeout:Number = Timespan.sixmonths;
      
      public var localGIFpath:String = "/__utm.gif";
      
      public function Configuration(param1:DebugConfiguration = null)
      {
         super();
         _debug = param1;
         _domain = new Domain(DomainNameMode.auto,"",_debug);
         serverMode = ServerOperationMode.remote;
         _initOrganicSources();
      }
      
      public function get organic() : Organic
      {
         return _organic;
      }
      
      public function get trackingLimitPerSession() : int
      {
         return _trackingLimitPerSession;
      }
      
      private function _initOrganicSources() : void
      {
         addOrganicSource(google,googleSearchParam);
         addOrganicSource("yahoo","p");
         addOrganicSource("msn","q");
         addOrganicSource("aol","query");
         addOrganicSource("aol","encquery");
         addOrganicSource("lycos","query");
         addOrganicSource("ask","q");
         addOrganicSource("altavista","q");
         addOrganicSource("netscape","query");
         addOrganicSource("cnn","query");
         addOrganicSource("looksmart","qt");
         addOrganicSource("about","terms");
         addOrganicSource("mamma","query");
         addOrganicSource("alltheweb","q");
         addOrganicSource("gigablast","q");
         addOrganicSource("voila","rdata");
         addOrganicSource("virgilio","qs");
         addOrganicSource("live","q");
         addOrganicSource("baidu","wd");
         addOrganicSource("alice","qs");
         addOrganicSource("yandex","text");
         addOrganicSource("najdi","q");
         addOrganicSource("aol","q");
         addOrganicSource("club-internet","q");
         addOrganicSource("mama","query");
         addOrganicSource("seznam","q");
         addOrganicSource("search","q");
         addOrganicSource("wp","szukaj");
         addOrganicSource("onet","qt");
         addOrganicSource("netsprint","q");
         addOrganicSource("google.interia","q");
         addOrganicSource("szukacz","q");
         addOrganicSource("yam","k");
         addOrganicSource("pchome","q");
         addOrganicSource("kvasir","searchExpr");
         addOrganicSource("sesam","q");
         addOrganicSource("ozu","q");
         addOrganicSource("terra","query");
         addOrganicSource("nostrum","query");
         addOrganicSource("mynet","q");
         addOrganicSource("ekolay","q");
         addOrganicSource("search.ilse","search_for");
      }
      
      public function get sampleRate() : Number
      {
         return _sampleRate;
      }
      
      public function get cookieName() : String
      {
         return _cookieName;
      }
      
      public function addOrganicSource(param1:String, param2:String) : void
      {
         var engine:String = param1;
         var keyword:String = param2;
         try
         {
            _organic.addSource(engine,keyword);
         }
         catch(e:Error)
         {
            if(Boolean(_debug) && _debug.active)
            {
               _debug.warning(e.message);
            }
         }
      }
      
      public function get domain() : Domain
      {
         return _domain;
      }
      
      public function set sampleRate(param1:Number) : void
      {
         if(param1 <= 0)
         {
            param1 = 0.1;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         param1 = Number(param1.toFixed(2));
         _sampleRate = param1;
      }
      
      public function get version() : String
      {
         return _version;
      }
   }
}


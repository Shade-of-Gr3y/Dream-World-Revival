package com.google.analytics.external
{
   import com.google.analytics.debug.DebugConfiguration;
   
   public class HTMLDOM extends JavascriptProxy
   {
      
      public static var cache_properties_js:XML = <script>
            <![CDATA[
                    function()
                    {
                        var obj = {};
                            obj.host         = document.location.host;
                            obj.language     = navigator.language ? navigator.language : navigator.browserLanguage;
                            obj.characterSet = document.characterSet ? document.characterSet : document.charset;
                            obj.colorDepth   = window.screen.colorDepth;
                            obj.location     = document.location.toString();
                            obj.pathname     = document.location.pathname;
                            obj.protocol     = document.location.protocol;
                            obj.search       = document.location.search;
                            obj.referrer     = document.referrer;
                            obj.title        = document.title;
                        
                        return obj;
                    }
                ]]>
         </script>;
      
      private var _referrer:String;
      
      private var _protocol:String;
      
      private var _host:String;
      
      private var _location:String;
      
      private var _pathname:String;
      
      private var _title:String;
      
      private var _characterSet:String;
      
      private var _search:String;
      
      private var _language:String;
      
      private var _colorDepth:String;
      
      public function HTMLDOM(param1:DebugConfiguration)
      {
         super(param1);
      }
      
      public function get search() : String
      {
         if(_search)
         {
            return _search;
         }
         if(!isAvailable())
         {
            return null;
         }
         _search = getProperty("document.location.search");
         return _search;
      }
      
      public function get location() : String
      {
         if(_location)
         {
            return _location;
         }
         if(!isAvailable())
         {
            return null;
         }
         _location = getPropertyString("document.location");
         return _location;
      }
      
      public function get pathname() : String
      {
         if(_pathname)
         {
            return _pathname;
         }
         if(!isAvailable())
         {
            return null;
         }
         _pathname = getProperty("document.location.pathname");
         return _pathname;
      }
      
      public function get referrer() : String
      {
         if(_referrer)
         {
            return _referrer;
         }
         if(!isAvailable())
         {
            return null;
         }
         _referrer = getProperty("document.referrer");
         return _referrer;
      }
      
      public function get protocol() : String
      {
         if(_protocol)
         {
            return _protocol;
         }
         if(!isAvailable())
         {
            return null;
         }
         _protocol = getProperty("document.location.protocol");
         return _protocol;
      }
      
      public function cacheProperties() : void
      {
         var _loc1_:Object = null;
         if(!isAvailable())
         {
            return;
         }
         _loc1_ = call(cache_properties_js);
         if(_loc1_)
         {
            _host = _loc1_.host;
            _language = _loc1_.language;
            _characterSet = _loc1_.characterSet;
            _colorDepth = _loc1_.colorDepth;
            _location = _loc1_.location;
            _pathname = _loc1_.pathname;
            _protocol = _loc1_.protocol;
            _search = _loc1_.search;
            _referrer = _loc1_.referrer;
            _title = _loc1_.title;
         }
      }
      
      public function get colorDepth() : String
      {
         if(_colorDepth)
         {
            return _colorDepth;
         }
         if(!isAvailable())
         {
            return null;
         }
         _colorDepth = getProperty("window.screen.colorDepth");
         return _colorDepth;
      }
      
      public function get title() : String
      {
         if(_title)
         {
            return _title;
         }
         if(!isAvailable())
         {
            return null;
         }
         _title = getProperty("document.title");
         return _title;
      }
      
      public function get host() : String
      {
         if(_host)
         {
            return _host;
         }
         if(!isAvailable())
         {
            return null;
         }
         _host = getProperty("document.location.host");
         return _host;
      }
      
      public function get characterSet() : String
      {
         var _loc1_:String = null;
         if(_characterSet)
         {
            return _characterSet;
         }
         if(!isAvailable())
         {
            return null;
         }
         _loc1_ = getProperty("document.characterSet");
         if(_loc1_ == null)
         {
            _loc1_ = getProperty("document.charset");
         }
         _characterSet = _loc1_;
         return _characterSet;
      }
      
      public function get language() : String
      {
         var _loc1_:String = null;
         if(_language)
         {
            return _language;
         }
         if(!isAvailable())
         {
            return null;
         }
         _loc1_ = getProperty("navigator.language");
         if(_loc1_ == null)
         {
            _loc1_ = getProperty("navigator.browserLanguage");
         }
         _language = _loc1_;
         return _language;
      }
   }
}


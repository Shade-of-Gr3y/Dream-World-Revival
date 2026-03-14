package com.google.analytics.utils
{
   public class URL
   {
      
      private var _url:String;
      
      public function URL(param1:String = "")
      {
         super();
         _url = param1.toLowerCase();
      }
      
      public function get domain() : String
      {
         var _loc1_:Array = null;
         if(hostName != "" && hostName.indexOf(".") > -1)
         {
            _loc1_ = hostName.split(".");
            switch(_loc1_.length)
            {
               case 2:
                  return hostName;
               case 3:
                  if(_loc1_[1] == "co")
                  {
                     return hostName;
                  }
                  _loc1_.shift();
                  return _loc1_.join(".");
                  break;
               case 4:
                  _loc1_.shift();
                  return _loc1_.join(".");
            }
         }
         return "";
      }
      
      public function get path() : String
      {
         var _loc1_:String = null;
         _loc1_ = _url;
         if(_loc1_.indexOf("://") > -1)
         {
            _loc1_ = _loc1_.split("://")[1];
         }
         if(_loc1_.indexOf(hostName) == 0)
         {
            _loc1_ = _loc1_.substr(hostName.length);
         }
         if(_loc1_.indexOf("?") > -1)
         {
            _loc1_ = _loc1_.split("?")[0];
         }
         if(_loc1_.charAt(0) != "/")
         {
            _loc1_ = "/" + _loc1_;
         }
         return _loc1_;
      }
      
      public function get search() : String
      {
         var _loc1_:String = null;
         _loc1_ = _url;
         if(_loc1_.indexOf("://") > -1)
         {
            _loc1_ = _loc1_.split("://")[1];
         }
         if(_loc1_.indexOf(hostName) == 0)
         {
            _loc1_ = _loc1_.substr(hostName.length);
         }
         if(_loc1_.indexOf("?") > -1)
         {
            _loc1_ = _loc1_.split("?")[1];
         }
         else
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public function get subDomain() : String
      {
         if(domain != "" && domain != hostName)
         {
            return hostName.split("." + domain).join("");
         }
         return "";
      }
      
      public function get protocol() : Protocols
      {
         var _loc1_:String = null;
         _loc1_ = _url.split("://")[0];
         switch(_loc1_)
         {
            case "file":
               return Protocols.file;
            case "http":
               return Protocols.HTTP;
            case "https":
               return Protocols.HTTPS;
            default:
               return Protocols.none;
         }
      }
      
      public function get hostName() : String
      {
         var _loc1_:String = null;
         _loc1_ = _url;
         if(_loc1_.indexOf("://") > -1)
         {
            _loc1_ = _loc1_.split("://")[1];
         }
         if(_loc1_.indexOf("/") > -1)
         {
            _loc1_ = _loc1_.split("/")[0];
         }
         if(_loc1_.indexOf("?") > -1)
         {
            _loc1_ = _loc1_.split("?")[0];
         }
         if(protocol == Protocols.file || protocol == Protocols.none)
         {
            return "";
         }
         return _loc1_;
      }
   }
}


package com.google.analytics.utils
{
   import com.google.analytics.core.Utils;
   import flash.system.Capabilities;
   import flash.system.System;
   
   public class UserAgent
   {
      
      public static var minimal:Boolean = false;
      
      private var _version:Version;
      
      private var _localInfo:Environment;
      
      private var _applicationProduct:String;
      
      public function UserAgent(param1:Environment, param2:String = "", param3:String = "")
      {
         super();
         _localInfo = param1;
         applicationProduct = param2;
         _version = Version.fromString(param3);
      }
      
      public function get tamarinProductToken() : String
      {
         if(UserAgent.minimal)
         {
            return "";
         }
         if(System.vmVersion)
         {
            return "Tamarin/" + Utils.trim(System.vmVersion,true);
         }
         return "";
      }
      
      public function set applicationProduct(param1:String) : void
      {
         _applicationProduct = param1;
      }
      
      public function get applicationVersion() : String
      {
         return _version.toString(2);
      }
      
      public function get applicationProductToken() : String
      {
         var _loc1_:String = null;
         _loc1_ = applicationProduct;
         if(applicationVersion != "")
         {
            _loc1_ += "/" + applicationVersion;
         }
         return _loc1_;
      }
      
      public function get vendorProductToken() : String
      {
         var _loc1_:* = null;
         _loc1_ = "";
         if(_localInfo.isAIR())
         {
            _loc1_ += "AIR";
         }
         else
         {
            _loc1_ += "FlashPlayer";
         }
         _loc1_ += "/";
         return _loc1_ + _version.toString(3);
      }
      
      public function toString() : String
      {
         var _loc1_:String = null;
         _loc1_ = "";
         _loc1_ += applicationProductToken;
         if(applicationComment != "")
         {
            _loc1_ += " " + applicationComment;
         }
         if(tamarinProductToken != "")
         {
            _loc1_ += " " + tamarinProductToken;
         }
         if(vendorProductToken != "")
         {
            _loc1_ += " " + vendorProductToken;
         }
         return _loc1_;
      }
      
      public function get applicationComment() : String
      {
         var _loc1_:Array = null;
         _loc1_ = [];
         _loc1_.push(_localInfo.platform);
         _loc1_.push(_localInfo.playerType);
         if(!UserAgent.minimal)
         {
            _loc1_.push(_localInfo.operatingSystem);
            _loc1_.push(_localInfo.language);
         }
         if(Capabilities.isDebugger)
         {
            _loc1_.push("DEBUG");
         }
         if(_loc1_.length > 0)
         {
            return "(" + _loc1_.join("; ") + ")";
         }
         return "";
      }
      
      public function set applicationVersion(param1:String) : void
      {
         _version = Version.fromString(param1);
      }
      
      public function get applicationProduct() : String
      {
         return _applicationProduct;
      }
   }
}


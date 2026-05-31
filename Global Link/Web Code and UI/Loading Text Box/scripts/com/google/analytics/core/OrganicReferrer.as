package com.google.analytics.core
{
   public class OrganicReferrer
   {
      
      private var _engine:String;
      
      private var _keyword:String;
      
      public function OrganicReferrer(param1:String, param2:String)
      {
         super();
         this.engine = param1;
         this.keyword = param2;
      }
      
      public function set engine(param1:String) : void
      {
         _engine = param1.toLowerCase();
      }
      
      public function get keyword() : String
      {
         return _keyword;
      }
      
      public function toString() : String
      {
         return engine + "?" + keyword;
      }
      
      public function get engine() : String
      {
         return _engine;
      }
      
      public function set keyword(param1:String) : void
      {
         _keyword = param1.toLowerCase();
      }
   }
}


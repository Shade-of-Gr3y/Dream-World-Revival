package com.google.analytics.data
{
   public interface Cookie
   {
      
      function toURLString() : String;
      
      function toSharedObject() : Object;
      
      function set creation(param1:Date) : void;
      
      function fromSharedObject(param1:Object) : void;
      
      function get expiration() : Date;
      
      function isExpired() : Boolean;
      
      function set expiration(param1:Date) : void;
      
      function get creation() : Date;
   }
}


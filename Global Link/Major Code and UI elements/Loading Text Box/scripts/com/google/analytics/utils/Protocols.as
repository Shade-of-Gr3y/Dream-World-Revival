package com.google.analytics.utils
{
   public class Protocols
   {
      
      public static const none:Protocols = new Protocols(0,"none");
      
      public static const file:Protocols = new Protocols(1,"file");
      
      public static const HTTP:Protocols = new Protocols(2,"HTTP");
      
      public static const HTTPS:Protocols = new Protocols(3,"HTTPS");
      
      private var _value:int;
      
      private var _name:String;
      
      public function Protocols(param1:int = 0, param2:String = "")
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function valueOf() : int
      {
         return _value;
      }
      
      public function toString() : String
      {
         return _name;
      }
   }
}


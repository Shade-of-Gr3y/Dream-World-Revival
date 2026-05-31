package com.google.analytics.core
{
   public class ServerOperationMode
   {
      
      public static const local:ServerOperationMode = new ServerOperationMode(0,"local");
      
      public static const remote:ServerOperationMode = new ServerOperationMode(1,"remote");
      
      public static const both:ServerOperationMode = new ServerOperationMode(2,"both");
      
      private var _value:int;
      
      private var _name:String;
      
      public function ServerOperationMode(param1:int = 0, param2:String = "")
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


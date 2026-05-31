package com.google.analytics.debug
{
   public class VisualDebugMode
   {
      
      public static const basic:VisualDebugMode = new VisualDebugMode(0,"basic");
      
      public static const advanced:VisualDebugMode = new VisualDebugMode(1,"advanced");
      
      public static const geek:VisualDebugMode = new VisualDebugMode(2,"geek");
      
      private var _value:int;
      
      private var _name:String;
      
      public function VisualDebugMode(param1:int = 0, param2:String = "")
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


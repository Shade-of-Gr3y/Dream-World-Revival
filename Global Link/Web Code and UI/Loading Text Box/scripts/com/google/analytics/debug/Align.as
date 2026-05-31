package com.google.analytics.debug
{
   public class Align
   {
      
      public static const none:Align = new Align(0,"none");
      
      public static const top:Align = new Align(1,"top");
      
      public static const bottom:Align = new Align(2,"bottom");
      
      public static const right:Align = new Align(16,"right");
      
      public static const left:Align = new Align(32,"left");
      
      public static const center:Align = new Align(256,"center");
      
      public static const topLeft:Align = new Align(33,"topLeft");
      
      public static const topRight:Align = new Align(17,"topRight");
      
      public static const bottomLeft:Align = new Align(34,"bottomLeft");
      
      public static const bottomRight:Align = new Align(18,"bottomRight");
      
      private var _value:int;
      
      private var _name:String;
      
      public function Align(param1:int = 0, param2:String = "")
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


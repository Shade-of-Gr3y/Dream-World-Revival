package com.adobe.serialization.json
{
   public class JSON
   {
      
      public function JSON()
      {
         super();
      }
      
      public static function decode(s:String) : *
      {
         var decoder:JSONDecoder = new JSONDecoder(s);
         return decoder.getValue();
      }
      
      public static function encode(o:Object) : String
      {
         var encoder:JSONEncoder = new JSONEncoder(o);
         return encoder.getString();
      }
   }
}


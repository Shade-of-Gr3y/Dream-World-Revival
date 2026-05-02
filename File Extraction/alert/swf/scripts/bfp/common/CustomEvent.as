package bfp.common
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const CUSTOM_EVENT:String = "CUSTOM_EVENT";
      
      private var _data:Object;
      
      public function CustomEvent(type:String, data:Object = null)
      {
         this._data = data;
         super(type);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}


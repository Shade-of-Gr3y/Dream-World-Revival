package bfp.common
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const CUSTOM_EVENT:String = "CUSTOM_EVENT";
       
      
      private var _data:Object;
      
      public function CustomEvent(param1:String, param2:Object = null)
      {
         this._data = param2;
         super(param1);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

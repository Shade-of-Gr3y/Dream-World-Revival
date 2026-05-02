package bfp.pokemon.liby.event
{
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public static const ON_CUSTOM_EVENT:String = "onCustomEvent";
      
      public var obj:Object;
      
      public function CustomEvent(param1:String, param2:Object = null)
      {
         this.obj = param2;
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new CustomEvent(type,this.obj);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomEvent","type","bubbles","cancelable","eventPhase","obj");
      }
   }
}


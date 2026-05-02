package bfp
{
   import flash.events.Event;
   
   public class PDWTutorialEvent extends Event
   {
      
      public static const MAKOMO_CHANGE_STATE_START:String = "makomo_changeStateStart";
      
      public static const MAKOMO_CHANGE_STATE_COMPLETE:String = "makomo_changeStateComplete";
      
      public static const MESSAGE_CHANGE:String = "tutorialMessage_change";
      
      public static const MESSAGE_COMPLETE:String = "tutorialMessage_complete";
      
      public static const MESSAGE_BUTTON_CLICK:String = "tutorialMessage_buttonClick";
      
      public static const MESSAGE_LINK_CLICK:String = "tutorialMessage_linkClick";
      
      public static const TUTORIAL_RESUME:String = "tutorialMessage_resume";
      
      public static const LOAD_COMPLETE:String = "tutorialEvent_loadComplete";
      
      private var _data:Object;
      
      public function PDWTutorialEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.data = data;
      }
      
      override public function clone() : Event
      {
         return new PDWTutorialEvent(type,this.data,bubbles,cancelable);
      }
      
      public function set data(value:Object) : void
      {
         this._data = value;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}


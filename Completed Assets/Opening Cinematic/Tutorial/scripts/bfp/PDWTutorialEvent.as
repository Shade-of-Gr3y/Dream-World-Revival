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
      
      public function PDWTutorialEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new PDWTutorialEvent(type,this.data,bubbles,cancelable);
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

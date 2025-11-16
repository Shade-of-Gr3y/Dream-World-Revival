package bfp.common
{
   import flash.events.Event;
   
   public class LoadingEvent extends Event
   {
      
      public static const SEND_PERCENT:String = "onSendPercent";
      
      public static const SHOW_LOADING:String = "onShowLoading";
      
      public static const GENERAL_LOADING_COVER_SHOW_FINISH:String = "onGeneralLoadingCoverShowFinish";
      
      public static const GENERAL_LOADING_BAR_SHOW_FINISH:String = "onGeneralLoadingBarShowFinish";
      
      public static const HIDE_LOADING:String = "onHideLoading";
      
      public static const GENERAL_LOADING_COVER_HIDE_FINISH:String = "onGeneralLoadingCoverHideFinish";
      
      public static const GENERAL_LOADING_BAR_HIDE_FINISH:String = "onGeneralLoadingBarHideFinish";
      
      public static const LANGUAGE_LOAD_COMPLETE:String = "onLanguageLoadComplete";
      
      public static const START_FIRST_LOADING:String = "onStartFirstLoading";
      
      public static const FINISH_FIRST_LOADING:String = "onFinishFirstLoading";
      
      public static const START_SCROLL:String = "onStartScroll";
      
      public static const END_SCROLL:String = "onEndScroll";
      
      public static const LANGUAGE_REMOVED:String = "onlanguageRemoved";
      
      public static const START_EARTH_ANIME:String = "onStartEarthAnime";
      
      public static const SKIP:String = "onSkip";
       
      
      public var obj:Object;
      
      public function LoadingEvent(param1:String, param2:Object = null)
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

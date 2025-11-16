package bfp
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import jp.feb19.net.MultipleLoader;
   
   public class PDWTutorial
   {
      
      protected static const _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static const MESSAGE_OPEN:String = "pdwBridgeMessageOpen";
      
      public static const MESSAGE_CLOSE:String = "pdwBridgeMessageClose";
      
      public static const MESSAGE_START:String = "pdwBridgeMessageStart";
      
      public static const MESSAGE_SEEK:String = "pdwBridgeMessageSeek";
      
      public static const MESSAGE_NEXT:String = "pdwBridgeMessageNext";
      
      public static const MAKOMO_APPEAR:String = "pdwBridgeMakomoAppear";
      
      public static const MAKOMO_DISAPPEAR:String = "pdwBridgeMakomoDisappear";
      
      public static const MAKOMO_CHANGE_STATE:String = "pdwBridgeMakomoChangeState";
      
      public static const MAKOMO_EMOTION_CHANGE:String = "pdwBridgeMakomoEmotionChange";
      
      public static const MAKOMO_EMOTION_RESTART:String = "pdwBridgeMakomoEmotionRestart";
      
      public static const MAKOMO_CLOUD:String = "pdwBridgeMakomoCloud";
      
      public static var assetsOfTutorial:Object;
      
      public static const MAKOMO_STATE_HIDE:uint = 0;
      
      public static const MAKOMO_STATE_LEFT:uint = 1;
      
      public static const MAKOMO_STATE_CENTER:uint = 2;
      
      public static const MAKOMO_STATE_RIGHT:uint = 3;
      
      public static const MAKOMO_STATE_HIDE_LEFT:uint = 4;
      
      public static const MAKOMO_STATE_CENTER_RIGHT:uint = 5;
      
      public static const MAKOMO_STATE_BOTTOM:uint = 6;
      
      public static const MAKOMO_EMOTION_A:uint = 1;
      
      public static const MAKOMO_EMOTION_B_NORMAL:uint = 2;
      
      public static const MAKOMO_EMOTION_B_CLOSE:uint = 3;
      
      public static const MAKOMO_EMOTION_B_RELAX:uint = 4;
      
      public static const MAKOMO_EMOTION_C:uint = 5;
      
      public static const RESET_START_TUTORIAL:String = "resetStartTutorial";
      
      public static const BACKGROUND_ATTENTION:String = "background_attention";
      
      public static const ATTENTION_FOOTPRINT:String = "attention_footprint";
      
      public static const ATTENTION_GAMEFRIENDMAP:String = "attention_gamefriendmap";
      
      public static const ATTENTION_CLOSE:String = "attention_close";
      
      public static const ATTENTION_DOOR:String = "attention_door";
      
      public static const FINISH:String = "tutorial_finish";
       
      
      public function PDWTutorial()
      {
         super();
      }
      
      public static function loadAssetsOfTutorial(param1:Array) : void
      {
         assetsOfTutorial = new Object();
         var _loc2_:MultipleLoader = new MultipleLoader(param1);
         _loc2_.addEventListener(MultipleLoader.LOAD_COMPLETE,loadCompleteAssetsOfTutorial);
         _loc2_.start();
      }
      
      private static function loadCompleteAssetsOfTutorial(param1:Event) : void
      {
         var _loc6_:Loader = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Bitmap = null;
         var _loc2_:MultipleLoader = MultipleLoader(param1.currentTarget);
         _loc2_.removeEventListener(MultipleLoader.LOAD_COMPLETE,loadCompleteAssetsOfTutorial);
         var _loc3_:Object = new Object();
         var _loc4_:int = int(_loc2_.loaders.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = (_loc7_ = (_loc6_ = Loader(_loc2_.loaders[_loc5_])).contentLoaderInfo.url).lastIndexOf("/");
            _loc9_ = _loc7_.lastIndexOf(".");
            _loc10_ = _loc7_.substr(_loc8_ + 1,_loc9_ - _loc8_ - 1);
            _loc11_ = Bitmap(_loc6_.content).bitmapData.clone();
            _loc12_ = new Bitmap(_loc11_);
            _loc3_[_loc10_] = _loc12_;
            _loc5_++;
         }
         assetsOfTutorial = _loc3_;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function messageOpen() : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_OPEN,{}));
      }
      
      public static function messageClose() : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_CLOSE,{}));
      }
      
      public static function messageStart(param1:Array) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_START,{"messageData":param1}));
      }
      
      public static function messageSeek(param1:int = 0) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_SEEK,{"pageNum":param1}));
      }
      
      public static function messageNext(param1:int = 0) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_NEXT,{}));
      }
      
      public static function makomoAppear(param1:uint = 2, param2:Number = 0.6) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_APPEAR,{
            "state":param1,
            "time":param2
         }));
      }
      
      public static function makomoDisappear(param1:Number = 0.6) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_DISAPPEAR,{"time":param1}));
      }
      
      public static function makomoChangeState(param1:uint, param2:Number = 0.6, param3:String = "easeOutQuart") : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_CHANGE_STATE,{
            "state":param1,
            "time":param2,
            "transition":param3
         }));
      }
      
      public static function makomoEmotionChange(param1:int = 2) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_EMOTION_CHANGE,{"emotionId":param1}));
      }
      
      public static function makomoEmotionRestart() : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_EMOTION_RESTART,{}));
      }
      
      public static function makomoCloud() : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_CLOUD,{}));
      }
      
      public static function resetStartTutorial() : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.RESET_START_TUTORIAL,{}));
      }
      
      public static function attention(param1:String = "", param2:Boolean = true) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.BACKGROUND_ATTENTION,{
            "attentionId":param1,
            "isShow":param2
         }));
      }
      
      public static function finish(param1:int) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.FINISH,{"num":param1}));
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
   }
}

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
      
      public static var assetsOfTutorial:Object;
      
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
      
      public static function loadAssetsOfTutorial(filePaths:Array) : void
      {
         assetsOfTutorial = new Object();
         var multipleLoader:MultipleLoader = new MultipleLoader(filePaths);
         multipleLoader.addEventListener(MultipleLoader.LOAD_COMPLETE,loadCompleteAssetsOfTutorial);
         multipleLoader.start();
      }
      
      private static function loadCompleteAssetsOfTutorial(event:Event) : void
      {
         var l:Loader = null;
         var url:String = null;
         var a:Number = NaN;
         var b:Number = NaN;
         var filename:String = null;
         var bmd:BitmapData = null;
         var bmp:Bitmap = null;
         var multipleLoader:MultipleLoader = MultipleLoader(event.currentTarget);
         multipleLoader.removeEventListener(MultipleLoader.LOAD_COMPLETE,loadCompleteAssetsOfTutorial);
         var bitmaps:Object = new Object();
         var count:int = int(multipleLoader.loaders.length);
         for(var i:int = 0; i < count; i++)
         {
            l = Loader(multipleLoader.loaders[i]);
            url = l.contentLoaderInfo.url;
            a = url.lastIndexOf("/");
            b = url.lastIndexOf(".");
            filename = url.substr(a + 1,b - a - 1);
            bmd = Bitmap(l.content).bitmapData.clone();
            bmp = new Bitmap(bmd);
            bitmaps[filename] = bmp;
         }
         assetsOfTutorial = bitmaps;
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
      
      public static function messageStart(messageData:Array) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_START,{"messageData":messageData}));
      }
      
      public static function messageSeek(pageNum:int = 0) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_SEEK,{"pageNum":pageNum}));
      }
      
      public static function messageNext(pageNum:int = 0) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MESSAGE_NEXT,{}));
      }
      
      public static function makomoAppear(state:uint = 2, time:Number = 0.6) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_APPEAR,{
            "state":state,
            "time":time
         }));
      }
      
      public static function makomoDisappear(time:Number = 0.6) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_DISAPPEAR,{"time":time}));
      }
      
      public static function makomoChangeState(state:uint, time:Number = 0.6, transition:String = "easeOutQuart") : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_CHANGE_STATE,{
            "state":state,
            "time":time,
            "transition":transition
         }));
      }
      
      public static function makomoEmotionChange(emotionId:int = 2) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.MAKOMO_EMOTION_CHANGE,{"emotionId":emotionId}));
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
      
      public static function attention(attentionId:String = "", isShow:Boolean = true) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.BACKGROUND_ATTENTION,{
            "attentionId":attentionId,
            "isShow":isShow
         }));
      }
      
      public static function finish(num:int) : void
      {
         dispatchEvent(new PDWTutorialEvent(PDWTutorial.FINISH,{"num":num}));
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function dispatchEvent(event:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(event);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
   }
}


package bfp.pdw.farm.objects
{
   import bfp.PDWHomeData;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.farm.FarmData;
   import bfp.pdw.farm.panel.Message;
   import caurina.transitions.Tweener;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   public class TitleTxtUnit extends EventDispatcher
   {
      
      private var targetTxt:TextField;
      
      private var data:FarmData;
      
      private var timer:Timer;
      
      private var messageObj:Message;
      
      private var targetTxtY:Number = 0;
      
      public function TitleTxtUnit(param1:TextField)
      {
         super();
         this.targetTxt = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.targetTxt.autoSize = TextFieldAutoSize.CENTER;
         this.targetTxt.selectable = false;
         this.targetTxt.multiline = false;
         this.targetTxt.wordWrap = false;
         this.targetTxtY = 20;
         this.timer = new Timer(7000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.messageObj = new Message();
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetTxt.text = "";
      }
      
      public function stop() : *
      {
         this.stopTimer();
      }
      
      public function run() : *
      {
         if(this.data.isFriendMode)
         {
            this.targetTxt.y = this.targetTxtY;
            Localize.setAutoFontTextString(this.targetTxt,"k_ad_1",PDWHomeData.anotherPGLName);
         }
         else
         {
            this.targetTxt.y = this.targetTxtY;
            Localize.setAutoFontTextString(this.targetTxt,"k_ad_1",PDWHomeData.myPGLName);
         }
         this.startTimer();
      }
      
      private function startTimer() : *
      {
         this.targetTxt.alpha = 1;
         this.timer.reset();
         this.timer.start();
      }
      
      private function stopTimer() : *
      {
         this.timer.stop();
         this.timer.reset();
      }
      
      private function onTimerComplete(param1:TimerEvent) : *
      {
         Tweener.addTween(this.targetTxt,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "alpha":0
         });
      }
   }
}


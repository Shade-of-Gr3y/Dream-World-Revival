package bfp.tpc.pdw.tutorial
{
   import bfp.PDWTutorial;
   import bfp.PDWTutorialEvent;
   import caurina.transitions.Tweener;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class Makomo extends MovieClip
   {
       
      
      public var mc:MovieClip;
      
      private var _currentState:uint;
      
      private var _currentEmotion:uint;
      
      private var _stateDataList:Array;
      
      public function Makomo()
      {
         this._stateDataList = [[1003,205,1,1],[-46,205,-1,1],[441,30,341 / 657,341 / 657],[793,205,1,1],[-178,205,-1,1],[518,30,341 / 657,341 / 657],[390,205,1,1]];
         super();
         this.gotoAndStop(2);
         this.mc.stop();
         this.blendMode = BlendMode.LAYER;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         this.mc.gotoAndPlay(1);
         this.visible = false;
         this._currentState = uint.MAX_VALUE;
      }
      
      public function release() : void
      {
         Tweener.removeTweens(this);
         this.visible = false;
         this._currentState = uint.MAX_VALUE;
      }
      
      public function appear(param1:uint = 2, param2:Number = 0.6) : void
      {
         this.alpha = 0;
         this.x = this._stateDataList[param1][0];
         this.y = this._stateDataList[param1][1];
         this.scaleX = this._stateDataList[param1][2];
         this.scaleY = this._stateDataList[param1][3];
         this.changeState(param1,param2);
      }
      
      public function disappear(param1:Number = 0.6) : void
      {
         var time:Number = param1;
         this._currentState = uint.MAX_VALUE;
         Tweener.removeTweens(this);
         PDWTutorial.dispatchEvent(new Event(PDWTutorialEvent.MAKOMO_CHANGE_STATE_START));
         Tweener.addTween(this,{
            "time":time,
            "transition":"easeNone",
            "alpha":0,
            "onComplete":function():void
            {
               this.visible = false;
               PDWTutorial.dispatchEvent(new Event(PDWTutorialEvent.MAKOMO_CHANGE_STATE_COMPLETE));
            }
         });
      }
      
      public function changeState(param1:uint, param2:Number = 0.6, param3:String = "easeOutQuart") : void
      {
         var toX:int;
         var toY:int;
         var toSX:Number;
         var toSY:Number;
         var state:uint = param1;
         var time:Number = param2;
         var transition:String = param3;
         this.visible = true;
         PDWTutorial.dispatchEvent(new Event(PDWTutorialEvent.MAKOMO_CHANGE_STATE_START));
         Tweener.removeTweens(this);
         toX = int(this._stateDataList[state][0]);
         toY = int(this._stateDataList[state][1]);
         toSX = Number(this._stateDataList[state][2]);
         toSY = Number(this._stateDataList[state][3]);
         this._currentState = state;
         Tweener.addTween(this,{
            "time":time,
            "transition":"easeNone",
            "alpha":1
         });
         Tweener.addTween(this,{
            "time":time,
            "transition":transition,
            "x":toX,
            "y":toY,
            "scaleX":toSX,
            "scaleY":toSY,
            "onComplete":function():void
            {
               PDWTutorial.dispatchEvent(new Event(PDWTutorialEvent.MAKOMO_CHANGE_STATE_COMPLETE));
            }
         });
      }
      
      public function changeEmotion(param1:uint) : void
      {
         this._currentEmotion = param1;
         this.gotoAndStop(param1);
      }
      
      public function restartEmotion() : void
      {
         this.mc.gotoAndPlay(1);
      }
   }
}

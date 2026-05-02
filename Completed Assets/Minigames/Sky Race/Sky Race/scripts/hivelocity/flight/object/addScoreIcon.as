package hivelocity.flight.object
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class addScoreIcon extends MovieClip
   {
      
      static const TIMER_DISTANCE:uint = 33;
      
      static const ICON_LIFE:uint = 10;
      
      static const COMBO_TYPE_USUALLY:uint = 1;
      
      static const COMBO_TYPE_LEAF:uint = 2;
      
      static const COMBO_TYPE_FIRE:uint = 3;
      
      static const COMBO_TYPE_WATER:uint = 4;
      
      static const COMBO_TYPE_ORDER:uint = 5;
      
      static const MOVE_HEIGHT:uint = 50;
       
      
      public var ptt_1:MovieClip;
      
      public var PT:MovieClip;
      
      public var ptt_2:MovieClip;
      
      public var ptt_3:MovieClip;
      
      public var ptt_4:MovieClip;
      
      private var _moveTimer:Timer;
      
      private var _moveSpeed:Number;
      
      private var _deleteCount:Number;
      
      public function addScoreIcon()
      {
         super();
         this._moveSpeed = 0;
      }
      
      public function setAddScore(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         switch(param5)
         {
            case COMBO_TYPE_USUALLY:
               _loc7_ = COMBO_TYPE_USUALLY;
               _loc6_ = 15;
               break;
            case COMBO_TYPE_LEAF:
               _loc7_ = COMBO_TYPE_LEAF;
               _loc6_ = 50;
               break;
            case COMBO_TYPE_FIRE:
               _loc7_ = COMBO_TYPE_FIRE;
               _loc6_ = 50;
               break;
            case COMBO_TYPE_WATER:
               _loc7_ = COMBO_TYPE_WATER;
               _loc6_ = 50;
               break;
            case COMBO_TYPE_ORDER:
               _loc7_ = COMBO_TYPE_ORDER;
               _loc6_ = 50;
         }
         if(param4)
         {
            _loc7_ = _loc7_ + 5;
         }
         this.x = param1;
         this.y = param2 + _loc6_;
         this.gotoAndStop(_loc7_);
         this._moveSpeed = param3;
         this.addPointAnime();
      }
      
      public function objDelete() : void
      {
         this._moveTimer.reset();
         this._moveTimer.stop();
         this._moveTimer.removeEventListener(TimerEvent.TIMER,this.__addScoreMoveHandler);
         this._moveTimer = null;
         dispatchEvent(new flightEvent(flightEvent.ADD_SCORE_REMOVE));
      }
      
      private function scoreIconMove() : void
      {
         this._deleteCount = 1;
         this._moveTimer = new Timer(TIMER_DISTANCE);
         this._moveTimer.addEventListener(TimerEvent.TIMER,this.__addScoreMoveHandler,false,0,true);
         this._moveTimer.reset();
         this._moveTimer.start();
      }
      
      private function __addScoreMoveHandler(param1:TimerEvent = null) : void
      {
         this.y = this.y - 5;
         this._deleteCount = this._deleteCount - 0.1;
         if(this._deleteCount <= 0)
         {
            this.objDelete();
         }
      }
      
      private function addPointAnime(param1:Boolean = false) : void
      {
         var mc:MovieClip = null;
         var $ef:Boolean = param1;
         var sp:Number = 0.8;
         var trn:String = "easeOutBack";
         var fnc:Function = this.addPointAnime;
         if(!$ef)
         {
            mc = this;
            with(mc)
            {
               
               alpha = 0;
               scaleX = 0.5;
               scaleY = 0.5;
               y = y + MOVE_HEIGHT;
            }
            Tweener.addTween(mc,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "y":mc.y - MOVE_HEIGHT,
               "time":sp,
               "transition":trn,
               "onComplete":fnc,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.scoreIconMove();
         }
      }
   }
}

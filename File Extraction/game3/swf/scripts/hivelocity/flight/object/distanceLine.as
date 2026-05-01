package hivelocity.flight.object
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol88")]
   public class distanceLine extends MovieClip
   {
      
      public static const FLAG_FIRST_POSITION:* = 320;
      
      public static const TIMER_DISTANCE:* = 33;
      
      public static const BASE_FPS:uint = 30;
      
      public static const SECOND:uint = 1000;
      
      public var flag_mc:MovieClip;
      
      private var _moveFlg:Boolean = true;
      
      private var _gameStageWidth:Number = 0;
      
      private var _gameSpeed:Number = 0;
      
      private var _moveTimer:Timer;
      
      private var _totalDistance:Number = 0;
      
      private var _fps:uint = 30;
      
      private var _soundController:soundController;
      
      public function distanceLine()
      {
         super();
         this.__init();
      }
      
      public function set setGameStageWidth(param1:Number) : void
      {
         this._gameStageWidth = param1;
      }
      
      public function set setSpeed(param1:Number) : void
      {
         this._gameSpeed = param1;
         this.start();
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function reset() : void
      {
         this.__init();
         this._soundController.soundReset();
      }
      
      public function start() : void
      {
      }
      
      public function stopmove() : void
      {
      }
      
      private function __init() : void
      {
         this.y += FLAG_FIRST_POSITION;
         this.cacheAsBitmap = true;
         this._soundController = new soundController();
         this.flagUp();
      }
      
      private function __distanceLineMoveHandler(param1:TimerEvent = null) : void
      {
         var _loc2_:uint = 0;
         if(this._moveFlg)
         {
            this.x += this._gameSpeed;
            this._totalDistance += this._gameSpeed;
            _loc2_ = this._fps;
            if(_loc2_ > 30)
            {
               _loc2_ = 30;
            }
            this._moveTimer.reset();
            this._moveTimer.delay = Math.round(1000 / _loc2_);
            this._moveTimer.start();
            if(this._totalDistance > this._gameStageWidth + 200)
            {
               dispatchEvent(new flightEvent(flightEvent.DISTANCE_LINE_REMOVE));
               this._moveFlg = false;
               this._moveTimer.removeEventListener(TimerEvent.TIMER,this.__distanceLineMoveHandler);
            }
         }
      }
      
      private function flagUp(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.5;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.flagUp;
         var _loc5_:MovieClip = this;
         if(!param1)
         {
            this._soundController.playSound("flag");
            Tweener.addTween(_loc5_,{
               "y":0,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.flagDown();
         }
      }
      
      private function flagDown(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 2;
         var _loc4_:String = "easeOutBack";
         var _loc5_:Function = this.flagDown;
         var _loc6_:MovieClip = this;
         if(!param1)
         {
            Tweener.addTween(_loc6_,{
               "y":FLAG_FIRST_POSITION,
               "time":_loc2_,
               "delay":_loc3_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            dispatchEvent(new flightEvent(flightEvent.DISTANCE_LINE_REMOVE));
         }
      }
   }
}


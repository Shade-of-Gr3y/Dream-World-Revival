package hivelocity.flight.popup
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   
   public class failBord extends MovieClip
   {
      
      static const BTN_DEFAULT:String = "_default";
      
      static const BTN_OVER:String = "_over";
      
      static const BTN_DOWN:String = "_down";
      
      static const BTN_OFF:String = "_off";
      
      static const BTN_UP:String = "_up";
       
      
      public var btn_ok:MovieClip;
      
      private var _boardSetPosition:int;
      
      private var _soundController:soundController;
      
      public function failBord()
      {
         super();
         this._boardSetPosition = this.y;
         this.visible = false;
         this.alpha = 0;
         this.scaleX = this.scaleY = 0;
         this._soundController = new soundController();
      }
      
      public function failBoardWinOpen() : void
      {
         this.winOpen();
      }
      
      private function winOpen(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.winOpen;
         if(!param1)
         {
            this._soundController.playSound("zannen");
            _loc5_ = this;
            _loc5_.visible = true;
            _loc5_.y = _loc5_.y + (_loc5_.height + 100);
            _loc5_.alpha = 0;
            this.scaleX = this.scaleY = 1;
            Tweener.addTween(_loc5_,{
               "time":_loc2_,
               "alpha":1,
               "transition":"linear"
            });
            Tweener.addTween(_loc5_,{
               "time":_loc2_,
               "y":this._boardSetPosition,
               "transition":"easeOutQuint",
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this["btn_ok"].mouseChildren = false;
            this["btn_ok"].buttonMode = true;
            this["btn_ok"].addEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown,false,0,true);
            this["btn_ok"].addEventListener(MouseEvent.ROLL_OVER,this.__mouseOver,false,0,true);
            this["btn_ok"].addEventListener(MouseEvent.MOUSE_UP,this.__gameFinish,false,0,true);
            this["btn_ok"].addEventListener(MouseEvent.ROLL_OUT,this.__mouseDefault,false,0,true);
         }
      }
      
      private function __mouseDown(param1:MouseEvent = null) : void
      {
         this._soundController.playSound("btnPush");
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DOWN);
      }
      
      private function __mouseOver(param1:MouseEvent = null) : void
      {
         this._soundController.playSound("btnOn");
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_OVER);
      }
      
      private function __mouseDefault(param1:MouseEvent = null) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DEFAULT);
      }
      
      private function __gameFinish(param1:MouseEvent = null) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DEFAULT);
         this["btn_ok"].removeEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown);
         this["btn_ok"].removeEventListener(MouseEvent.MOUSE_OVER,this.__mouseOver);
         this["btn_ok"].removeEventListener(MouseEvent.MOUSE_UP,this.__gameFinish);
         dispatchEvent(new flightEvent(flightEvent.GAME_FINISH));
         this._soundController.soundReset();
      }
   }
}

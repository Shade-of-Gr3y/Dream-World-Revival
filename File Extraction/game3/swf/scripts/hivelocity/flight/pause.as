package hivelocity.flight
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol880")]
   public class pause extends MovieClip
   {
      
      internal static const BTN_DEFAULT:String = "_default";
      
      internal static const BTN_OVER:String = "_over";
      
      internal static const BTN_DOWN:String = "_down";
      
      internal static const BTN_OFF:String = "_off";
      
      internal static const BTN_UP:String = "_up";
      
      public var pauseGameMask_mc:MovieClip;
      
      public var btnReturnGame_mc:MovieClip;
      
      public var pauseIcon_mc:MovieClip;
      
      public var btnHowToPlay_mc:MovieClip;
      
      private var _initAlpha:Number;
      
      private var _btnArray:Array;
      
      private var _howtoplay:howToPlay;
      
      private var _soundController:soundController;
      
      public function pause()
      {
         super();
         this._initAlpha = this.alpha;
         this.__init();
      }
      
      public function winOpen() : void
      {
         this.winOpenAnime();
      }
      
      public function winClose() : void
      {
         this.winCloseAnime();
      }
      
      public function reset() : void
      {
         this._soundController.soundReset();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      private function __init() : void
      {
         this._btnArray = [];
         this.visible = false;
         with(this["pauseGameMask_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
         }
         with(this["btnHowToPlay_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
         }
         with(this["btnReturnGame_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
         }
         with(this["pauseIcon_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
         }
         this._btnArray.push(this["btnHowToPlay_mc"]);
         this._btnArray.push(this["btnReturnGame_mc"]);
         this._soundController = new soundController();
      }
      
      private function setbtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].mouseChildren = false;
            param1[_loc2_].buttonMode = true;
            param1[_loc2_].addEventListener(MouseEvent.CLICK,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.ROLL_OVER,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_UP,this.handleButton,false,0,true);
            _loc2_++;
         }
      }
      
      private function deletebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = false;
            param1[_loc2_].removeEventListener(MouseEvent.CLICK,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.MOUSE_UP,this.handleButton);
            _loc2_++;
         }
      }
      
      private function invalidatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = false;
            _loc2_++;
         }
      }
      
      private function validatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = true;
            _loc2_++;
         }
      }
      
      private function winOpenAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutQuart";
         var _loc4_:Function = this.winOpenAnime;
         _loc5_ = this["pauseGameMask_mc"];
         if(!param1)
         {
            this.visible = true;
            this._soundController.playSound("popupOpen");
            Tweener.addTween(_loc5_,{
               "alpha":this._initAlpha,
               "scaleX":1,
               "scaleY":1,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.addBtnAnime();
         }
      }
      
      private function winCloseAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutQuart";
         var _loc4_:Function = this.winCloseAnime;
         _loc5_ = this["pauseGameMask_mc"];
         if(!param1)
         {
            this._soundController.playSound("popupClose");
            _loc5_ = this["pauseIcon_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnHowToPlay_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnReturnGame_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["pauseGameMask_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            dispatchEvent(new flightEvent(flightEvent.PAUSE_CANCEL));
            this.visible = false;
         }
      }
      
      private function addBtnAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.5;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.addBtnAnime;
         if(!param1)
         {
            _loc5_ = this["pauseIcon_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnHowToPlay_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnReturnGame_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.setbtn(this._btnArray);
         }
      }
      
      private function deleteBtnAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutQuart";
         var _loc4_:Function = this.deleteBtnAnime;
         if(!param1)
         {
            _loc5_ = this["pauseIcon_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnHowToPlay_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["btnReturnGame_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.winCloseAnime();
         }
      }
      
      private function handleButton(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.buttonMode)
         {
            switch(param1.type)
            {
               case MouseEvent.ROLL_OVER:
                  this._soundController.playSound("btnOn");
                  _loc2_.gotoAndStop(BTN_OVER);
                  break;
               case MouseEvent.ROLL_OUT:
                  _loc2_.gotoAndStop(BTN_DEFAULT);
                  break;
               case MouseEvent.MOUSE_DOWN:
                  this._soundController.playSound("btnPush");
                  _loc2_.gotoAndStop(BTN_DOWN);
                  break;
               case MouseEvent.MOUSE_UP:
                  _loc2_.gotoAndStop(BTN_UP);
                  switch(_loc2_.name.split("_")[0])
                  {
                     case "btnHowToPlay":
                        this.__howToPlayOpen();
                        break;
                     case "btnReturnGame":
                        this.deletebtn(this._btnArray);
                        this.winClose();
                  }
            }
         }
         _loc2_ = null;
      }
      
      private function __howToPlayOpen() : void
      {
         this._howtoplay = new howToPlay();
         this.addChild(this._howtoplay);
         this._howtoplay.helpOpen();
         this._howtoplay.addEventListener(flightEvent.HOWTO_WIN_CLOSE,this.__howToWinRemove,false,0,true);
      }
      
      private function __howToWinRemove(param1:flightEvent) : void
      {
         this.removeChild(this._howtoplay);
         this._howtoplay.removeEventListener(flightEvent.HOWTO_WIN_CLOSE,this.__howToWinRemove);
         this._howtoplay = null;
      }
   }
}


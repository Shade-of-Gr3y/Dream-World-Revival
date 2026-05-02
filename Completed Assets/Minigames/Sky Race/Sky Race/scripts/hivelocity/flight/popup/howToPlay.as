package hivelocity.flight.popup
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   import org.libspark.betweenas3.BetweenAS3;
   import org.libspark.betweenas3.easing.Back;
   import org.libspark.betweenas3.easing.Expo;
   import org.libspark.betweenas3.easing.Quad;
   import org.libspark.betweenas3.tweens.ITween;
   
   public class howToPlay extends MovieClip
   {
      
      static const BTN_DEFAULT:String = "_default";
      
      static const BTN_OVER:String = "_over";
      
      static const BTN_DOWN:String = "_down";
      
      static const BTN_OFF:String = "_off";
      
      static const BTN_UP:String = "_up";
       
      
      public var bg:MovieClip;
      
      public var contents_mc:MovieClip;
      
      private var ballArray:Array;
      
      private var tweenArr:Array;
      
      private var _btnArr:Array;
      
      private var _soundController:soundController;
      
      public function howToPlay()
      {
         this.ballArray = [];
         this.tweenArr = [];
         this._btnArr = [];
         super();
         this.__init();
      }
      
      public function helpOpen() : void
      {
         var _loc3_:MovieClip = null;
         this._soundController.playSound("popupOpen");
         var _loc1_:int = 0;
         while(_loc1_ < this.ballArray.length)
         {
            _loc3_ = this.ballArray[_loc1_].mc;
            this.tweenArr[_loc1_] = BetweenAS3.tween(_loc3_,{
               "x":this.ballArray[_loc1_].x,
               "y":this.ballArray[_loc1_].y,
               "scaleX":1,
               "scaleY":1
            },null,0.5,Back.easeOut);
            _loc1_++;
         }
         var _loc2_:ITween = BetweenAS3.parallel.apply(null,this.tweenArr);
         _loc2_.onComplete = this.helpLook;
         _loc2_.play();
      }
      
      public function helpClose() : void
      {
         var _loc3_:MovieClip = null;
         this._soundController.playSound("popupClose");
         this.contents_mc.visible = false;
         this.contents_mc.alpha = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.ballArray.length)
         {
            _loc3_ = this.ballArray[_loc1_].mc;
            this.tweenArr[_loc1_] = BetweenAS3.tween(_loc3_,{
               "x":0,
               "y":0,
               "scaleX":0,
               "scaleY":0
            },null,0.5,Back.easeIn);
            _loc1_++;
         }
         var _loc2_:ITween = BetweenAS3.parallel.apply(null,this.tweenArr);
         _loc2_.onComplete = this.closeEventSend;
         _loc2_.play();
      }
      
      private function __init() : void
      {
         var _ball:MovieClip = null;
         with(this.contents_mc)
         {
            
            alpha = 0;
            visible = false;
         }
         var i:int = 0;
         while(i < 1)
         {
            _ball = this.bg.kumo;
            this.ballArray.push({
               "mc":_ball,
               "x":_ball.x,
               "y":_ball.y
            });
            _ball.x = 0;
            _ball.y = 0;
            _ball.scaleX = 0;
            _ball.scaleY = 0;
            i++;
         }
         this._btnArr = [];
         this._btnArr.push(this.contents_mc.btn_close);
         this._btnArr.push(this.contents_mc.naka.btn_next);
         this._btnArr.push(this.contents_mc.naka.btn_previous);
         this.setbtn(this._btnArr);
         this._soundController = new soundController();
      }
      
      private function helpSlide(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_.split("_")[1])
         {
            case "next":
               BetweenAS3.tween(this.contents_mc.naka,{"x":-876},null,0.5,Expo.easeOut).play();
               break;
            case "previous":
               BetweenAS3.tween(this.contents_mc.naka,{"x":0},null,0.5,Expo.easeOut).play();
         }
      }
      
      private function helpLook() : void
      {
         this.contents_mc.visible = true;
         BetweenAS3.tween(this.contents_mc,{"alpha":1},null,0.3,Quad.easeOut).play();
      }
      
      private function closeEventSend() : void
      {
         this._soundController.soundReset();
         dispatchEvent(new flightEvent(flightEvent.HOWTO_WIN_CLOSE));
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
      
      private function onCloseClickListener(param1:MouseEvent) : void
      {
         this.helpClose();
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
                  switch(_loc2_.name.split("_")[1])
                  {
                     case "close":
                        this.deletebtn(this._btnArr);
                        this.helpClose();
                        break;
                     case "next":
                        BetweenAS3.tween(this.contents_mc.naka,{"x":-876},null,0.5,Expo.easeOut).play();
                        break;
                     case "previous":
                        BetweenAS3.tween(this.contents_mc.naka,{"x":0},null,0.5,Expo.easeOut).play();
                  }
            }
         }
         _loc2_ = null;
      }
   }
}

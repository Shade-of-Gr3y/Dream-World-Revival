package hivelocity.flight.utility
{
   import as3.hivelocity.flight.events.mainBtnEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   
   public class mainBtn extends MovieClip
   {
      
      static const BTN_DEFAULT:String = "_default";
      
      static const BTN_OVER:String = "_over";
      
      static const BTN_DOWN:String = "_down";
      
      static const BTN_OFF:String = "_off";
      
      static const BTN_UP:String = "_up";
       
      
      public var btn:MovieClip;
      
      private var _btnArr:Array;
      
      private var _isLocked:Boolean;
      
      private var _langCode:String = "";
      
      private var _soundController:soundController;
      
      public function mainBtn()
      {
         this._btnArr = [];
         super();
         this._btnArr = [];
         this._btnArr.push(this);
         this.setbtn(this._btnArr);
         this._isLocked = false;
         this._soundController = new soundController();
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         this._isLocked = param1;
         if(this._isLocked)
         {
            this.validatebtn(this._btnArr);
         }
         else
         {
            this.invalidatebtn(this._btnArr);
         }
      }
      
      public function invalidatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = false;
            param1[_loc2_].gotoAndStop(BTN_OFF);
            _loc2_++;
         }
      }
      
      public function validatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = true;
            param1[_loc2_].gotoAndStop(BTN_DEFAULT);
            _loc2_++;
         }
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
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.handleButton,false,0,true);
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
               case MouseEvent.MOUSE_OVER:
                  switch(_loc2_.name.split("_")[0])
                  {
                     case "btnGameStart":
                        _loc2_.gotoAndStop(BTN_OVER);
                        break;
                     case "btnHowToPlay":
                        _loc2_.gotoAndStop(BTN_OVER);
                  }
                  break;
               case MouseEvent.MOUSE_OUT:
                  switch(_loc2_.name.split("_")[0])
                  {
                     case "btnGameStart":
                        _loc2_.gotoAndStop(BTN_DEFAULT);
                        break;
                     case "btnHowToPlay":
                        _loc2_.gotoAndStop(BTN_DEFAULT);
                  }
                  break;
               case MouseEvent.MOUSE_UP:
                  _loc2_.gotoAndStop(BTN_DEFAULT);
                  switch(_loc2_.name.split("_")[0])
                  {
                     case "btnGameBack":
                        dispatchEvent(new mainBtnEvent(mainBtnEvent.BTN_GAME_BACK));
                        break;
                     case "btnGameStart":
                        dispatchEvent(new mainBtnEvent(mainBtnEvent.BTN_GAME_START));
                        break;
                     case "btnHowToPlay":
                        dispatchEvent(new mainBtnEvent(mainBtnEvent.BTN_HOWTOPLAY));
                        break;
                     case "btnGameHint":
                        dispatchEvent(new mainBtnEvent(mainBtnEvent.BTN_GAME_PAUSE));
                  }
            }
         }
         _loc2_ = null;
      }
   }
}

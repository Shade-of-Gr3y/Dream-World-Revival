package hivelocity.flight.sound
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Timer;
   
   public class flightgameSoundLoader
   {
       
      
      private var seCount:Sound;
      
      private var seCount1:Sound;
      
      private var seCount2:Sound;
      
      private var seCloudrush:Sound;
      
      private var seBtnOn:Sound;
      
      private var seBtnPush:Sound;
      
      private var seCloud:Sound;
      
      private var seCoinGet:Sound;
      
      private var seCoinIn:Sound;
      
      private var seElec:Sound;
      
      private var seFlag:Sound;
      
      private var seGole:Sound;
      
      private var seOpen:Sound;
      
      private var sePopupClose:Sound;
      
      private var sePopupOpen:Sound;
      
      private var seSpace:Sound;
      
      private var seSpeedDown:Sound;
      
      private var seSpeedUp:Sound;
      
      private var seTimeup:Sound;
      
      private var seZannen:Sound;
      
      private var seResult:Sound;
      
      private var bgmGame:Sound;
      
      private var bgmOpening:Sound;
      
      private var bgmGoodEnding:Sound;
      
      private var bgmBadEnding:Sound;
      
      private var bgmMain:Sound;
      
      private var _soundController:soundController;
      
      private var _bgmChannel:SoundChannel;
      
      private var _seChannel:SoundChannel;
      
      private var _fadeInTimer:Timer;
      
      private var _fadeOutTimer:Timer;
      
      private var _fadeOutFlg:Boolean = false;
      
      private var _fadeInFlg:Boolean = false;
      
      private var _fadeOutBaseVlm:Number = 0.0;
      
      private var _fadeOutCount:int = 0;
      
      private var _fadeOutVolume:Number = 0.0;
      
      private var _fadeInBaseVlm:Number = 0.0;
      
      private var _fadeInCount:int = 0;
      
      private var _fadeInVolume:Number = 0.0;
      
      private var _coin:Boolean = false;
      
      private var _result:Boolean = false;
      
      private var _bgmStop:Boolean = false;
      
      public function flightgameSoundLoader()
      {
         super();
         this.setSoundEffect();
         this.setBGM();
      }
      
      public function playBGM(param1:String, param2:Number = 1) : void
      {
         this._bgmStop = false;
         var _loc3_:SoundTransform = new SoundTransform();
         _loc3_.volume = param2;
         if(this._bgmChannel)
         {
            this._bgmChannel.stop();
         }
         switch(param1)
         {
            case "game":
               this._bgmChannel = this.bgmGame.play(0,2147483647,_loc3_);
               break;
            case "opening":
               this._bgmChannel = this.bgmOpening.play(0,2147483647,_loc3_);
               break;
            case "gole":
               this._bgmChannel = this.bgmGoodEnding.play(0,2147483647,_loc3_);
               break;
            case "zannen":
               this._bgmChannel = this.bgmBadEnding.play(0,2147483647,_loc3_);
               break;
            case "main":
               this._bgmChannel = this.bgmMain.play(0,2147483647,_loc3_);
         }
      }
      
      public function playSilentBGM(param1:String, param2:Number = 1) : void
      {
         var _loc3_:SoundTransform = new SoundTransform();
         _loc3_.volume = 0;
         switch(param1)
         {
            case "game":
               this._bgmChannel = this.bgmGame.play(0,2147483647,_loc3_);
               break;
            case "opening":
               this._bgmChannel = this.bgmOpening.play(0,2147483647,_loc3_);
               break;
            case "gole":
               this._bgmChannel = this.bgmGoodEnding.play(0,2147483647,_loc3_);
               break;
            case "zannen":
               this._bgmChannel = this.bgmBadEnding.play(0,2147483647,_loc3_);
               break;
            case "main":
               this._bgmChannel = this.bgmMain.play(0,2147483647,_loc3_);
         }
      }
      
      public function stopBGM() : void
      {
      }
      
      public function closeBGM() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:SoundTransform = null;
         if(this._bgmChannel)
         {
            _loc1_ = this._bgmChannel.position;
            _loc2_ = new SoundTransform();
            _loc2_ = this._bgmChannel.soundTransform;
            this._bgmChannel.stop();
            this._bgmChannel = this.bgmMain.play(_loc1_,0);
            this._bgmChannel.soundTransform = _loc2_;
            this._bgmChannel.addEventListener(Event.SOUND_COMPLETE,this.closeBGMHandler,false,0,true);
         }
      }
      
      public function bgmFadeOut(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:SoundTransform = null;
         if(this._bgmChannel)
         {
            _loc3_ = new SoundTransform();
            _loc3_ = this._bgmChannel.soundTransform;
            if(this._fadeInFlg)
            {
               this._fadeInTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeInHandler);
               this._fadeInTimer.stop();
               this._fadeInTimer.reset();
               this._fadeInFlg = false;
            }
            if(this._fadeOutFlg)
            {
               this._fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler);
               this._fadeOutTimer.stop();
               this._fadeOutTimer.reset();
               this._fadeOutFlg = false;
            }
            this._fadeOutFlg = true;
            this._fadeOutCount = 30;
            this._fadeOutBaseVlm = _loc3_.volume;
            this._fadeOutVolume = this._fadeOutBaseVlm / (param1 / this._fadeOutCount);
            this._fadeOutTimer = new Timer(param1 / this._fadeOutCount);
            this._fadeOutTimer.addEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler,false,0,true);
            this._fadeOutTimer.start();
            this._bgmStop = param2;
         }
      }
      
      public function bgmFadeIn(param1:int) : void
      {
         var _loc2_:SoundTransform = null;
         if(this._bgmChannel && !this._bgmStop)
         {
            _loc2_ = new SoundTransform();
            _loc2_ = this._bgmChannel.soundTransform;
            if(this._fadeInFlg)
            {
               this._fadeInTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeInHandler);
               this._fadeInTimer.stop();
               this._fadeInTimer.reset();
               this._fadeInFlg = false;
            }
            if(this._fadeOutFlg)
            {
               this._fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler);
               this._fadeOutTimer.stop();
               this._fadeOutTimer.reset();
               this._fadeOutFlg = false;
            }
            this._fadeInFlg = true;
            this._fadeInCount = 30;
            this._fadeInBaseVlm = _loc2_.volume;
            this._fadeInVolume = this._fadeInBaseVlm / (param1 / this._fadeInCount);
            this._fadeInTimer = new Timer(param1 / this._fadeInCount);
            this._fadeInTimer.addEventListener(TimerEvent.TIMER,this.bgmFadeInHandler,false,0,true);
            this._fadeInTimer.start();
         }
      }
      
      public function playSound(param1:String) : void
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case "btnOn":
               this._seChannel = this.seBtnOn.play();
               _loc2_ = true;
               break;
            case "btnPush":
               this._seChannel = this.seBtnPush.play();
               _loc2_ = true;
               break;
            case "cloud":
               this._seChannel = this.seCloud.play();
               _loc2_ = true;
               break;
            case "cloudRush":
               this._seChannel = this.seCloudrush.play();
               _loc2_ = true;
               break;
            case "coinGet":
               this._coin = true;
               this._seChannel = this.seCoinGet.play();
               _loc2_ = true;
               break;
            case "coinIn":
               this._seChannel = this.seCoinIn.play();
               _loc2_ = true;
               break;
            case "elec":
               this._seChannel = this.seElec.play();
               _loc2_ = true;
               break;
            case "flag":
               this._seChannel = this.seFlag.play();
               _loc2_ = true;
               break;
            case "gole":
               this._seChannel = this.seGole.play();
               _loc2_ = true;
               break;
            case "open":
               this._seChannel = this.seOpen.play();
               _loc2_ = true;
               break;
            case "popupClose":
               this._seChannel = this.sePopupClose.play();
               _loc2_ = true;
               break;
            case "popupOpen":
               this._seChannel = this.sePopupOpen.play();
               _loc2_ = true;
               break;
            case "btnPush":
               this._seChannel = this.seBtnPush.play();
               _loc2_ = true;
               break;
            case "space":
               this._seChannel = this.seSpace.play();
               _loc2_ = true;
               break;
            case "openinig":
               this._seChannel = this.seOpen.play();
               _loc2_ = true;
               break;
            case "speedUp":
               this._seChannel = this.seSpeedUp.play();
               _loc2_ = true;
               break;
            case "speedDown":
               this._seChannel = this.seSpeedDown.play();
               _loc2_ = true;
               break;
            case "timeUp":
               this._seChannel = this.seTimeup.play();
               _loc2_ = true;
               break;
            case "zannen":
               this._seChannel = this.seZannen.play();
               _loc2_ = true;
               break;
            case "count":
               this._seChannel = this.seCount.play();
               _loc2_ = true;
               break;
            case "count1":
               this._seChannel = this.seCount1.play();
               _loc2_ = true;
               break;
            case "count2":
               this._seChannel = this.seCount2.play();
               _loc2_ = true;
               break;
            case "result":
               this._result = true;
               this._seChannel = this.seResult.play();
               _loc2_ = true;
         }
         if(_loc2_)
         {
            if(param1 == "coinGet")
            {
               this._seChannel.addEventListener(Event.SOUND_COMPLETE,this.deleteCoingetSound,false,0,true);
            }
            else if(param1 == "gole")
            {
               this._seChannel.addEventListener(Event.SOUND_COMPLETE,this.deleteResultSound,false,0,true);
            }
            else if(param1 != "result")
            {
               this._seChannel.addEventListener(Event.SOUND_COMPLETE,this.deleteSound,false,0,true);
            }
         }
      }
      
      public function soundReset() : void
      {
         this.seCount = null;
         this.seCount1 = null;
         this.seCount2 = null;
         this.seCloudrush = null;
         this.seBtnOn = null;
         this.seBtnPush = null;
         this.seCloud = null;
         this.seCoinGet = null;
         this.seCoinIn = null;
         this.seElec = null;
         this.seFlag = null;
         this.seGole = null;
         this.seOpen = null;
         this.sePopupClose = null;
         this.sePopupOpen = null;
         this.seSpace = null;
         this.seSpeedDown = null;
         this.seSpeedUp = null;
         this.seTimeup = null;
         this.seZannen = null;
         this.seResult = null;
         this.bgmGame = null;
         this.bgmOpening = null;
         this.bgmBadEnding = null;
         this.bgmGoodEnding = null;
         this.bgmMain = null;
         this._bgmChannel = null;
      }
      
      private function bgmFadeOutAndStop(param1:int) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         _loc2_ = this._bgmChannel.soundTransform;
         this._fadeOutFlg = true;
         if(this._fadeInFlg)
         {
            this._fadeInTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeInHandler);
            this._fadeInTimer.stop();
            this._fadeInTimer.reset();
            this._fadeInFlg = false;
         }
         if(this._fadeOutFlg)
         {
            this._fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler);
            this._fadeOutTimer.stop();
            this._fadeOutTimer.reset();
            this._fadeOutFlg = false;
         }
         this._fadeOutCount = 30;
         this._fadeOutBaseVlm = _loc2_.volume;
         this._fadeOutVolume = this._fadeOutBaseVlm / (param1 / this._fadeOutCount);
         this._fadeOutTimer = new Timer(param1 / this._fadeOutCount);
         this._fadeOutTimer.addEventListener(TimerEvent.TIMER,this.bgmFadeOutAndStopHandler,false,0,true);
         this._fadeOutTimer.start();
      }
      
      private function deleteSound(param1:Event) : void
      {
         if(this._seChannel)
         {
            this._seChannel.removeEventListener(Event.SOUND_COMPLETE,this.deleteSound);
         }
      }
      
      private function deleteCoingetSound(param1:Event) : void
      {
         this._coin = false;
         this._seChannel.removeEventListener(Event.SOUND_COMPLETE,this.deleteCoingetSound);
      }
      
      private function deleteResultSound(param1:Event) : void
      {
         this._result = false;
         this._seChannel.removeEventListener(Event.SOUND_COMPLETE,this.deleteResultSound);
      }
      
      private function setSoundEffect() : void
      {
         this.seCount = new se_count();
         this.seCount1 = new se_count_1();
         this.seCount2 = new se_count_2();
         this.seCloudrush = new se_cloudrush();
         this.seBtnOn = new se_btnon();
         this.seBtnPush = new se_btnpush();
         this.seCloud = new se_cloud();
         this.seCoinGet = new se_coinget();
         this.seCoinIn = new se_coinin();
         this.seElec = new se_elec();
         this.seFlag = new se_flag();
         this.seGole = new se_gole();
         this.seOpen = new se_open();
         this.sePopupClose = new se_popupclose();
         this.sePopupOpen = new se_popupopen();
         this.seSpace = new se_space();
         this.seSpeedDown = new se_speeddown();
         this.seSpeedUp = new se_speedup();
         this.seTimeup = new se_timeup();
         this.seZannen = new se_zannen();
         this.seResult = new se_result();
      }
      
      private function setBGM() : void
      {
         this.bgmGame = new bgm_game();
         this.bgmOpening = new bgm_opening();
         this.bgmBadEnding = new bgm_game();
         this.bgmGoodEnding = new bgm_gole();
         this.bgmMain = new bgm_main();
      }
      
      private function closeBGMHandler(param1:Event) : void
      {
         this._bgmChannel = this.bgmMain.play(0,0);
         this.bgmFadeOutAndStop(1000);
      }
      
      private function bgmFadeOutAndStopHandler(param1:TimerEvent) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         _loc2_ = this._bgmChannel.soundTransform;
         _loc2_.volume = _loc2_.volume - this._fadeOutVolume;
         this._bgmChannel.soundTransform = _loc2_;
         this._fadeOutCount--;
         if(this._fadeOutCount < 0)
         {
            _loc2_.volume = 0;
            this._bgmChannel.soundTransform = _loc2_;
            this._fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler);
            this._fadeOutTimer.stop();
            this._fadeOutTimer.reset();
            this._fadeOutFlg = false;
            this.stopBGM();
            this.soundReset();
         }
      }
      
      private function bgmFadeOutHandler(param1:TimerEvent) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         _loc2_ = this._bgmChannel.soundTransform;
         _loc2_.volume = _loc2_.volume - this._fadeOutVolume;
         this._bgmChannel.soundTransform = _loc2_;
         this._fadeOutCount--;
         if(this._fadeOutCount < 0)
         {
            _loc2_.volume = 0;
            this._bgmChannel.soundTransform = _loc2_;
            this._fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeOutHandler);
            this._fadeOutTimer.stop();
            this._fadeOutTimer.reset();
            this._fadeOutFlg = false;
            if(this._bgmStop)
            {
               this._bgmChannel.stop();
               this._bgmChannel = null;
            }
         }
      }
      
      private function bgmFadeInHandler(param1:TimerEvent) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         _loc2_ = this._bgmChannel.soundTransform;
         _loc2_.volume = _loc2_.volume + this._fadeOutVolume;
         this._bgmChannel.soundTransform = _loc2_;
         this._fadeInCount--;
         if(this._fadeInCount < 0)
         {
            _loc2_.volume = 1;
            this._bgmChannel.soundTransform = _loc2_;
            this._fadeInTimer.removeEventListener(TimerEvent.TIMER,this.bgmFadeInHandler);
            this._fadeInTimer.stop();
            this._fadeInTimer.reset();
            this._fadeInFlg = false;
         }
      }
   }
}

package hivelocity.flight
{
   import as3.hivelocity.flight.events.flightEvent;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class background extends MovieClip
   {
      
      public static const TIMER_DISTANCE:* = 33;
      
      public static const BG_NUM:* = 1;
      
      public static const BASE_FPS:uint = 30;
      
      public static const SECOND:uint = 1000;
      
      public static const BG_START_MOVE:uint = 600;
      
      private var _traceFlg:Boolean;
      
      private var _moveFlg:Boolean;
      
      private var _moveTimer:Timer;
      
      private var _bgspeed:Number;
      
      private var _bgW:int;
      
      private var _bgH:int;
      
      private var _bgMoveNum:Number;
      
      private var _bgFrNum:Number;
      
      private var _flightBg:flightBg;
      
      private var _sky:sky;
      
      private var _bgArr:Array;
      
      private var _totalDistance:Number;
      
      private var _baseSpeed:Number;
      
      private var _fps:uint = 30;
      
      private var _mapPokemonArr:Array = [];
      
      private var _mapPokeMoveObj:mapPokeMoveObj;
      
      private var _loopflg:Boolean = false;
      
      public function background()
      {
         super();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this._sky = new sky();
         this.addChild(this._sky);
         this.y -= BG_START_MOVE;
         this.__init();
      }
      
      public function set setTraceFlg(param1:Boolean) : void
      {
         this._traceFlg = param1;
      }
      
      public function set setBgSpeed(param1:Number) : void
      {
         this._bgspeed = param1;
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function set setBgBaseSpeed(param1:Number) : void
      {
         this._baseSpeed = param1;
      }
      
      public function get getTotalDictance() : Number
      {
         return this._totalDistance;
      }
      
      public function reset() : void
      {
         this.__init();
      }
      
      public function start() : void
      {
         this._moveFlg = true;
         addEventListener(Event.ENTER_FRAME,this.__charaMoveHandler,false,0,true);
      }
      
      public function stopmove() : void
      {
         this._moveFlg = false;
         removeEventListener(Event.ENTER_FRAME,this.__charaMoveHandler);
      }
      
      public function opening() : void
      {
         this.openingAnime();
      }
      
      private function tracer(param1:*) : void
      {
         if(this._traceFlg)
         {
         }
      }
      
      private function __init() : void
      {
         this.mapPokemonInit();
         this._bgFrNum = 0;
         this._bgMoveNum = 0;
         this._totalDistance = 0;
         this._moveFlg = false;
         this._flightBg = new flightBg();
         this._bgW = this._flightBg.width;
         this._bgH = this._flightBg.height;
         this._bgArr = [];
         this._bgArr.push(this._flightBg);
         addChild(this._flightBg);
         this._flightBg.cacheAsBitmap = true;
         this._flightBg.x = 0;
         var _loc1_:int = 1;
         while(_loc1_ < BG_NUM)
         {
            this._flightBg = new flightBg();
            this._flightBg.x = this._bgArr[0].x - this._bgW * _loc1_;
            this._bgArr.push(this._flightBg);
            addChild(this._flightBg);
            this.pokeImgRemove(this._flightBg.addpoke);
            this.setPokemonMapping(this._flightBg.addpoke);
            this._flightBg.cacheAsBitmap = true;
            _loc1_++;
         }
      }
      
      private function mapPokemonInit() : void
      {
         var _loc3_:Point = null;
         this._mapPokemonArr = [];
         var _loc1_:Array = [];
         var _loc2_:Object = new Object();
         _loc3_ = new Point(45,33);
         _loc2_.point = _loc3_;
         _loc2_.id = 426;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(600,213);
         _loc2_.point = _loc3_;
         _loc2_.id = 458;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1180,90);
         _loc2_.point = _loc3_;
         _loc2_.id = 149;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
         _loc1_ = [];
         _loc2_ = new Object();
         _loc3_ = new Point(113,160);
         _loc2_.point = _loc3_;
         _loc2_.id = 144;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(806,74);
         _loc2_.point = _loc3_;
         _loc2_.id = 145;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1443,74);
         _loc2_.point = _loc3_;
         _loc2_.id = 334;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
         _loc1_ = [];
         _loc2_ = new Object();
         _loc3_ = new Point(420,45);
         _loc2_.point = _loc3_;
         _loc2_.id = 176;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1015,173);
         _loc2_.point = _loc3_;
         _loc2_.id = 458;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1766,74);
         _loc2_.point = _loc3_;
         _loc2_.id = 144;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
         _loc1_ = [];
         _loc2_ = new Object();
         _loc3_ = new Point(50,22);
         _loc2_.point = _loc3_;
         _loc2_.id = 458;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(990,130);
         _loc2_.point = _loc3_;
         _loc2_.id = 334;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1780,70);
         _loc2_.point = _loc3_;
         _loc2_.id = 149;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
         _loc1_ = [];
         _loc2_ = new Object();
         _loc3_ = new Point(830,58);
         _loc2_.point = _loc3_;
         _loc2_.id = 176;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1450,75);
         _loc2_.point = _loc3_;
         _loc2_.id = 426;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
         _loc1_ = [];
         _loc2_ = new Object();
         _loc3_ = new Point(530,40);
         _loc2_.point = _loc3_;
         _loc2_.id = 149;
         _loc1_.push(_loc2_);
         _loc2_ = new Object();
         _loc3_ = new Point(1133,180);
         _loc2_.point = _loc3_;
         _loc2_.id = 146;
         _loc1_.push(_loc2_);
         this._mapPokemonArr.push(_loc1_);
      }
      
      private function setPokemonMapping(param1:MovieClip) : void
      {
         var _loc2_:int = Math.floor(this._mapPokemonArr.length * Math.random());
         var _loc3_:int = 0;
         while(_loc3_ < this._mapPokemonArr[_loc2_].length)
         {
            this.pokeImgLoader(param1,55,this._mapPokemonArr[_loc2_][_loc3_].id,this._mapPokemonArr[_loc2_][_loc3_].point.x,this._mapPokemonArr[_loc2_][_loc3_].point.y);
            _loc3_++;
         }
      }
      
      private function pokeImgLoader(param1:MovieClip, param2:int, param3:int, param4:Number, param5:Number) : void
      {
         var _loc6_:int = param3;
         var _loc7_:int = param2;
         var _loc8_:* = PokemonBridge.createRenderer();
         this._mapPokeMoveObj = new mapPokeMoveObj();
         param1.addChild(this._mapPokeMoveObj);
         this._mapPokeMoveObj.x = param4;
         this._mapPokeMoveObj.y = param5;
         if(Boolean(_loc8_) && param3 > 0)
         {
            _loc8_.loadToArea(_loc6_,0,_loc7_,_loc7_);
            this._mapPokeMoveObj.addBase_mc.addChild(_loc8_.display);
            _loc8_.shadowOpacity = 0;
            _loc8_.display.cacheAsBitmap = true;
            if(this._loopflg)
            {
               this._mapPokeMoveObj.addBase_mc.gotoAndPlay("loop");
               this._loopflg = false;
            }
            else
            {
               this._mapPokeMoveObj.addBase_mc.gotoAndPlay("loop2nd");
               this._loopflg = true;
            }
         }
      }
      
      private function pokeImgRemove(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1;
         while(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
      }
      
      private function __charaMoveHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         if(this._moveFlg)
         {
            _loc2_ = 0;
            while(_loc2_ < BG_NUM)
            {
               if(_loc2_ == 0)
               {
                  this._bgArr[_loc2_].x += this._baseSpeed;
               }
               else
               {
                  this._bgArr[_loc2_].x = this._bgArr[0].x - this._bgW * _loc2_;
               }
               _loc2_++;
            }
            this._bgMoveNum += this._baseSpeed;
            this._totalDistance += this._bgspeed;
            if(this._bgMoveNum > this._bgW * 2)
            {
               if(this._bgArr.length > 1)
               {
                  this._bgMoveNum -= this._bgW;
                  this._bgArr.push(this._bgArr.shift());
                  this._bgArr[0].x -= this._bgMoveNum;
                  this._bgMoveNum = 0;
                  this.pokeImgRemove(this._bgArr[1].addpoke);
                  this.setPokemonMapping(this._bgArr[1].addpoke);
               }
               else
               {
                  this._bgMoveNum -= this._bgW;
                  this._bgArr[0].x = -this._flightBg.width;
                  this._bgMoveNum = 0;
               }
            }
            dispatchEvent(new flightEvent(flightEvent.BG_MOVE));
         }
      }
      
      private function openingAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 1.5;
         var _loc3_:String = "easeOutExpo";
         var _loc4_:Function = this.openingAnime;
         _loc5_ = this;
         if(!param1)
         {
            _loc5_.y = -BG_START_MOVE;
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
            dispatchEvent(new flightEvent(flightEvent.GAME_OPENING_BG));
         }
      }
   }
}


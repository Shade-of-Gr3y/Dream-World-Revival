package hivelocity.flight.status
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol746")]
   public class flightMeter extends MovieClip
   {
      
      public static const METER:uint = 4;
      
      public static const ROLL_NUM:int = 30;
      
      public static const ROLL_10:int = 300;
      
      public var meter_2:MovieClip;
      
      public var meter_3:MovieClip;
      
      public var meter_4:MovieClip;
      
      public var blink_mc:MovieClip;
      
      public var meterTxt_4:TextField;
      
      public var meterTxt_1:TextField;
      
      public var meterTxt_3:TextField;
      
      public var meterTxt_2:TextField;
      
      public var meter_1:MovieClip;
      
      private var _maxMeter:uint = 1;
      
      private var _meter:int = 0;
      
      private var _gamePosition:Number = 0;
      
      private var _gameWidth:Number = 0;
      
      private var _rollY:Number = 0;
      
      private var _rollMoveArr:Array = [];
      
      private var _rollZeroArr:Array = [];
      
      public function flightMeter()
      {
         super();
         addFrameScript(0,this.frame1);
         this._rollY = this["meter_1"].y;
         var _loc1_:int = 1;
         while(_loc1_ <= METER)
         {
            this["meterTxt_" + _loc1_].text = "0";
            _loc1_++;
         }
         this.__init();
      }
      
      public function set setMeterMax(param1:uint) : void
      {
         this._maxMeter = param1;
         this.__setMeter(this._maxMeter);
      }
      
      public function set setGameWidthMax(param1:uint) : void
      {
         this._gameWidth = param1;
      }
      
      public function set setGamePosition(param1:Number) : void
      {
         this._gamePosition = param1;
         this._meter = this._maxMeter - this._maxMeter * (this._gamePosition / this._gameWidth);
         if(this._meter > this._maxMeter)
         {
            this._meter = this._maxMeter;
         }
         if(this._meter < 0)
         {
            this._meter = 0;
         }
         this.setMeter();
      }
      
      public function get getMeter() : int
      {
         return this._meter;
      }
      
      public function setMeter() : void
      {
         this.__setMeter(this._meter);
      }
      
      private function __init() : void
      {
      }
      
      private function __setMeter(param1:int) : void
      {
         var _loc7_:String = null;
         var _loc2_:String = param1.toString();
         var _loc3_:int = _loc2_.length;
         var _loc4_:String = "";
         var _loc5_:int = 1;
         while(_loc5_ <= METER - _loc3_)
         {
            _loc2_ = _loc7_ = "0" + _loc2_;
            _loc5_++;
         }
         this._rollZeroArr = [];
         var _loc6_:int = 1;
         while(_loc6_ <= _loc2_.length)
         {
            _loc4_ = _loc2_.charAt(_loc6_ - 1);
            if(this["meterTxt_" + _loc6_].text != "0")
            {
               this._rollZeroArr[_loc6_ - 1] = 1;
            }
            else if(this["meterTxt_" + _loc6_].text == "0")
            {
               this._rollZeroArr[_loc6_ - 1] = 2;
            }
            else
            {
               this._rollZeroArr[_loc6_ - 1] = 0;
            }
            this["meterTxt_" + _loc6_].text = _loc4_;
            _loc6_++;
         }
         this.__setRoll(param1);
      }
      
      private function __setRoll(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc11_:String = null;
         var _loc2_:Number = 0.2;
         var _loc3_:String = "easeOutQuad";
         var _loc5_:String = param1.toString();
         var _loc6_:int = _loc5_.length;
         this._rollMoveArr = [];
         var _loc7_:int = 1;
         while(_loc7_ <= METER - _loc6_)
         {
            _loc5_ = _loc11_ = "0" + _loc5_;
            _loc7_++;
         }
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < METER)
         {
            if(_loc5_.charAt(_loc9_) == "0" && this._rollZeroArr[_loc9_] == 1)
            {
               this._rollMoveArr[_loc9_] = ROLL_10 + this._rollY;
            }
            else if(this._rollZeroArr[_loc9_] == 2 && int(_loc5_.charAt(_loc9_)) == 0)
            {
               this["meter_" + (_loc9_ + 1)].y = this._rollY;
               this._rollMoveArr[_loc9_] = this._rollY;
            }
            else
            {
               this._rollMoveArr[_loc9_] = (10 - int(_loc5_.charAt(_loc9_))) * ROLL_NUM + this._rollY;
            }
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < METER)
         {
            _loc4_ = this["meter_" + (_loc10_ + 1)];
            if(_loc5_.charAt(_loc10_) == "0" && this._rollZeroArr[_loc10_] == 1)
            {
               this.rollmove(_loc4_,this._rollMoveArr[_loc10_],true);
            }
            else
            {
               this.rollmove(_loc4_,this._rollMoveArr[_loc10_]);
            }
            _loc10_++;
         }
      }
      
      private function rollmove(param1:MovieClip, param2:Number, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc5_:Number = 0.2;
         var _loc6_:String = "easeOutQuad";
         var _loc7_:Function = this.rollmove;
         var _loc8_:MovieClip = param1;
         if(!param4)
         {
            Tweener.addTween(_loc8_,{
               "y":param2,
               "time":_loc5_,
               "transition":_loc6_,
               "onComplete":_loc7_,
               "onCompleteParams":[param1,param2,param3,param4]
            });
         }
         else if(param3)
         {
            _loc8_.y = this._rollY;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}


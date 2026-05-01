package hivelocity.flight.object
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class objenergy extends MovieClip
   {
      
      internal static const ENERGY_POSITION_COLUMN_MARGIN:int = 150;
      
      internal static const ENERGY_POSITION_ROW_MARGIN:int = 0;
      
      internal static const ENERGY_POSITION_HEIGHT_MARGIN:int = 0;
      
      internal static const TIMER_DISTANCE:* = 33;
      
      internal static const ENERGY_TYPE_LEAF:uint = 1;
      
      internal static const ENERGY_TYPE_FIRE:uint = 2;
      
      internal static const ENERGY_TYPE_WATER:uint = 3;
      
      internal static const ENERGY_TYPE_THUNDER:uint = 4;
      
      private var _traceFlg:Boolean;
      
      private var _energySpeed:Number;
      
      private var _splitColumn:uint;
      
      private var _splitRow:uint;
      
      private var _moveFlg:Boolean;
      
      private var _moveTimer:Timer;
      
      private var _energyNum:int;
      
      private var _energyObjArr:Array;
      
      private var _energyPArr:Array;
      
      private var _energyMoveDistance:Number;
      
      private var _energyPattam:uint;
      
      private var _energyVisibleArea:uint;
      
      private var _flightEnergy:flightEnergy;
      
      private var _eneGetAnimArr:Array;
      
      private var _thunderFlg:Boolean;
      
      private var _targetArr:Array;
      
      private var _fps:uint = 30;
      
      public function objenergy()
      {
         super();
         this.__init();
      }
      
      public function set setTraceFlg(param1:Boolean) : void
      {
         this._traceFlg = param1;
      }
      
      public function set setEnergySpeed(param1:Number) : void
      {
         this._energySpeed = param1;
      }
      
      public function set setEnergyPositionArr(param1:Array) : void
      {
         this._energyPArr = param1;
         this._setEnergy(this._energyPArr);
      }
      
      public function set setSplitColumn(param1:Number) : void
      {
         this._splitColumn = param1;
      }
      
      public function set setSplitRow(param1:Number) : void
      {
         this._splitRow = param1;
      }
      
      public function set setPattam(param1:uint) : void
      {
         this._energyPattam = param1;
      }
      
      public function set seThunderFlg(param1:Boolean) : void
      {
         this._thunderFlg = param1;
         this.setEnergyGetDF(this._thunderFlg);
      }
      
      public function set setEnergyVisibleArea(param1:uint) : void
      {
         this._energyVisibleArea = param1 + ENERGY_POSITION_COLUMN_MARGIN * 2;
      }
      
      public function set setTargetEnergyArray(param1:Array) : void
      {
         this._targetArr = param1;
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function get getEnergyObjArr() : Array
      {
         return this._energyObjArr;
      }
      
      public function reset() : void
      {
         this._targetArr = [];
         this._moveFlg = false;
         removeEventListener(Event.ENTER_FRAME,this.__energyMoveHandler);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.__init();
      }
      
      public function start() : void
      {
         this._moveFlg = true;
         addEventListener(Event.ENTER_FRAME,this.__energyMoveHandler,false,0,true);
      }
      
      public function stopmove() : void
      {
         this._moveFlg = false;
         removeEventListener(Event.ENTER_FRAME,this.__energyMoveHandler);
      }
      
      public function eneGetAction(param1:int, param2:uint) : void
      {
         this._energyObjArr[param1].getFlg = true;
         this._energyObjArr[param1].obj.gotoAndPlay("get");
         this._energyObjArr[param1].obj.addEventListener(flightEvent.ENERGY_GET,this.__eneGetHandler,false,0,true);
         this._eneGetAnimArr.push(this._energyObjArr[param1]);
      }
      
      private function tracer(param1:*) : void
      {
         if(this._traceFlg)
         {
         }
      }
      
      private function __init() : void
      {
         this._targetArr = [];
         this._eneGetAnimArr = [];
         this._energyNum = 0;
         this._energyMoveDistance = 0;
         this._energyObjArr = [];
         this._energyPArr = [];
         this._thunderFlg = false;
      }
      
      private function eneObjController() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._energyObjArr.length)
         {
            if(this._energyObjArr[_loc1_].obj != null)
            {
               if(!this._energyObjArr[_loc1_].flg || Boolean(this._energyObjArr[_loc1_].delflg))
               {
                  this._energyObjArr[_loc1_].flg = false;
                  this._energyObjArr[_loc1_].delflg = false;
                  removeChild(this._energyObjArr[_loc1_].obj);
                  delete this._energyObjArr[_loc1_].obj;
               }
            }
            _loc1_++;
         }
      }
      
      private function _setEnergy(param1:Array) : void
      {
         var _loc3_:Object = null;
         this.eneObjController();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new Object();
            if(param1[_loc2_] > 0)
            {
               _loc3_.flg = true;
               _loc3_.delflg = false;
               _loc3_.getFlg = false;
               _loc3_.addspeed = 0;
               _loc3_.move = 0;
               _loc3_.type = param1[_loc2_];
               _loc3_.obj = new flightEnergy();
               _loc3_.obj.x = -ENERGY_POSITION_COLUMN_MARGIN;
               _loc3_.obj.y = _loc2_ * this._splitRow;
               _loc3_.obj.energyDF_mc.visible = this._thunderFlg;
               _loc3_.obj.coins.gotoAndStop(_loc3_.type);
               addChild(_loc3_.obj);
               _loc3_.obj.cacheAsBitmap = true;
               this._energyObjArr[this._energyNum] = _loc3_;
               ++this._energyNum;
            }
            _loc2_++;
         }
         this._moveFlg = true;
      }
      
      private function setEnergyGetDF(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._energyNum)
         {
            if(Boolean(this._energyObjArr[_loc2_].flg) && Boolean(!this._energyObjArr[_loc2_].getFlg) && this._energyObjArr[_loc2_].obj != null)
            {
               this._energyObjArr[_loc2_].obj.energyDF_mc.visible = param1;
            }
            _loc2_++;
         }
      }
      
      private function setTargetEnegy() : void
      {
      }
      
      private function targetJudge(param1:uint) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(this._targetArr.length > 0 || this._targetArr != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this._targetArr.length)
            {
               if(param1 == this._targetArr[_loc3_])
               {
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function __eneGetHandler(param1:flightEvent = null) : void
      {
         var _loc2_:* = param1.target;
         var _loc3_:Object = {};
         _loc2_.removeEventListener(flightEvent.ENERGY_GET,this.__eneGetHandler);
         if(this._eneGetAnimArr.length > 0)
         {
            this._eneGetAnimArr[this._eneGetAnimArr.length - 1].flg = false;
            this._eneGetAnimArr[this._eneGetAnimArr.length - 1].getFlg = false;
            _loc3_ = this._eneGetAnimArr.pop();
         }
      }
      
      private function __energyMoveHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this._moveFlg)
         {
            this.setEnergyGetDF(this._thunderFlg);
            _loc2_ = 0;
            while(_loc2_ < this._energyNum)
            {
               if(this._energyObjArr[_loc2_].obj != null)
               {
                  if(Boolean(this._energyObjArr[_loc2_].flg) || Boolean(this._energyObjArr[_loc2_].getFlg))
                  {
                     _loc3_ = this._energySpeed + this._energyObjArr[_loc2_].addspeed;
                     this._energyObjArr[_loc2_].obj.x += _loc3_;
                     this._energyObjArr[_loc2_].move += _loc3_;
                     if(this._energyObjArr[_loc2_].move > this._energyVisibleArea && !this._energyObjArr[_loc2_].getFlg)
                     {
                        this._energyObjArr[_loc2_].flg = false;
                        this._energyObjArr[_loc2_].obj.visible = false;
                        this._energyObjArr[_loc2_].delflg = true;
                     }
                  }
               }
               _loc2_++;
            }
            this._energyMoveDistance += this._energySpeed;
            if(this._energyMoveDistance > this._splitColumn)
            {
               this._energyMoveDistance = 0;
               dispatchEvent(new flightEvent(flightEvent.ENERGY_CHANGE));
            }
         }
      }
   }
}


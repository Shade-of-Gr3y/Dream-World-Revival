package hivelocity.flight.object
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class objcloud extends MovieClip
   {
      
      internal static const CLOUD_POSITION_MARGIN:int = 150;
      
      internal static const TIMER_DISTANCE:uint = 33;
      
      internal static const CLOUD_POSITION_HEGHT_MARGIN:int = 0;
      
      private var _traceFlg:Boolean;
      
      private var _cloudSpeed:Number;
      
      private var _splitColumn:uint;
      
      private var _splitRow:uint;
      
      private var _moveFlg:Boolean;
      
      private var _moveTimer:Timer;
      
      private var _cloudNum:int;
      
      private var _cloudObjArr:Array;
      
      private var _cloudPArr:Array;
      
      private var _cloudMoveDistance:Number;
      
      private var _cloudPattam:uint;
      
      private var _cloudVisibleArea:uint;
      
      private var _cloudSizeArr:Array;
      
      private var _flightCloud:flightCloud;
      
      private var _flightCloud120:flightCloud120;
      
      private var _flightCloud100:flightCloud100;
      
      private var _flightCloud80:flightCloud80;
      
      private var _flightCloud75:flightCloud75;
      
      private var _flightCloud70:flightCloud70;
      
      private var _flightCloud65:flightCloud65;
      
      private var _flightCloud60:flightCloud60;
      
      private var _fps:uint = 30;
      
      public function objcloud()
      {
         super();
         this.__init();
      }
      
      public function set setTraceFlg(param1:Boolean) : void
      {
         this._traceFlg = param1;
      }
      
      public function set setCloudSpeed(param1:Number) : void
      {
         this._cloudSpeed = param1;
      }
      
      public function set setCloudPositionArr(param1:Array) : void
      {
         this._cloudPArr = param1;
         this._setCloud(this._cloudPArr);
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
         this._cloudPattam = param1;
      }
      
      public function set setCloudVisibleArea(param1:uint) : void
      {
         this._cloudVisibleArea = param1 + CLOUD_POSITION_MARGIN * 2;
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function get getCloudObjArr() : Array
      {
         return this._cloudObjArr;
      }
      
      public function reset() : void
      {
         this._moveFlg = false;
         removeEventListener(Event.ENTER_FRAME,this.__cloudMoveHandler);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.__init();
      }
      
      public function start() : void
      {
         this._moveFlg = true;
         addEventListener(Event.ENTER_FRAME,this.__cloudMoveHandler,false,0,true);
      }
      
      public function stopmove() : void
      {
         this._moveFlg = false;
         removeEventListener(Event.ENTER_FRAME,this.__cloudMoveHandler);
      }
      
      private function tracer(param1:*) : void
      {
         if(this._traceFlg)
         {
         }
      }
      
      private function __init() : void
      {
         this._cloudNum = 0;
         this._cloudMoveDistance = 0;
         this._cloudObjArr = [];
         this._cloudPArr = [];
         this._cloudSizeArr = [0.6,0.65,0.7,0.75,0.8,0.9,1];
      }
      
      private function _setCloud(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new Object();
            if(param1[_loc2_] > 0)
            {
               _loc3_.flg = true;
               _loc3_.move = 0;
               _loc3_.type = param1[_loc2_];
               _loc3_.hitFlg = false;
               switch(_loc3_.type - 1)
               {
                  case 0:
                     _loc3_.obj = new flightCloud60();
                     break;
                  case 1:
                     _loc3_.obj = new flightCloud65();
                     break;
                  case 2:
                     _loc3_.obj = new flightCloud70();
                     break;
                  case 3:
                     _loc3_.obj = new flightCloud75();
                     break;
                  case 4:
                     _loc3_.obj = new flightCloud80();
                     break;
                  case 5:
                     _loc3_.obj = new flightCloud100();
                     break;
                  case 6:
                     _loc3_.obj = new flightCloud120();
               }
               _loc3_.obj.x = -CLOUD_POSITION_MARGIN;
               _loc3_.obj.y = _loc2_ * this._splitRow + CLOUD_POSITION_HEGHT_MARGIN;
               addChild(_loc3_.obj);
               _loc3_.obj.cacheAsBitmap = false;
               this._cloudObjArr[this._cloudNum] = _loc3_;
               ++this._cloudNum;
            }
            _loc2_++;
         }
         this._moveFlg = true;
      }
      
      private function __cloudMoveHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this._moveFlg)
         {
            _loc2_ = 0;
            while(_loc2_ < this._cloudNum)
            {
               if(this._cloudObjArr[_loc2_].obj != null)
               {
                  if(this._cloudObjArr[_loc2_].flg)
                  {
                     _loc3_ = this._cloudSpeed;
                     if(this._cloudObjArr[_loc2_].hitFlg)
                     {
                        this._cloudObjArr[_loc2_].obj.x += _loc3_ * 0.9;
                        this._cloudObjArr[_loc2_].move += _loc3_ * 0.9;
                     }
                     else
                     {
                        this._cloudObjArr[_loc2_].obj.x += _loc3_;
                        this._cloudObjArr[_loc2_].move += _loc3_;
                     }
                     if(this._cloudObjArr[_loc2_].move > this._cloudVisibleArea)
                     {
                        this._cloudObjArr[_loc2_].flg = false;
                        removeChild(this._cloudObjArr[_loc2_].obj);
                        delete this._cloudObjArr[_loc2_].obj;
                     }
                  }
               }
               _loc2_++;
            }
            this._cloudMoveDistance += this._cloudSpeed;
            if(this._cloudMoveDistance > this._splitColumn)
            {
               this._cloudMoveDistance = 0;
               dispatchEvent(new flightEvent(flightEvent.CLOUD_CHANGE));
            }
         }
      }
   }
}


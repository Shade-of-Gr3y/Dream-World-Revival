package hivelocity.flight
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class character extends MovieClip
   {
      
      internal static const MOVE_TIME_DISTANCE:uint = 33;
      
      internal static const MOVE_DISTANCE:Number = 0.03;
      
      internal static const MOVE_AREA:uint = 40;
      
      internal static const UNMOVE_AREA_SIDE:uint = 0;
      
      internal static const UNMOVE_AREA_TOP:uint = 40;
      
      internal static const UNMOVE_AREA_BOTTOM:uint = 80;
      
      internal static const LAYER_SPEED:uint = 1;
      
      internal static const LAYER_CLOUD:uint = 2;
      
      internal static const LAYER_THUNDER:uint = 3;
      
      internal static const LAYER_SPEEDANIME:uint = 4;
      
      internal static const SUPER_SPEED:uint = 1;
      
      internal static const HYPER_SPEED:uint = 2;
      
      internal static const SPEED_UP:String = "up";
      
      internal static const SPEED_DOWN:String = "down";
      
      private var _traceFlg:Boolean;
      
      private var _moveTimer:Timer;
      
      private var _mouseX:int;
      
      private var _mouseY:int;
      
      private var _stageW:uint;
      
      private var _stageH:uint;
      
      private var _mousePoint:Point;
      
      private var _chara:flightChara;
      
      private var _addSpeedIcon:addSpeedIcon;
      
      private var _hitCloud:hitCloud;
      
      private var _hitThunder:hitThunder;
      
      private var _hitCloudFlg:Boolean;
      
      private var _hitThunderFlg:Boolean;
      
      private var _pauseFlg:Boolean = false;
      
      private var _ctrlSpeed:Number;
      
      private var _speed:Number;
      
      private var _ctrlMax:Number;
      
      private var _charaSpeedAnime:charaSpeedAnime;
      
      private var _speedAnimeFlg:Boolean = true;
      
      private var _setSpeedStep:String = "";
      
      private var _setSpeedLayer:*;
      
      private var _fps:uint = 30;
      
      public function character()
      {
         super();
         this.__init();
      }
      
      public function set setTraceFlg(param1:Boolean) : void
      {
         this._traceFlg = param1;
      }
      
      public function set stageW(param1:uint) : void
      {
         this._stageW = param1;
      }
      
      public function set stageH(param1:uint) : void
      {
         this._stageH = param1;
      }
      
      public function set setSpeed(param1:Number) : void
      {
         this._speed = param1;
         this.charaSpeedController();
      }
      
      public function set setSpeedIconLayer(param1:*) : void
      {
         this._setSpeedLayer = param1;
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function get getCharaPosition() : Point
      {
         return new Point(this._chara.x,this._chara.y);
      }
      
      public function get getHitAreaMc() : Object
      {
         return this._chara["charaHitArea_mc"] as Object;
      }
      
      public function get getThunderHitFlg() : Boolean
      {
         return this._hitThunderFlg;
      }
      
      public function reset() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.__charaMoveHandler);
         removeChild(this._chara);
         this.__init();
      }
      
      public function start() : void
      {
         if(this._hitCloudFlg)
         {
            this._hitCloud.kumo.play();
         }
         if(this._hitThunderFlg)
         {
            this._hitThunder.play();
         }
         this._pauseFlg = false;
         this._chara.play();
         addEventListener(Event.ENTER_FRAME,this.__charaMoveHandler,false,0,true);
      }
      
      public function playAction() : void
      {
         this._pauseFlg = false;
         this._chara.play();
      }
      
      public function stopmove() : void
      {
         if(this._hitCloudFlg)
         {
            this.cloudStop();
            this._hitCloud.kumo.stop();
         }
         if(this._hitThunderFlg)
         {
            this._hitThunder.stop();
         }
         this._pauseFlg = true;
         this._chara.stop();
         removeEventListener(Event.ENTER_FRAME,this.__charaMoveHandler);
      }
      
      public function stopControl() : void
      {
         this._pauseFlg = true;
         removeEventListener(Event.ENTER_FRAME,this.__charaMoveHandler);
         this._chara.play();
      }
      
      public function goalAction() : void
      {
         this.cloudStop();
         removeEventListener(Event.ENTER_FRAME,this.__charaMoveHandler);
         this.removeActionCloud();
         this.charaMoveCenter();
      }
      
      public function setActionAddSpeed(param1:String) : void
      {
         if(param1 != null)
         {
            this._addSpeedIcon = new addSpeedIcon();
            this.charaSetObject(this._addSpeedIcon,LAYER_SPEED);
            this._addSpeedIcon.x = this._chara.x;
            this._addSpeedIcon.y = this._chara.y;
            this._addSpeedIcon.x += this._chara.width / 2;
            if(param1 == SPEED_UP)
            {
               this._addSpeedIcon.gotoAndPlay(SPEED_UP);
            }
            else if(param1 == SPEED_DOWN)
            {
               this._addSpeedIcon.gotoAndPlay(SPEED_DOWN);
            }
            this._addSpeedIcon.addEventListener(flightEvent.ADD_SPEED_REMOVE,this.addSpeedIconRemove,false,0,true);
         }
      }
      
      public function setActionAddCloud() : void
      {
         if(!this._hitCloudFlg)
         {
            this._hitCloudFlg = true;
            this._hitCloud = new hitCloud();
            this.charaSetObject(this._hitCloud,LAYER_CLOUD);
            this._hitCloud.kumo.gotoAndPlay("hit");
         }
      }
      
      public function cloudStop() : void
      {
         if(this._hitCloudFlg)
         {
            this._hitCloud.kumo.gotoAndStop(1);
         }
      }
      
      public function removeActionCloud() : void
      {
         if(this._hitCloudFlg)
         {
            this._hitCloudFlg = false;
            this._hitCloud.kumo.gotoAndStop(1);
            this.charaRemoveObject(this._hitCloud,LAYER_CLOUD);
         }
      }
      
      public function setActionAddThunder() : void
      {
         if(!this._hitThunderFlg)
         {
            this._hitThunderFlg = true;
            this._hitThunder = new hitThunder();
            this.charaSetObject(this._hitThunder,LAYER_THUNDER);
            this._hitThunder.gotoAndPlay("hit");
            this._hitThunder.addEventListener(flightEvent.ADD_THUNDER_REMOVE,this.addThunderRemove,false,0,true);
            this._chara.stop();
         }
      }
      
      public function setCharaSpeed(param1:uint) : void
      {
      }
      
      public function removeCharaSpeed() : void
      {
         if(!this._speedAnimeFlg)
         {
            if(this._charaSpeedAnime != null)
            {
               this.charaRemoveObject(this._charaSpeedAnime,LAYER_SPEEDANIME);
               this._charaSpeedAnime = null;
               this._speedAnimeFlg = true;
               this._setSpeedStep = "";
            }
         }
      }
      
      public function opening() : void
      {
         this.charaMoveOpening();
      }
      
      private function tracer(param1:*) : void
      {
         if(this._traceFlg)
         {
         }
      }
      
      private function __init() : void
      {
         this._hitThunderFlg = false;
         this._mousePoint = new Point();
         this._chara = new flightChara();
         addChild(this._chara);
         this._chara.cacheAsBitmap = true;
         this._chara.x = 1200;
         this._chara.y = 252;
      }
      
      private function charaSpeedController() : void
      {
         this._ctrlSpeed = MOVE_DISTANCE * (this._speed * 0.1);
         this._ctrlMax = this._speed * 0.5;
      }
      
      private function charaMoveCenter(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 2;
         var _loc3_:String = "easeOutQuad";
         var _loc4_:Function = this.charaMoveCenter;
         if(!param1)
         {
            _loc5_ = this._chara;
            Tweener.addTween(_loc5_,{
               "y":this._stageH / 2,
               "x":500,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.charaMoveOutGameArea();
         }
      }
      
      private function charaMoveOutGameArea(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 2;
         var _loc3_:String = "easeInQuart";
         var _loc4_:Function = this.charaMoveOutGameArea;
         if(!param1)
         {
            _loc5_ = this._chara;
            Tweener.addTween(_loc5_,{
               "x":-300,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
      }
      
      private function charaMoveOpening(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 2;
         var _loc3_:String = "easeOutQuart";
         var _loc4_:Function = this.charaMoveOpening;
         if(!param1)
         {
            _loc5_ = this._chara;
            Tweener.addTween(_loc5_,{
               "x":800,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
      }
      
      private function charaSetObject(param1:*, param2:uint) : void
      {
         var _loc3_:MovieClip = null;
         switch(param2)
         {
            case LAYER_SPEED:
               _loc3_ = this._setSpeedLayer;
               break;
            case LAYER_CLOUD:
               _loc3_ = this._chara["cloudLayer_mc"];
               break;
            case LAYER_THUNDER:
               _loc3_ = this._chara["thunderLayer_mc"];
               break;
            case LAYER_SPEEDANIME:
               _loc3_ = this._chara["charaSpeedLayer_mc"];
         }
         if(_loc3_ != null)
         {
            _loc3_.addChild(param1 as MovieClip);
         }
      }
      
      private function charaRemoveObject(param1:*, param2:uint) : void
      {
         var _loc3_:MovieClip = null;
         switch(param2)
         {
            case LAYER_SPEED:
               _loc3_ = this._setSpeedLayer;
               break;
            case LAYER_CLOUD:
               _loc3_ = this._chara["cloudLayer_mc"];
               break;
            case LAYER_THUNDER:
               _loc3_ = this._chara["thunderLayer_mc"];
               break;
            case LAYER_THUNDER:
               _loc3_ = this._chara["thunderLayer_mc"];
               break;
            case LAYER_SPEEDANIME:
               _loc3_ = this._chara["charaSpeedLayer_mc"];
         }
         if(_loc3_ != null)
         {
            _loc3_.removeChild(param1 as MovieClip);
         }
      }
      
      private function addSpeedIconRemove(param1:flightEvent = null) : void
      {
         var _loc2_:* = param1.target;
         _loc2_.removeEventListener(flightEvent.ADD_SPEED_REMOVE,this.addSpeedIconRemove);
         this.charaRemoveObject(_loc2_,LAYER_SPEED);
      }
      
      private function addThunderRemove(param1:flightEvent = null) : void
      {
         this._hitThunderFlg = false;
         var _loc2_:* = param1.target;
         _loc2_.removeEventListener(flightEvent.ADD_THUNDER_REMOVE,this.addThunderRemove);
         this.charaRemoveObject(_loc2_,LAYER_THUNDER);
         dispatchEvent(new flightEvent(flightEvent.ADD_THUNDER_REMOVE));
         this._chara.play();
      }
      
      private function __charaMoveHandler(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!this._hitThunderFlg && !this._pauseFlg)
         {
            _loc2_ = this._mousePoint.x * this._ctrlSpeed;
            _loc3_ = this._mousePoint.y * this._ctrlSpeed;
            if(this._ctrlMax < Math.abs(_loc2_))
            {
               if(_loc2_ < 0)
               {
                  _loc2_ = -this._ctrlMax;
               }
               else
               {
                  _loc2_ = this._ctrlMax * 1.5;
               }
            }
            if(this._ctrlMax < Math.abs(_loc3_))
            {
               if(_loc3_ < 0)
               {
                  _loc3_ = -this._ctrlMax;
               }
               else
               {
                  _loc3_ = this._ctrlMax;
               }
            }
            this._mousePoint.x = this._chara.mouseX;
            this._mousePoint.y = this._chara.mouseY;
            if(this._hitCloudFlg)
            {
               this._chara.x += Math.abs(_loc2_) * 0.5;
               this._chara.y += _loc3_;
            }
            else
            {
               this._chara.x += _loc2_;
               this._chara.y += _loc3_;
            }
            _loc4_ = this._chara.width - (this._chara.width - this._chara.charaArea.width);
            _loc5_ = this._chara.height - (this._chara.height - this._chara.charaArea.height);
            if(this._chara.x < UNMOVE_AREA_SIDE)
            {
               this._chara.x = UNMOVE_AREA_SIDE;
            }
            else if(this._chara.x > this._stageW - (_loc4_ + UNMOVE_AREA_SIDE))
            {
               this._chara.x = this._stageW - (_loc4_ + UNMOVE_AREA_SIDE);
            }
            if(this._chara.y < UNMOVE_AREA_TOP + _loc5_ / 2)
            {
               this._chara.y = UNMOVE_AREA_TOP + _loc5_ / 2;
            }
            else if(this._chara.y > this._stageH - (_loc5_ / 2 + UNMOVE_AREA_BOTTOM))
            {
               this._chara.y = this._stageH - (_loc5_ / 2 + UNMOVE_AREA_BOTTOM);
            }
            dispatchEvent(new flightEvent(flightEvent.CHARA_MOVE));
         }
      }
   }
}


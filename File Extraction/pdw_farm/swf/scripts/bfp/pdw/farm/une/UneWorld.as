package bfp.pdw.farm.une
{
   import bfp.common.Logger;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.water.*;
   import bfp.pokemon.liby.event.CustomEvent;
   import caurina.transitions.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class UneWorld extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var pokemonArea:MovieClip;
      
      private var uneMaskAreaObj:UneMaskArea;
      
      private var uneMaskAnimeObj:UneMaskAnime;
      
      private var fukidashiArea:MovieClip;
      
      private var fl:Number = 250;
      
      private var vpX:Number = 0;
      
      private var vpY:Number = 0;
      
      private var renderTimer:Timer;
      
      private var _rowLine:Number = 0;
      
      private var maxRowLine:Number = 0;
      
      private var minRowLine:Number = 0;
      
      private var moveDelayTimer:Timer;
      
      private const MOVE_FLAG_OK:int = 0;
      
      private const MOVE_FLAG_UP_NG:int = 1;
      
      private const MOVE_FLAG_DOWN_NG:int = 2;
      
      private var moveStatus:int = 0;
      
      private var uneList:Array = [];
      
      private var uneNameList:Array = ["farm_une_0","farm_une_1","farm_une_2","farm_une_3","farm_une_4"];
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function UneWorld(param1:MovieClip, param2:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.fukidashiArea = param2;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.targetMC.x = 501;
         this.targetMC.y = 100;
         this.pokemonArea = new MovieClip();
         this.renderTimer = new Timer(30 / 1000);
         this.renderTimer.addEventListener(TimerEvent.TIMER,this.onRenderingLoop);
         this.moveDelayTimer = new Timer(200);
         this.moveDelayTimer.addEventListener(TimerEvent.TIMER,this.onMoveDelayTimer);
         this._rowLine = 0;
      }
      
      public function run() : *
      {
      }
      
      public function stop() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         Tweener.removeTweens(this.targetMC);
         this.stopRendering();
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            _loc2_.stop();
            _loc2_.removeEventListener("onFieldClick",this.onFieldClick);
            _loc2_.removeEventListener("onFieldOver",this.onFieldOver);
            _loc2_.removeEventListener("onFieldOut",this.onFieldOut);
            _loc1_++;
         }
      }
      
      public function reset() : *
      {
         this.removeUne();
         this._rowLine = 0;
      }
      
      public function show(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.showEnd();
      }
      
      private function showEnd() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         this.create();
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            _loc2_.run();
            _loc2_.addEventListener("onFieldClick",this.onFieldClick);
            _loc2_.addEventListener("onFieldOver",this.onFieldOver);
            _loc2_.addEventListener("onFieldOut",this.onFieldOut);
            _loc2_.addEventListener("onUneClick",this.onUneClick);
            _loc1_++;
         }
         this.startRendering();
         if(!this.data.isFirstTutorial)
         {
            this.setBtnFunc();
         }
         if(this.data.isUneIncreaseAnime)
         {
            if(this.data.numFurrows > 5)
            {
               _loc3_ = this.data.numFurrows - 5;
               _loc4_ = this.moveRowLine(-_loc3_);
               this.bridge.updateNowUneCount(this.nowRowNum + 1);
               Tweener.addTween(this.targetMC,{
                  "delay":0.3 * _loc3_,
                  "onComplete":this.showDigda
               });
            }
            else
            {
               Tweener.addTween(this.targetMC,{
                  "delay":0.3,
                  "onComplete":this.showDigda
               });
            }
         }
      }
      
      private function showDigda() : *
      {
         dispatchEvent(new CustomEvent("onShowDigda"));
      }
      
      private function create() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         Logger.log("はたけ　うね生成↓↓↓↓↓↓↓↓↓");
         this.minRowLine = -(this.data.numFurrows - 1);
         this.uneList = [];
         _loc1_ = 0;
         while(_loc1_ < this.data.numFurrows)
         {
            _loc2_ = new Une(this.uneNameList[(_loc1_ + this.uneNameList.length) % this.uneNameList.length],_loc1_,this.fukidashiArea);
            _loc2_.positionNum = _loc1_ + 4;
            _loc2_.defaultPositonNum = _loc2_.positionNum;
            if(_loc2_.positionNum > 8)
            {
               _loc2_.z = this.data.unePosList[8].z + (_loc2_.positionNum - 8) * this.data.backSpaceZ;
               _loc2_.y = this.data.unePosList[8].y + this.data.BACKSPACE_Y;
               _loc2_.targetMC.alpha = 0;
               _loc2_.targetMC.visible = false;
            }
            else if(_loc2_.positionNum < 0)
            {
               _loc2_.z = this.data.unePosList[0].z + _loc2_.positionNum * this.data.frontSpaceZ;
               _loc2_.y = this.data.unePosList[0].y;
            }
            else
            {
               _loc2_.z = this.data.unePosList[_loc2_.positionNum].z;
               _loc2_.y = this.data.unePosList[_loc2_.positionNum].y;
            }
            _loc2_.oldZ = _loc2_.z;
            _loc2_.vpX = this.vpX;
            _loc2_.vpY = this.vpY;
            _loc2_.fl = this.fl;
            _loc2_.setInfomation(this.data.uneParamList[_loc1_]);
            _loc2_.render();
            this.targetMC.addChildAt(_loc2_.targetMC,0);
            this.uneList.push(_loc2_);
            _loc1_++;
         }
         Logger.log("はたけ　うね生成↑↑↑↑↑↑↑↑↑↑");
         if(this.data.isUneIncreaseAnime)
         {
            this.uneMaskAreaObj = new UneMaskArea("uneMask");
            this.uneMaskAreaObj.vpX = this.vpX;
            this.uneMaskAreaObj.vpY = this.vpY;
            this.uneMaskAreaObj.fl = this.fl;
            _loc2_ = this.uneList[this.uneList.length - 1];
            this.uneMaskAreaObj.defaultPositonNum = this.uneMaskAreaObj.positionNum = _loc2_.positionNum;
            this.uneMaskAreaObj.x = _loc2_.x;
            this.uneMaskAreaObj.y = _loc2_.y;
            this.uneMaskAreaObj.z = _loc2_.z;
            this.uneMaskAreaObj.render();
            this.targetMC.addChild(this.uneMaskAreaObj.targetMC);
            this.uneMaskAreaObj.targetMC.gotoAndStop(1);
            _loc2_.targetMC.mask = this.uneMaskAreaObj.targetMC;
            this.uneMaskAnimeObj = new UneMaskAnime("uneMaskAnime");
            this.uneMaskAnimeObj.vpX = this.vpX;
            this.uneMaskAnimeObj.vpY = this.vpY;
            this.uneMaskAnimeObj.fl = this.fl;
            _loc2_ = this.uneList[this.uneList.length - 1];
            this.uneMaskAnimeObj.defaultPositonNum = this.uneMaskAnimeObj.positionNum = _loc2_.positionNum;
            this.uneMaskAnimeObj.x = _loc2_.x;
            this.uneMaskAnimeObj.y = _loc2_.y;
            this.uneMaskAnimeObj.z = _loc2_.z;
            this.uneMaskAnimeObj.render();
            this.targetMC.addChildAt(this.uneMaskAnimeObj.targetMC,1);
            this.uneMaskAnimeObj.targetMC.alpha = 0;
            this.uneMaskAnimeObj.targetMC.gotoAndStop(1);
         }
      }
      
      private function removeUne() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            _loc2_.stop();
            _loc2_.reset();
            if(this.targetMC.contains(_loc2_.targetMC))
            {
               this.targetMC.removeChild(_loc2_.targetMC);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.uneList = [];
      }
      
      private function changeDepth() : *
      {
         var _loc2_:Une = null;
         var _loc1_:* = 0;
         this.uneList.sortOn("z",Array.NUMERIC | Array.DESCENDING);
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            this.targetMC.addChild(_loc2_.targetMC);
            _loc1_++;
         }
      }
      
      private function startRendering() : *
      {
         this.renderTimer.reset();
         this.renderTimer.start();
      }
      
      private function stopRendering() : *
      {
         this.renderTimer.stop();
         this.renderTimer.reset();
      }
      
      private function onRenderingLoop(param1:TimerEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Une = null;
         _loc2_ = 0;
         while(_loc2_ < this.uneList.length)
         {
            _loc3_ = this.uneList[_loc2_];
            _loc3_.render();
            _loc2_++;
         }
         if(this.uneMaskAreaObj != null)
         {
            this.uneMaskAreaObj.render();
         }
         if(this.uneMaskAnimeObj != null)
         {
            this.uneMaskAnimeObj.render();
         }
      }
      
      public function set rowLine(param1:Number) : *
      {
         this._rowLine = param1;
      }
      
      public function get rowLine() : *
      {
         return this._rowLine;
      }
      
      public function get nowRowNum() : Number
      {
         return -this._rowLine;
      }
      
      public function moveRowLine(param1:*) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:Une = null;
         var _loc2_:* = param1 - this._rowLine;
         var _loc3_:* = Math.abs(param1 - this._rowLine);
         var _loc4_:* = "rowNone";
         if(_loc2_ > 0 && this.moveStatus == this.MOVE_FLAG_UP_NG)
         {
            _loc4_ = "ng";
         }
         else if(_loc2_ < 0 && this.moveStatus == this.MOVE_FLAG_DOWN_NG)
         {
            _loc4_ = "ng";
         }
         else
         {
            if(_loc2_ > 0)
            {
               this.moveStatus = this.MOVE_FLAG_DOWN_NG;
               this.startMoveDelayTimer();
            }
            else
            {
               this.moveStatus = this.MOVE_FLAG_UP_NG;
               this.startMoveDelayTimer();
            }
            this._rowLine = param1;
            if(this._rowLine <= this.minRowLine)
            {
               this._rowLine = this.minRowLine;
               _loc4_ = "top";
            }
            else if(this._rowLine >= this.maxRowLine)
            {
               this._rowLine = this.maxRowLine;
               _loc4_ = "bottom";
            }
            _loc6_ = 1;
            _loc7_ = 0;
            _loc8_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this.uneList.length)
            {
               _loc10_ = this.uneList[_loc5_];
               _loc10_.positionNum = _loc10_.defaultPositonNum + this._rowLine;
               if(_loc10_.positionNum > 8)
               {
                  _loc8_ = this.data.unePosList[8].z + this.data.backSpaceZ * (_loc10_.positionNum - 8);
                  _loc7_ = this.data.unePosList[8].y + this.data.BACKSPACE_Y;
               }
               else if(_loc10_.positionNum < 0)
               {
                  _loc8_ = this.data.unePosList[0].z + this.data.frontSpaceZ * _loc10_.positionNum;
                  _loc7_ = this.data.unePosList[0].y;
               }
               else
               {
                  _loc8_ = this.data.unePosList[_loc10_.positionNum].z;
                  _loc7_ = this.data.unePosList[_loc10_.positionNum].y;
               }
               Tweener.removeTweens(_loc10_,"z");
               Tweener.addTween(_loc10_,{
                  "delay":0,
                  "time":0.3 * _loc3_,
                  "transition":"easeOutQuad",
                  "y":_loc7_,
                  "z":_loc8_
               });
               _loc5_++;
            }
            _loc9_ = 0;
            if(this.uneMaskAreaObj != null && this.data.isUneIncreaseAnime)
            {
               this.uneMaskAreaObj.positionNum = this.uneMaskAreaObj.defaultPositonNum + this._rowLine;
               if(this.uneMaskAreaObj.positionNum > 8)
               {
                  _loc8_ = this.data.unePosList[8].z + this.data.backSpaceZ * (this.uneMaskAreaObj.positionNum - 8);
                  _loc7_ = this.data.unePosList[8].y + this.data.BACKSPACE_Y;
               }
               else if(this.uneMaskAreaObj.positionNum < 0)
               {
                  _loc8_ = this.data.unePosList[0].z + this.data.frontSpaceZ * this.uneMaskAreaObj.positionNum;
                  _loc7_ = this.data.unePosList[0].y;
               }
               else
               {
                  _loc8_ = this.data.unePosList[this.uneMaskAreaObj.positionNum].z;
                  _loc7_ = this.data.unePosList[this.uneMaskAreaObj.positionNum].y;
               }
               Tweener.removeTweens(this.uneMaskAreaObj,"z");
               Tweener.addTween(this.uneMaskAreaObj,{
                  "delay":0,
                  "time":0.3 * _loc3_,
                  "transition":"easeOutQuad",
                  "y":_loc7_,
                  "z":_loc8_
               });
            }
            if(this.uneMaskAnimeObj != null && this.data.isUneIncreaseAnime)
            {
               this.uneMaskAnimeObj.positionNum = this.uneMaskAnimeObj.defaultPositonNum + this._rowLine;
               if(this.uneMaskAnimeObj.positionNum > 8)
               {
                  _loc8_ = this.data.unePosList[8].z + this.data.backSpaceZ * (this.uneMaskAnimeObj.positionNum - 8);
                  _loc7_ = this.data.unePosList[8].y + this.data.BACKSPACE_Y;
               }
               else if(this.uneMaskAnimeObj.positionNum < 0)
               {
                  _loc8_ = this.data.unePosList[0].z + this.data.frontSpaceZ * this.uneMaskAnimeObj.positionNum;
                  _loc7_ = this.data.unePosList[0].y;
               }
               else
               {
                  _loc8_ = this.data.unePosList[this.uneMaskAnimeObj.positionNum].z;
                  _loc7_ = this.data.unePosList[this.uneMaskAnimeObj.positionNum].y;
               }
               Tweener.removeTweens(this.uneMaskAnimeObj,"z");
               Tweener.addTween(this.uneMaskAnimeObj,{
                  "delay":0,
                  "time":0.3 * _loc3_,
                  "transition":"easeOutQuad",
                  "y":_loc7_,
                  "z":_loc8_
               });
            }
         }
         return _loc4_;
      }
      
      private function startMoveDelayTimer() : *
      {
         this.moveDelayTimer.stop();
         this.moveDelayTimer.reset();
         this.moveDelayTimer.delay = 300;
         this.moveDelayTimer.start();
      }
      
      private function stopMoveDelayTimer() : *
      {
         this.moveDelayTimer.stop();
         this.moveDelayTimer.reset();
      }
      
      private function onMoveDelayTimer(param1:TimerEvent) : *
      {
         this.stopMoveDelayTimer();
         this.moveStatus = this.MOVE_FLAG_OK;
      }
      
      private function onFieldClick(param1:CustomEvent) : *
      {
         var _loc2_:* = {};
         _loc2_.uneId = param1.obj.uneId;
         _loc2_.fieldId = param1.obj.fieldId;
         _loc2_.status = param1.obj.status;
         _loc2_.x = param1.obj.x;
         _loc2_.y = param1.obj.y;
         _loc2_.h = param1.obj.h;
         _loc2_.nutsName = param1.obj.nutsName;
         _loc2_.nutsID = param1.obj.nutsID;
         _loc2_.nutsDescription = param1.obj.nutsDescription;
         _loc2_.isAPI = param1.obj.isAPI;
         if(_loc2_.uneId == this.nowRowNum)
         {
            dispatchEvent(new CustomEvent("onFieldClick",_loc2_));
         }
         else
         {
            dispatchEvent(new CustomEvent("onFieldClickForMove",_loc2_));
         }
      }
      
      private function onFieldOver(param1:CustomEvent) : *
      {
         var _loc2_:* = {};
         _loc2_.uneId = param1.obj.uneId;
         _loc2_.fieldId = param1.obj.fieldId;
         _loc2_.status = param1.obj.status;
         _loc2_.x = param1.obj.x;
         _loc2_.y = param1.obj.y;
         _loc2_.h = param1.obj.h;
         _loc2_.nutsName = param1.obj.nutsName;
         _loc2_.nutsID = param1.obj.nutsID;
         _loc2_.nutsDescription = param1.obj.nutsDescription;
         if(_loc2_.uneId == this.nowRowNum)
         {
            dispatchEvent(new CustomEvent("onFieldOver",_loc2_));
         }
      }
      
      private function onFieldOut(param1:CustomEvent) : *
      {
         if(param1.obj.uneId == this.nowRowNum)
         {
            dispatchEvent(new CustomEvent("onFieldOut",{
               "uneId":param1.obj.uneId,
               "fieldId":param1.obj.fieldId,
               "status":param1.obj.status
            }));
         }
      }
      
      private function onUneClick(param1:CustomEvent) : *
      {
         if(param1.obj.uneID != this.nowRowNum)
         {
            dispatchEvent(new CustomEvent("onUneClick",{"uneId":param1.obj.uneID}));
         }
      }
      
      public function setBtnFunc() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            if(_loc1_ == this.nowRowNum)
            {
               _loc2_.targetMC.mouseEnabled = false;
               _loc2_.setBtnFunc();
               _loc2_.clearUneBtnFunc();
            }
            else
            {
               _loc2_.targetMC.mouseEnabled = false;
               _loc2_.setBtnFunc(false);
               _loc2_.setUneBtnFunc();
            }
            _loc1_++;
         }
      }
      
      public function clearBtnFunc() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            _loc2_.clearBtnFunc();
            _loc1_++;
         }
      }
      
      public function changeBtnActive() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            if(_loc1_ == this.nowRowNum)
            {
            }
            _loc1_++;
         }
      }
      
      public function plantNuts(param1:*, param2:*, param3:*, param4:*, param5:*) : *
      {
         var _loc6_:Une = this.uneList[param2];
         _loc6_.plantNuts(param1,param3,param4,param5);
      }
      
      public function restoreSoil(param1:*, param2:*) : *
      {
         var _loc3_:Une = null;
         var _loc5_:* = undefined;
         var _loc4_:Array = [];
         var _loc6_:* = 0;
         switch(this.data.selectSprinklerData.interior_id)
         {
            case this.data.SPRINKLER_ID_DONFAN:
               _loc3_ = this.uneList[param1];
               _loc3_.restoreSoil(param2,[0,1,2]);
               break;
            case this.data.SPRINKLER_ID_KAIOUGA:
               _loc6_ = Math.min(this.data.numFurrows - param1,5);
               _loc5_ = 0;
               while(_loc5_ < this.uneList.length)
               {
                  _loc3_ = this.uneList[_loc5_];
                  _loc3_.restoreSoil(param2,[0,1,2]);
                  _loc5_++;
               }
               break;
            default:
               _loc3_ = this.uneList[param1];
               _loc3_.restoreSoil(param2);
         }
         this.clearBtnFunc();
         this.setBtnFunc();
      }
      
      public function glowNuts(param1:*, param2:*) : *
      {
         var _loc3_:Une = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc4_:Array = [];
         var _loc7_:* = 0;
         switch(this.data.selectSprinklerData.interior_id)
         {
            case this.data.SPRINKLER_ID_DONFAN:
               _loc3_ = this.uneList[param1];
               _loc3_.glowNuts(param2,[0,1,2]);
               break;
            case this.data.SPRINKLER_ID_KAIOUGA:
               _loc7_ = Math.min(this.data.numFurrows - param1,5);
               _loc5_ = 0;
               while(_loc5_ < this.uneList.length)
               {
                  _loc3_ = this.uneList[_loc5_];
                  _loc3_.glowNuts(param2,[0,1,2]);
                  _loc5_++;
               }
               break;
            default:
               _loc3_ = this.uneList[param1];
               _loc3_.glowNuts(param2);
         }
      }
      
      public function harvestNuts(param1:*, param2:*) : *
      {
         var _loc3_:Une = this.uneList[param1];
         _loc3_.harvestNuts(param2);
      }
      
      public function watering(param1:*, param2:*) : *
      {
         var _loc3_:Une = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc4_:Array = [];
         var _loc7_:* = 0;
         switch(this.data.selectSprinklerData.interior_id)
         {
            case this.data.SPRINKLER_ID_DONFAN:
               _loc3_ = this.uneList[param1];
               _loc5_ = 0;
               while(_loc5_ < 3)
               {
                  if(param2 != _loc5_)
                  {
                     _loc4_.push(_loc5_);
                  }
                  _loc5_++;
               }
               _loc3_.watering(param2,_loc4_);
               break;
            case this.data.SPRINKLER_ID_KAIOUGA:
               _loc7_ = Math.min(this.data.numFurrows - param1,5);
               _loc5_ = 0;
               while(_loc5_ < this.uneList.length)
               {
                  _loc4_ = [];
                  _loc3_ = this.uneList[_loc5_];
                  if(_loc5_ == param1)
                  {
                     _loc6_ = 0;
                     while(_loc6_ < 3)
                     {
                        if(param2 != _loc6_)
                        {
                           _loc4_.push(_loc6_);
                        }
                        _loc6_++;
                     }
                     _loc3_.watering(param2,_loc4_);
                  }
                  else if(param1 < _loc5_ && _loc5_ < _loc7_)
                  {
                     _loc3_.watering(param2,[0,1,2]);
                  }
                  else
                  {
                     _loc3_.secondWatering(param2,[0,1,2]);
                  }
                  _loc5_++;
               }
         }
      }
      
      public function showNewUne() : *
      {
         Tweener.addTween(this.uneMaskAnimeObj.targetMC,{
            "delay":0.3,
            "time":0.2,
            "transition":"linear",
            "alpha":1
         });
         Tweener.addTween(this.uneMaskAnimeObj.targetMC,{
            "delay":0.5,
            "time":2,
            "transition":"linear",
            "_frame":60
         });
         Tweener.addTween(this.uneMaskAnimeObj.targetMC,{
            "delay":2.2,
            "time":0.2,
            "transition":"linear",
            "alpha":0
         });
         Tweener.addTween(this.uneMaskAreaObj.targetMC,{
            "delay":0.5,
            "time":2,
            "transition":"linear",
            "_frame":60,
            "onComplete":this.showNewUneEnd
         });
      }
      
      private function showNewUneEnd() : *
      {
         var _loc1_:Une = this.uneList[this.uneList.length - 1];
         _loc1_.targetMC.mask = null;
         this.uneMaskAreaObj.targetMC.visible = false;
         if(this.targetMC.contains(this.uneMaskAreaObj.targetMC))
         {
            this.targetMC.removeChild(this.uneMaskAreaObj.targetMC);
         }
         this.uneMaskAreaObj.stop();
         this.uneMaskAreaObj.reset();
         this.uneMaskAreaObj = null;
         this.uneMaskAnimeObj.targetMC.visible = false;
         if(this.targetMC.contains(this.uneMaskAnimeObj.targetMC))
         {
            this.targetMC.removeChild(this.uneMaskAnimeObj.targetMC);
         }
         this.uneMaskAnimeObj.stop();
         this.uneMaskAnimeObj.reset();
         this.uneMaskAnimeObj = null;
         Tweener.addTween(this.targetMC,{
            "delay":0.3,
            "onComplete":this.uneIncrementAnimeFinish
         });
      }
      
      private function uneIncrementAnimeFinish() : *
      {
         dispatchEvent(new CustomEvent("onUneIncrementAnimeFinish"));
      }
      
      public function tutorialGoGetNutsScene() : *
      {
         var _loc1_:Une = this.uneList[0];
         _loc1_.tutorialGoGetNutsScene();
      }
      
      public function tutorialFinish() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Une = null;
         _loc1_ = 0;
         while(_loc1_ < this.uneList.length)
         {
            _loc2_ = this.uneList[_loc1_];
            _loc2_.tutorialFinish();
            _loc1_++;
         }
      }
   }
}


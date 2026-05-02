package bfp.pdw.farm.field
{
   import bfp.PDWBridge;
   import bfp.common.Logger;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import bfp.pokemon.liby.event.CustomEvent;
   import bfp.pokemon.liby.util.BtnSetting;
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
   
   public class NutsField extends EventDispatcher
   {
      
      private var _targetMC:MovieClip;
      
      public var btnMC:MovieClip;
      
      private var nutsArea:MovieClip;
      
      private var lightArea:MovieClip;
      
      private var naeMC:MovieClip;
      
      private var naeBtnMC:MovieClip;
      
      private var wateringArea:MovieClip;
      
      private var fukidashiArea:MovieClip;
      
      private var soilObj:Soil;
      
      private var waterintAreaObj:NutsFieldWaterArea;
      
      private var fukidashiAreaCtrObj:NutsInfomationCtr;
      
      private var fukidashiObj:NutsInfomation;
      
      private var glowAnimeAreaObj:GlowAnimaArea;
      
      private var messageObj:Message;
      
      private var _id:Number = 0;
      
      private var uneId:Number = 0;
      
      private var fieldStatus:String = "";
      
      private var plantStatus:String = "";
      
      private var soilStatus:String = "";
      
      private var plantNutsID:Number = -1;
      
      private var kirakiraCount:Number = 30;
      
      private var isAPI:* = false;
      
      private var friendFieldStatus:String = "";
      
      private var friendPlantStatus:String = "";
      
      private var plantList:Object;
      
      private var infoObj:Object;
      
      private var lightList:Array = [];
      
      private var data:FarmData;
      
      private var kirakiraTimer:Timer;
      
      public function NutsField(param1:MovieClip, param2:Number, param3:Number, param4:MovieClip)
      {
         super();
         this._targetMC = param1;
         this._id = param2;
         this.uneId = param3;
         this.fukidashiArea = param4;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.fieldStatus = this.data.FIELD_STATUS_NONE;
         this.btnMC = this._targetMC.btnMC;
         this.btnMC.mouseChildren = false;
         this.nutsArea = this._targetMC.nutsArea;
         this.nutsArea.mouseChildren = false;
         this.nutsArea.mouseEnabled = false;
         this.nutsArea.visible = false;
         this.nutsArea.alpha = 0;
         this.lightArea = new MovieClip();
         this.lightArea.mouseChildren = false;
         this.lightArea.mouseEnabled = false;
         this._targetMC.addChild(this.lightArea);
         this.wateringArea = this._targetMC.wateringArea;
         this.wateringArea.mouseChildren = false;
         this.wateringArea.mouseEnabled = false;
         this.wateringArea.visible = false;
         this.wateringArea.alpha = 0;
         this.kirakiraTimer = new Timer(1000 / 30,this.kirakiraCount);
         this.kirakiraTimer.addEventListener(TimerEvent.TIMER,this.onKirakiraTimerLoop);
         this.kirakiraTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onKirakiraTimerComplete);
         this.plantList = {};
         this.waterintAreaObj = new NutsFieldWaterArea(this._targetMC.wateringArea);
         this.soilObj = new Soil(this._targetMC.soilMC,this._targetMC.defaultSoil);
         this.fukidashiAreaCtrObj = new NutsInfomationCtr(this.fukidashiArea,this.btnMC);
         this.glowAnimeAreaObj = new GlowAnimaArea();
         this.messageObj = new Message();
      }
      
      public function reset() : *
      {
         this.soilObj.reset();
         this.waterintAreaObj.reset();
         this.removeLight();
         this.fukidashiAreaCtrObj.reset();
         this.glowAnimeAreaObj.resetContent();
      }
      
      public function stop() : *
      {
         this.soilObj.stop();
         this.waterintAreaObj.stop();
         this.removeNaeImg();
         this.clearBtnFunc();
         this.fukidashiAreaCtrObj.stop();
         this.fukidashiAreaCtrObj.removeEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
         this.glowAnimeAreaObj.stopContent();
      }
      
      public function run() : *
      {
         this.soilObj.run();
         this.waterintAreaObj.run();
         this.fukidashiAreaCtrObj.run();
      }
      
      private function onPDWOneHourAlert(param1:Event) : *
      {
         Logger.log("はたけ　1時間");
         this.fukidashiAreaCtrObj.hide();
      }
      
      private function onPDWOneHourAlertSleep(param1:Event) : *
      {
         Logger.log("はたけ　1時間　と　起こす？");
         this.fukidashiAreaCtrObj.hide();
      }
      
      private function onPDWPressureAlert(param1:Event) : *
      {
         Logger.log("はたけ　退出要求");
         this.fukidashiAreaCtrObj.hide();
      }
      
      private function onPDWPressureAlertSleep(param1:Event) : *
      {
         Logger.log("はたけ　退出要求　と　起こす？");
         this.fukidashiAreaCtrObj.hide();
      }
      
      private function onPDWExitAlert(param1:Event) : *
      {
         Logger.log("はたけ　強制退出");
         this.fukidashiAreaCtrObj.hide();
         this.clearBtnFunc();
      }
      
      private function onPDWExitAlertSleep(param1:Event) : *
      {
         Logger.log("はたけ　強制退出　と　起こす？");
         this.fukidashiAreaCtrObj.hide();
         this.clearBtnFunc();
      }
      
      public function setBtnFunc(param1:* = true) : *
      {
         if(param1)
         {
            if(this.data.isFriendMode)
            {
               switch(this.fieldStatus)
               {
                  case this.data.FIELD_STATUS_PLANT:
                     switch(this.soilStatus)
                     {
                        case this.data.SOIL_STATUS_SAFE:
                           this.isAPI = false;
                           BtnSetting.addBtn(this.btnMC,{
                              "click":this.onClick,
                              "over":this.onOver,
                              "out":this.onOut,
                              "buttonMode":false
                           });
                           break;
                        default:
                           this.isAPI = true;
                           BtnSetting.addBtn(this.btnMC,{
                              "click":this.onClick,
                              "over":this.onOver,
                              "out":this.onOut,
                              "buttonMode":true
                           });
                     }
                     break;
                  default:
                     this.isAPI = false;
                     BtnSetting.addBtn(this.btnMC,{
                        "click":this.onClick,
                        "over":this.onOver,
                        "out":this.onOut,
                        "buttonMode":false
                     });
               }
            }
            else
            {
               switch(this.fieldStatus)
               {
                  case this.data.FIELD_STATUS_PLANT:
                     switch(this.soilStatus)
                     {
                        case this.data.SOIL_STATUS_SAFE:
                           this.isAPI = false;
                           BtnSetting.addBtn(this.btnMC,{
                              "click":this.onClick,
                              "over":this.onOver,
                              "out":this.onOut,
                              "buttonMode":false
                           });
                           break;
                        default:
                           this.isAPI = true;
                           BtnSetting.addBtn(this.btnMC,{
                              "click":this.onClick,
                              "over":this.onOver,
                              "out":this.onOut,
                              "buttonMode":true
                           });
                     }
                     break;
                  default:
                     this.isAPI = true;
                     BtnSetting.addBtn(this.btnMC,{
                        "click":this.onClick,
                        "over":this.onOver,
                        "out":this.onOut,
                        "buttonMode":true
                     });
               }
            }
         }
         else
         {
            this.isAPI = false;
            BtnSetting.removeBtn(this.btnMC,{
               "click":this.onClick,
               "over":this.onOver,
               "out":this.onOut,
               "buttonMode":false
            });
            BtnSetting.addBtn(this.btnMC,{
               "click":this.onClick,
               "buttonMode":true
            });
         }
      }
      
      public function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.btnMC,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":false
         });
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         if(this.data.isFriendMode)
         {
            switch(this.fieldStatus)
            {
               case this.data.FIELD_STATUS_PLANT:
                  this.clickFunc();
            }
         }
         else
         {
            this.clickFunc();
         }
      }
      
      private function clickFunc() : *
      {
         PDWBridge.sfxClick();
         var _loc1_:* = {};
         _loc1_.fieldID = this._id;
         _loc1_.status = this.fieldStatus;
         _loc1_.h = this.btnMC.height;
         _loc1_.nutsName = this.infoObj.nutsName;
         _loc1_.nutsID = this.plantNutsID;
         _loc1_.nutsDescription = this.infoObj.nutsDescription;
         _loc1_.isAPI = this.isAPI;
         if(this.isAPI)
         {
            this.fukidashiAreaCtrObj.stopDelayOutTimer();
            this.fukidashiAreaCtrObj.stopOverCheck();
            this.fukidashiAreaCtrObj.hideFukidashi();
         }
         dispatchEvent(new CustomEvent("onFieldClick",_loc1_));
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         PDWBridge.sfxMouseOver();
         switch(this.fieldStatus)
         {
            case this.data.FIELD_STATUS_NONE:
               this.fukidashiAreaCtrObj.show(this.fieldStatus,this.plantStatus,this.infoObj.nutsName,this.plantNutsID,this.uneId,this._id,this.soilStatus);
               break;
            case this.data.FIELD_STATUS_PLANT:
               this.fukidashiAreaCtrObj.addEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
               this.fukidashiAreaCtrObj.show(this.fieldStatus,this.plantStatus,this.infoObj.nutsName,this.plantNutsID,this.uneId,this._id,this.soilStatus);
               break;
            case this.data.FIELD_STATUS_NUTS:
               this.fukidashiAreaCtrObj.addEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
               this.fukidashiAreaCtrObj.show(this.fieldStatus,this.plantStatus,this.infoObj.nutsName,this.plantNutsID,this.uneId,this._id,this.soilStatus);
         }
      }
      
      private function onFukidashiDetailClick(param1:CustomEvent) : *
      {
         this.fukidashiAreaCtrObj.removeEventListener("onFukidashiDetailClick",this.onFukidashiDetailClick);
         var _loc2_:* = {};
         _loc2_.nutsName = this.infoObj.nutsName;
         _loc2_.nutsID = this.plantNutsID;
         _loc2_.nutsDescription = this.infoObj.nutsDescription;
         FarmBridge.getInstance().showDetailPanel(_loc2_);
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         switch(this.fieldStatus)
         {
            case this.data.FIELD_STATUS_NONE:
               this.fukidashiAreaCtrObj.startDelayOutTimer();
               break;
            case this.data.FIELD_STATUS_PLANT:
               this.fukidashiAreaCtrObj.startDelayOutTimer();
               break;
            case this.data.FIELD_STATUS_NUTS:
               this.fukidashiAreaCtrObj.startDelayOutTimer();
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get targetMC() : MovieClip
      {
         return this._targetMC;
      }
      
      public function plantNuts(param1:*, param2:*, param3:*) : *
      {
         this.plantNutsID = param1;
         this.infoObj.nutsID = param1;
         this.infoObj.nutsName = param2;
         this.infoObj.nutsDescription = param3;
         this.fieldStatus = this.data.FIELD_STATUS_PLANT;
         this.plantStatus = this.data.PLANT_STATUS_SOIL;
         this.soilStatus = this.data.SOIL_STATUS_SAFE;
         this.infoObj.f_HP = 100;
         this.addNaeImg();
         this.changePlantStatusView(this.data.isFriendMode);
         this.soilObj.change(this.soilStatus);
         this.clearBtnFunc();
         this.setBtnFunc(true);
      }
      
      public function restoreSoil() : *
      {
         this.soilStatus = this.data.SOIL_STATUS_SAFE;
         switch(this.fieldStatus)
         {
            case this.data.FIELD_STATUS_PLANT:
               this.soilObj.change(this.soilStatus);
         }
      }
      
      public function glowNuts() : *
      {
         if(this.data.isFriendMode)
         {
            switch(this.fieldStatus)
            {
               case this.data.FIELD_STATUS_PLANT:
                  if(this.infoObj.f_HP < 100)
                  {
                     this.infoObj.f_HP = 100;
                     this.targetMC.addChild(this.glowAnimeAreaObj);
                     this.glowAnimeAreaObj.y = -this.btnMC.height / 2;
                     this.glowAnimeAreaObj.addEventListener("kirakiraFinish",this.onKirakiraFinish);
                     this.glowAnimeAreaObj.runContent();
                  }
                  this.watringAnimetion();
            }
         }
         else
         {
            switch(this.fieldStatus)
            {
               case this.data.FIELD_STATUS_PLANT:
                  if(this.infoObj.f_HP < 100)
                  {
                     this.infoObj.f_HP = 100;
                     this.targetMC.addChild(this.glowAnimeAreaObj);
                     this.glowAnimeAreaObj.y = -this.btnMC.height / 2;
                     this.glowAnimeAreaObj.addEventListener("kirakiraFinish",this.onKirakiraFinish);
                     this.glowAnimeAreaObj.runContent();
                  }
                  this.watringAnimetion();
            }
         }
      }
      
      private function onKirakiraFinish(param1:CustomEvent) : *
      {
         if(this.targetMC.contains(this.glowAnimeAreaObj))
         {
            this.targetMC.removeChild(this.glowAnimeAreaObj);
         }
         this.glowAnimeAreaObj.removeEventListener("kirakiraFinish",this.onKirakiraFinish);
      }
      
      public function harvestNuts() : *
      {
         this.fieldStatus = this.data.FIELD_STATUS_NONE;
         this.soilStatus = this.data.SOIL_STATUS_SAFE;
         this.plantStatus = this.data.PLANT_STATUS_SOIL;
         this.soilObj.change("none");
         this.harvestAnime();
      }
      
      public function watering() : *
      {
         var _loc1_:* = 0;
         var _loc2_:* = -this.data.SPRINKLER_POS_HEIGHT;
         var _loc3_:* = this.data.SPRINKLER_POS_HEIGHT;
         switch(this.fieldStatus)
         {
            case this.data.FIELD_STATUS_PLANT:
               this.waterintAreaObj.show();
               this.waterintAreaObj.startWater(_loc1_,_loc2_,_loc3_);
         }
      }
      
      public function secondWatering() : *
      {
         switch(this.fieldStatus)
         {
            case this.data.FIELD_STATUS_PLANT:
         }
      }
      
      public function setInfomation(param1:Object) : *
      {
         Logger.log("はたけ　状態反映 uneID:" + this.uneId + "  fieldID:" + this._id + " 　HP:" + param1.f_HP + "  field_status:" + param1.f_status + "  plant_status:" + param1.p_status);
         this.infoObj = param1;
         this.plantNutsID = param1.nutsID;
         switch(param1.f_status)
         {
            case this.data.FIELD_STATUS_NONE:
               this.fieldStatus = this.data.FIELD_STATUS_NONE;
               this.friendFieldStatus = this.data.FIELD_STATUS_NONE;
               this.changeNoneView();
               break;
            case this.data.FIELD_STATUS_PLANT:
               this.addNaeImg();
               this.fieldStatus = this.data.FIELD_STATUS_PLANT;
               this.friendFieldStatus = this.data.FIELD_STATUS_PLANT;
               this.changePlantView();
               break;
            case this.data.FIELD_STATUS_NUTS:
               this.addNaeImg();
               this.fieldStatus = this.data.FIELD_STATUS_NUTS;
               this.friendFieldStatus = this.data.FIELD_STATUS_PLANT;
               if(this.data.isFriendMode)
               {
                  this.changeNutsView();
                  break;
               }
               this.changeNutsView();
         }
      }
      
      private function addNaeImg() : *
      {
         var _loc1_:Loader = this.data.uneParamList[this.uneId][this.id].naeLoader;
         _loc1_.x = -Math.floor(this.data.PLANT_WID / 2);
         _loc1_.y = -Math.floor(105);
         this.naeMC = MovieClip(_loc1_.content);
         this.nutsArea.addChild(_loc1_);
         var _loc2_:Loader = this.data.uneParamList[this.uneId][this.id].btnLoader;
         _loc2_.x = -Math.floor(this.data.PLANT_WID / 2);
         _loc2_.y = -Math.floor(105);
         this.naeBtnMC = MovieClip(_loc2_.content);
         this.btnMC.addChild(_loc2_);
      }
      
      private function removeNaeImg() : *
      {
         if(!(this.data.uneParamList[this.uneId][this.id].naeLoader == null || this.data.uneParamList[this.uneId][this.id].naeLoader == undefined))
         {
            if(this.nutsArea.contains(this.data.uneParamList[this.uneId][this.id].naeLoader))
            {
               this.nutsArea.removeChild(this.data.uneParamList[this.uneId][this.id].naeLoader);
            }
         }
         if(!(this.data.uneParamList[this.uneId][this.id].btnLoader == null || this.data.uneParamList[this.uneId][this.id].btnLoader == undefined))
         {
            if(this.btnMC.contains(this.data.uneParamList[this.uneId][this.id].btnLoader))
            {
               this.btnMC.removeChild(this.data.uneParamList[this.uneId][this.id].btnLoader);
            }
         }
      }
      
      private function changeNoneView() : *
      {
         this.plantStatus = this.data.PLANT_STATUS_SOIL;
         this.soilStatus = this.data.SOIL_STATUS_SAFE;
         this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
      }
      
      private function changePlantView() : *
      {
         switch(this.infoObj.p_status)
         {
            case this.data.PLANT_STATUS_SOIL:
               this.plantStatus = this.data.PLANT_STATUS_SOIL;
               this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
               break;
            case this.data.PLANT_STATUS_SPROUT:
               this.plantStatus = this.data.PLANT_STATUS_SPROUT;
               this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
               break;
            case this.data.PLANT_STATUS_TRUNK:
               this.plantStatus = this.data.PLANT_STATUS_TRUNK;
               this.friendPlantStatus = this.data.PLANT_STATUS_SPROUT;
               break;
            case this.data.PLANT_STATUS_FLOWER:
               this.plantStatus = this.data.PLANT_STATUS_FLOWER;
               this.friendPlantStatus = this.data.PLANT_STATUS_TRUNK;
               break;
            case this.data.PLANT_STATUS_FRUIT:
               this.plantStatus = this.data.PLANT_STATUS_FRUIT;
               this.friendPlantStatus = this.data.PLANT_STATUS_FLOWER;
         }
         if(this.data.isFriendMode)
         {
            this.glow();
         }
         else
         {
            this.glow();
         }
         if(Number(this.infoObj.f_HP) > 70)
         {
            this.soilStatus = this.data.SOIL_STATUS_SAFE;
            this.soilObj.change(this.soilStatus);
         }
         else if(Number(this.infoObj.f_HP) <= 70 && Number(this.infoObj.f_HP) > 0)
         {
            this.soilStatus = this.data.SOIL_STATUS_CAUTION;
            this.soilObj.change(this.soilStatus);
         }
         else
         {
            this.soilStatus = this.data.SOIL_STATUS_DANGER;
            this.soilObj.change(this.soilStatus);
         }
      }
      
      private function changeNutsView() : *
      {
         this.plantStatus = this.data.PLANT_STATUS_FRUIT;
         this.glow();
         this.fruitsAnime();
         if(Number(this.infoObj.f_HP) > 70)
         {
            this.soilStatus = this.data.SOIL_STATUS_SAFE;
            this.soilObj.change(this.soilStatus);
         }
         else if(Number(this.infoObj.f_HP) <= 70 && Number(this.infoObj.f_HP) > 0)
         {
            this.soilStatus = this.data.SOIL_STATUS_CAUTION;
            this.soilObj.change(this.soilStatus);
         }
         else
         {
            this.soilStatus = this.data.SOIL_STATUS_DANGER;
            this.soilObj.change(this.soilStatus);
         }
      }
      
      private function changePlantStatusView(param1:* = false) : *
      {
         var _loc2_:* = this.plantStatus;
         if(!param1)
         {
         }
         switch(_loc2_)
         {
            case this.data.PLANT_STATUS_SPROUT:
               this.naeMC.gotoAndStop(2);
               this.naeBtnMC.gotoAndStop(2);
               break;
            case this.data.PLANT_STATUS_TRUNK:
               this.naeMC.gotoAndStop(3);
               this.naeBtnMC.gotoAndStop(3);
               break;
            case this.data.PLANT_STATUS_FLOWER:
               this.naeMC.gotoAndStop(4);
               this.naeBtnMC.gotoAndStop(4);
               break;
            case this.data.PLANT_STATUS_FRUIT:
               this.naeMC.gotoAndStop(5);
               this.naeBtnMC.gotoAndStop(5);
         }
      }
      
      private function glow() : *
      {
         switch(this.plantStatus)
         {
            case this.data.PLANT_STATUS_SPROUT:
            case this.data.PLANT_STATUS_TRUNK:
            case this.data.PLANT_STATUS_FLOWER:
               break;
            case this.data.PLANT_STATUS_FRUIT:
               this.fruitsAnime();
         }
         this.changeNuts();
      }
      
      private function friendGlow() : *
      {
         switch(this.friendPlantStatus)
         {
            case this.data.PLANT_STATUS_SPROUT:
            case this.data.PLANT_STATUS_TRUNK:
            case this.data.PLANT_STATUS_FLOWER:
               break;
            case this.data.PLANT_STATUS_FRUIT:
               this.fruitsAnime();
         }
         this.changeFriendNuts();
      }
      
      private function watringAnimetion() : *
      {
         Tweener.removeTweens(this.nutsArea);
         Tweener.addTween(this.nutsArea,{
            "delay":0,
            "time":0.05,
            "transition":"easeOutQuad",
            "scaleX":1.1,
            "scaleY":1.3
         });
         Tweener.addTween(this.nutsArea,{
            "delay":0.05,
            "time":0.5,
            "transition":"easeOutElastic",
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function changeNuts() : *
      {
         this.nutsArea.visible = true;
         this.nutsArea.alpha = 1;
         Tweener.removeTweens(this.nutsArea);
         Tweener.addTween(this.nutsArea,{
            "delay":0,
            "time":0.05,
            "transition":"easeOutQuad",
            "scaleX":1.1,
            "scaleY":1.3,
            "onComplete":this.changeNutsSecond
         });
      }
      
      private function changeNutsSecond() : *
      {
         this.changePlantStatusView();
         Tweener.addTween(this.nutsArea,{
            "delay":0,
            "time":0.5,
            "transition":"easeOutElastic",
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function changeFriendNuts() : *
      {
         this.nutsArea.visible = true;
         this.nutsArea.alpha = 1;
         Tweener.removeTweens(this.nutsArea);
         Tweener.addTween(this.nutsArea,{
            "delay":0,
            "time":0.05,
            "transition":"easeOutQuad",
            "scaleX":1.1,
            "scaleY":1.3,
            "onComplete":this.changeFriendNutsSecond
         });
      }
      
      private function changeFriendNutsSecond() : *
      {
         this.changePlantStatusView(true);
         Tweener.addTween(this.nutsArea,{
            "delay":0,
            "time":0.5,
            "transition":"easeOutElastic",
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function fruitsAnime() : *
      {
         this.startKiraKira();
      }
      
      private function startKiraKira() : *
      {
         this.kirakiraTimer.reset();
         this.kirakiraTimer.start();
      }
      
      private function stopKiraKira() : *
      {
         this.kirakiraTimer.stop();
         this.kirakiraTimer.reset();
      }
      
      private function onKirakiraTimerLoop(param1:TimerEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Light = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc4_:* = (this.nutsArea.width - this.nutsArea.width / 2) * 1.2;
         var _loc5_:* = (this.nutsArea.height - this.nutsArea.height / 2) * 1.2;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new Light();
            _loc3_.addEventListener("onLightEnd",this.onLightEnd);
            _loc3_.scaleX = _loc3_.scaleY = Math.random() * 1 + 0.5;
            _loc6_ = Math.random() * 360;
            _loc7_ = _loc6_ / 180 * Math.PI;
            _loc8_ = Math.cos(_loc7_) * Math.random() * _loc4_;
            _loc9_ = Math.sin(_loc7_) * Math.random() * _loc5_ - _loc5_;
            _loc3_.start(_loc8_,_loc9_);
            this.lightArea.addChild(_loc3_);
            this.lightList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function onKirakiraTimerComplete(param1:TimerEvent) : *
      {
         this.stopKiraKira();
      }
      
      private function onLightEnd(param1:CustomEvent) : *
      {
         var _loc2_:Light = Light(param1.currentTarget);
         var _loc3_:* = this.lightList.indexOf(_loc2_);
         var _loc4_:* = this.lightList.splice(_loc3_,1);
         _loc2_.removeEventListener("onLightEnd",this.onLightEnd);
         _loc2_.stopContent();
         if(this.lightArea.contains(_loc2_))
         {
            this.lightArea.removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function removeLight() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Light = null;
         _loc1_ = this.lightList.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.lightList[_loc1_];
            _loc2_.stopContent();
            if(this.lightArea.contains(_loc2_))
            {
               this.lightArea.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_--;
         }
         this.lightList = [];
      }
      
      private function harvestAnime() : *
      {
         if(this.naeMC != null)
         {
            this.naeMC.gotoAndStop(1);
         }
         if(this.naeBtnMC != null)
         {
            this.naeBtnMC.gotoAndStop(1);
         }
      }
      
      private function removeAllPlant() : *
      {
      }
      
      public function tutorialFinish() : *
      {
         this.infoObj.nutsID = this.data.uneParamList[this.uneId][this._id].nutsID;
         this.infoObj.myCroftID = this.data.uneParamList[this.uneId][this._id].myCroftID;
         this.infoObj.pokeItemID = this.data.uneParamList[this.uneId][this._id].pokeItemID;
         this.infoObj.nutsName = this.data.uneParamList[this.uneId][this._id].nutsName;
         this.infoObj.f_HP = this.data.uneParamList[this.uneId][this._id].f_HP;
         this.infoObj.p_status = this.data.uneParamList[this.uneId][this._id].p_status;
         this.infoObj.f_status = this.data.uneParamList[this.uneId][this._id].f_status;
         this.plantNutsID = this.infoObj.nutsID;
         switch(this.infoObj.f_status)
         {
            case this.data.FIELD_STATUS_NONE:
               this.fieldStatus = this.data.FIELD_STATUS_NONE;
               this.friendFieldStatus = this.data.FIELD_STATUS_NONE;
               this.plantStatus = this.data.PLANT_STATUS_SOIL;
               this.soilStatus = this.data.SOIL_STATUS_SAFE;
               this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
               break;
            case this.data.FIELD_STATUS_PLANT:
               this.fieldStatus = this.data.FIELD_STATUS_PLANT;
               this.friendFieldStatus = this.data.FIELD_STATUS_PLANT;
               switch(this.infoObj.p_status)
               {
                  case this.data.PLANT_STATUS_SOIL:
                     this.plantStatus = this.data.PLANT_STATUS_SOIL;
                     this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
                     break;
                  case this.data.PLANT_STATUS_SPROUT:
                     this.plantStatus = this.data.PLANT_STATUS_SPROUT;
                     this.friendPlantStatus = this.data.PLANT_STATUS_SOIL;
                     break;
                  case this.data.PLANT_STATUS_TRUNK:
                     this.plantStatus = this.data.PLANT_STATUS_TRUNK;
                     this.friendPlantStatus = this.data.PLANT_STATUS_SPROUT;
                     break;
                  case this.data.PLANT_STATUS_FLOWER:
                     this.plantStatus = this.data.PLANT_STATUS_FLOWER;
                     this.friendPlantStatus = this.data.PLANT_STATUS_TRUNK;
                     break;
                  case this.data.PLANT_STATUS_FRUIT:
                     this.plantStatus = this.data.PLANT_STATUS_FRUIT;
                     this.friendPlantStatus = this.data.PLANT_STATUS_FLOWER;
               }
               if(this.infoObj.f_HP == 100)
               {
                  this.soilStatus = this.data.SOIL_STATUS_SAFE;
                  break;
               }
               if(this.infoObj.f_HP > 70)
               {
                  this.soilStatus = this.data.SOIL_STATUS_CAUTION;
                  break;
               }
               this.soilStatus = this.data.SOIL_STATUS_DANGER;
               break;
            case this.data.FIELD_STATUS_NUTS:
               this.fieldStatus = this.data.FIELD_STATUS_NUTS;
               this.friendFieldStatus = this.data.FIELD_STATUS_PLANT;
               this.plantStatus = this.data.PLANT_STATUS_FRUIT;
               if(this.infoObj.f_HP == 100)
               {
                  this.soilStatus = this.data.SOIL_STATUS_SAFE;
                  break;
               }
               if(this.infoObj.f_HP > 70)
               {
                  this.soilStatus = this.data.SOIL_STATUS_CAUTION;
                  break;
               }
               this.soilStatus = this.data.SOIL_STATUS_DANGER;
         }
         this.soilObj.change("none");
         this.harvestAnime();
      }
   }
}


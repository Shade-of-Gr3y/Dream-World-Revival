package bfp.pdw.farm.une
{
   import bfp.PDWBridge;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.core.objects.*;
   import bfp.pdw.farm.field.*;
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
   
   public class Une extends Container3D
   {
      
      private var className:String = "";
      
      private var _id:Number = 0;
      
      private var _positionNum:Number = 0;
      
      public var defaultPositonNum:Number = 0;
      
      private var uneBg:MovieClip;
      
      private var fukidashiArea:MovieClip;
      
      public var oldZ:Number = 0;
      
      private var fieldList:Array;
      
      private var data:FarmData;
      
      public function Une(param1:*, param2:*, param3:*, param4:* = 0, param5:* = 0, param6:* = 0)
      {
         this.className = param1;
         this._id = param2;
         this.fukidashiArea = param3;
         var _loc7_:* = getDefinitionByName(param1);
         super(new _loc7_(),param4,param5,param6);
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         _targetMC.mouseEnabled = false;
         this.uneBg = _targetMC.bg;
         this.fieldList = [];
         this.fieldList.push(new NutsField(_targetMC.field0,0,this.id,this.fukidashiArea));
         this.fieldList.push(new NutsField(_targetMC.field1,1,this.id,this.fukidashiArea));
         this.fieldList.push(new NutsField(_targetMC.field2,2,this.id,this.fukidashiArea));
      }
      
      public function reset() : *
      {
      }
      
      public function stop() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:NutsField = null;
         _loc1_ = 0;
         while(_loc1_ < this.fieldList.length)
         {
            _loc2_ = this.fieldList[_loc1_];
            _loc2_.stop();
            _loc2_.removeEventListener("onFieldClick",this.onFieldClick);
            _loc1_++;
         }
      }
      
      public function run() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:NutsField = null;
         _loc1_ = 0;
         while(_loc1_ < this.fieldList.length)
         {
            _loc2_ = this.fieldList[_loc1_];
            _loc2_.run();
            _loc2_.addEventListener("onFieldClick",this.onFieldClick);
            _loc2_.addEventListener("onFieldOver",this.onFieldOver);
            _loc2_.addEventListener("onFieldOut",this.onFieldOut);
            _loc1_++;
         }
      }
      
      public function setBtnFunc(param1:* = true) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:NutsField = null;
         _loc2_ = 0;
         while(_loc2_ < this.fieldList.length)
         {
            _loc3_ = this.fieldList[_loc2_];
            _loc3_.setBtnFunc(param1);
            _loc2_++;
         }
      }
      
      public function clearBtnFunc() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:NutsField = null;
         _loc1_ = 0;
         while(_loc1_ < this.fieldList.length)
         {
            _loc2_ = this.fieldList[_loc1_];
            _loc2_.clearBtnFunc();
            _loc1_++;
         }
      }
      
      private function onFieldClick(param1:CustomEvent) : *
      {
         var _loc2_:NutsField = this.fieldList[param1.obj.fieldID];
         var _loc3_:* = _loc2_.targetMC.x * scale;
         var _loc4_:* = _loc2_.targetMC.y * scale;
         var _loc5_:Point = targetMC.localToGlobal(new Point(_loc3_,_loc4_));
         var _loc6_:* = {};
         _loc6_.uneId = this._id;
         _loc6_.fieldId = param1.obj.fieldID;
         _loc6_.status = param1.obj.status;
         _loc6_.x = _loc5_.x;
         _loc6_.y = _loc5_.y;
         _loc6_.h = param1.obj.h;
         _loc6_.nutsID = param1.obj.nutsID;
         _loc6_.nutsName = param1.obj.nutsName;
         _loc6_.nutsDescription = param1.obj.nutsDescription;
         _loc6_.isAPI = param1.obj.isAPI;
         dispatchEvent(new CustomEvent("onFieldClick",_loc6_));
      }
      
      private function onFieldOver(param1:CustomEvent) : *
      {
         var _loc2_:NutsField = this.fieldList[param1.obj.fieldID];
         var _loc3_:* = _loc2_.targetMC.x * scale;
         var _loc4_:* = _loc2_.targetMC.y * scale;
         var _loc5_:Point = targetMC.localToGlobal(new Point(_loc3_,_loc4_));
         var _loc6_:* = {};
         _loc6_.uneId = this._id;
         _loc6_.fieldId = param1.obj.fieldID;
         _loc6_.status = param1.obj.status;
         _loc6_.x = _loc5_.x;
         _loc6_.y = _loc5_.y;
         _loc6_.h = param1.obj.h;
         _loc6_.nutsID = param1.obj.nutsID;
         _loc6_.nutsName = param1.obj.nutsName;
         _loc6_.nutsDescription = param1.obj.nutsDescription;
         dispatchEvent(new CustomEvent("onFieldOver",_loc6_));
      }
      
      private function onFieldOut(param1:CustomEvent) : *
      {
         dispatchEvent(new CustomEvent("onFieldOut",{
            "uneId":this._id,
            "fieldId":param1.obj.fieldID,
            "status":param1.obj.status
         }));
      }
      
      public function setUneBtnFunc() : *
      {
         BtnSetting.addBtn(this.uneBg,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":true
         });
      }
      
      public function clearUneBtnFunc() : *
      {
         BtnSetting.removeBtn(this.uneBg,{
            "click":this.onClick,
            "over":this.onOver,
            "out":this.onOut,
            "buttonMode":false
         });
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.uneBg:
               dispatchEvent(new CustomEvent("onUneClick",{"uneID":this._id}));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.uneBg:
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.uneBg:
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get positionNum() : Number
      {
         return this._positionNum;
      }
      
      public function set positionNum(param1:Number) : *
      {
         this._positionNum = param1;
      }
      
      override public function render() : *
      {
         super.render();
         var _loc1_:* = 1;
         if(z > this.oldZ)
         {
            if(this.oldZ <= 370 && z > 370)
            {
               Tweener.removeTweens(targetMC,"_autoAlpha");
               Tweener.addTween(targetMC,{
                  "delay":0,
                  "time":0.3,
                  "transition":"easeOutQuad",
                  "_autoAlpha":0
               });
            }
            else if(this.oldZ <= 0 - this.data.frontSpaceZ && z > 0 - this.data.frontSpaceZ)
            {
               Tweener.removeTweens(targetMC,"_autoAlpha");
               Tweener.addTween(targetMC,{
                  "delay":0,
                  "time":0.3,
                  "transition":"easeOutQuad",
                  "_autoAlpha":1
               });
            }
            else if(!(this.oldZ > 370 && z > 370))
            {
               if(!(this.oldZ <= 0 - this.data.frontSpaceZ && z <= 0 - this.data.frontSpaceZ))
               {
                  if(!targetMC.visible)
                  {
                     Tweener.removeTweens(targetMC,"_autoAlpha");
                     Tweener.addTween(targetMC,{
                        "delay":0,
                        "time":0.3,
                        "transition":"easeOutQuad",
                        "_autoAlpha":1
                     });
                  }
               }
            }
         }
         else if(z < this.oldZ)
         {
            if(this.oldZ >= 0 && z < 0)
            {
               Tweener.removeTweens(targetMC,"_autoAlpha");
               Tweener.addTween(targetMC,{
                  "delay":0,
                  "time":0.3,
                  "transition":"easeOutQuad",
                  "_autoAlpha":0
               });
            }
            else if(z < 370 + this.data.BACKSPACE_Y && this.oldZ >= 370 + this.data.BACKSPACE_Y)
            {
               Tweener.removeTweens(targetMC,"_autoAlpha");
               Tweener.addTween(targetMC,{
                  "delay":0,
                  "time":0.3,
                  "transition":"easeOutQuad",
                  "_autoAlpha":1
               });
            }
            else if(!(z < 0 && this.oldZ < 0))
            {
               if(!(z > 370 + this.data.BACKSPACE_Y && this.oldZ > 370 + this.data.BACKSPACE_Y))
               {
                  if(!targetMC.visible)
                  {
                     Tweener.removeTweens(targetMC,"_autoAlpha");
                     Tweener.addTween(targetMC,{
                        "delay":0,
                        "time":0.3,
                        "transition":"easeOutQuad",
                        "_autoAlpha":1
                     });
                  }
               }
            }
         }
         if(!targetMC.visible)
         {
            targetMC.scaleX = targetMC.scaleY = 0;
         }
         this.oldZ = z;
      }
      
      public function setInfomation(param1:Array) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:NutsField = null;
         _loc2_ = 0;
         while(_loc2_ < this.fieldList.length)
         {
            _loc3_ = this.fieldList[_loc2_];
            _loc3_.setInfomation(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function plantNuts(param1:*, param2:*, param3:*, param4:*) : *
      {
         var _loc5_:NutsField = this.fieldList[param2];
         _loc5_.plantNuts(param1,param3,param4);
      }
      
      public function restoreSoil(param1:*, param2:Array = null) : *
      {
         var _loc3_:NutsField = null;
         var _loc4_:* = undefined;
         if(param2 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc3_ = this.fieldList[param2[_loc4_]];
               _loc3_.restoreSoil();
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = this.fieldList[param1];
            _loc3_.restoreSoil();
         }
      }
      
      public function glowNuts(param1:*, param2:Array = null) : *
      {
         var _loc3_:NutsField = null;
         var _loc4_:* = undefined;
         if(param2 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc3_ = this.fieldList[param2[_loc4_]];
               _loc3_.glowNuts();
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = this.fieldList[param1];
            _loc3_.glowNuts();
         }
      }
      
      public function harvestNuts(param1:*) : *
      {
         var _loc2_:NutsField = this.fieldList[param1];
         _loc2_.harvestNuts();
      }
      
      public function watering(param1:*, param2:Array = null) : *
      {
         var _loc3_:NutsField = null;
         var _loc4_:* = undefined;
         if(param2 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc3_ = this.fieldList[param2[_loc4_]];
               _loc3_.watering();
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = this.fieldList[param1];
            _loc3_.watering();
         }
      }
      
      public function secondWatering(param1:*, param2:Array) : *
      {
         var _loc3_:NutsField = null;
         var _loc4_:* = undefined;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = this.fieldList[param2[_loc4_]];
            _loc3_.watering();
            _loc4_++;
         }
      }
      
      public function tutorialGoGetNutsScene() : *
      {
         var _loc1_:NutsField = this.fieldList[1];
         _loc1_.setBtnFunc();
      }
      
      public function tutorialFinish() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:NutsField = null;
         _loc1_ = 0;
         while(_loc1_ < this.fieldList.length)
         {
            _loc2_ = this.fieldList[_loc1_];
            _loc2_.tutorialFinish();
            _loc1_++;
         }
      }
   }
}


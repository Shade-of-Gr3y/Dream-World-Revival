package bfp.pdw.farm.une
{
   import bfp.PDWBridge;
   import bfp.PDWBridgeEvent;
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
   
   public class FieldCtr extends EventDispatcher
   {
      
      private var uneWorldObj:UneWorld;
      
      private var arrowBtnUnitObj:ArrowBtnUnit;
      
      private var digdaAreaObj:DigdaArea;
      
      private var pokemonAreaObj:PokemonFiledArea;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var selectUneID:Number = 0;
      
      private var selectFieldID:Number = 0;
      
      private var selectNutsName:String = "";
      
      public var isTutorial:Boolean = false;
      
      public function FieldCtr(param1:UneWorld, param2:ArrowBtnUnit, param3:DigdaArea, param4:PokemonFiledArea)
      {
         super();
         this.uneWorldObj = param1;
         this.arrowBtnUnitObj = param2;
         this.digdaAreaObj = param3;
         this.pokemonAreaObj = param4;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
      }
      
      public function reset() : *
      {
         this.uneWorldObj.reset();
         this.arrowBtnUnitObj.reset();
         this.digdaAreaObj.reset();
         this.pokemonAreaObj.reset();
      }
      
      public function stop() : *
      {
         this.clearEvent();
         this.uneWorldObj.stop();
         this.arrowBtnUnitObj.stop();
         this.digdaAreaObj.stop();
         this.pokemonAreaObj.stop();
      }
      
      public function run() : *
      {
         this.uneWorldObj.run();
         this.arrowBtnUnitObj.run();
         this.digdaAreaObj.run();
         this.pokemonAreaObj.run();
         this.setEvent();
      }
      
      public function show(param1:* = 0, param2:* = false) : *
      {
         this.isTutorial = param2;
         this.uneWorldObj.show(param1);
         this.pokemonAreaObj.show(param1);
         if(!this.data.isUneIncreaseAnime)
         {
            if(this.data.numFurrows > 1)
            {
               this.arrowBtnUnitObj.enable("top");
            }
         }
      }
      
      public function startUneIncreaseAnime() : *
      {
         this.onShowDigda(null);
      }
      
      private function setEvent() : *
      {
         this.bridge.addEventListener("onPlantNuts",this.onPlantNuts);
         this.bridge.addEventListener("onGlowthNuts",this.onGlowthNuts);
         this.bridge.addEventListener("onHarvestNuts",this.onHarvestNuts);
         this.bridge.addEventListener("onRestoreSoil",this.onRestoreSoil);
         this.bridge.addEventListener("onHideDigda",this.onHideDigda);
         this.bridge.addEventListener("onStartWater",this.onStartWater);
         this.bridge.addEventListener("onTutorialFinish",this.onTutorialFinish);
         this.bridge.addEventListener("onAppearArrow",this.onAppearArrow);
         this.bridge.addEventListener("onBanishArrow",this.onBanishArrow);
         this.bridge.addEventListener("onStartNewUneAnime",this.onStartNewUneAnime);
         this.arrowBtnUnitObj.addEventListener("onArrowBtnClick",this.onArrowBtnClick);
         this.uneWorldObj.addEventListener("onFieldClick",this.onFieldClick);
         this.uneWorldObj.addEventListener("onFieldClickForMove",this.onFieldClickForMove);
         this.uneWorldObj.addEventListener("onFieldOver",this.onFieldOver);
         this.uneWorldObj.addEventListener("onFieldOut",this.onFieldOut);
         this.uneWorldObj.addEventListener("onUneClick",this.onUneClick);
         this.uneWorldObj.addEventListener("onShowDigda",this.onShowDigda);
         this.uneWorldObj.addEventListener("onUneIncrementAnimeFinish",this.onUneIncrementAnimeFinish);
         this.pokemonAreaObj.addEventListener("onPokemonClick",this.onPokemonClick);
         PDWBridge.addEventListener(PDWBridgeEvent.HOME_MOVE_START,this.onHomeMoveStart);
      }
      
      private function clearEvent() : *
      {
         this.bridge.removeEventListener("onPlantNuts",this.onPlantNuts);
         this.bridge.removeEventListener("onGlowthNuts",this.onGlowthNuts);
         this.bridge.removeEventListener("onHarvestNuts",this.onHarvestNuts);
         this.bridge.removeEventListener("onRestoreSoil",this.onRestoreSoil);
         this.bridge.removeEventListener("onHideDigda",this.onHideDigda);
         this.bridge.removeEventListener("onStartWater",this.onStartWater);
         this.bridge.removeEventListener("onTutorialFinish",this.onTutorialFinish);
         this.bridge.removeEventListener("onAppearArrow",this.onAppearArrow);
         this.bridge.removeEventListener("onBanishArrow",this.onBanishArrow);
         this.bridge.removeEventListener("onStartNewUneAnime",this.onStartNewUneAnime);
         this.arrowBtnUnitObj.removeEventListener("onArrowBtnClick",this.onArrowBtnClick);
         this.uneWorldObj.removeEventListener("onFieldClick",this.onFieldClick);
         this.uneWorldObj.removeEventListener("onFieldClickForMove",this.onFieldClickForMove);
         this.uneWorldObj.removeEventListener("onFieldOver",this.onFieldOver);
         this.uneWorldObj.removeEventListener("onFieldOut",this.onFieldOut);
         this.uneWorldObj.removeEventListener("onUneClick",this.onUneClick);
         this.uneWorldObj.removeEventListener("onShowDigda",this.onShowDigda);
         this.uneWorldObj.removeEventListener("onUneIncrementAnimeFinish",this.onUneIncrementAnimeFinish);
         this.pokemonAreaObj.removeEventListener("onPokemonClick",this.onPokemonClick);
         PDWBridge.removeEventListener(PDWBridgeEvent.HOME_MOVE_START,this.onHomeMoveStart);
      }
      
      private function onPlantNuts(param1:CustomEvent) : *
      {
         if(this.data.isFirstTutorial)
         {
            this.selectFieldID = 1;
         }
         this.uneWorldObj.plantNuts(param1.obj.nutsID,this.selectUneID,this.selectFieldID,param1.obj.nutsName,param1.obj.selectNutsDescription);
      }
      
      private function onRestoreSoil(param1:CustomEvent) : *
      {
         this.uneWorldObj.restoreSoil(param1.obj.uneID,param1.obj.fieldID);
      }
      
      private function onGlowthNuts(param1:CustomEvent) : *
      {
         this.uneWorldObj.glowNuts(param1.obj.uneID,param1.obj.fieldID);
      }
      
      private function onHarvestNuts(param1:CustomEvent) : *
      {
         this.uneWorldObj.harvestNuts(param1.obj.uneID,param1.obj.fieldID);
      }
      
      private function onStartNewUneAnime(param1:CustomEvent) : *
      {
         this.uneWorldObj.showNewUne();
      }
      
      private function onHideDigda(param1:CustomEvent) : *
      {
         this.pokemonAreaObj.showPokemon(0.3);
         if(this.data.numFurrows > 5)
         {
            this.arrowBtnUnitObj.enable("top");
            this.arrowBtnUnitObj.enable("bottom");
         }
         else if(this.data.numFurrows > 1)
         {
            this.arrowBtnUnitObj.enable("top");
         }
      }
      
      private function onStartWater(param1:CustomEvent) : *
      {
         this.uneWorldObj.watering(param1.obj.uneID,param1.obj.fieldID);
      }
      
      private function onTutorialGoGetNutsScene(param1:CustomEvent) : *
      {
      }
      
      private function onTutorialFinish(param1:CustomEvent) : *
      {
         this.arrowBtnUnitObj.enable("top");
         this.uneWorldObj.tutorialFinish();
         this.uneWorldObj.setBtnFunc();
      }
      
      private function onAppearArrow(param1:CustomEvent) : *
      {
         this.arrowBtnUnitObj.appear();
      }
      
      private function onBanishArrow(param1:CustomEvent) : *
      {
         this.arrowBtnUnitObj.banish();
      }
      
      private function onHomeMoveStart(param1:PDWBridgeEvent) : *
      {
         Logger.log("はたけ　コンテンツ移動開始　ポケモン削除");
         this.pokemonAreaObj.hide();
      }
      
      private function onArrowBtnClick(param1:CustomEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = param1.obj.key;
         switch(_loc2_)
         {
            case "top":
               _loc3_ = this.uneWorldObj.moveRowLine(this.uneWorldObj.rowLine - 1);
               break;
            case "bottom":
               _loc3_ = this.uneWorldObj.moveRowLine(this.uneWorldObj.rowLine + 1);
         }
         if(_loc3_ != "ng")
         {
            this.btnActiveCheck(_loc3_);
            this.uneWorldObj.setBtnFunc();
            this.uneWorldObj.changeBtnActive();
            this.bridge.updateNowUneCount(this.uneWorldObj.nowRowNum + 1);
         }
      }
      
      private function btnActiveCheck(param1:*) : *
      {
         switch(param1)
         {
            case "rowNone":
               this.arrowBtnUnitObj.enable("top");
               this.arrowBtnUnitObj.enable("bottom");
               break;
            case "top":
               this.arrowBtnUnitObj.disable("top");
               this.arrowBtnUnitObj.enable("bottom");
               break;
            case "bottom":
               this.arrowBtnUnitObj.enable("top");
               this.arrowBtnUnitObj.disable("bottom");
         }
      }
      
      private function onShowDigda(param1:CustomEvent) : *
      {
         if(!this.isTutorial)
         {
            this.digdaAreaObj.show();
            Tweener.addTween(this,{
               "delay":0.3,
               "onComplete":this.showDigdaPanel
            });
         }
      }
      
      private function showDigdaPanel() : *
      {
         var _loc1_:* = {};
         _loc1_.type = this.data.PANEL_TYPE_ADDFURROWALERT;
         this.bridge.showPanel(_loc1_);
      }
      
      private function onUneIncrementAnimeFinish(param1:CustomEvent) : *
      {
         var _loc2_:* = {};
         _loc2_.type = this.data.PANEL_TYPE_ADDFURROWALERT_SECOND;
         this.bridge.showPanel(_loc2_);
         this.digdaAreaObj.hide();
      }
      
      private function onFieldClick(param1:CustomEvent) : *
      {
         var _loc3_:* = undefined;
         this.selectUneID = param1.obj.uneId;
         this.selectFieldID = param1.obj.fieldId;
         this.selectNutsName = param1.obj.nutsName;
         var _loc2_:* = param1.obj.status;
         switch(_loc2_)
         {
            case this.data.FIELD_STATUS_NONE:
               _loc3_ = {};
               _loc3_.type = this.data.PANEL_TYPE_ITEMBOX;
               _loc3_.uneID = this.selectUneID;
               _loc3_.fieldID = this.selectFieldID;
               if(!this.data.isFriendMode)
               {
                  this.bridge.showPanel(_loc3_);
               }
               break;
            case this.data.FIELD_STATUS_PLANT:
               if(param1.obj.isAPI)
               {
                  this.data.isWaterAnime = true;
                  _loc3_ = {};
                  _loc3_.nutsID = param1.obj.nutsID;
                  _loc3_.uneID = param1.obj.uneId;
                  _loc3_.fieldID = param1.obj.fieldId;
                  _loc3_.nutsName = param1.obj.nutsName;
                  _loc3_.x = param1.obj.x;
                  _loc3_.y = param1.obj.y;
                  _loc3_.h = param1.obj.h;
                  _loc3_.nutsDescription = param1.obj.nutsDescription;
                  _loc3_.isAPI = param1.obj.isAPI;
                  this.bridge.showWaterCheckPanel(_loc3_);
               }
               break;
            case this.data.FIELD_STATUS_NUTS:
               _loc3_ = {};
               _loc3_.nutsID = param1.obj.nutsID;
               _loc3_.uneID = param1.obj.uneId;
               _loc3_.fieldID = param1.obj.fieldId;
               _loc3_.nutsName = param1.obj.nutsName;
               _loc3_.x = param1.obj.x;
               _loc3_.y = param1.obj.y;
               _loc3_.h = param1.obj.h;
               _loc3_.nutsDescription = param1.obj.nutsDescription;
               if(!this.data.isFriendMode)
               {
                  this.bridge.showHarvestPanel(_loc3_);
                  break;
               }
               this.bridge.showWaterCheckPanel(_loc3_);
         }
      }
      
      private function onFieldClickForMove(param1:CustomEvent) : *
      {
         var _loc2_:* = this.uneWorldObj.moveRowLine(-param1.obj.uneId);
         if(_loc2_ != "ng")
         {
            this.btnActiveCheck(_loc2_);
            this.uneWorldObj.setBtnFunc();
            this.uneWorldObj.changeBtnActive();
            this.bridge.updateNowUneCount(this.uneWorldObj.nowRowNum + 1);
         }
      }
      
      private function onFieldOver(param1:CustomEvent) : *
      {
         var _loc2_:* = undefined;
         this.selectUneID = param1.obj.uneId;
         this.selectFieldID = param1.obj.fieldId;
         this.selectNutsName = param1.obj.nutsName;
         switch(param1.obj.status)
         {
            case this.data.FIELD_STATUS_PLANT:
               this.data.isWaterAnime = true;
               _loc2_ = {};
               _loc2_.nutsID = param1.obj.nutsID;
               _loc2_.uneID = param1.obj.uneId;
               _loc2_.fieldID = param1.obj.fieldId;
               _loc2_.nutsName = param1.obj.nutsName;
               _loc2_.x = param1.obj.x;
               _loc2_.y = param1.obj.y;
               _loc2_.h = param1.obj.h;
               _loc2_.nutsDescription = param1.obj.nutsDescription;
               this.bridge.showWaterCheckPanel(_loc2_);
               break;
            case this.data.FIELD_STATUS_NUTS:
               _loc2_ = {};
               _loc2_.nutsID = param1.obj.nutsID;
               _loc2_.uneID = param1.obj.uneId;
               _loc2_.fieldID = param1.obj.fieldId;
               _loc2_.nutsName = param1.obj.nutsName;
               _loc2_.x = param1.obj.x;
               _loc2_.y = param1.obj.y;
               _loc2_.h = param1.obj.h;
               _loc2_.nutsDescription = param1.obj.nutsDescription;
               if(!this.data.isFriendMode)
               {
                  this.bridge.showHarvestPanel(_loc2_);
                  break;
               }
               this.data.isWaterAnime = true;
               this.bridge.showWaterCheckPanel(_loc2_);
         }
      }
      
      private function onFieldOut(param1:CustomEvent) : *
      {
         switch(param1.obj.status)
         {
            case this.data.FIELD_STATUS_PLANT:
            case this.data.FIELD_STATUS_NUTS:
         }
      }
      
      private function onUneClick(param1:CustomEvent) : *
      {
         var _loc2_:* = this.uneWorldObj.moveRowLine(-param1.obj.uneId);
         this.btnActiveCheck(_loc2_);
         this.uneWorldObj.setBtnFunc();
         this.uneWorldObj.changeBtnActive();
         this.bridge.updateNowUneCount(this.uneWorldObj.nowRowNum + 1);
      }
      
      private function onPokemonClick(param1:CustomEvent) : *
      {
         var _loc2_:* = {};
         _loc2_.type = this.data.PANEL_TYPE_POKEMONSTATUS;
         this.bridge.showPanel(_loc2_);
      }
      
      public function changePokemon(param1:*) : *
      {
      }
   }
}


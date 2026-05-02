package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
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
   
   public class PanelCtr extends EventDispatcher
   {
      
      private var itemPanelObj:ItemPanel;
      
      private var plantFinishPanelObj:PlantFinishPanel;
      
      private var harvestFinishPanelObj:HarvestFinishPanel;
      
      private var noNutsAlertPanelObj:NoNutsAlertPanel;
      
      private var addFurrowAlertPanelObj:AddFurrowAlertPanel;
      
      private var panelCoverObj:PanelCover;
      
      private var detailPanelObj:DetailPanel;
      
      private var pokemonStatusPanelObj:PokemonStatusPanel;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var filePath:FarmFilePath;
      
      private var selectNutsID:Number = 0;
      
      private var selectUneID:Number = 0;
      
      private var selectFieldID:Number = 0;
      
      private var selectPokeItemID:Number = 0;
      
      private var selectNutsName:String = "";
      
      private var selectNutsDescription:String = "";
      
      private var selectX:Number = 0;
      
      private var selectY:Number = 0;
      
      private var selectH:Number = 0;
      
      public function PanelCtr(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*)
      {
         super();
         this.itemPanelObj = param1;
         this.plantFinishPanelObj = param2;
         this.harvestFinishPanelObj = param3;
         this.noNutsAlertPanelObj = param4;
         this.addFurrowAlertPanelObj = param5;
         this.panelCoverObj = param6;
         this.detailPanelObj = param7;
         this.pokemonStatusPanelObj = param8;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.filePath = FarmFilePath.getInstance();
      }
      
      public function reset() : *
      {
         this.itemPanelObj.reset();
         this.plantFinishPanelObj.reset();
         this.harvestFinishPanelObj.reset();
         this.noNutsAlertPanelObj.reset();
         this.addFurrowAlertPanelObj.reset();
         this.panelCoverObj.reset();
         this.detailPanelObj.reset();
         this.pokemonStatusPanelObj.reset();
      }
      
      public function stop() : *
      {
         this.itemPanelObj.stop();
         this.plantFinishPanelObj.stop();
         this.harvestFinishPanelObj.stop();
         this.noNutsAlertPanelObj.stop();
         this.addFurrowAlertPanelObj.stop();
         this.panelCoverObj.stop();
         this.detailPanelObj.stop();
         this.pokemonStatusPanelObj.stop();
         this.clearEvent();
      }
      
      public function run() : *
      {
         this.itemPanelObj.run();
         this.plantFinishPanelObj.run();
         this.harvestFinishPanelObj.run();
         this.noNutsAlertPanelObj.run();
         this.addFurrowAlertPanelObj.run();
         this.panelCoverObj.run();
         this.detailPanelObj.run();
         this.pokemonStatusPanelObj.run();
         this.setEvent();
      }
      
      private function setEvent() : *
      {
         this.bridge.addEventListener("onShowPanel",this.onShowPanel);
         this.bridge.addEventListener("onShowCover",this.onShowCover);
         this.bridge.addEventListener("onHideCover",this.onHideCover);
         this.bridge.addEventListener("onShowHarvestPanel",this.onShowHarvestPanel);
         this.bridge.addEventListener("onShowWaterCheckPanel",this.onShowWaterCheckPanel);
         this.bridge.addEventListener("onShowDetailPanel",this.onShowDetailPanel);
         this.bridge.addEventListener("onDebugNoWaterAlert",this.onDebugNoWaterAlert);
         this.itemPanelObj.addEventListener("onSelectedYes",this.onSelectedYes);
         this.itemPanelObj.addEventListener("onSelectedNo",this.onSelectedNo);
         this.itemPanelObj.addEventListener("onSelectedOne",this.onSelectedOne);
         this.itemPanelObj.addEventListener("onClosePanelFinish",this.onClosePanelFinish);
         this.itemPanelObj.addEventListener("onItemPanelNoNuts",this.onItemPanelNoNuts);
         this.plantFinishPanelObj.addEventListener("onPlantFinishPanelCloseClick",this.onPlantFinishPanelCloseClick);
         this.harvestFinishPanelObj.addEventListener("onHarvestFinishPanelCloseClick",this.onHarvestFinishPanelCloseClick);
         this.noNutsAlertPanelObj.addEventListener("onNoNutsAlertPanelCloseClick",this.onNoNutsAlertPanelCloseClick);
         this.addFurrowAlertPanelObj.addEventListener("onAddFurrowAlertPanelCloseClick",this.onAddFurrowAlertPanelCloseClick);
         this.detailPanelObj.addEventListener("onDetailPanelCloseClick",this.onDetailPanelCloseClick);
         this.pokemonStatusPanelObj.addEventListener("onPokemonStatusPanelCloseClick",this.onPokemonStatusPanelCloseClick);
         this.panelCoverObj.addEventListener("onCoverClick",this.onCoverClick);
      }
      
      private function clearEvent() : *
      {
         this.bridge.removeEventListener("onShowPanel",this.onShowPanel);
         this.bridge.removeEventListener("onShowCover",this.onShowCover);
         this.bridge.removeEventListener("onHideCover",this.onHideCover);
         this.bridge.removeEventListener("onShowHarvestPanel",this.onShowHarvestPanel);
         this.bridge.removeEventListener("onShowWaterCheckPanel",this.onShowWaterCheckPanel);
         this.bridge.removeEventListener("onShowDetailPanel",this.onShowDetailPanel);
         this.bridge.removeEventListener("onDebugNoWaterAlert",this.onDebugNoWaterAlert);
         this.itemPanelObj.removeEventListener("onSelectedYes",this.onSelectedYes);
         this.itemPanelObj.removeEventListener("onSelectedNo",this.onSelectedNo);
         this.itemPanelObj.removeEventListener("onSelectedOne",this.onSelectedOne);
         this.itemPanelObj.removeEventListener("onClosePanelFinish",this.onClosePanelFinish);
         this.itemPanelObj.removeEventListener("onItemPanelNoNuts",this.onItemPanelNoNuts);
         this.plantFinishPanelObj.removeEventListener("onPlantFinishPanelCloseClick",this.onPlantFinishPanelCloseClick);
         this.harvestFinishPanelObj.removeEventListener("onHarvestFinishPanelCloseClick",this.onHarvestFinishPanelCloseClick);
         this.noNutsAlertPanelObj.removeEventListener("onNoNutsAlertPanelCloseClick",this.onNoNutsAlertPanelCloseClick);
         this.addFurrowAlertPanelObj.removeEventListener("onAddFurrowAlertPanelCloseClick",this.onAddFurrowAlertPanelCloseClick);
         this.detailPanelObj.removeEventListener("onDetailPanelCloseClick",this.onDetailPanelCloseClick);
         this.pokemonStatusPanelObj.removeEventListener("onPokemonStatusPanelCloseClick",this.onPokemonStatusPanelCloseClick);
         this.panelCoverObj.removeEventListener("onCoverClick",this.onCoverClick);
      }
      
      private function onShowPanel(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj.type;
         this.panelCoverObj.appear();
         if(param1.obj.uneID != undefined)
         {
            this.selectUneID = param1.obj.uneID;
         }
         if(param1.obj.fieldID != undefined)
         {
            this.selectFieldID = param1.obj.fieldID;
         }
         switch(_loc2_)
         {
            case this.data.PANEL_TYPE_ITEMBOX:
               this.itemPanelObj.show();
               if(this.data.isFirstTutorial)
               {
                  this.bridge.tutorialGoSelectNutsScene();
               }
               break;
            case this.data.PANEL_TYPE_WATERCHECK:
            case this.data.PANEL_TYPE_HARVESTCHECK:
            case this.data.PANEL_TYPE_NONUTSALERT:
               break;
            case this.data.PANEL_TYPE_ADDFURROWALERT:
               this.addFurrowAlertPanelObj.addEventListener("onNextCutAddFurrow",this.onNextCutAddFurrow);
               this.addFurrowAlertPanelObj.show();
               break;
            case this.data.PANEL_TYPE_ADDFURROWALERT_SECOND:
               this.addFurrowAlertPanelObj.showAnime3();
               break;
            case this.data.PANEL_TYPE_POKEMONSTATUS:
               this.pokemonStatusPanelObj.initialize(this.data.POKEMON_INFO_TYPE_MY);
               this.pokemonStatusPanelObj.show();
               this.panelCoverObj.setBtnFunc(this.data.PANEL_TYPE_POKEMONSTATUS);
               this.bridge.banishArrow();
         }
      }
      
      private function onShowCover(param1:CustomEvent) : *
      {
         this.panelCoverObj.appear();
      }
      
      private function onHideCover(param1:CustomEvent) : *
      {
         this.panelCoverObj.banish();
      }
      
      private function onShowWaterCheckPanel(param1:CustomEvent) : *
      {
         this.panelCoverObj.appear();
         this.selectNutsID = param1.obj.nutsID;
         this.selectUneID = param1.obj.uneID;
         this.selectFieldID = param1.obj.fieldID;
         this.selectNutsName = param1.obj.nutsName;
         this.selectNutsDescription = param1.obj.nutsDescription;
         this.selectX = param1.obj.x;
         this.selectY = param1.obj.y;
         this.selectH = param1.obj.h;
         var _loc2_:* = param1.obj.x;
         var _loc3_:* = param1.obj.y - (param1.obj.h - 5);
         this.onFukidashiWateringClick(null);
      }
      
      private function onShowHarvestPanel(param1:CustomEvent) : *
      {
         this.panelCoverObj.appear();
         this.selectNutsID = param1.obj.nutsID;
         this.selectUneID = param1.obj.uneID;
         this.selectFieldID = param1.obj.fieldID;
         this.selectNutsName = param1.obj.nutsName;
         this.selectNutsDescription = param1.obj.nutsDescription;
         this.selectX = param1.obj.x;
         this.selectY = param1.obj.y;
         this.selectH = param1.obj.h;
         var _loc2_:* = param1.obj.x;
         var _loc3_:* = param1.obj.y - (param1.obj.h - 5);
         this.onFukidashiHarvestClick(null);
      }
      
      private function onShowDetailPanel(param1:CustomEvent) : *
      {
         this.panelCoverObj.appear();
         this.selectNutsID = param1.obj.nutsID;
         this.selectNutsName = param1.obj.nutsName;
         this.selectNutsDescription = param1.obj.nutsDescription;
         this.data.isWaterAnime = false;
         this.detailPanelObj.show(this.selectNutsID,this.selectNutsName,this.selectNutsDescription,0.1);
      }
      
      private function onDebugNoWaterAlert(param1:CustomEvent) : *
      {
         this.onItemPanelNoNuts(null);
      }
      
      private function onSelectedYes(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj;
         this.selectNutsID = this.filePath.getItemToNuts(Number(_loc2_.pokeItemID));
         this.selectNutsName = _loc2_.nutsName;
         this.selectNutsDescription = _loc2_.nutsDescription;
         var _loc3_:* = _loc2_.pokeItemID;
         this.bridge.addEventListener("onResponsePlantNutsData",this.onResponsePlantNutsData);
         this.bridge.sendPlantNutsData(this.data.uneParamList[this.selectUneID][this.selectFieldID].myCroftID,_loc3_);
      }
      
      private function onResponsePlantNutsData(param1:CustomEvent) : *
      {
         PDWBridge.sfx(PDWBridge.SFX_ID_PLANT);
         this.bridge.removeEventListener("onResponsePlantNutsData",this.onResponsePlantNutsData);
         var _loc2_:* = param1.obj;
         var _loc3_:NaeLoader = new NaeLoader();
         _loc3_.addEventListener("onNaeLoadComplete",this.onNaeLoadComplete);
         _loc3_.addEventListener(NaeLoader.ON_NAE_LOAD_ERROR,this.onNaeLoadError);
         _loc3_.load(this.selectNutsID,this.selectUneID,this.selectFieldID);
      }
      
      private function onNaeLoadComplete(param1:CustomEvent) : *
      {
         this.plantFinishPanelObj.show(this.selectNutsID,this.selectNutsName,0.1);
         this.bridge.plantNuts(this.selectNutsID,this.selectNutsName,this.selectNutsDescription);
      }
      
      private function onNaeLoadError(param1:CustomEvent) : *
      {
      }
      
      private function onItemPanelNoNuts(param1:CustomEvent) : *
      {
         this.noNutsAlertPanelObj.show(0,this.data.ALERT_TYPE_NO_NUTS);
      }
      
      private function onSelectedNo(param1:CustomEvent) : *
      {
      }
      
      private function onSelectedOne(param1:CustomEvent) : *
      {
      }
      
      private function onClosePanelFinish(param1:CustomEvent) : *
      {
         this.itemPanelObj.hide();
         this.panelCoverObj.banish();
      }
      
      private function onPlantFinishPanelCloseClick(param1:CustomEvent) : *
      {
         this.plantFinishPanelObj.hide();
         this.panelCoverObj.banish();
         if(this.data.isFirstTutorial)
         {
            this.bridge.tutorialGoGlowNutsFinishScene();
         }
      }
      
      private function onFukidashiWateringClick(param1:CustomEvent) : *
      {
         var _loc2_:* = undefined;
         if(this.data.isFriendMode)
         {
            if(PDWHomeData.anotherWateringCount > 0)
            {
               _loc2_ = this.data.uneParamList[this.selectUneID][this.selectFieldID].myCroftID;
               this.bridge.addEventListener("onResponseFriendWater",this.onResponseFriendWater);
               this.bridge.sendFriendWater(PDWHomeData.anotherMemberSaveDataId,_loc2_);
               this.bridge.showSprinkling(this.selectX,this.selectY,this.selectH);
            }
            else
            {
               PDWHomeData.anotherWateringCount = 0;
               this.noNutsAlertPanelObj.show(0,this.data.ALERT_TYPE_NO_WATER);
            }
         }
         else
         {
            this.bridge.addEventListener("onResponseWater",this.onResponseWater);
            this.bridge.sendWater(this.data.uneParamList[this.selectUneID][this.selectFieldID].myCroftID);
            this.bridge.showSprinkling(this.selectX,this.selectY,this.selectH);
         }
      }
      
      private function onResponseWater(param1:CustomEvent) : *
      {
         this.bridge.removeEventListener("onResponseWater",this.onResponseWater);
         var _loc2_:* = param1.obj;
         this.bridge.startWater(this.selectUneID,this.selectFieldID);
      }
      
      private function onResponseFriendWater(param1:CustomEvent) : *
      {
         this.bridge.removeEventListener("onResponseFriendWater",this.onResponseFriendWater);
         var _loc2_:* = param1.obj;
         this.bridge.startWater(this.selectUneID,this.selectFieldID);
         if(_loc2_.remains_watering)
         {
            PDWHomeData.anotherWateringCount = Number(_loc2_.remains_watering);
         }
         else
         {
            --PDWHomeData.anotherWateringCount;
            if(PDWHomeData.anotherWateringCount < 0)
            {
               PDWHomeData.anotherWateringCount = 0;
            }
         }
         this.bridge.upDateWateringCountView(PDWHomeData.anotherWateringCount);
      }
      
      private function onFukidashiHarvestClick(param1:CustomEvent) : *
      {
         this.bridge.addEventListener("onResponseHarvest",this.onResponseHarvest);
         this.bridge.sendHarvest(this.data.uneParamList[this.selectUneID][this.selectFieldID].myCroftID);
      }
      
      private function onResponseHarvest(param1:CustomEvent) : *
      {
         PDWBridge.sfx(PDWBridge.SFX_ID_HARVEST);
         this.bridge.removeEventListener("onResponseHarvest",this.onResponseHarvest);
         var _loc2_:* = param1.obj;
         var _loc3_:* = Number(_loc2_.kinomi_id);
         var _loc4_:* = Number(_loc2_.pokeitem_id);
         var _loc5_:* = _loc2_.kinomi;
         var _loc6_:* = Number(_loc2_.count);
         this.harvestFinishPanelObj.show(_loc3_,_loc4_,_loc5_,_loc6_,0.1);
         this.bridge.harvestNuts(this.selectUneID,this.selectFieldID);
      }
      
      private function onFukidashiDetailClick(param1:CustomEvent) : *
      {
         this.data.isWaterAnime = false;
         this.detailPanelObj.show(this.selectNutsID,this.selectNutsName,this.selectNutsDescription,0.1);
      }
      
      private function onFukidashiClose(param1:CustomEvent) : *
      {
         this.data.isWaterAnime = false;
         this.panelCoverObj.banish();
      }
      
      private function onDetailPanelCloseClick(param1:CustomEvent) : *
      {
         this.detailPanelObj.hide();
         this.panelCoverObj.banish();
      }
      
      private function onHarvestFinishPanelCloseClick(param1:CustomEvent) : *
      {
         this.harvestFinishPanelObj.hide();
         this.panelCoverObj.banish();
      }
      
      private function onNoNutsAlertPanelCloseClick(param1:CustomEvent) : *
      {
         this.noNutsAlertPanelObj.hide();
         this.panelCoverObj.banish();
      }
      
      private function onNextCutAddFurrow(param1:CustomEvent) : *
      {
         this.addFurrowAlertPanelObj.removeEventListener("onNextCutAddFurrow",this.onNextCutAddFurrow);
         this.bridge.startNewUneAnime();
      }
      
      private function onAddFurrowAlertPanelCloseClick(param1:CustomEvent) : *
      {
         this.addFurrowAlertPanelObj.hide();
         this.panelCoverObj.banish();
         this.bridge.hideDigda();
      }
      
      private function onPokemonStatusPanelCloseClick(param1:CustomEvent) : *
      {
         this.pokemonStatusPanelObj.hide();
         this.panelCoverObj.clearBtnFunc();
         this.panelCoverObj.banish();
         this.bridge.appearArrow();
      }
      
      private function onCoverClick(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj.type;
         switch(_loc2_)
         {
            case this.data.PANEL_TYPE_POKEMONSTATUS:
               this.pokemonStatusPanelObj.hide();
               this.panelCoverObj.clearBtnFunc();
               this.panelCoverObj.banish();
               this.bridge.appearArrow();
         }
      }
   }
}


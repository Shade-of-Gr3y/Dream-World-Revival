package bfp.pdw.farm
{
   import bfp.pokemon.liby.event.CustomEvent;
   import flash.events.EventDispatcher;
   
   public class FarmBridge extends EventDispatcher
   {
      
      private static var _instance:FarmBridge = null;
      
      public function FarmBridge(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function getInstance() : FarmBridge
      {
         if(_instance == null)
         {
            _instance = new FarmBridge(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function showSprinkling(param1:* = 0, param2:* = 0, param3:* = 100) : *
      {
         dispatchEvent(new CustomEvent("onShowSprinkling",{
            "x":param1,
            "y":param2,
            "h":param3
         }));
      }
      
      public function hideSprinkling() : *
      {
         dispatchEvent(new CustomEvent("onHideSprinkling"));
      }
      
      public function startWater(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onStartWater",{
            "uneID":param1,
            "fieldID":param2
         }));
      }
      
      public function stopWater() : *
      {
         dispatchEvent(new CustomEvent("onStopWater"));
      }
      
      public function showPanel(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onShowPanel",param1));
      }
      
      public function showCover() : *
      {
         dispatchEvent(new CustomEvent("onShowCover"));
      }
      
      public function hideCover() : *
      {
         dispatchEvent(new CustomEvent("onHideCover"));
      }
      
      public function showWaterCheckPanel(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onShowWaterCheckPanel",param1));
      }
      
      public function showHarvestPanel(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onShowHarvestPanel",param1));
      }
      
      public function showDetailPanel(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onShowDetailPanel",param1));
      }
      
      public function updateNowUneCount(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onUpdateNowUneCount",{"value":param1}));
      }
      
      public function plantNuts(param1:*, param2:*, param3:*) : *
      {
         dispatchEvent(new CustomEvent("onPlantNuts",{
            "nutsID":param1,
            "nutsName":param2,
            "selectNutsDescription":param3
         }));
      }
      
      public function restoreSoil(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onRestoreSoil",{
            "uneID":param1,
            "fieldID":param2
         }));
      }
      
      public function growthNuts(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onGlowthNuts",{
            "uneID":param1,
            "fieldID":param2
         }));
      }
      
      public function harvestNuts(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onHarvestNuts",{
            "uneID":param1,
            "fieldID":param2
         }));
      }
      
      public function changeSprinkler() : *
      {
         dispatchEvent(new CustomEvent("onChangeSprinkler"));
      }
      
      public function startNewUneAnime() : *
      {
         dispatchEvent(new CustomEvent("onStartNewUneAnime"));
      }
      
      public function showDigda() : *
      {
         dispatchEvent(new CustomEvent("onShowDigda"));
      }
      
      public function hideDigda() : *
      {
         dispatchEvent(new CustomEvent("onHideDigda"));
      }
      
      public function appearArrow() : *
      {
         dispatchEvent(new CustomEvent("onAppearArrow"));
      }
      
      public function banishArrow() : *
      {
         dispatchEvent(new CustomEvent("onBanishArrow"));
      }
      
      public function upDateWateringCountView(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onUpDateWateringCountView",{"num":param1}));
      }
      
      public function tutorialGoGetNutsScene() : *
      {
         dispatchEvent(new CustomEvent("onTutorialGoGetNutsScene"));
      }
      
      public function tutorialGoGetNutsFinishScene() : *
      {
         dispatchEvent(new CustomEvent("onTutorialGoGetNutsFinishScene"));
      }
      
      public function tutorialGoSelectNutsScene() : *
      {
         dispatchEvent(new CustomEvent("onTutorialGoSelectNutsScene"));
      }
      
      public function tutorialGoGlowNutsScene() : *
      {
         dispatchEvent(new CustomEvent("onTutorialGoGlowNutsScene"));
      }
      
      public function tutorialGoGlowNutsFinishScene() : *
      {
         dispatchEvent(new CustomEvent("onTutorialGoGlowNutsFinishScene"));
      }
      
      public function tutorialGoWateringScene() : *
      {
         dispatchEvent(new CustomEvent("onTutoriralGoWateringScene"));
      }
      
      public function tutorialGoWateringFinishScene() : *
      {
         dispatchEvent(new CustomEvent("onTutoriralGoWateringFinishScene"));
      }
      
      public function tutorialFinish() : *
      {
         dispatchEvent(new CustomEvent("onTutorialFinish"));
      }
      
      public function sendPlantNutsData(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onSendPlantNutsData",{
            "myCroftID":param1,
            "pokeItemID":param2
         }));
      }
      
      public function resposePlantNutsData(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponsePlantNutsData",param1));
      }
      
      public function sendWater(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onSendWater",{"myCroftID":param1}));
      }
      
      public function responseWater(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseWater",param1));
      }
      
      public function sendFriendWater(param1:*, param2:*) : *
      {
         dispatchEvent(new CustomEvent("onSendFriendWater",{
            "memberSavedataID":param1,
            "myCroftID":param2
         }));
      }
      
      public function responseFriendWater(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseFriendWater",param1));
      }
      
      public function sendHarvest(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onSendHarvest",{"myCroftID":param1}));
      }
      
      public function responseHarvest(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseHarvest",param1));
      }
      
      public function sendSelectSprinkler(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onSendSelectSprinkler",{"interiorID":param1}));
      }
      
      public function responseSelectSprinkler(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseSelectSprinkler",param1));
      }
      
      public function sendEndTutorial() : *
      {
         dispatchEvent(new CustomEvent("onSendEndTutorial"));
      }
      
      public function responseEndTutorial(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseEndTutorial",param1));
      }
      
      public function sendMyFarmData() : *
      {
         dispatchEvent(new CustomEvent("onSendMyFarmData"));
      }
      
      public function responseMyFarmData(param1:*) : *
      {
         dispatchEvent(new CustomEvent("onResponseMyFarmData",param1));
      }
      
      public function debugNoWaterAlert() : *
      {
         dispatchEvent(new CustomEvent("onDebugNoWaterAlert"));
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}

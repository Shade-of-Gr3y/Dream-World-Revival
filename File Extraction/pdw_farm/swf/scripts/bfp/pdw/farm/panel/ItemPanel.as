package bfp.pdw.farm.panel
{
   import bfp.chest.chestBridge;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.Localize;
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
   import bfp.pokemon.liby.util.McInit;
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
   
   public class ItemPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var filePath:FarmFilePath;
      
      public function ItemPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.filePath = FarmFilePath.getInstance();
         McInit.initParam(this.targetMC);
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         this.clearEvent();
      }
      
      public function run() : *
      {
      }
      
      private function setEvent() : *
      {
         chestBridge.addEventListener(chestBridge.SELECTED_YES,this.onSelectedYes);
         chestBridge.addEventListener(chestBridge.SELECTED_NO,this.onSelectedNo);
         chestBridge.addEventListener(chestBridge.SELECTED_ONE,this.onSelectedOne);
         chestBridge.addEventListener(chestBridge.SELECTED_CLOSE,this.onSelectedClose);
         chestBridge.addEventListener(chestBridge.NO_ITEM,this.onNoItem);
      }
      
      private function clearEvent() : *
      {
         chestBridge.removeEventListener(chestBridge.SELECTED_YES,this.onSelectedYes);
         chestBridge.removeEventListener(chestBridge.SELECTED_NO,this.onSelectedNo);
         chestBridge.removeEventListener(chestBridge.SELECTED_ONE,this.onSelectedOne);
         chestBridge.removeEventListener(chestBridge.SELECTED_CLOSE,this.onSelectedClose);
         chestBridge.removeEventListener(chestBridge.NO_ITEM,this.onNoItem);
      }
      
      public function show(param1:* = 0) : *
      {
         var _loc2_:* = undefined;
         if(this.data.isFirstTutorial)
         {
            Tweener.addTween(this.targetMC,{
               "delay":param1,
               "onComplete":this.showAnime
            });
         }
         else
         {
            this.setEvent();
            _loc2_ = Localize.getIDText("k_aff_1");
            chestBridge.messageWindow(_loc2_,chestBridge.TYPE_YES_NO);
            chestBridge.open(chestBridge.MODE_NUTS,chestBridge.DESIGN_SIDE,chestBridge.NO_POST_WINDOW);
         }
      }
      
      private function showAnime() : *
      {
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
      }
      
      private function hideEnd() : *
      {
         this.targetMC.visible = false;
         this.stop();
         this.reset();
      }
      
      private function onSelectedYes(param1:Event) : *
      {
         var _loc2_:* = chestBridge.selectedItemData;
         var _loc3_:* = {};
         _loc3_.pokeItemID = _loc2_.pokeitem_id;
         _loc3_.nutsName = _loc2_.pokeitem;
         var _loc4_:* = "";
         if(_loc2_.field_line1 != null)
         {
            _loc4_ += _loc2_.field_line1;
         }
         if(_loc2_.field_line2 != null)
         {
            _loc4_ = _loc4_ + "\n" + _loc2_.field_line2;
         }
         if(_loc2_.field_line3 != null)
         {
            _loc4_ = _loc4_ + "\n" + _loc2_.field_line3;
         }
         _loc3_.nutsDescription = _loc4_;
         PokemonBridge.tag("pdw.farm_plants_" + _loc3_.pokeItemID);
         dispatchEvent(new CustomEvent("onSelectedYes",_loc3_));
      }
      
      private function onSelectedNo(param1:Event) : *
      {
         dispatchEvent(new CustomEvent("onSelectedNo"));
      }
      
      private function onSelectedOne(param1:Event) : *
      {
         dispatchEvent(new CustomEvent("onSelectedOne"));
      }
      
      private function onSelectedClose(param1:Event) : *
      {
         this.targetMC.visible = false;
         this.stop();
         this.reset();
         dispatchEvent(new CustomEvent("onClosePanelFinish"));
      }
      
      private function onNoItem(param1:Event) : *
      {
         Logger.log("はたけ　植えるきのみなし");
         dispatchEvent(new CustomEvent("onItemPanelNoNuts"));
      }
   }
}


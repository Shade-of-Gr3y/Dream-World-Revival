package bfp.pdw.farm.menu
{
   import bfp.PDWHomeData;
   import bfp.pdw.common_y.Localize;
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
   
   public class WateringCountInfo extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var wateringTitleMC:MovieClip;
      
      private var wateringTitleTxt:TextField;
      
      private var wateringCountTxt:TextField;
      
      private var wateringCountUnitTxt:TextField;
      
      private var wateringTitleTxtY:Number = 0;
      
      private var wateringCountTxtY:Number = 0;
      
      private var wateringCountUnitTxtY:Number = 0;
      
      public function WateringCountInfo(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.wateringTitleMC = this.targetMC.wateringTitleMC;
         this.wateringTitleTxt = this.wateringTitleMC.txt;
         this.wateringTitleTxtY = 0;
         this.wateringCountTxt = this.targetMC.wateringCountTxt;
         this.wateringCountTxtY = 20;
         this.wateringCountUnitTxt = this.targetMC.wateringCountUnitTxt;
         this.wateringCountUnitTxtY = 26;
      }
      
      public function reset() : *
      {
      }
      
      public function stop() : *
      {
      }
      
      public function run() : *
      {
         this.wateringTitleTxt.y = this.wateringTitleTxtY;
         Localize.setAutoFontTextString(this.wateringTitleTxt,"k_bb_1");
         this.wateringTitleTxt.autoSize = TextFieldAutoSize.CENTER;
         this.wateringTitleTxt.mouseEnabled = false;
         this.wateringTitleTxt.selectable = false;
         this.wateringTitleTxt.wordWrap = false;
         this.wateringTitleTxt.multiline = false;
         this.wateringCountUnitTxt.y = this.wateringCountUnitTxtY;
         Localize.setAutoFontTextString(this.wateringCountUnitTxt,"k_bb_2");
         this.wateringCountUnitTxt.autoSize = TextFieldAutoSize.LEFT;
         this.wateringCountUnitTxt.mouseEnabled = false;
         this.wateringCountUnitTxt.selectable = false;
         this.wateringCountUnitTxt.wordWrap = false;
         this.wateringCountUnitTxt.multiline = false;
         this.wateringCountTxt.y = this.wateringCountTxtY;
         Localize.setTextAndFormatTag(this.wateringCountTxt,String(PDWHomeData.anotherWateringCount),"k_bb_3");
         this.wateringCountTxt.autoSize = TextFieldAutoSize.RIGHT;
         this.wateringCountTxt.mouseEnabled = false;
         this.wateringCountTxt.selectable = false;
         this.wateringCountTxt.wordWrap = false;
         this.wateringCountTxt.multiline = false;
      }
      
      public function show() : *
      {
      }
      
      public function hide() : *
      {
      }
      
      public function appear() : *
      {
         this.targetMC.visible = true;
      }
      
      public function banish() : *
      {
         this.targetMC.visible = false;
      }
      
      public function setCountValue(param1:*) : *
      {
         this.wateringCountTxt.y = this.wateringCountTxtY;
         Localize.setTextAndFormatTag(this.wateringCountTxt,String(param1),"k_bb_3");
         this.wateringCountTxt.autoSize = TextFieldAutoSize.RIGHT;
         this.wateringCountTxt.mouseEnabled = false;
         this.wateringCountTxt.selectable = false;
         this.wateringCountTxt.wordWrap = false;
         this.wateringCountTxt.multiline = false;
      }
   }
}


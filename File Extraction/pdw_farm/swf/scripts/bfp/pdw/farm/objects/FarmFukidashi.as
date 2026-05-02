package bfp.pdw.farm.objects
{
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol195")]
   public class FarmFukidashi extends MovieClip
   {
      
      public var mask_mc:MovieClip;
      
      public var tuno_mc:MovieClip;
      
      public var info_mc:MovieClip;
      
      public var frame_mc:MovieClip;
      
      public var bg_mc:MovieClip;
      
      private var infoTxt:TextField;
      
      private var frameMC:MovieClip;
      
      private var maskMC:MovieClip;
      
      private var bgMC:MovieClip;
      
      private var tunoMC:MovieClip;
      
      private var infoMC:MovieClip;
      
      private var _minWid:* = 100;
      
      private var paddingX:* = 6;
      
      private var paddingY:* = 7;
      
      private var infoTxtY:Number = 0;
      
      public function FarmFukidashi()
      {
         super();
         this.infoMC = this.info_mc;
         this.infoTxt = this.info_mc.info_txt;
         this.frameMC = this.frame_mc;
         this.maskMC = this.mask_mc;
         this.bgMC = this.bg_mc;
         this.tunoMC = this.tuno_mc;
         this.bgMC.mask = this.maskMC;
      }
      
      public function setMessage(param1:*) : *
      {
         this.infoTxt.y = this.infoTxtY;
         Localize.setText(this.infoTxt,param1);
         this.infoTxt.autoSize = TextFieldAutoSize.CENTER;
         this.infoTxt.wordWrap = false;
         this.infoTxt.selectable = false;
         this.infoTxt.multiline = false;
         this.changeSize();
      }
      
      private function changeSize() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc1_ = Math.floor(Math.max(this.infoTxt.width,this._minWid) + this.paddingX * 2);
         _loc3_ = _loc1_ % 2;
         if(_loc3_ != 0)
         {
            _loc1_ += 1;
         }
         _loc2_ = Math.floor(this.infoTxt.height + this.paddingY * 2);
         _loc3_ = _loc2_ % 2;
         if(_loc3_ != 0)
         {
            _loc2_ += 1;
         }
         this.frameMC.width = _loc1_;
         this.frameMC.height = _loc2_;
         this.maskMC.width = _loc1_ - 2;
         this.maskMC.height = _loc2_ - 2;
         this.bgMC.width = _loc1_ - 2;
         this.bgMC.height = _loc2_ - 2;
         this.infoMC.x = 10 + Math.floor(_loc1_ / 2);
         this.infoMC.y = -(Math.floor(this.infoMC.height / 2) + 2);
      }
      
      public function get minWid() : Number
      {
         return this._minWid;
      }
      
      public function set minWid(param1:Number) : *
      {
         this._minWid = param1;
      }
   }
}


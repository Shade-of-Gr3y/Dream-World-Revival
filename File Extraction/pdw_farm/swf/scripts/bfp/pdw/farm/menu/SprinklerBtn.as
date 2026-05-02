package bfp.pdw.farm.menu
{
   import bfp.PDWBridge;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol35")]
   public class SprinklerBtn extends MovieClip
   {
      
      public var imgIconArea_mc:MovieClip;
      
      public var btn_mc:MovieClip;
      
      private var nameTxt:TextField;
      
      private var imgIconArea:MovieClip;
      
      private var btnMC:MovieClip;
      
      private var txtContainer:MovieClip;
      
      public var isSelected:Number = 0;
      
      public var interiorID:Number = 0;
      
      private var color:uint = 0;
      
      private var isSelectedSprinkler:Boolean = false;
      
      private var infoObj:Object;
      
      private var txtIdList:Array;
      
      private var txtY:Number = 0;
      
      public function SprinklerBtn(param1:Object, param2:*)
      {
         super();
         this.infoObj = param1;
         this.color = param2;
         this.init();
      }
      
      private function init() : *
      {
         this.txtContainer = new MovieClip();
         this.txtContainer.mouseEnabled = false;
         this.txtIdList = [];
         this.txtIdList[3] = "k_ad_7";
         this.txtIdList[5] = "k_ad_11";
         this.txtIdList[4] = "k_ad_9";
         this.txtIdList[2] = "k_ad_5";
         this.txtIdList[6] = "k_ad_13";
         this.txtIdList[1] = "k_ad_3";
         this.isSelected = this.infoObj.selected_flag;
         this.interiorID = this.infoObj.interior_id;
         this.addChild(this.txtContainer);
         this.nameTxt = new TextField();
         this.txtContainer.addChild(this.nameTxt);
         this.nameTxt.y = this.txtY;
         Localize.setTextAndFormatTag(this.nameTxt,this.infoObj.interior_name,this.txtIdList[this.interiorID]);
         this.nameTxt.x = 49;
         this.nameTxt.width = 123;
         this.nameTxt.selectable = false;
         this.nameTxt.mouseEnabled = false;
         this.nameTxt.multiline = true;
         this.nameTxt.wordWrap = true;
         this.nameTxt.height = this.nameTxt.textHeight + 4;
         this.txtContainer.y = Math.floor((36 - this.nameTxt.height) / 2);
         this.nameTxt.textColor = this.color;
         this.imgIconArea = this.imgIconArea_mc;
         var _loc1_:Loader = this.infoObj.iconLoader;
         var _loc2_:MovieClip = MovieClip(_loc1_.content);
         _loc2_.gotoAndStop(3);
         _loc1_.x = -Math.floor(_loc1_.width / 2);
         _loc1_.y = -Math.floor(_loc1_.height / 2);
         this.imgIconArea.addChild(_loc1_);
         this.btnMC = this.btn_mc;
         this.addChild(this.btnMC);
         this.resetContent();
      }
      
      public function resetContent() : *
      {
      }
      
      public function stopContent() : *
      {
         var _loc1_:* = undefined;
         Tweener.removeTweens(this);
         Tweener.removeTweens(this.imgIconArea);
         _loc1_ = this.imgIconArea.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.imgIconArea.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      public function runContent() : *
      {
      }
      
      public function show(param1:* = 0) : *
      {
         Tweener.addTween(this,{
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
         this.setBtnFunc();
      }
      
      public function hide(param1:* = 0) : *
      {
         this.clearBtnFunc();
         Tweener.addTween(this,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideEnd
         });
      }
      
      private function hideEnd() : *
      {
         stop();
         this.resetContent();
      }
      
      public function setBtnFunc(param1:Boolean = false) : *
      {
         this.isSelectedSprinkler = param1;
         if(param1)
         {
            BtnSetting.addBtn(this.btnMC,{
               "over":this.onOver,
               "out":this.onOut,
               "buttonMode":false
            });
         }
         else
         {
            BtnSetting.addBtn(this.btnMC,{
               "click":this.onClick,
               "over":this.onOver,
               "out":this.onOut,
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
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.btnMC:
               PDWBridge.sfxClick();
               dispatchEvent(new CustomEvent("onSprinklerBtnClick",{"interior_id":this.infoObj.interior_id}));
         }
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.btnMC:
               PDWBridge.sfxMouseOver();
               if(!this.isSelectedSprinkler)
               {
                  this.nameTxt.textColor = PDWBridge.ROLLOVER_COLOR;
               }
               dispatchEvent(new CustomEvent("onSprinklerBtnOver",{
                  "interior_id":this.infoObj.interior_id,
                  "y":this.y
               }));
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.btnMC:
               if(!this.isSelectedSprinkler)
               {
                  this.nameTxt.textColor = this.color;
               }
               dispatchEvent(new CustomEvent("onSprinklerBtnOut",{
                  "interior_id":this.infoObj.interior_id,
                  "y":this.y
               }));
         }
      }
      
      public function changeColor(param1:*) : *
      {
         switch(param1)
         {
            case "selected":
               this.nameTxt.textColor = PDWBridge.ROLLOVER_COLOR;
               break;
            default:
               this.nameTxt.textColor = this.color;
         }
      }
   }
}


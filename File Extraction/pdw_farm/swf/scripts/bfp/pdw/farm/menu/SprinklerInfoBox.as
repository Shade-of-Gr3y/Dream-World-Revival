package bfp.pdw.farm.menu
{
   import bfp.PDWBridge;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.Localize;
   import bfp.pdw.common_y.effect.BtnEffect;
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
   
   public class SprinklerInfoBox extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var btnMC:MovieClip;
      
      private var selectTxt:TextField;
      
      private var selectIconArea:MovieClip;
      
      private var uneCountTxt:TextField;
      
      private var uneNowCountTxt:TextField;
      
      private var btnBg:MovieClip;
      
      private var arrowIcon:MovieClip;
      
      private var menuFukidashi:FarmFukidashi;
      
      private var nowUneTitleTxt:TextField;
      
      private var nowUneTitleMC:MovieClip;
      
      private var nowSprinklerMC:MovieClip;
      
      private var nowSprinklerTxt:TextField;
      
      private var wateringCountInfoBoxObj:WateringCountInfo;
      
      private var listUnit:MovieClip;
      
      private var listMask:MovieClip;
      
      private var btnArea:MovieClip;
      
      private var bg:MovieClip;
      
      private var myBg:MovieClip;
      
      private var friendBg:MovieClip;
      
      private var menuFukidashiAnimator:FarmFukidashiAnimator;
      
      private var btnList:Array = [];
      
      private var lineList:Array = [];
      
      private var BTN_TEMPLATE:String = "sprinklerBtn_template";
      
      private var LINE_TEMPLATE:String = "sprinklerBtn_line";
      
      private var isOpen:Boolean = false;
      
      private var baseY:Number = 75;
      
      private var baseH:Number = 40;
      
      private var spaceY:Number = 40;
      
      private var distanceX:Number = 250;
      
      private var messageObj:Message;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var selectTxtY:Number = 0;
      
      private var uneCountTxtY:Number = 0;
      
      private var uneNowCountTxtY:Number = 0;
      
      private var nowUneTitleTxtY:Number = 0;
      
      private var nowSprinklerTxtY:Number = 0;
      
      public function SprinklerInfoBox(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
         McInit.initParam(this.targetMC);
         this.btnMC = this.targetMC.btnMC;
         this.selectTxt = new TextField();
         this.uneCountTxt = this.targetMC.uneCountTxt;
         this.uneCountTxt.autoSize = TextFieldAutoSize.LEFT;
         this.uneCountTxt.selectable = false;
         this.uneCountTxt.wordWrap = false;
         this.uneCountTxt.multiline = false;
         this.uneCountTxt.textColor = this.data.FONT_COLOR;
         this.uneCountTxtY = 26;
         this.uneNowCountTxt = this.targetMC.uneNowCountTxt;
         this.uneNowCountTxt.autoSize = TextFieldAutoSize.RIGHT;
         this.uneNowCountTxt.selectable = false;
         this.uneNowCountTxt.wordWrap = false;
         this.uneNowCountTxt.multiline = false;
         this.uneNowCountTxt.textColor = this.data.FONT_COLOR;
         this.uneNowCountTxtY = 26;
         this.btnBg = this.targetMC.btnBg;
         this.selectIconArea = this.targetMC.selectIconArea;
         this.arrowIcon = this.targetMC.arrowIcon;
         this.arrowIcon.mouseEnabled = false;
         this.nowUneTitleMC = this.targetMC.nowUneTitleMC;
         this.nowUneTitleTxt = this.nowUneTitleMC.nowUneTitleTxt;
         this.nowUneTitleTxtY = 0;
         this.nowSprinklerMC = this.targetMC.nowSprinklerMC;
         this.nowSprinklerTxt = this.nowSprinklerMC.nowSprinklerTxt;
         this.nowSprinklerTxtY = 0;
         this.listUnit = this.targetMC.listUnit;
         McInit.initParam(this.listUnit);
         this.listMask = this.targetMC.listMask;
         McInit.initParam(this.listMask);
         this.listUnit.mask = this.listMask;
         this.btnArea = this.listUnit.btnArea;
         this.bg = this.listUnit.bg;
         this.targetMC.addChild(this.btnMC);
         this.menuFukidashi = this.targetMC.menuFukidashi;
         this.menuFukidashi.mouseChildren = false;
         this.menuFukidashi.mouseEnabled = false;
         this.menuFukidashiAnimator = new FarmFukidashiAnimator(this.menuFukidashi,this.menuFukidashi.x,this.menuFukidashi.y);
         this.targetMC.addChild(this.menuFukidashi);
         this.wateringCountInfoBoxObj = new WateringCountInfo(this.targetMC.wateringPanelMC);
         this.myBg = this.targetMC.myBg;
         this.friendBg = this.targetMC.friendBg;
         this.messageObj = new Message();
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.x = this.targetMC.dx - this.distanceX;
         this.targetMC.y = this.targetMC.dy;
         BtnEffect.bgReset(this.btnBg);
         this.selectTxt.text = "";
         this.uneNowCountTxt.y = this.uneNowCountTxtY;
         Localize.setTextAndFormatTag(this.uneNowCountTxt,String(1),"k_ad_16");
         this.menuFukidashiAnimator.hide();
         this.myBg.visible = false;
         this.friendBg.visible = false;
         this.isOpen = false;
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.btnMC);
         Tweener.removeTweens(this.targetMC);
         this.removeList();
      }
      
      public function run() : *
      {
         this.menuFukidashiAnimator.hide();
         this.targetMC.addChild(this.selectTxt);
         this.selectTxt.x = 60;
         this.selectTxt.width = 110;
         this.selectTxt.selectable = false;
         this.selectTxt.mouseEnabled = false;
         this.selectTxt.multiline = true;
         this.selectTxt.wordWrap = true;
         this.selectTxt.textColor = this.data.FONT_COLOR;
         this.nowUneTitleTxt.y = this.nowUneTitleTxtY;
         Localize.setText(this.nowUneTitleTxt,"k_ad_15");
         this.nowUneTitleTxt.selectable = false;
         this.nowUneTitleTxt.wordWrap = false;
         this.nowUneTitleTxt.multiline = false;
         this.nowUneTitleTxt.autoSize = TextFieldAutoSize.CENTER;
         this.nowSprinklerTxt.y = this.nowSprinklerTxtY;
         Localize.setText(this.nowSprinklerTxt,"k_ad_2");
         this.nowSprinklerTxt.selectable = false;
         this.nowSprinklerTxt.wordWrap = false;
         this.nowSprinklerTxt.multiline = false;
         this.nowSprinklerTxt.autoSize = TextFieldAutoSize.CENTER;
         this.setSelectInfo();
         this.createList();
         if(this.data.isFriendMode)
         {
            this.myBg.visible = false;
            this.friendBg.visible = true;
            this.wateringCountInfoBoxObj.appear();
            this.wateringCountInfoBoxObj.run();
         }
         else
         {
            this.myBg.visible = true;
            this.friendBg.visible = false;
            this.wateringCountInfoBoxObj.banish();
         }
      }
      
      public function show(param1:* = 0) : *
      {
         this.uneCountTxt.y = this.uneCountTxtY;
         Localize.setTextAndFormatTag(this.uneCountTxt,String(this.data.uneParamList.length),"k_ad_17");
         this.uneCountTxt.autoSize = TextFieldAutoSize.LEFT;
         this.uneCountTxt.selectable = false;
         this.uneCountTxt.wordWrap = false;
         this.uneCountTxt.multiline = false;
         this.uneCountTxt.textColor = this.data.FONT_COLOR;
         this.uneNowCountTxt.y = this.uneNowCountTxtY;
         Localize.setTextAndFormatTag(this.uneNowCountTxt,String(1),"k_ad_16");
         this.uneNowCountTxt.autoSize = TextFieldAutoSize.RIGHT;
         this.uneNowCountTxt.selectable = false;
         this.uneNowCountTxt.wordWrap = false;
         this.uneNowCountTxt.multiline = false;
         this.uneNowCountTxt.textColor = this.data.FONT_COLOR;
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         this.targetMC.visible = true;
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.6,
            "transition":"easeOutCubic",
            "x":this.targetMC.dx,
            "onComplete":this.showEnd
         });
      }
      
      private function showEnd() : *
      {
         if(!this.data.isFirstTutorial)
         {
            this.setBtnFunc();
         }
      }
      
      public function hide(param1:* = 0) : *
      {
         this.clearBtnFunc();
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.6,
            "transition":"easeOutCubic",
            "x":this.targetMC.dx - this.distanceX,
            "onComplete":this.hideEnd
         });
      }
      
      private function hideEnd() : *
      {
         this.stop();
         this.reset();
      }
      
      public function setFunc() : *
      {
         this.setBtnFunc();
      }
      
      private function setBtnFunc() : *
      {
         if(this.data.sprinklerList.length > 1)
         {
            BtnSetting.addBtn(this.btnMC,{
               "click":this.onClick,
               "over":this.onOver,
               "out":this.onOut,
               "buttonMode":true
            });
         }
         else
         {
            BtnSetting.addBtn(this.btnMC,{
               "over":this.onOver,
               "out":this.onOut,
               "buttonMode":false
            });
         }
      }
      
      private function clearBtnFunc() : *
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
         PDWBridge.sfxClick();
         switch(_loc2_)
         {
            case this.btnMC:
               if(this.isOpen)
               {
                  this.isOpen = false;
                  this.clearListBtnFunc();
                  this.closeSprinkler();
                  dispatchEvent(new CustomEvent("onCloseMenu"));
                  break;
               }
               this.isOpen = true;
               this.setListBtnFunc();
               this.setActiveView();
               this.openSprinkler();
               dispatchEvent(new CustomEvent("onOpenMenu"));
         }
      }
      
      public function closeMenu() : *
      {
         this.isOpen = false;
         this.clearListBtnFunc();
         this.closeSprinkler();
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.btnMC:
               PDWBridge.sfxMouseOver();
               BtnEffect.bgOver(this.btnBg);
               _loc3_ = this.data.selectSprinklerData.interior_id;
               _loc4_ = this.getInformationID(_loc3_);
               this.menuFukidashi.setMessage(_loc4_);
               this.menuFukidashiAnimator.defaultY = 94;
               this.menuFukidashiAnimator.show(FarmFukidashiAnimator.POSITION_TYPE_SIDE);
         }
      }
      
      private function onOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_)
         {
            case this.btnMC:
               BtnEffect.bgOut(this.btnBg);
               this.menuFukidashiAnimator.hide();
         }
      }
      
      private function createList() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:SprinklerBtn = null;
         var _loc3_:* = undefined;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.data.sprinklerList.length)
         {
            _loc2_ = new SprinklerBtn(this.data.sprinklerList[_loc1_],this.data.FONT_COLOR);
            _loc2_.y = _loc1_ * this.spaceY;
            this.btnArea.addChild(_loc2_);
            this.btnList.push(_loc2_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length - 1)
         {
            _loc3_ = getDefinitionByName(this.LINE_TEMPLATE);
            _loc4_ = new _loc3_();
            _loc4_.y = 38 + _loc1_ * this.spaceY;
            this.btnArea.addChild(_loc4_);
            this.lineList.push(_loc4_);
            _loc1_++;
         }
         this.bg.height = this.btnList.length * this.spaceY + 5;
         this.listMask.height = this.bg.height + 5;
         this.listUnit.y = this.listUnit.dy - (this.listUnit.height + 20);
         if(this.data.sprinklerList.length <= 1)
         {
            this.arrowIcon.visible = false;
         }
      }
      
      private function removeList() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:SprinklerBtn = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length)
         {
            _loc2_ = this.btnList[_loc1_];
            if(this.btnArea.contains(_loc2_))
            {
               this.btnArea.removeChild(_loc2_);
            }
            _loc2_.stopContent();
            _loc2_ = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.lineList.length)
         {
            _loc3_ = this.lineList[_loc1_];
            if(this.btnArea.contains(_loc3_))
            {
               this.btnArea.removeChild(_loc3_);
            }
            _loc3_ = null;
            _loc1_++;
         }
         this.btnList = [];
         this.lineList = [];
      }
      
      private function setSelectInfo() : *
      {
         var _loc1_:* = undefined;
         Localize.setTextAndFormatTag(this.selectTxt,this.data.selectSprinklerData.interior_name,"k_ad_18");
         this.selectTxt.x = 60;
         this.selectTxt.width = 110;
         this.selectTxt.selectable = false;
         this.selectTxt.mouseEnabled = false;
         this.selectTxt.multiline = true;
         this.selectTxt.wordWrap = true;
         this.selectTxt.textColor = this.data.FONT_COLOR;
         this.selectTxt.height = this.selectTxt.textHeight + 4;
         this.selectTxt.y = this.baseY + Math.floor((this.baseH - this.selectTxt.height) / 2);
         _loc1_ = this.selectIconArea.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.selectIconArea.removeChildAt(_loc1_);
            _loc1_--;
         }
         var _loc2_:Loader = this.data.selectSprinklerData.iconLoader;
         var _loc3_:MovieClip = MovieClip(_loc2_.content);
         _loc3_.gotoAndStop(3);
         _loc2_.x = -Math.floor(_loc2_.width / 2);
         _loc2_.y = -Math.floor(_loc2_.height / 2);
         this.selectIconArea.addChild(_loc2_);
      }
      
      private function openSprinkler() : *
      {
         Tweener.addTween(this.listUnit,{
            "delay":0,
            "time":0.5,
            "transition":"easeOutCubic",
            "y":this.listUnit.dy
         });
      }
      
      private function closeSprinkler() : *
      {
         Tweener.addTween(this.listUnit,{
            "delay":0,
            "time":0.3,
            "transition":"easeOutCubic",
            "y":this.listUnit.dy - (this.listUnit.height + 20)
         });
      }
      
      private function setListBtnFunc() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:SprinklerBtn = null;
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length)
         {
            _loc2_ = this.btnList[_loc1_];
            if(_loc2_.isSelected)
            {
               _loc2_.addEventListener("onSprinklerBtnClick",this.onSprinklerBtnClick);
               _loc2_.addEventListener("onSprinklerBtnOver",this.onSprinklerBtnOver);
               _loc2_.addEventListener("onSprinklerBtnOut",this.onSprinklerBtnOut);
               _loc2_.clearBtnFunc();
               _loc2_.setBtnFunc(true);
            }
            else
            {
               _loc2_.addEventListener("onSprinklerBtnClick",this.onSprinklerBtnClick);
               _loc2_.addEventListener("onSprinklerBtnOver",this.onSprinklerBtnOver);
               _loc2_.addEventListener("onSprinklerBtnOut",this.onSprinklerBtnOut);
               _loc2_.clearBtnFunc();
               _loc2_.setBtnFunc();
            }
            _loc1_++;
         }
      }
      
      private function clearListBtnFunc() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:SprinklerBtn = null;
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length)
         {
            _loc2_ = this.btnList[_loc1_];
            _loc2_.removeEventListener("onSprinklerBtnClick",this.onSprinklerBtnClick);
            _loc2_.removeEventListener("onSprinklerBtnOver",this.onSprinklerBtnOver);
            _loc2_.removeEventListener("onSprinklerBtnOut",this.onSprinklerBtnOut);
            _loc2_.clearBtnFunc();
            _loc1_++;
         }
      }
      
      private function onSprinklerBtnClick(param1:CustomEvent) : *
      {
         this.isOpen = false;
         this.clearListBtnFunc();
         this.closeSprinkler();
         this.menuFukidashiAnimator.hide();
         var _loc2_:* = param1.obj.interior_id;
         PokemonBridge.tag("pdw.farm_joro_" + _loc2_);
         dispatchEvent(new CustomEvent("onSprinklerBtnClick",{"interior_id":_loc2_}));
      }
      
      private function onSprinklerBtnOver(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj.interior_id;
         var _loc3_:* = param1.obj.y;
         var _loc4_:* = this.btnArea.localToGlobal(new Point(0,_loc3_));
         var _loc5_:* = this.getInformationID(_loc2_);
         this.menuFukidashi.setMessage(_loc5_);
         this.menuFukidashiAnimator.defaultY = this.targetMC.y + _loc4_.y + 5;
         this.menuFukidashiAnimator.show(FarmFukidashiAnimator.POSITION_TYPE_SIDE);
      }
      
      private function onSprinklerBtnOut(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj.interior_id;
         this.menuFukidashiAnimator.hide();
      }
      
      private function setActiveView() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:SprinklerBtn = null;
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length)
         {
            _loc2_ = this.btnList[_loc1_];
            if(_loc2_.isSelected)
            {
               _loc2_.changeColor("selected");
            }
            else
            {
               _loc2_.changeColor("normal");
            }
            _loc1_++;
         }
      }
      
      public function changeSprinkler() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:SprinklerBtn = null;
         _loc1_ = this.selectIconArea.numChildren - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.selectIconArea.removeChildAt(_loc1_);
            if(_loc2_ is Loader)
            {
               _loc2_.unload();
            }
            _loc1_--;
         }
         this.setSelectInfo();
         _loc1_ = 0;
         while(_loc1_ < this.btnList.length)
         {
            _loc3_ = this.btnList[_loc1_];
            if(_loc3_.interiorID == this.data.selectSprinklerData.interior_id)
            {
               _loc3_.isSelected = 1;
            }
            else
            {
               _loc3_.isSelected = 0;
            }
            _loc1_++;
         }
      }
      
      public function updateUneCount(param1:*) : *
      {
         this.uneNowCountTxt.y = this.uneNowCountTxtY;
         Localize.setTextAndFormatTag(this.uneNowCountTxt,String(param1),"k_ad_16");
         this.uneNowCountTxt.autoSize = TextFieldAutoSize.RIGHT;
         this.uneNowCountTxt.selectable = false;
         this.uneNowCountTxt.wordWrap = false;
         this.uneNowCountTxt.multiline = false;
         this.uneNowCountTxt.textColor = this.data.FONT_COLOR;
      }
      
      public function updateWateringCount(param1:*) : *
      {
         this.wateringCountInfoBoxObj.setCountValue(param1);
      }
      
      private function getInformationID(param1:*) : *
      {
         switch(param1)
         {
            case this.data.SPRINKLER_ID_NORMAL:
               return "k_ad_4";
            case this.data.SPRINKLER_ID_DELIBIRD:
               return "k_ad_14";
            case this.data.SPRINKLER_ID_ZENIGAME:
               return "k_ad_6";
            case this.data.SPRINKLER_ID_DONFAN:
               return "k_ad_10";
            case this.data.SPRINKLER_ID_KAIOUGA:
               return "k_ad_12";
            case this.data.SPRINKLER_ID_KODAK:
               return "k_ad_8";
            default:
               return;
         }
      }
   }
}


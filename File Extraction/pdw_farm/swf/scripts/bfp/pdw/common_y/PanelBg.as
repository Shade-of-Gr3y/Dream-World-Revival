package bfp.pdw.common_y
{
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol100")]
   public class PanelBg extends MovieClip
   {
      
      public var corner_RB_mc:MovieClip;
      
      public var corner_RT_mc:MovieClip;
      
      public var corner_LB_mc:MovieClip;
      
      public var corner_LT_mc:MovieClip;
      
      public var centerBg_mc:MovieClip;
      
      private var centerBg:MovieClip;
      
      private var corner_LT:MovieClip;
      
      private var corner_LB:MovieClip;
      
      private var corner_RT:MovieClip;
      
      private var corner_RB:MovieClip;
      
      private var topMC:MovieClip;
      
      private var bottomMC:MovieClip;
      
      private var leftMC:MovieClip;
      
      private var rightMC:MovieClip;
      
      private var frame0MC:MovieClip;
      
      private var frame1MC:MovieClip;
      
      private var frame2MC:MovieClip;
      
      private var frame3MC:MovieClip;
      
      private var bm:Bitmap;
      
      private var bmd:BitmapData;
      
      private var _w:Number = 1;
      
      private var _h:Number = 1;
      
      private var marginTop:Number = 20;
      
      private var marginBottom:Number = 20;
      
      private var marginLeft:Number = 20;
      
      private var marginRight:Number = 20;
      
      private var frameNameList:Array = ["frame0","frame1","frame2","frame3"];
      
      private var topFrameList:Array = [];
      
      private var bottomFrameList:Array = [];
      
      private var leftFrameList:Array = [];
      
      private var rightFrameList:Array = [];
      
      private var frameList:Array = [];
      
      public function PanelBg(param1:Number = 300, param2:Number = 200)
      {
         super();
         this._w = Math.floor(param1);
         this._h = Math.floor(param2);
         this.centerBg = this.centerBg_mc;
         this.corner_LT = this.corner_LT_mc;
         this.corner_LB = this.corner_LB_mc;
         this.corner_RT = this.corner_RT_mc;
         this.corner_RB = this.corner_RB_mc;
         this.topMC = new MovieClip();
         this.bottomMC = new MovieClip();
         this.leftMC = new MovieClip();
         this.rightMC = new MovieClip();
         this.addChild(this.topMC);
         this.addChild(this.bottomMC);
         this.addChild(this.leftMC);
         this.addChild(this.rightMC);
         this.bm = new Bitmap();
         this.bm.smoothing = true;
         this.addChild(this.bm);
         this.init();
      }
      
      private function init() : *
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.resetContent();
         this.create();
      }
      
      public function resetContent() : *
      {
         if(this.bmd != null)
         {
            this.bmd.dispose();
            this.bmd = null;
         }
      }
      
      public function stopContent() : *
      {
      }
      
      public function runContent() : *
      {
      }
      
      private function onAddToStage(param1:Event) : *
      {
      }
      
      private function onRemovedFromStage(param1:Event) : *
      {
         this.destroy();
      }
      
      public function setSize(param1:*, param2:*) : *
      {
         this._w = Math.floor(param1);
         this._h = Math.floor(param2);
         this.destroy();
         this.create();
      }
      
      public function get wid() : *
      {
         return this._w;
      }
      
      public function get hei() : *
      {
         return this._h;
      }
      
      private function create() : *
      {
         var _loc10_:* = undefined;
         var _loc11_:MovieClip = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         if(this.bmd != null)
         {
            this.bmd.dispose();
            this.bmd = null;
         }
         this.bmd = new BitmapData(this._w,this._h,true,0);
         var _loc1_:* = 40;
         var _loc2_:* = this._w - (this.corner_LT.width + this.corner_RT.width);
         var _loc3_:* = this._h - (this.corner_LT.height + this.corner_LB.height);
         var _loc4_:* = Math.ceil(_loc2_ / _loc1_);
         var _loc5_:* = Math.ceil(_loc3_ / _loc1_);
         var _loc6_:* = _loc4_ * _loc1_;
         var _loc7_:* = _loc5_ * _loc1_;
         var _loc8_:* = _loc6_ - _loc2_;
         var _loc9_:* = _loc7_ - _loc3_;
         _loc10_ = 0;
         while(_loc10_ < _loc4_)
         {
            _loc13_ = Math.floor(Math.random() * this.frameNameList.length);
            _loc12_ = getDefinitionByName(this.frameNameList[_loc13_]);
            _loc11_ = new _loc12_();
            _loc11_.x = _loc10_ * _loc1_;
            this.topMC.addChild(_loc11_);
            this.topFrameList.push(_loc11_);
            if(_loc10_ == _loc4_ - 1)
            {
               _loc11_.width = _loc1_ - _loc8_;
            }
            _loc10_++;
         }
         this.topMC.scaleX = 1;
         this.topMC.x = this.corner_LT.width;
         this.topMC.y = 0;
         _loc10_ = 0;
         while(_loc10_ < _loc4_)
         {
            _loc13_ = Math.floor(Math.random() * this.frameNameList.length);
            _loc12_ = getDefinitionByName(this.frameNameList[_loc13_]);
            _loc11_ = new _loc12_();
            _loc11_.x = _loc10_ * _loc1_;
            this.bottomMC.addChild(_loc11_);
            this.bottomFrameList.push(_loc11_);
            if(_loc10_ == _loc4_ - 1)
            {
               _loc11_.width = _loc1_ - _loc8_;
            }
            _loc10_++;
         }
         this.bottomMC.scaleX = 1;
         this.bottomMC.rotation = 180;
         this.bottomMC.x = this.corner_LT.width + _loc2_;
         this.bottomMC.y = this.corner_LT.height * 2 + _loc3_;
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc13_ = Math.floor(Math.random() * this.frameNameList.length);
            _loc12_ = getDefinitionByName(this.frameNameList[_loc13_]);
            _loc11_ = new _loc12_();
            _loc11_.x = _loc10_ * _loc1_;
            this.leftMC.addChild(_loc11_);
            this.leftFrameList.push(_loc11_);
            if(_loc10_ == _loc5_ - 1)
            {
               _loc11_.width = _loc1_ - _loc9_;
            }
            _loc10_++;
         }
         this.leftMC.scaleX = 1;
         this.leftMC.rotation = -90;
         this.leftMC.x = 0;
         this.leftMC.y = this.corner_LT.height + _loc3_;
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc13_ = Math.floor(Math.random() * this.frameNameList.length);
            _loc12_ = getDefinitionByName(this.frameNameList[_loc13_]);
            _loc11_ = new _loc12_();
            _loc11_.x = _loc10_ * _loc1_;
            this.rightMC.addChild(_loc11_);
            this.rightFrameList.push(_loc11_);
            if(_loc10_ == _loc5_ - 1)
            {
               _loc11_.width = _loc1_ - _loc9_;
            }
            _loc10_++;
         }
         this.rightMC.scaleX = 1;
         this.rightMC.rotation = 90;
         this.rightMC.x = this.corner_LT.width * 2 + _loc2_;
         this.rightMC.y = this.corner_LT.height;
         this.centerBg.x = this.corner_LT.width;
         this.centerBg.y = this.corner_LT.height;
         this.centerBg.width = _loc2_;
         this.centerBg.height = _loc3_;
         this.corner_LT.x = 0;
         this.corner_LT.y = 0;
         this.corner_RT.x = this.corner_LT.width + _loc2_;
         this.corner_RT.y = 0;
         this.corner_LB.x = 0;
         this.corner_LB.y = this.corner_LT.height + _loc3_;
         this.corner_RB.x = this.corner_LT.width + _loc2_;
         this.corner_RB.y = this.corner_LT.height + _loc3_;
      }
      
      private function destroy() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.topFrameList.length)
         {
            _loc2_ = this.topFrameList[_loc1_];
            if(this.topMC.contains(_loc2_))
            {
               this.topMC.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.topFrameList = [];
         this.topMC.x = 0;
         this.topMC.y = 0;
         this.topMC.rotation = 0;
         this.topMC.scaleX = 0;
         _loc1_ = 0;
         while(_loc1_ < this.bottomFrameList.length)
         {
            _loc2_ = this.bottomFrameList[_loc1_];
            if(this.bottomMC.contains(_loc2_))
            {
               this.bottomMC.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.bottomFrameList = [];
         this.bottomMC.x = 0;
         this.bottomMC.y = 0;
         this.bottomMC.rotation = 0;
         this.bottomMC.scaleX = 0;
         _loc1_ = 0;
         while(_loc1_ < this.leftFrameList.length)
         {
            _loc2_ = this.leftFrameList[_loc1_];
            if(this.leftMC.contains(_loc2_))
            {
               this.leftMC.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.leftFrameList = [];
         this.leftMC.x = 0;
         this.leftMC.y = 0;
         this.leftMC.rotation = 0;
         this.leftMC.scaleX = 0;
         _loc1_ = 0;
         while(_loc1_ < this.rightFrameList.length)
         {
            _loc2_ = this.rightFrameList[_loc1_];
            if(this.rightMC.contains(_loc2_))
            {
               this.rightMC.removeChild(_loc2_);
            }
            _loc2_ = null;
            _loc1_++;
         }
         this.rightFrameList = [];
         this.rightMC.x = 0;
         this.rightMC.y = 0;
         this.rightMC.rotation = 0;
         this.rightMC.scaleX = 0;
      }
   }
}


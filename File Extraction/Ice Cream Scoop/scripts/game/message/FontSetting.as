package game.message
{
   import bfp.common.*;
   import common.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class FontSetting extends MovieClip
   {
      
      private var orgWidth:int;
      
      private var textMc:TextField;
      
      private var countFrame:int;
      
      private var _width:*;
      
      private var orgHeight:int;
      
      private var _height:*;
      
      private var mainMc:MovieClip;
      
      private var _x:*;
      
      private var _y:*;
      
      public function FontSetting(param1:MovieClip, param2:String, param3:Boolean, param4:Number = -1)
      {
         var _loc5_:TextFormat = null;
         super();
         this.mainMc = comDefine.getTextMc(param1);
         this.textMc = param1.textMC;
         this.textMc.y += 2;
         this.orgWidth = param1.width;
         this.orgHeight = param1.height;
         this._x = this.textMc.x;
         this._y = this.textMc.y;
         this._width = this.orgWidth;
         this._height = this.orgHeight;
         this.textMc.text = param2;
         setFont(this.textMc,param3);
         if(param4 != -1)
         {
            _loc5_ = this.textMc.defaultTextFormat;
            _loc5_.letterSpacing = param4;
            this.textMc.defaultTextFormat = _loc5_;
         }
         if(this.orgWidth > this.textMc.width)
         {
            this.textMc.autoSize = TextFieldAutoSize.NONE;
            this.textMc.width = this.orgWidth;
            this.textMc.x = this._x;
         }
         if(this.mainMc.width > this.orgWidth)
         {
            this.mainMc.scaleX = this.orgWidth / this.mainMc.width;
         }
         if(this.mainMc.height > this.orgHeight)
         {
            this.mainMc.scaleY = this.orgHeight / this.mainMc.height;
         }
      }
      
      public static function setFont(param1:TextField, param2:Boolean) : *
      {
         var _loc4_:TextFormat = null;
         var _loc3_:TextFormat = param1.defaultTextFormat;
         param1.selectable = false;
         if(comDefine.nLanguage != "ko" && comDefine.nLanguage != "ja")
         {
            FontManager.setSelectedFont(param1,param2);
            _loc4_ = param1.defaultTextFormat;
            _loc3_.font = _loc4_.font;
            _loc3_.letterSpacing = 1;
            param1.defaultTextFormat = _loc3_;
         }
         FontManager.setAutoFontText(param1,param1.text,param2);
         param1.autoSize = param1.defaultTextFormat.align;
      }
      
      public static function setIDText(param1:TextField, param2:int, param3:Boolean) : *
      {
         param1.text = MessageMgr.getInstance().getMessage(param2);
         setFont(param1,param3);
      }
      
      public static function setText(param1:TextField, param2:String, param3:Boolean) : *
      {
         param1.text = param2;
         setFont(param1,param3);
      }
      
      private function _enterFrame(param1:Event) : void
      {
         if(this.countFrame > 0)
         {
            if(this._width == this.textMc.width && this._height == this.textMc.height)
            {
               --this.countFrame;
            }
            this._width = this.textMc.width;
            this._height = this.textMc.height;
         }
         else
         {
            this.mainMc.scaleX = this.orgWidth / this.textMc.width;
            this.mainMc.scaleY = this.orgHeight / this.textMc.height;
            removeEventListener(Event.ENTER_FRAME,this._enterFrame);
         }
      }
      
      private function setFontWidth() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:Number = NaN;
         if(this.textMc.width > this.orgWidth)
         {
            _loc2_ = 1;
            _loc3_ = this.textMc.defaultTextFormat;
            _loc4_ = _loc3_.size as Number;
            _loc1_ = _loc3_.size as uint;
            while(_loc1_ >= 5)
            {
               _loc3_.size = _loc1_;
               this.textMc.setTextFormat(_loc3_);
               if(this.mainMc.width <= this.orgWidth)
               {
                  break;
               }
               _loc2_ = _loc1_;
               _loc1_--;
            }
            _loc3_.size = _loc2_;
            this.textMc.setTextFormat(_loc3_);
         }
      }
      
      private function fontToBmp() : void
      {
         var _loc1_:BitmapData = new BitmapData(this.textMc.width - this.textMc.x,this.textMc.height - this.textMc.y,true,0);
         _loc1_.draw(this.textMc);
         var _loc2_:Bitmap = new Bitmap(_loc1_);
         _loc2_.x = this.textMc.x;
         _loc2_.y = this.textMc.y;
         this.mainMc.removeChild(this.textMc);
         this.mainMc.addChild(_loc2_);
         this.mainMc.width = this.orgWidth;
         this.mainMc.height = this.orgHeight;
      }
   }
}


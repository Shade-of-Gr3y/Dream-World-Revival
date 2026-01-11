package bfp.tpc.pdw.news
{
   import bfp.PDWBridge;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import jp.feb19.utils.StringUtilities;
   
   public class NewsRecord extends Sprite
   {
       
      
      private var _date:String;
      
      private var _type:String;
      
      private var _title:String;
      
      private var _tf:TextField;
      
      private var _titletf:TextField;
      
      private var _bmdType:BitmapData;
      
      private var _bmpType:Bitmap;
      
      public function NewsRecord(param1:String, param2:String, param3:String, param4:Boolean)
      {
         super();
         this._date = param1;
         this._type = param2;
         this._title = param3;
         this.update();
      }
      
      public function clear() : void
      {
         if(this._tf)
         {
            removeChild(this._tf);
            this._tf = null;
         }
         if(this._titletf)
         {
            removeChild(this._titletf);
            this._titletf = null;
         }
         if(this._bmdType)
         {
            this._bmdType.dispose();
            this._bmdType = null;
         }
         if(this._bmpType)
         {
            removeChild(this._bmpType);
            this._bmpType = null;
         }
      }
      
      public function update() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:TextFormat = null;
         var _loc5_:TextField = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc15_:Font = null;
         this.clear();
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         for(_loc3_ in Font.enumerateFonts())
         {
            if((_loc15_ = Font.enumerateFonts()[_loc3_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
            }
            else if(_loc15_.fontName == "PokemonFontFFFCorporate")
            {
               _loc2_ = true;
            }
         }
         (_loc4_ = new TextFormat()).font = "PokemonFontFFFCorporate";
         _loc4_.size = 8;
         _loc4_.color = 4333835;
         (_loc5_ = new TextField()).defaultTextFormat = _loc4_;
         _loc5_.embedFonts = _loc2_;
         _loc5_.antiAliasType = "normal";
         _loc5_.gridFitType = "pixel";
         _loc5_.antiAliasType = AntiAliasType.ADVANCED;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.x = 1;
         _loc5_.y = 4;
         _loc5_.selectable = false;
         _loc6_ = !!this._date ? this._date : "0000-00-00 00:00";
         var _loc7_:Array;
         var _loc9_:Array = (_loc7_ = StringUtilities.replaceAll(_loc6_,"-","/").split(" "))[0].split("/");
         switch(PokemonBridge.lang)
         {
            case "en":
               _loc8_ = _loc9_[1] + "/" + _loc9_[2] + "/" + _loc9_[0];
               break;
            case "es":
               _loc8_ = _loc9_[2] + "/" + _loc9_[1] + "/" + _loc9_[0];
               break;
            case "fr":
               _loc8_ = _loc9_[2] + "/" + _loc9_[1] + "/" + _loc9_[0];
               break;
            case "it":
               _loc8_ = _loc9_[2] + "/" + _loc9_[1] + "/" + _loc9_[0];
               break;
            case "de":
               _loc8_ = _loc9_[2] + "." + _loc9_[1] + "." + _loc9_[0];
               break;
            case "ja":
               _loc8_ = _loc9_[0] + "." + _loc9_[1] + "." + _loc9_[2];
               break;
            case "ko":
               _loc8_ = _loc9_[0] + "." + _loc9_[1] + "." + _loc9_[2];
               break;
            default:
               _loc8_ = _loc9_[0] + "." + _loc9_[1] + "." + _loc9_[2];
         }
         _loc5_.text = _loc8_;
         addChild(_loc5_);
         this._tf = _loc5_;
         var _loc10_:int = 0;
         switch(this._type)
         {
            case "10":
               _loc10_ = 0;
               break;
            case "20":
               _loc10_ = 1;
               break;
            case "30":
               _loc10_ = 2;
               break;
            case "41":
               _loc10_ = 3;
               break;
            case "42":
               _loc10_ = 3;
               break;
            case "50":
               _loc10_ = 4;
               break;
            case "51":
               _loc10_ = 4;
               break;
            case "52":
               _loc10_ = 4;
               break;
            case "60":
               _loc10_ = 5;
               break;
            case "61":
               _loc10_ = 5;
               break;
            default:
               _loc10_ = 0;
         }
         var _loc11_:BitmapData = PDWBridge.newsBitmapData[_loc10_].clone();
         var _loc12_:Bitmap;
         (_loc12_ = new Bitmap(_loc11_)).x = 54;
         _loc12_.y = 3;
         addChild(_loc12_);
         this._bmpType = _loc12_;
         this._bmdType = _loc11_;
         var _loc13_:TextFormat;
         (_loc13_ = new TextFormat()).font = "PokemonFontShingoM";
         _loc13_.size = 11;
         _loc13_.color = 3355443;
         var _loc14_:TextField;
         (_loc14_ = new TextField()).antiAliasType = "advanced";
         _loc14_.gridFitType = "subpixel";
         _loc14_.sharpness = -200;
         _loc14_.thickness = 100;
         _loc14_.embedFonts = _loc1_;
         _loc14_.defaultTextFormat = _loc13_;
         _loc14_.text = this._title;
         _loc14_.autoSize = TextFieldAutoSize.LEFT;
         _loc14_.x = 164;
         _loc14_.y = 1;
         _loc14_.selectable = false;
         addChild(_loc14_);
         FontManager.setTextM(_loc14_);
         this._titletf = _loc14_;
      }
   }
}

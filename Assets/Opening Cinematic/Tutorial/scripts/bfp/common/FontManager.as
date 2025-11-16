package bfp.common
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FontManager
   {
      
      public static const LOADED:String = "LOADED";
      
      private static var tf1:TextFormat;
      
      private static var tf2:TextFormat;
      
      private static var tf3:TextFormat;
      
      private static var tf4:TextFormat;
      
      private static var tf5:TextFormat;
      
      private static var tf6:TextFormat;
      
      private static var tf7:TextFormat;
      
      private static var tf8:TextFormat;
      
      private static var tf9:TextFormat;
      
      private static var tf10:TextFormat;
      
      private static var tf11:TextFormat;
      
      private static var tf12:TextFormat;
      
      private static var loader:Loader;
      
      public static const LANG_CODE_JA:String = "ja";
      
      public static const LANG_CODE_KO:String = "ko";
      
      public static const LANG_CODE_EN:String = "en";
      
      public static var lang_code:String;
      
      private static var id_position:Object = new Object();
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function FontManager()
      {
         super();
      }
      
      public static function standalone(param1:String) : void
      {
         var path:String = param1;
         loader = new Loader();
         var request:URLRequest = new URLRequest();
         request.url = path;
         request.method = URLRequestMethod.GET;
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
         try
         {
            loader.load(request);
         }
         catch(e:*)
         {
            trace("NOT FOUND - font.swf");
         }
      }
      
      public static function get bytesLoaded() : *
      {
         var _loc1_:* = 0;
         if(Boolean(loader) && Boolean(loader.contentLoaderInfo))
         {
            _loc1_ = loader.contentLoaderInfo.bytesLoaded;
         }
         return _loc1_;
      }
      
      public static function get bytesTotal() : *
      {
         var _loc1_:* = -1;
         if(Boolean(loader) && Boolean(loader.contentLoaderInfo))
         {
            _loc1_ = loader.contentLoaderInfo.bytesTotal;
         }
         return _loc1_;
      }
      
      public static function init() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Font = null;
         for(_loc1_ in Font.enumerateFonts())
         {
            _loc2_ = Font.enumerateFonts()[_loc1_];
            if(_loc2_.fontName == "PokemonFontKozM")
            {
               tf1 = new TextFormat();
               tf1.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonFontFFFCompact")
            {
               tf2 = new TextFormat();
               tf2.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonFontKozB")
            {
               tf3 = new TextFormat();
               tf3.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonFontFFFCorporateBold")
            {
               tf4 = new TextFormat();
               tf4.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "InterparkGothicOTFM")
            {
               tf5 = new TextFormat();
               tf5.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "InterparkGothicOTFB")
            {
               tf6 = new TextFormat();
               tf6.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "p-kigou-b")
            {
               tf7 = new TextFormat();
               tf7.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "p-kigou-m")
            {
               tf8 = new TextFormat();
               tf8.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonHelveticaNeueLTStdBdCn")
            {
               tf9 = new TextFormat();
               tf9.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonHelveticaNeueLTStdMdCn")
            {
               tf10 = new TextFormat();
               tf10.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonHelveticaNeueLTStdBdCnO")
            {
               tf11 = new TextFormat();
               tf11.font = _loc2_.fontName;
            }
            if(_loc2_.fontName == "PokemonHelveticaNeueLTStdMdCnO")
            {
               tf12 = new TextFormat();
               tf12.font = _loc2_.fontName;
            }
            trace(_loc2_.fontName + " " + _loc2_.fontStyle + " " + _loc2_.fontType);
         }
         if(!lang_code)
         {
            FontManager.langCode = "";
         }
      }
      
      public static function loadStringsXml(param1:*, param2:String = "") : void
      {
         textFieldManager.addEventListener(Event.COMPLETE,textFieldCompleteHandler);
         textFieldManager.init(param1,param2);
      }
      
      private static function textFieldCompleteHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function loadedCheckId(param1:String) : Boolean
      {
         return textFieldManager.loadedCheckId(param1);
      }
      
      public static function setShingoM(param1:TextField) : void
      {
      }
      
      public static function setShingoExtM(param1:TextField) : void
      {
      }
      
      public static function setShingoB(param1:TextField) : void
      {
      }
      
      public static function setShingoExtB(param1:TextField) : void
      {
      }
      
      public static function setJapaneseM(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf1)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf1;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setJapaneseExtM(param1:TextField) : void
      {
         if(tf1)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf1;
         }
      }
      
      public static function setJapaneseB(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf3)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf3;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setJapaneseExtB(param1:TextField) : void
      {
         if(tf3)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf3;
         }
      }
      
      public static function setFFFCompact(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf2)
         {
            param1.embedFonts = true;
            param1.antiAliasType = "normal";
            param1.gridFitType = "pixel";
            param1.defaultTextFormat = tf2;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setFFFCorporateBold(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf4)
         {
            param1.embedFonts = true;
            param1.antiAliasType = "normal";
            param1.gridFitType = "pixel";
            param1.defaultTextFormat = tf4;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setKoreanM(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf5)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf5;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setKoreanExtM(param1:TextField) : void
      {
         if(tf5)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf5;
         }
      }
      
      public static function setKoreanB(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf6)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf6;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setKoreanExtB(param1:TextField) : void
      {
         if(tf6)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf6;
         }
      }
      
      public static function setHelveticaM(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf9)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf9;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setHelveticaExtM(param1:TextField) : void
      {
         if(tf9)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf9;
         }
      }
      
      public static function setHelveticaB(param1:TextField) : void
      {
         var _loc2_:String = null;
         if(tf10)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf10;
            _loc2_ = param1.text;
            param1.text = _loc2_;
         }
      }
      
      public static function setHelveticaExtB(param1:TextField) : void
      {
         if(tf10)
         {
            param1.embedFonts = true;
            if(param1.antiAliasType != AntiAliasType.ADVANCED)
            {
               param1.antiAliasType = "advanced";
               param1.gridFitType = "subpixel";
               param1.sharpness = -500;
               param1.thickness = -100;
            }
            param1.defaultTextFormat = tf10;
         }
      }
      
      public static function setTextM(param1:TextField) : void
      {
         param1.embedFonts = true;
         if(param1.antiAliasType != AntiAliasType.ADVANCED)
         {
            param1.antiAliasType = "advanced";
            param1.gridFitType = "subpixel";
            param1.sharpness = -500;
            param1.thickness = -100;
         }
         param1.htmlText = markupMultilingualText(param1.text,false);
      }
      
      public static function setTextB(param1:TextField) : void
      {
         param1.embedFonts = true;
         if(param1.antiAliasType != AntiAliasType.ADVANCED)
         {
            param1.antiAliasType = "advanced";
            param1.gridFitType = "subpixel";
            param1.sharpness = -500;
            param1.thickness = -100;
         }
         param1.htmlText = markupMultilingualText(param1.text,true);
      }
      
      public static function markupMultilingualText(param1:String, param2:Boolean = false, param3:Boolean = false) : String
      {
         var text:String = param1;
         var boldFlag:Boolean = param2;
         var italicFlag:Boolean = param3;
         return text.replace(/([①-⒇Ş-ş]+)|([!-~ -ÿıŁ-łŒ-œŠ-šŸŽ-žƒˆ-ˇˉ˘-˝Ωμπ–-—‘-‚“-„†-•…‰‹-›⁄€ℓ™Ω℮∂∆∏∑-−∕∙-√∞∫≈≠≤-≥◊]+)|([ㄱ-ㅣ가-힝]+)|([\n]+)|([^①-⒇Ş-ş\n!-~ -ÿıŁ-łŒ-œŠ-šŸŽ-žƒˆ-ˇˉ˘-˝Ωμπ–-—‘-‚“-„†-•…‰‹-›⁄€ℓ™Ω℮∂∆∏∑-−∕∙-√∞∫≈≠≤-≥◊ㄱ-ㅣ가-힝]+)/g,function(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String):String
         {
            var _loc9_:* = undefined;
            if(param5)
            {
               return param1;
            }
            if(param2)
            {
               if(boldFlag)
               {
                  _loc9_ = tf7.font;
               }
               else
               {
                  _loc9_ = tf8.font;
               }
            }
            else if(param4)
            {
               if(boldFlag)
               {
                  _loc9_ = tf6.font;
               }
               else
               {
                  _loc9_ = tf5.font;
               }
            }
            else if(param3)
            {
               if(boldFlag)
               {
                  if(italicFlag)
                  {
                     _loc9_ = tf11.font;
                  }
                  else
                  {
                     _loc9_ = tf9.font;
                  }
               }
               else if(italicFlag)
               {
                  _loc9_ = tf12.font;
               }
               else
               {
                  _loc9_ = tf10.font;
               }
            }
            else if(boldFlag)
            {
               _loc9_ = tf3.font;
            }
            else
            {
               _loc9_ = tf1.font;
            }
            return "<FONT FACE=\"" + _loc9_ + "\">" + param1 + "</FONT>";
         });
      }
      
      public static function setTextID(param1:TextField, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(param3)
         {
            setAutoFontTextID(param1,param2);
         }
         else
         {
            _loc4_ = textFieldManager.createTextFormatTag(param2);
            textFieldManager.setAntiAlias(param1,param2,param1.getTextFormat());
            _loc5_ = textFieldManager.getIdText(param2);
            setBaseline(param1,_loc4_,param2);
            _loc5_ = markupMultilingualText(_loc5_,_loc4_.boldFlag);
            param1.embedFonts = true;
            _loc6_ = _loc4_.leftTag + _loc5_ + _loc4_.rightTag;
            param1.htmlText = _loc6_;
         }
      }
      
      public static function setAutoFontTextID(param1:TextField, param2:String) : void
      {
         var _loc3_:Object = textFieldManager.createTextFormatTag(param2);
         setBaseline(param1,_loc3_,param2);
         textFieldManager.setAntiAlias(param1,param2,param1.getTextFormat());
         param1.text = textFieldManager.getIdText(param2);
         var _loc4_:String = markupMultilingualText(param1.text,_loc3_.boldFlag);
         var _loc5_:* = _loc3_.leftTag + _loc4_ + _loc3_.rightTag;
         param1.embedFonts = true;
         param1.htmlText = _loc5_;
      }
      
      public static function setText(param1:TextField, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:* = markupMultilingualText(param2,param3);
         param1.embedFonts = true;
         param1.htmlText = _loc4_;
      }
      
      public static function setTextAndFormat(param1:TextField, param2:String, param3:String) : void
      {
         var _loc4_:Object = textFieldManager.createTextFormatTag(param3);
         setBaseline(param1,_loc4_,param3);
         textFieldManager.setAntiAlias(param1,param3,param1.getTextFormat());
         var _loc5_:* = markupMultilingualText(param2,_loc4_.boldFlag);
         param1.embedFonts = true;
         var _loc6_:* = _loc4_.leftTag + _loc5_ + _loc4_.rightTag;
         param1.htmlText = _loc6_;
      }
      
      public static function addFormat(param1:TextField, param2:String) : void
      {
         var _loc3_:* = textFieldManager.createTextFormat(param1,param2,param1.getTextFormat());
         setBaseline(param1,_loc3_,param2);
         param1.embedFonts = false;
      }
      
      public static function setTextAndFormatTag(param1:TextField, param2:String, param3:String) : void
      {
         var _loc4_:Object = textFieldManager.createTextFormatTag(param3);
         setBaseline(param1,_loc4_,param3);
         textFieldManager.setAntiAlias(param1,param3,param1.getTextFormat());
         var _loc5_:* = _loc4_.leftTag + param2 + _loc4_.rightTag;
         param1.embedFonts = true;
         param1.htmlText = _loc5_;
      }
      
      public static function setHtmlText(param1:TextField, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:* = "";
         var _loc5_:String = "";
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(param3)
               {
                  _loc5_ = "InterparkGothicOTFM";
               }
               else
               {
                  _loc5_ = "InterparkGothicOTFB";
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(param3)
               {
                  _loc5_ = "PokemonHelveticaNeueLTStdBdCn";
               }
               else
               {
                  _loc5_ = "PokemonHelveticaNeueLTStdMdCn";
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(param3)
               {
                  _loc5_ = "PokemonFontKozM";
               }
               else
               {
                  _loc5_ = "PokemonFontKozB";
               }
         }
         _loc4_ = "<FONT FACE=\"" + _loc5_ + "\">" + param2 + "</FONT>";
         param1.embedFonts = true;
         param1.htmlText = _loc4_;
      }
      
      public static function setAutoFontText(param1:TextField, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         param1.embedFonts = true;
         var _loc5_:String = markupMultilingualText(param2,param3);
         param1.htmlText = getAutoFontText(_loc5_,param3,param4);
      }
      
      public static function getAutoFontText(param1:String, param2:Boolean = false, param3:Boolean = false) : String
      {
         var _loc4_:String = "";
         var _loc5_:String = "";
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(param2)
               {
                  _loc5_ = "InterparkGothicOTFM";
               }
               else
               {
                  _loc5_ = "InterparkGothicOTFB";
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(param2)
               {
                  if(param3)
                  {
                     _loc5_ = "PokemonHelveticaNeueLTStdBdCnO";
                  }
                  else
                  {
                     _loc5_ = "PokemonHelveticaNeueLTStdBdCn";
                  }
               }
               else if(param3)
               {
                  _loc5_ = "PokemonHelveticaNeueLTStdMdCnO";
               }
               else
               {
                  _loc5_ = "PokemonHelveticaNeueLTStdMdCn";
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(param2)
               {
                  _loc5_ = "PokemonFontKozM";
               }
               else
               {
                  _loc5_ = "PokemonFontKozB";
               }
         }
         return "<FONT FACE=\"" + _loc5_ + "\">" + param1 + "</FONT>";
      }
      
      public static function set langCode(param1:String) : void
      {
         lang_code = param1;
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               textFieldManager.defaultFontNameM = "InterparkGothicOTFM";
               textFieldManager.defaultFontNameB = "InterparkGothicOTFB";
               break;
            case FontManager.LANG_CODE_EN:
               textFieldManager.defaultFontNameM = "PokemonHelveticaNeueLTStdBdCn";
               textFieldManager.defaultFontNameB = "PokemonHelveticaNeueLTStdMdCn";
               break;
            case FontManager.LANG_CODE_JA:
            default:
               textFieldManager.defaultFontNameM = "PokemonFontKozM";
               textFieldManager.defaultFontNameB = "PokemonFontKozB";
         }
      }
      
      public static function get langCode() : String
      {
         return lang_code;
      }
      
      public static function getIdText(param1:String) : String
      {
         return textFieldManager.getIdText(param1);
      }
      
      public static function setSelectedFont(param1:TextField, param2:Boolean = false) : void
      {
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(param2)
               {
                  FontManager.setKoreanB(param1);
               }
               else
               {
                  FontManager.setKoreanM(param1);
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(param2)
               {
                  FontManager.setHelveticaB(param1);
               }
               else
               {
                  FontManager.setHelveticaM(param1);
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(param2)
               {
                  FontManager.setJapaneseB(param1);
               }
               else
               {
                  FontManager.setJapaneseM(param1);
               }
         }
      }
      
      private static function setBaseline(param1:TextField, param2:Object, param3:String) : void
      {
         var err_flag:* = undefined;
         var chk_flag:* = undefined;
         var tf:TextField = param1;
         var tagdata:Object = param2;
         var id:String = param3;
         if(tagdata.baselineMode == "mem")
         {
            err_flag = false;
            if(tagdata.baselineShift)
            {
               chk_flag = tf.parent is MovieClip;
               if(chk_flag)
               {
                  if(tf.name)
                  {
                     if(!tf.parent.hasOwnProperty(tf.name + "_defY"))
                     {
                        try
                        {
                           tf.parent[tf.name + "_defY"] = tf.y;
                        }
                        catch(e:ReferenceError)
                        {
                           err_flag = true;
                        }
                     }
                     if(!err_flag)
                     {
                        tf.y = tf.parent[tf.name + "_defY"] + parseInt(tagdata.baselineShift,10);
                     }
                  }
                  else
                  {
                     tf.y += parseInt(tagdata.baselineShift,10);
                  }
               }
               if(!chk_flag || err_flag)
               {
                  if(id_position[id] == undefined)
                  {
                     id_position[id] = tf.y;
                  }
                  tf.y = id_position[id] + parseInt(tagdata.baselineShift,10);
               }
            }
            else if(tagdata.baselinePosition)
            {
               tf.y = parseInt(tagdata.baselinePosition,10);
            }
         }
         else if(tagdata.baselineShift)
         {
            tf.y += parseInt(tagdata.baselineShift,10);
         }
      }
      
      public static function clearBaselineInfo(param1:TextField) : void
      {
         if(param1.parent is MovieClip && param1.name && param1.parent[param1.name + "_defY"] != undefined)
         {
            param1.parent[param1.name + "_defY"] = undefined;
         }
      }
      
      public static function clearBaselineInfoId(param1:String) : void
      {
         id_position[param1] = undefined;
      }
      
      public static function splitAndReplace(param1:String, param2:*, param3:*) : String
      {
         var _loc4_:Array;
         if((_loc4_ = param1.split(param2)).length == 0)
         {
            return param1;
         }
         return _loc4_.join(param3);
      }
      
      private static function completeHandler(param1:Event = null) : void
      {
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
         init();
         dispatchEvent(new Event(LOADED));
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
      
      public function setAnti() : void
      {
      }
   }
}

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
      
      public static var lang_code:String;
      
      private static var loader:Loader;
      
      private static var tf1:TextFormat;
      
      public static const LOADED:String = "LOADED";
      
      public static const LANG_CODE_JA:String = "ja";
      
      public static const LANG_CODE_KO:String = "ko";
      
      public static const LANG_CODE_EN:String = "en";
      
      private static var id_position:Object = new Object();
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public function FontManager()
      {
         super();
      }
      
      public static function clearBaselineInfo(tf:TextField) : void
      {
         if(Boolean(tf.parent is MovieClip) && Boolean(tf.name) && tf.parent[tf.name + "_defY"] != undefined)
         {
            tf.parent[tf.name + "_defY"] = undefined;
         }
      }
      
      public static function init() : void
      {
         var i:* = undefined;
         var f:Font = null;
         for(i in Font.enumerateFonts())
         {
            f = Font.enumerateFonts()[i];
            if(f.fontName == "PokemonFontKozM")
            {
               tf1 = new TextFormat();
               tf1.font = f.fontName;
            }
            if(f.fontName == "PokemonFontFFFCompact")
            {
               tf2 = new TextFormat();
               tf2.font = f.fontName;
            }
            if(f.fontName == "PokemonFontKozB")
            {
               tf3 = new TextFormat();
               tf3.font = f.fontName;
            }
            if(f.fontName == "PokemonFontFFFCorporateBold")
            {
               tf4 = new TextFormat();
               tf4.font = f.fontName;
            }
            if(f.fontName == "InterparkGothicOTFM")
            {
               tf5 = new TextFormat();
               tf5.font = f.fontName;
            }
            if(f.fontName == "InterparkGothicOTFB")
            {
               tf6 = new TextFormat();
               tf6.font = f.fontName;
            }
            if(f.fontName == "p-kigou-b")
            {
               tf7 = new TextFormat();
               tf7.font = f.fontName;
            }
            if(f.fontName == "p-kigou-m")
            {
               tf8 = new TextFormat();
               tf8.font = f.fontName;
            }
            if(f.fontName == "PokemonHelveticaNeueLTStdBdCn")
            {
               tf9 = new TextFormat();
               tf9.font = f.fontName;
            }
            if(f.fontName == "PokemonHelveticaNeueLTStdMdCn")
            {
               tf10 = new TextFormat();
               tf10.font = f.fontName;
            }
            if(f.fontName == "PokemonHelveticaNeueLTStdBdCnO")
            {
               tf11 = new TextFormat();
               tf11.font = f.fontName;
            }
            if(f.fontName == "PokemonHelveticaNeueLTStdMdCnO")
            {
               tf12 = new TextFormat();
               tf12.font = f.fontName;
            }
            trace(f.fontName + " " + f.fontStyle + " " + f.fontType);
         }
         if(!lang_code)
         {
            FontManager.langCode = "";
         }
      }
      
      public static function setShingoExtB(txt:TextField) : void
      {
      }
      
      public static function setShingoExtM(txt:TextField) : void
      {
      }
      
      public static function setHtmlText(tf:TextField, st:String, boldFlag:Boolean = false) : void
      {
         var wk_data:String = "";
         var fontName:String = "";
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(boldFlag)
               {
                  fontName = "InterparkGothicOTFM";
               }
               else
               {
                  fontName = "InterparkGothicOTFB";
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(boldFlag)
               {
                  fontName = "PokemonHelveticaNeueLTStdBdCn";
               }
               else
               {
                  fontName = "PokemonHelveticaNeueLTStdMdCn";
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(boldFlag)
               {
                  fontName = "PokemonFontKozM";
               }
               else
               {
                  fontName = "PokemonFontKozB";
               }
         }
         wk_data = "<FONT FACE=\"" + fontName + "\">" + st + "</FONT>";
         tf.embedFonts = true;
         tf.htmlText = wk_data;
      }
      
      public static function setJapaneseExtM(txt:TextField) : void
      {
         if(tf1)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf1;
         }
      }
      
      public static function get bytesTotal() : *
      {
         var ret:* = -1;
         if(Boolean(loader) && Boolean(loader.contentLoaderInfo))
         {
            ret = loader.contentLoaderInfo.bytesTotal;
         }
         return ret;
      }
      
      public static function setJapaneseExtB(txt:TextField) : void
      {
         if(tf3)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf3;
         }
      }
      
      public static function setFFFCorporateBold(txt:TextField) : void
      {
         var str:String = null;
         if(tf4)
         {
            txt.embedFonts = true;
            txt.antiAliasType = "normal";
            txt.gridFitType = "pixel";
            txt.defaultTextFormat = tf4;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function setTextID(tf:TextField, id:String, autoFont:Boolean = false) : void
      {
         var tagdata:Object = null;
         var tf_data:* = undefined;
         var wk_data:* = undefined;
         if(autoFont)
         {
            setAutoFontTextID(tf,id);
         }
         else
         {
            tagdata = textFieldManager.createTextFormatTag(id);
            textFieldManager.setAntiAlias(tf,id,tf.getTextFormat());
            tf_data = textFieldManager.getIdText(id);
            setBaseline(tf,tagdata,id);
            tf_data = markupMultilingualText(tf_data,tagdata.boldFlag);
            tf.embedFonts = true;
            wk_data = tagdata.leftTag + tf_data + tagdata.rightTag;
            tf.htmlText = wk_data;
         }
      }
      
      public static function setFFFCompact(txt:TextField) : void
      {
         var str:String = null;
         if(tf2)
         {
            txt.embedFonts = true;
            txt.antiAliasType = "normal";
            txt.gridFitType = "pixel";
            txt.defaultTextFormat = tf2;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function setText(tf:TextField, st:String, boldFlag:Boolean = false) : void
      {
         var tf_data:* = markupMultilingualText(st,boldFlag);
         tf.embedFonts = true;
         tf.htmlText = tf_data;
      }
      
      public static function setShingoM(txt:TextField) : void
      {
      }
      
      public static function addFormat(tf:TextField, id:String) : void
      {
         var tagdata:* = textFieldManager.createTextFormat(tf,id,tf.getTextFormat());
         setBaseline(tf,tagdata,id);
         tf.embedFonts = false;
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
      
      public static function setKoreanM(txt:TextField) : void
      {
         var str:String = null;
         if(tf5)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf5;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function setShingoB(txt:TextField) : void
      {
      }
      
      public static function setHelveticaExtB(txt:TextField) : void
      {
         if(tf10)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf10;
         }
      }
      
      public static function setSelectedFont(tf:TextField, boldFlag:Boolean = false) : void
      {
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(boldFlag)
               {
                  FontManager.setKoreanB(tf);
               }
               else
               {
                  FontManager.setKoreanM(tf);
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(boldFlag)
               {
                  FontManager.setHelveticaB(tf);
               }
               else
               {
                  FontManager.setHelveticaM(tf);
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(boldFlag)
               {
                  FontManager.setJapaneseB(tf);
               }
               else
               {
                  FontManager.setJapaneseM(tf);
               }
         }
      }
      
      public static function loadStringsXml(req_list:*, file_id:String = "") : void
      {
         textFieldManager.addEventListener(Event.COMPLETE,textFieldCompleteHandler);
         textFieldManager.init(req_list,file_id);
      }
      
      public static function setTextAndFormat(tf:TextField, st:String, id:String) : void
      {
         var tagdata:Object = textFieldManager.createTextFormatTag(id);
         setBaseline(tf,tagdata,id);
         textFieldManager.setAntiAlias(tf,id,tf.getTextFormat());
         var tf_data:* = markupMultilingualText(st,tagdata.boldFlag);
         tf.embedFonts = true;
         var wk_data:* = tagdata.leftTag + tf_data + tagdata.rightTag;
         tf.htmlText = wk_data;
      }
      
      public static function dispatchEvent(e:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(e);
      }
      
      public static function setHelveticaExtM(txt:TextField) : void
      {
         if(tf9)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf9;
         }
      }
      
      private static function textFieldCompleteHandler(e:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function standalone(path:String) : void
      {
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
      
      private static function setBaseline(tf:TextField, tagdata:Object, id:String) : void
      {
         var err_flag:* = undefined;
         var chk_flag:* = undefined;
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
               if(!chk_flag || Boolean(err_flag))
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
      
      public static function setAutoFontTextID(tf:TextField, id:String) : void
      {
         var tagdata:Object = textFieldManager.createTextFormatTag(id);
         setBaseline(tf,tagdata,id);
         textFieldManager.setAntiAlias(tf,id,tf.getTextFormat());
         tf.text = textFieldManager.getIdText(id);
         var tf_data:String = markupMultilingualText(tf.text,tagdata.boldFlag);
         var wk_data:* = tagdata.leftTag + tf_data + tagdata.rightTag;
         tf.embedFonts = true;
         tf.htmlText = wk_data;
      }
      
      public static function get bytesLoaded() : *
      {
         var ret:* = 0;
         if(Boolean(loader) && Boolean(loader.contentLoaderInfo))
         {
            ret = loader.contentLoaderInfo.bytesLoaded;
         }
         return ret;
      }
      
      private static function completeHandler(e:Event = null) : void
      {
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
         init();
         dispatchEvent(new Event(LOADED));
      }
      
      public static function setTextM(txt:TextField) : void
      {
         txt.embedFonts = true;
         if(txt.antiAliasType != AntiAliasType.ADVANCED)
         {
            txt.antiAliasType = "advanced";
            txt.gridFitType = "subpixel";
            txt.sharpness = -500;
            txt.thickness = -100;
         }
         txt.htmlText = markupMultilingualText(txt.text,false);
      }
      
      public static function setHelveticaB(txt:TextField) : void
      {
         var str:String = null;
         if(tf10)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf10;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function setTextAndFormatTag(tf:TextField, st:String, id:String) : void
      {
         var tagdata:Object = textFieldManager.createTextFormatTag(id);
         setBaseline(tf,tagdata,id);
         textFieldManager.setAntiAlias(tf,id,tf.getTextFormat());
         var wk_data:* = tagdata.leftTag + st + tagdata.rightTag;
         tf.embedFonts = true;
         tf.htmlText = wk_data;
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function clearBaselineInfoId(id:String) : void
      {
         id_position[id] = undefined;
      }
      
      public static function setHelveticaM(txt:TextField) : void
      {
         var str:String = null;
         if(tf9)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf9;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function getAutoFontText(st:String, boldFlag:Boolean = false, italicFlag:Boolean = false) : String
      {
         var wk_data:String = "";
         var fontName:String = "";
         switch(lang_code)
         {
            case FontManager.LANG_CODE_KO:
               if(boldFlag)
               {
                  fontName = "InterparkGothicOTFM";
               }
               else
               {
                  fontName = "InterparkGothicOTFB";
               }
               break;
            case FontManager.LANG_CODE_EN:
               if(boldFlag)
               {
                  if(italicFlag)
                  {
                     fontName = "PokemonHelveticaNeueLTStdBdCnO";
                  }
                  else
                  {
                     fontName = "PokemonHelveticaNeueLTStdBdCn";
                  }
               }
               else if(italicFlag)
               {
                  fontName = "PokemonHelveticaNeueLTStdMdCnO";
               }
               else
               {
                  fontName = "PokemonHelveticaNeueLTStdMdCn";
               }
               break;
            case FontManager.LANG_CODE_JA:
            default:
               if(boldFlag)
               {
                  fontName = "PokemonFontKozM";
               }
               else
               {
                  fontName = "PokemonFontKozB";
               }
         }
         return "<FONT FACE=\"" + fontName + "\">" + st + "</FONT>";
      }
      
      public static function getIdText(id:String) : String
      {
         return textFieldManager.getIdText(id);
      }
      
      public static function markupMultilingualText(text:String, boldFlag:Boolean = false, italicFlag:Boolean = false) : String
      {
         return text.replace(/([①-⒇Ş-ş]+)|([!-~ -ÿıŁ-łŒ-œŠ-šŸŽ-žƒˆ-ˇˉ˘-˝Ωμπ–-—‘-‚“-„†-•…‰‹-›⁄€ℓ™Ω℮∂∆∏∑-−∕∙-√∞∫≈≠≤-≥◊]+)|([ㄱ-ㅣ가-힝]+)|([\n]+)|([^①-⒇Ş-ş\n!-~ -ÿıŁ-łŒ-œŠ-šŸŽ-žƒˆ-ˇˉ˘-˝Ωμπ–-—‘-‚“-„†-•…‰‹-›⁄€ℓ™Ω℮∂∆∏∑-−∕∙-√∞∫≈≠≤-≥◊ㄱ-ㅣ가-힝]+)/g,function(match:String, extKigou:String, efigs:String, hangeul:String, ctrcode:String, another:String, index:int, all:String):String
         {
            var fontName:* = undefined;
            if(ctrcode)
            {
               return match;
            }
            if(extKigou)
            {
               if(boldFlag)
               {
                  fontName = tf7.font;
               }
               else
               {
                  fontName = tf8.font;
               }
            }
            else if(hangeul)
            {
               if(boldFlag)
               {
                  fontName = tf6.font;
               }
               else
               {
                  fontName = tf5.font;
               }
            }
            else if(efigs)
            {
               if(boldFlag)
               {
                  if(italicFlag)
                  {
                     fontName = tf11.font;
                  }
                  else
                  {
                     fontName = tf9.font;
                  }
               }
               else if(italicFlag)
               {
                  fontName = tf12.font;
               }
               else
               {
                  fontName = tf10.font;
               }
            }
            else if(boldFlag)
            {
               fontName = tf3.font;
            }
            else
            {
               fontName = tf1.font;
            }
            return "<FONT FACE=\"" + fontName + "\">" + match + "</FONT>";
         });
      }
      
      public static function setKoreanExtB(txt:TextField) : void
      {
         if(tf6)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf6;
         }
      }
      
      public static function splitAndReplace(mes_txt:String, split_txt:*, replace_txt:*) : String
      {
         var wk:Array = mes_txt.split(split_txt);
         if(wk.length == 0)
         {
            return mes_txt;
         }
         return wk.join(replace_txt);
      }
      
      public static function setAutoFontText(tf:TextField, st:String, boldFlag:Boolean = false, italicFlag:Boolean = false) : void
      {
         tf.embedFonts = true;
         var tf_data:String = markupMultilingualText(st,boldFlag);
         tf.htmlText = getAutoFontText(tf_data,boldFlag,italicFlag);
      }
      
      public static function setJapaneseB(txt:TextField) : void
      {
         var str:String = null;
         if(tf3)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf3;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function setKoreanExtM(txt:TextField) : void
      {
         if(tf5)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf5;
         }
      }
      
      public static function setTextB(txt:TextField) : void
      {
         txt.embedFonts = true;
         if(txt.antiAliasType != AntiAliasType.ADVANCED)
         {
            txt.antiAliasType = "advanced";
            txt.gridFitType = "subpixel";
            txt.sharpness = -500;
            txt.thickness = -100;
         }
         txt.htmlText = markupMultilingualText(txt.text,true);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
      
      public static function set langCode(code:String) : void
      {
         lang_code = code;
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
      
      public static function setJapaneseM(txt:TextField) : void
      {
         var str:String = null;
         if(tf1)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf1;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function get langCode() : String
      {
         return lang_code;
      }
      
      public static function setKoreanB(txt:TextField) : void
      {
         var str:String = null;
         if(tf6)
         {
            txt.embedFonts = true;
            if(txt.antiAliasType != AntiAliasType.ADVANCED)
            {
               txt.antiAliasType = "advanced";
               txt.gridFitType = "subpixel";
               txt.sharpness = -500;
               txt.thickness = -100;
            }
            txt.defaultTextFormat = tf6;
            str = txt.text;
            txt.text = str;
         }
      }
      
      public static function loadedCheckId(file_id:String) : Boolean
      {
         return textFieldManager.loadedCheckId(file_id);
      }
      
      public function setAnti() : void
      {
      }
   }
}


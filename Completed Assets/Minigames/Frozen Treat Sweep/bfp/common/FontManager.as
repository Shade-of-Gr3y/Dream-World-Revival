package bfp.common
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;

    public class FontManager extends Object
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
            return;
        }// end function

        public function setAnti() : void
        {
            return;
        }// end function

        public static function standalone(param1:String) : void
        {
            var path:* = param1;
            loader = new Loader();
            var request:* = new URLRequest();
            request.url = path;
            request.method = URLRequestMethod.GET;
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            try
            {
                loader.load(request);
            }
            catch (e)
            {
            }
            return;
        }// end function

        public static function get bytesLoaded()
        {
            var _loc_1:* = 0;
            if (loader && loader.contentLoaderInfo)
            {
                _loc_1 = loader.contentLoaderInfo.bytesLoaded;
            }
            return _loc_1;
        }// end function

        public static function get bytesTotal()
        {
            var _loc_1:* = -1;
            if (loader && loader.contentLoaderInfo)
            {
                _loc_1 = loader.contentLoaderInfo.bytesTotal;
            }
            return _loc_1;
        }// end function

        public static function init() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:Font = null;
            for (_loc_1 in Font.enumerateFonts())
            {
                
                _loc_2 = Font.enumerateFonts()[_loc_1];
                if (_loc_2.fontName == "PokemonFontKozM")
                {
                    tf1 = new TextFormat();
                    tf1.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonFontFFFCompact")
                {
                    tf2 = new TextFormat();
                    tf2.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonFontKozB")
                {
                    tf3 = new TextFormat();
                    tf3.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonFontFFFCorporateBold")
                {
                    tf4 = new TextFormat();
                    tf4.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "InterparkGothicOTFM")
                {
                    tf5 = new TextFormat();
                    tf5.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "InterparkGothicOTFB")
                {
                    tf6 = new TextFormat();
                    tf6.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "p-kigou-b")
                {
                    tf7 = new TextFormat();
                    tf7.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "p-kigou-m")
                {
                    tf8 = new TextFormat();
                    tf8.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonHelveticaNeueLTStdBdCn")
                {
                    tf9 = new TextFormat();
                    tf9.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonHelveticaNeueLTStdMdCn")
                {
                    tf10 = new TextFormat();
                    tf10.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonHelveticaNeueLTStdBdCnO")
                {
                    tf11 = new TextFormat();
                    tf11.font = _loc_2.fontName;
                }
                if (_loc_2.fontName == "PokemonHelveticaNeueLTStdMdCnO")
                {
                    tf12 = new TextFormat();
                    tf12.font = _loc_2.fontName;
                }
            }
            if (!lang_code)
            {
                FontManager.langCode = "";
            }
            return;
        }// end function

        public static function loadStringsXml(param1, param2:String = "") : void
        {
            textFieldManager.addEventListener(Event.COMPLETE, textFieldCompleteHandler);
            textFieldManager.init(param1, param2);
            return;
        }// end function

        private static function textFieldCompleteHandler(event:Event) : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public static function loadedCheckId(param1:String) : Boolean
        {
            return textFieldManager.loadedCheckId(param1);
        }// end function

        public static function setShingoM(param1:TextField) : void
        {
            return;
        }// end function

        public static function setShingoExtM(param1:TextField) : void
        {
            return;
        }// end function

        public static function setShingoB(param1:TextField) : void
        {
            return;
        }// end function

        public static function setShingoExtB(param1:TextField) : void
        {
            return;
        }// end function

        public static function setJapaneseM(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf1)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf1;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setJapaneseExtM(param1:TextField) : void
        {
            if (tf1)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf1;
            }
            return;
        }// end function

        public static function setJapaneseB(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf3)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf3;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setJapaneseExtB(param1:TextField) : void
        {
            if (tf3)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf3;
            }
            return;
        }// end function

        public static function setFFFCompact(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf2)
            {
                param1.embedFonts = true;
                param1.antiAliasType = "normal";
                param1.gridFitType = "pixel";
                param1.defaultTextFormat = tf2;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setFFFCorporateBold(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf4)
            {
                param1.embedFonts = true;
                param1.antiAliasType = "normal";
                param1.gridFitType = "pixel";
                param1.defaultTextFormat = tf4;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setKoreanM(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf5)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf5;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setKoreanExtM(param1:TextField) : void
        {
            if (tf5)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf5;
            }
            return;
        }// end function

        public static function setKoreanB(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf6)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf6;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setKoreanExtB(param1:TextField) : void
        {
            if (tf6)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf6;
            }
            return;
        }// end function

        public static function setHelveticaM(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf9)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf9;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setHelveticaExtM(param1:TextField) : void
        {
            if (tf9)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf9;
            }
            return;
        }// end function

        public static function setHelveticaB(param1:TextField) : void
        {
            var _loc_2:String = null;
            if (tf10)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf10;
                _loc_2 = param1.text;
                param1.text = _loc_2;
            }
            return;
        }// end function

        public static function setHelveticaExtB(param1:TextField) : void
        {
            if (tf10)
            {
                param1.embedFonts = true;
                if (param1.antiAliasType != AntiAliasType.ADVANCED)
                {
                    param1.antiAliasType = "advanced";
                    param1.gridFitType = "subpixel";
                    param1.sharpness = -500;
                    param1.thickness = -100;
                }
                param1.defaultTextFormat = tf10;
            }
            return;
        }// end function

        public static function setTextM(param1:TextField) : void
        {
            param1.embedFonts = true;
            if (param1.antiAliasType != AntiAliasType.ADVANCED)
            {
                param1.antiAliasType = "advanced";
                param1.gridFitType = "subpixel";
                param1.sharpness = -500;
                param1.thickness = -100;
            }
            param1.htmlText = markupMultilingualText(param1.text, false);
            return;
        }// end function

        public static function setTextB(param1:TextField) : void
        {
            param1.embedFonts = true;
            if (param1.antiAliasType != AntiAliasType.ADVANCED)
            {
                param1.antiAliasType = "advanced";
                param1.gridFitType = "subpixel";
                param1.sharpness = -500;
                param1.thickness = -100;
            }
            param1.htmlText = markupMultilingualText(param1.text, true);
            return;
        }// end function

        public static function markupMultilingualText(param1:String, param2:Boolean = false, param3:Boolean = false) : String
        {
            var text:* = param1;
            var boldFlag:* = param2;
            var italicFlag:* = param3;
            return text.replace(/([?-?S-s]+)|([!-~ -ÿiL-lŒ-œŠ-šŸŽ-žƒˆ-?¯?-?Oµp–-—‘-‚“-„†-•…‰‹-›/€l™?e????--/·-v8?˜?=-=?]+)|([?-??-?]+)|([
]+)|([^?-?S-s
!-~ -ÿiL-lŒ-œŠ-šŸŽ-žƒˆ-?¯?-?Oµp–-—‘-‚“-„†-•…‰‹-›/€l™?e????--/·-v8?˜?=-=??-??-?]+)/g, function (param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String) : String
            {
                var _loc_9:* = undefined;
                if (param5)
                {
                    return param1;
                }
                if (param2)
                {
                    if (boldFlag)
                    {
                        _loc_9 = tf7.font;
                    }
                    else
                    {
                        _loc_9 = tf8.font;
                    }
                }
                else if (param4)
                {
                    if (boldFlag)
                    {
                        _loc_9 = tf6.font;
                    }
                    else
                    {
                        _loc_9 = tf5.font;
                    }
                }
                else if (param3)
                {
                    if (boldFlag)
                    {
                        if (italicFlag)
                        {
                            _loc_9 = tf11.font;
                        }
                        else
                        {
                            _loc_9 = tf9.font;
                        }
                    }
                    else if (italicFlag)
                    {
                        _loc_9 = tf12.font;
                    }
                    else
                    {
                        _loc_9 = tf10.font;
                    }
                }
                else if (boldFlag)
                {
                    _loc_9 = tf3.font;
                }
                else
                {
                    _loc_9 = tf1.font;
                }
                return "<FONT FACE=\"" + _loc_9 + "\">" + param1 + "</FONT>";
            }// end function
            );
        }// end function

        public static function setTextID(param1:TextField, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:Object = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param3)
            {
                setAutoFontTextID(param1, param2);
            }
            else
            {
                _loc_4 = textFieldManager.createTextFormatTag(param2);
                textFieldManager.setAntiAlias(param1, param2, param1.getTextFormat());
                _loc_5 = textFieldManager.getIdText(param2);
                setBaseline(param1, _loc_4, param2);
                _loc_5 = markupMultilingualText(_loc_5, _loc_4.boldFlag);
                param1.embedFonts = true;
                _loc_6 = _loc_4.leftTag + _loc_5 + _loc_4.rightTag;
                param1.htmlText = _loc_6;
            }
            return;
        }// end function

        public static function setAutoFontTextID(param1:TextField, param2:String) : void
        {
            var _loc_3:* = textFieldManager.createTextFormatTag(param2);
            setBaseline(param1, _loc_3, param2);
            textFieldManager.setAntiAlias(param1, param2, param1.getTextFormat());
            param1.text = textFieldManager.getIdText(param2);
            var _loc_4:* = markupMultilingualText(param1.text, _loc_3.boldFlag);
            var _loc_5:* = _loc_3.leftTag + _loc_4 + _loc_3.rightTag;
            param1.embedFonts = true;
            param1.htmlText = _loc_5;
            return;
        }// end function

        public static function setText(param1:TextField, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:* = markupMultilingualText(param2, param3);
            param1.embedFonts = true;
            param1.htmlText = _loc_4;
            return;
        }// end function

        public static function setTextAndFormat(param1:TextField, param2:String, param3:String) : void
        {
            var _loc_4:* = textFieldManager.createTextFormatTag(param3);
            setBaseline(param1, _loc_4, param3);
            textFieldManager.setAntiAlias(param1, param3, param1.getTextFormat());
            var _loc_5:* = markupMultilingualText(param2, _loc_4.boldFlag);
            param1.embedFonts = true;
            var _loc_6:* = _loc_4.leftTag + _loc_5 + _loc_4.rightTag;
            param1.htmlText = _loc_6;
            return;
        }// end function

        public static function addFormat(param1:TextField, param2:String) : void
        {
            var _loc_3:* = textFieldManager.createTextFormat(param1, param2, param1.getTextFormat());
            setBaseline(param1, _loc_3, param2);
            param1.embedFonts = false;
            return;
        }// end function

        public static function setTextAndFormatTag(param1:TextField, param2:String, param3:String) : void
        {
            var _loc_4:* = textFieldManager.createTextFormatTag(param3);
            setBaseline(param1, _loc_4, param3);
            textFieldManager.setAntiAlias(param1, param3, param1.getTextFormat());
            var _loc_5:* = _loc_4.leftTag + param2 + _loc_4.rightTag;
            param1.embedFonts = true;
            param1.htmlText = _loc_5;
            return;
        }// end function

        public static function setHtmlText(param1:TextField, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:String = "";
            var _loc_5:String = "";
            switch(lang_code)
            {
                case FontManager.LANG_CODE_KO:
                {
                    if (param3)
                    {
                        _loc_5 = "InterparkGothicOTFM";
                    }
                    else
                    {
                        _loc_5 = "InterparkGothicOTFB";
                    }
                    break;
                }
                case FontManager.LANG_CODE_EN:
                {
                    if (param3)
                    {
                        _loc_5 = "PokemonHelveticaNeueLTStdBdCn";
                    }
                    else
                    {
                        _loc_5 = "PokemonHelveticaNeueLTStdMdCn";
                    }
                    break;
                }
                case FontManager.LANG_CODE_JA:
                {
                }
                default:
                {
                    if (param3)
                    {
                        _loc_5 = "PokemonFontKozM";
                    }
                    else
                    {
                        _loc_5 = "PokemonFontKozB";
                    }
                    break;
                    break;
                }
            }
            _loc_4 = "<FONT FACE=\"" + _loc_5 + "\">" + param2 + "</FONT>";
            param1.embedFonts = true;
            param1.htmlText = _loc_4;
            return;
        }// end function

        public static function setAutoFontText(param1:TextField, param2:String, param3:Boolean = false, param4:Boolean = false) : void
        {
            param1.embedFonts = true;
            var _loc_5:* = markupMultilingualText(param2, param3);
            param1.htmlText = getAutoFontText(_loc_5, param3, param4);
            return;
        }// end function

        public static function getAutoFontText(param1:String, param2:Boolean = false, param3:Boolean = false) : String
        {
            var _loc_4:String = "";
            var _loc_5:String = "";
            switch(lang_code)
            {
                case FontManager.LANG_CODE_KO:
                {
                    if (param2)
                    {
                        _loc_5 = "InterparkGothicOTFM";
                    }
                    else
                    {
                        _loc_5 = "InterparkGothicOTFB";
                    }
                    break;
                }
                case FontManager.LANG_CODE_EN:
                {
                    if (param2)
                    {
                        if (param3)
                        {
                            _loc_5 = "PokemonHelveticaNeueLTStdBdCnO";
                        }
                        else
                        {
                            _loc_5 = "PokemonHelveticaNeueLTStdBdCn";
                        }
                    }
                    else if (param3)
                    {
                        _loc_5 = "PokemonHelveticaNeueLTStdMdCnO";
                    }
                    else
                    {
                        _loc_5 = "PokemonHelveticaNeueLTStdMdCn";
                    }
                    break;
                }
                case FontManager.LANG_CODE_JA:
                {
                }
                default:
                {
                    if (param2)
                    {
                        _loc_5 = "PokemonFontKozM";
                    }
                    else
                    {
                        _loc_5 = "PokemonFontKozB";
                    }
                    break;
                    break;
                }
            }
            _loc_4 = "<FONT FACE=\"" + _loc_5 + "\">" + param1 + "</FONT>";
            return _loc_4;
        }// end function

        public static function set langCode(param1:String) : void
        {
            lang_code = param1;
            switch(lang_code)
            {
                case FontManager.LANG_CODE_KO:
                {
                    textFieldManager.defaultFontNameM = "InterparkGothicOTFM";
                    textFieldManager.defaultFontNameB = "InterparkGothicOTFB";
                    break;
                }
                case FontManager.LANG_CODE_EN:
                {
                    textFieldManager.defaultFontNameM = "PokemonHelveticaNeueLTStdBdCn";
                    textFieldManager.defaultFontNameB = "PokemonHelveticaNeueLTStdMdCn";
                    break;
                }
                case FontManager.LANG_CODE_JA:
                {
                }
                default:
                {
                    textFieldManager.defaultFontNameM = "PokemonFontKozM";
                    textFieldManager.defaultFontNameB = "PokemonFontKozB";
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function get langCode() : String
        {
            return lang_code;
        }// end function

        public static function getIdText(param1:String) : String
        {
            return textFieldManager.getIdText(param1);
        }// end function

        public static function setSelectedFont(param1:TextField, param2:Boolean = false) : void
        {
            switch(lang_code)
            {
                case FontManager.LANG_CODE_KO:
                {
                    if (param2)
                    {
                        FontManager.setKoreanB(param1);
                    }
                    else
                    {
                        FontManager.setKoreanM(param1);
                    }
                    break;
                }
                case FontManager.LANG_CODE_EN:
                {
                    if (param2)
                    {
                        FontManager.setHelveticaB(param1);
                    }
                    else
                    {
                        FontManager.setHelveticaM(param1);
                    }
                    break;
                }
                case FontManager.LANG_CODE_JA:
                {
                }
                default:
                {
                    if (param2)
                    {
                        FontManager.setJapaneseB(param1);
                    }
                    else
                    {
                        FontManager.setJapaneseM(param1);
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private static function setBaseline(param1:TextField, param2:Object, param3:String) : void
        {
            var err_flag:*;
            var chk_flag:*;
            var tf:* = param1;
            var tagdata:* = param2;
            var id:* = param3;
            if (tagdata.baselineMode == "mem")
            {
                err_flag;
                if (tagdata.baselineShift)
                {
                    chk_flag = tf.parent is MovieClip;
                    if (chk_flag)
                    {
                        if (tf.name)
                        {
                            if (!tf.parent.hasOwnProperty(tf.name + "_defY"))
                            {
                                try
                                {
                                    tf.parent[tf.name + "_defY"] = tf.y;
                                }
                                catch (e:ReferenceError)
                                {
                                    err_flag;
                                }
                            }
                            if (!err_flag)
                            {
                                tf.y = tf.parent[tf.name + "_defY"] + parseInt(tagdata.baselineShift, 10);
                            }
                        }
                        else
                        {
                            tf.y = tf.y + parseInt(tagdata.baselineShift, 10);
                        }
                    }
                    if (!chk_flag || err_flag)
                    {
                        if (id_position[id] == undefined)
                        {
                            id_position[id] = tf.y;
                        }
                        tf.y = id_position[id] + parseInt(tagdata.baselineShift, 10);
                    }
                }
                else if (tagdata.baselinePosition)
                {
                    tf.y = parseInt(tagdata.baselinePosition, 10);
                }
            }
            else if (tagdata.baselineShift)
            {
                tf.y = tf.y + parseInt(tagdata.baselineShift, 10);
            }
            return;
        }// end function

        public static function clearBaselineInfo(param1:TextField) : void
        {
            if (param1.parent is MovieClip && param1.name && param1.parent[param1.name + "_defY"] != undefined)
            {
                param1.parent[param1.name + "_defY"] = undefined;
            }
            return;
        }// end function

        public static function clearBaselineInfoId(param1:String) : void
        {
            id_position[param1] = undefined;
            return;
        }// end function

        public static function splitAndReplace(param1:String, param2, param3) : String
        {
            var _loc_4:* = param1.split(param2);
            if (param1.split(param2).length == 0)
            {
                return param1;
            }
            return _loc_4.join(param3);
        }// end function

        private static function completeHandler(event:Event = null) : void
        {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
            init();
            dispatchEvent(new Event(LOADED));
            return;
        }// end function

        public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public static function dispatchEvent(event:Event) : Boolean
        {
            return _dispatcher.dispatchEvent(event);
        }// end function

        public static function hasEventListener(param1:String) : Boolean
        {
            return _dispatcher.hasEventListener(param1);
        }// end function

        public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public static function willTrigger(param1:String) : Boolean
        {
            return _dispatcher.willTrigger(param1);
        }// end function

    }
}

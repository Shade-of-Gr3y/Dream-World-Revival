package bfp.common
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class textFieldManager extends Object
    {
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        private static var _dictionary:Dictionary = new Dictionary(false);
        private static var _format_dictionary:Dictionary = new Dictionary(false);
        private static var _fonts:Dictionary = new Dictionary(false);
        private static var default_font_name_M:String;
        private static var default_font_name_B:String;
        private static var stringsFileLoaderList:Object = new Array();

        public function textFieldManager()
        {
            return;
        }// end function

        public static function init(param1, param2:String = "") : void
        {
            var _loc_3:* = new stringsFileLoader();
            stringsFileLoaderList.push(_loc_3);
            _loc_3.addEventListener(Event.COMPLETE, stringsFileLoaderHandler);
            _loc_3.load(param1, param2);
            return;
        }// end function

        private static function stringsFileLoaderHandler(event:Event) : void
        {
            var _loc_2:XML = null;
            var _loc_3:String = null;
            var _loc_4:XML = null;
            var _loc_5:Dictionary = null;
            var _loc_6:String = null;
            event.currentTarget.removeEvent();
            _loc_2 = event.currentTarget.stringsFormatXml;
            if (_loc_2)
            {
                for (_loc_3 in _loc_2.string)
                {
                    
                    _loc_6 = _loc_2.string[_loc_3].@id.toString();
                    _format_dictionary[_loc_6] = _loc_2.string[_loc_3];
                }
                for (_loc_3 in _loc_2..font)
                {
                    
                    _loc_4 = _loc_2..font[_loc_3];
                    _fonts[_loc_4.@id.toString()] = _loc_4;
                }
            }
            _loc_2 = event.currentTarget.stringsXml;
            if (_loc_2)
            {
                for (_loc_3 in _loc_2.string)
                {
                    
                    _loc_6 = _loc_2.string[_loc_3].@id.toString();
                    _dictionary[_loc_6] = _loc_2.string[_loc_3];
                }
            }
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public static function removeEvent() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < stringsFileLoaderList.length)
            {
                
                stringsFileLoaderList[_loc_1].removeEvent();
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public static function close() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < stringsFileLoaderList.length)
            {
                
                stringsFileLoaderList[_loc_1].close();
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public static function loadedCheckId(param1) : Boolean
        {
            var _loc_2:Boolean = false;
            var _loc_3:* = 0;
            while (_loc_3 < stringsFileLoaderList.length)
            {
                
                if (stringsFileLoaderList[_loc_3].fileId == param1 && stringsFileLoaderList[_loc_3].checkLoaded)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function set defaultFontNameM(param1:String) : void
        {
            default_font_name_M = param1;
            return;
        }// end function

        public static function set defaultFontNameB(param1:String) : void
        {
            default_font_name_B = param1;
            return;
        }// end function

        public static function setAntiAlias(param1, param2, param3) : void
        {
            var _loc_5:String = null;
            var _loc_6:XML = null;
            var _loc_7:String = null;
            var _loc_4:* = _format_dictionary[param2];
            if (_format_dictionary[param2] && _loc_4.@font.toString() != "")
            {
                _loc_6 = _fonts[_loc_4.@font.toString()];
                param3.font = _loc_6.@name.toString();
                if (_loc_6.@font === "normal")
                {
                    _loc_5 = AntiAliasType.NORMAL;
                }
                else if (_loc_6.@font === "advanced")
                {
                    _loc_5 = AntiAliasType.ADVANCED;
                }
                if (_loc_6.@gridFitType.toString() != "")
                {
                    _loc_5 = AntiAliasType.ADVANCED;
                }
                if (_loc_5)
                {
                    param1.antiAliasType = _loc_5;
                }
                if (_loc_6.@gridFitType === "none")
                {
                    _loc_7 = GridFitType.NONE;
                }
                else if (_loc_6.@gridFitType === "pixel")
                {
                    _loc_7 = GridFitType.PIXEL;
                }
                else if (_loc_6.@gridFitType === "subpixel")
                {
                    _loc_7 = GridFitType.SUBPIXEL;
                }
                if (_loc_7)
                {
                    param1.gridFitType = _loc_7;
                }
                if (_loc_6.@sharpness.toString() != "")
                {
                    param1.sharpness = _loc_6.@sharpness;
                }
                if (_loc_6.@thickness.toString() != "")
                {
                    param1.thickness = _loc_6.@thickness;
                }
            }
            else
            {
                _loc_5 = AntiAliasType.ADVANCED;
                param1.antiAliasType = _loc_5;
                _loc_7 = GridFitType.PIXEL;
                param1.gridFitType = _loc_7;
                param1.sharpness = 0;
                param1.thickness = 0;
            }
            return;
        }// end function

        public static function createTextFormat(param1:TextField, param2:String, param3:TextFormat = null) : Object
        {
            var _loc_6:TextFormat = null;
            var _loc_7:String = null;
            var _loc_4:* = new Object();
            new Object().boldFlag = false;
            var _loc_5:* = _format_dictionary[param2];
            if (_format_dictionary[param2])
            {
                if (!param3)
                {
                    _loc_6 = new TextFormat();
                }
                else
                {
                    _loc_6 = param3;
                }
                setAntiAlias(param1, param2, _loc_6);
                if (_loc_5.@indent.toString() != "")
                {
                    _loc_6.indent = _loc_5.@indent;
                }
                if (_loc_5.@blockIndent.toString() != "")
                {
                    _loc_6.blockIndent = _loc_5.@blockIndent;
                }
                if (_loc_5.@size.toString() != "")
                {
                    _loc_6.size = _loc_5.@size;
                }
                if (_loc_5.@color.toString() != "")
                {
                    _loc_6.color = _loc_5.@color;
                }
                if (_loc_5.@underline.toString() != "")
                {
                    _loc_6.underline = true;
                }
                if (_loc_5.@align.toString() != "")
                {
                    if (_loc_5.@align === "left")
                    {
                        _loc_7 = TextFormatAlign.LEFT;
                    }
                    else if (_loc_5.@align === "center")
                    {
                        _loc_7 = TextFormatAlign.CENTER;
                    }
                    else if (_loc_5.@align === "right")
                    {
                        _loc_7 = TextFormatAlign.RIGHT;
                    }
                    else if (_loc_5.@align === "justify")
                    {
                        _loc_7 = TextFormatAlign.JUSTIFY;
                    }
                    if (_loc_7)
                    {
                        _loc_6.align = _loc_7;
                    }
                }
                if (_loc_5.@width.toString() != "")
                {
                    param1.width = _loc_5.@width;
                    param1.wordWrap = true;
                    param1.multiline = true;
                }
                else if (_loc_5.@align === "left")
                {
                    param1.autoSize = TextFieldAutoSize.LEFT;
                }
                if (_loc_5.@color.toString() != "")
                {
                    _loc_6.color = _loc_5.@color;
                }
                if (_loc_5.@leading.toString() != "")
                {
                    _loc_6.leading = _loc_5.@leading;
                }
                else
                {
                    _loc_6.leading = 0;
                }
                if (_loc_5.@kerning.toString() != "")
                {
                    _loc_6.kerning = true;
                }
                if (_loc_5.@letterSpacing.toString() != "")
                {
                    _loc_6.letterSpacing = _loc_5.@letterSpacing;
                }
                if (_loc_5.@bold.toString() == "true")
                {
                    _loc_4.boldFlag = true;
                }
                if (_loc_5.@baselineShift.toString() != "")
                {
                    _loc_4.baselineShift = _loc_5.@baselineShift;
                }
                if (_loc_5.@baselinePosition.toString() != "")
                {
                    _loc_4.baselinePosition = _loc_5.@baselinePosition;
                }
                if (_loc_5.@baselineMode.toString() != "")
                {
                    _loc_4.baselineMode = _loc_5.@baselineMode;
                }
                if (!param3)
                {
                    param1.embedFonts = true;
                }
                param1.defaultTextFormat = _loc_6;
            }
            return _loc_4;
        }// end function

        public static function createTextFormatTag(param1:String) : Object
        {
            var _loc_4:* = undefined;
            var _loc_5:String = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:XML = null;
            var _loc_9:* = undefined;
            var _loc_2:* = new Object();
            _loc_2.leftTag = "";
            _loc_2.rightTag = "";
            _loc_2.boldFlag = false;
            var _loc_3:* = _format_dictionary[param1];
            if (_loc_3)
            {
                _loc_4 = "";
                _loc_5 = "";
                _loc_6 = false;
                if (_loc_3.@font.toString() != "")
                {
                    _loc_8 = _fonts[_loc_3.@font.toString()];
                    if (_loc_8.@name)
                    {
                        _loc_4 = _loc_4 + (" face=\'" + _loc_8.@name.toString() + "\'");
                    }
                }
                if (_loc_3.@indent.toString() != "")
                {
                    _loc_5 = _loc_5 + (" indent = \'" + _loc_3.@indent + "\'");
                }
                if (_loc_3.@blockIndent.toString() != "")
                {
                    _loc_5 = _loc_5 + (" blockIndent = \'" + _loc_3.@blockInden + "\'");
                }
                if (_loc_3.@size.toString() != "")
                {
                    _loc_4 = _loc_4 + (" size = \'" + _loc_3.@size + "\'");
                }
                if (_loc_3.@color.toString() != "")
                {
                    _loc_9 = _loc_3.@color;
                    if (_loc_9.substr(0, 2) == "0x" || _loc_9.substr(0, 2) == "0X")
                    {
                        _loc_9 = "#" + _loc_9.substr(2);
                    }
                    _loc_4 = _loc_4 + (" color = \'" + _loc_9 + "\'");
                }
                if (_loc_3.@kerning.toString() != "")
                {
                    _loc_4 = _loc_4 + (" kerning =\'" + _loc_3.@kerning + "\'");
                }
                if (_loc_3.@letterSpacing.toString() != "")
                {
                    _loc_4 = _loc_4 + (" letterSpacing =\'" + _loc_3.@letterSpacing + "\'");
                }
                if (_loc_3.@leading.toString() != "")
                {
                    _loc_5 = _loc_5 + (" leading = \'" + _loc_3.@leading + "\'");
                }
                if (_loc_3.@bold.toString() == "true")
                {
                    _loc_2.boldFlag = true;
                }
                if (_loc_3.@italic.toString() == "true")
                {
                    _loc_6 = true;
                }
                if (_loc_3.@baselineShift.toString() != "")
                {
                    _loc_2.baselineShift = _loc_3.@baselineShift;
                }
                if (_loc_3.@baselinePosition.toString() != "")
                {
                    _loc_2.baselinePosition = _loc_3.@baselinePosition;
                }
                if (_loc_3.@baselineMode.toString() != "")
                {
                    _loc_2.baselineMode = _loc_3.@baselineMode;
                }
                _loc_7 = "";
                if (_loc_5.length > 0)
                {
                    _loc_2.leftTag = _loc_2.leftTag + ("<textformat " + _loc_5 + " >");
                    _loc_2.rightTag = _loc_2.rightTag + "</textformat>";
                }
                if (_loc_4.length > 0)
                {
                    _loc_2.leftTag = _loc_2.leftTag + ("<font " + _loc_4 + " >");
                    _loc_2.rightTag = _loc_2.rightTag + "</font>";
                }
            }
            return _loc_2;
        }// end function

        public static function getIdText(param1:String) : String
        {
            var _loc_2:* = _dictionary[param1];
            if (!_loc_2)
            {
                _loc_2 = "";
            }
            return _loc_2;
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

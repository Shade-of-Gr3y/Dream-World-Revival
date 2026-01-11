package bfp.common
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class textFieldManager
   {
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _dictionary:Dictionary = new Dictionary(false);
      
      private static var _format_dictionary:Dictionary = new Dictionary(false);
      
      private static var _fonts:Dictionary = new Dictionary(false);
      
      private static var default_font_name_M:String;
      
      private static var default_font_name_B:String;
      
      private static var stringsFileLoaderList:* = new Array();
       
      
      public function textFieldManager()
      {
         super();
      }
      
      public static function init(param1:*, param2:String = "") : void
      {
         var _loc3_:* = new stringsFileLoader();
         stringsFileLoaderList.push(_loc3_);
         _loc3_.addEventListener(Event.COMPLETE,stringsFileLoaderHandler);
         _loc3_.load(param1,param2);
      }
      
      private static function stringsFileLoaderHandler(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:XML = null;
         var _loc5_:Dictionary = null;
         var _loc6_:String = null;
         param1.currentTarget.removeEvent();
         _loc2_ = param1.currentTarget.stringsFormatXml;
         if(_loc2_)
         {
            for(_loc3_ in _loc2_.string)
            {
               _loc6_ = String(_loc2_.string[_loc3_].@id.toString());
               _format_dictionary[_loc6_] = _loc2_.string[_loc3_];
            }
            for(_loc3_ in _loc2_..font)
            {
               _loc4_ = _loc2_..font[_loc3_];
               _fonts[_loc4_.@id.toString()] = _loc4_;
            }
         }
         _loc2_ = param1.currentTarget.stringsXml;
         if(_loc2_)
         {
            for(_loc3_ in _loc2_.string)
            {
               _loc6_ = String(_loc2_.string[_loc3_].@id.toString());
               _dictionary[_loc6_] = _loc2_.string[_loc3_];
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function removeEvent() : void
      {
         var _loc1_:* = 0;
         while(_loc1_ < stringsFileLoaderList.length)
         {
            stringsFileLoaderList[_loc1_].removeEvent();
            _loc1_++;
         }
      }
      
      public static function close() : void
      {
         var _loc1_:* = 0;
         while(_loc1_ < stringsFileLoaderList.length)
         {
            stringsFileLoaderList[_loc1_].close();
            _loc1_++;
         }
      }
      
      public static function loadedCheckId(param1:*) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:* = 0;
         while(_loc3_ < stringsFileLoaderList.length)
         {
            if(stringsFileLoaderList[_loc3_].fileId == param1 && Boolean(stringsFileLoaderList[_loc3_].checkLoaded))
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function set defaultFontNameM(param1:String) : void
      {
         default_font_name_M = param1;
      }
      
      public static function set defaultFontNameB(param1:String) : void
      {
         default_font_name_B = param1;
      }
      
      public static function setAntiAlias(param1:*, param2:*, param3:*) : void
      {
         var _loc5_:String = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc4_:XML;
         if((Boolean(_loc4_ = _format_dictionary[param2])) && _loc4_.@font.toString() != "")
         {
            _loc6_ = _fonts[_loc4_.@font.toString()];
            param3.font = _loc6_.@name.toString();
            if(_loc6_.@font === "normal")
            {
               _loc5_ = AntiAliasType.NORMAL;
            }
            else if(_loc6_.@font === "advanced")
            {
               _loc5_ = AntiAliasType.ADVANCED;
            }
            if(_loc6_.@gridFitType.toString() != "")
            {
               _loc5_ = AntiAliasType.ADVANCED;
            }
            if(_loc5_)
            {
               param1.antiAliasType = _loc5_;
            }
            if(_loc6_.@gridFitType === "none")
            {
               _loc7_ = GridFitType.NONE;
            }
            else if(_loc6_.@gridFitType === "pixel")
            {
               _loc7_ = GridFitType.PIXEL;
            }
            else if(_loc6_.@gridFitType === "subpixel")
            {
               _loc7_ = GridFitType.SUBPIXEL;
            }
            if(_loc7_)
            {
               param1.gridFitType = _loc7_;
            }
            if(_loc6_.@sharpness.toString() != "")
            {
               param1.sharpness = _loc6_.@sharpness;
            }
            if(_loc6_.@thickness.toString() != "")
            {
               param1.thickness = _loc6_.@thickness;
            }
         }
         else
         {
            _loc5_ = AntiAliasType.ADVANCED;
            param1.antiAliasType = _loc5_;
            _loc7_ = GridFitType.PIXEL;
            param1.gridFitType = _loc7_;
            param1.sharpness = 0;
            param1.thickness = 0;
         }
      }
      
      public static function createTextFormat(param1:TextField, param2:String, param3:TextFormat = null) : Object
      {
         var _loc6_:TextFormat = null;
         var _loc7_:String = null;
         var _loc4_:*;
         (_loc4_ = new Object()).boldFlag = false;
         var _loc5_:XML;
         if(_loc5_ = _format_dictionary[param2])
         {
            if(!param3)
            {
               _loc6_ = new TextFormat();
            }
            else
            {
               _loc6_ = param3;
            }
            setAntiAlias(param1,param2,_loc6_);
            if(_loc5_.@indent.toString() != "")
            {
               _loc6_.indent = _loc5_.@indent;
            }
            if(_loc5_.@blockIndent.toString() != "")
            {
               _loc6_.blockIndent = _loc5_.@blockIndent;
            }
            if(_loc5_.@size.toString() != "")
            {
               _loc6_.size = _loc5_.@size;
            }
            if(_loc5_.@color.toString() != "")
            {
               _loc6_.color = _loc5_.@color;
            }
            if(_loc5_.@underline.toString() != "")
            {
               _loc6_.underline = true;
            }
            if(_loc5_.@align.toString() != "")
            {
               if(_loc5_.@align === "left")
               {
                  _loc7_ = TextFormatAlign.LEFT;
               }
               else if(_loc5_.@align === "center")
               {
                  _loc7_ = TextFormatAlign.CENTER;
               }
               else if(_loc5_.@align === "right")
               {
                  _loc7_ = TextFormatAlign.RIGHT;
               }
               else if(_loc5_.@align === "justify")
               {
                  _loc7_ = TextFormatAlign.JUSTIFY;
               }
               if(_loc7_)
               {
                  _loc6_.align = _loc7_;
               }
            }
            if(_loc5_.@width.toString() != "")
            {
               param1.width = _loc5_.@width;
               param1.wordWrap = true;
               param1.multiline = true;
            }
            else if(_loc5_.@align === "left")
            {
               param1.autoSize = TextFieldAutoSize.LEFT;
            }
            if(_loc5_.@color.toString() != "")
            {
               _loc6_.color = _loc5_.@color;
            }
            if(_loc5_.@leading.toString() != "")
            {
               _loc6_.leading = _loc5_.@leading;
            }
            else
            {
               _loc6_.leading = 0;
            }
            if(_loc5_.@kerning.toString() != "")
            {
               _loc6_.kerning = true;
            }
            if(_loc5_.@letterSpacing.toString() != "")
            {
               _loc6_.letterSpacing = _loc5_.@letterSpacing;
            }
            if(_loc5_.@bold.toString() == "true")
            {
               _loc4_.boldFlag = true;
            }
            if(_loc5_.@baselineShift.toString() != "")
            {
               _loc4_.baselineShift = _loc5_.@baselineShift;
            }
            if(_loc5_.@baselinePosition.toString() != "")
            {
               _loc4_.baselinePosition = _loc5_.@baselinePosition;
            }
            if(_loc5_.@baselineMode.toString() != "")
            {
               _loc4_.baselineMode = _loc5_.@baselineMode;
            }
            if(!param3)
            {
               param1.embedFonts = true;
            }
            param1.defaultTextFormat = _loc6_;
         }
         return _loc4_;
      }
      
      public static function createTextFormatTag(param1:String) : Object
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:XML = null;
         var _loc9_:* = undefined;
         var _loc2_:* = new Object();
         _loc2_.leftTag = "";
         _loc2_.rightTag = "";
         _loc2_.boldFlag = false;
         var _loc3_:XML = _format_dictionary[param1];
         if(_loc3_)
         {
            _loc4_ = "";
            _loc5_ = "";
            _loc6_ = false;
            if(_loc3_.@font.toString() != "")
            {
               if((_loc8_ = _fonts[_loc3_.@font.toString()]).@name)
               {
                  _loc4_ += " face=\'" + _loc8_.@name.toString() + "\'";
               }
            }
            if(_loc3_.@indent.toString() != "")
            {
               _loc5_ += " indent = \'" + _loc3_.@indent + "\'";
            }
            if(_loc3_.@blockIndent.toString() != "")
            {
               _loc5_ += " blockIndent = \'" + _loc3_.@blockInden + "\'";
            }
            if(_loc3_.@size.toString() != "")
            {
               _loc4_ += " size = \'" + _loc3_.@size + "\'";
            }
            if(_loc3_.@color.toString() != "")
            {
               if((_loc9_ = _loc3_.@color).substr(0,2) == "0x" || _loc9_.substr(0,2) == "0X")
               {
                  _loc9_ = "#" + _loc9_.substr(2);
               }
               _loc4_ += " color = \'" + _loc9_ + "\'";
            }
            if(_loc3_.@kerning.toString() != "")
            {
               _loc4_ += " kerning =\'" + _loc3_.@kerning + "\'";
            }
            if(_loc3_.@letterSpacing.toString() != "")
            {
               _loc4_ += " letterSpacing =\'" + _loc3_.@letterSpacing + "\'";
            }
            if(_loc3_.@leading.toString() != "")
            {
               _loc5_ += " leading = \'" + _loc3_.@leading + "\'";
            }
            if(_loc3_.@bold.toString() == "true")
            {
               _loc2_.boldFlag = true;
            }
            if(_loc3_.@italic.toString() == "true")
            {
               _loc6_ = true;
            }
            if(_loc3_.@baselineShift.toString() != "")
            {
               _loc2_.baselineShift = _loc3_.@baselineShift;
            }
            if(_loc3_.@baselinePosition.toString() != "")
            {
               _loc2_.baselinePosition = _loc3_.@baselinePosition;
            }
            if(_loc3_.@baselineMode.toString() != "")
            {
               _loc2_.baselineMode = _loc3_.@baselineMode;
            }
            _loc7_ = "";
            if(_loc5_.length > 0)
            {
               _loc2_.leftTag += "<textformat " + _loc5_ + " >";
               _loc2_.rightTag += "</textformat>";
            }
            if(_loc4_.length > 0)
            {
               _loc2_.leftTag += "<font " + _loc4_ + " >";
               _loc2_.rightTag += "</font>";
            }
         }
         return _loc2_;
      }
      
      public static function getIdText(param1:String) : String
      {
         var _loc2_:* = _dictionary[param1];
         if(!_loc2_)
         {
            _loc2_ = "";
         }
         return _loc2_;
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
   }
}

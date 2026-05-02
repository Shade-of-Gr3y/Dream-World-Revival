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
      
      private static var default_font_name_M:String;
      
      private static var default_font_name_B:String;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _dictionary:Dictionary = new Dictionary(false);
      
      private static var _format_dictionary:Dictionary = new Dictionary(false);
      
      private static var _fonts:Dictionary = new Dictionary(false);
      
      private static var stringsFileLoaderList:* = new Array();
      
      public function textFieldManager()
      {
         super();
      }
      
      public static function init(req_list:*, id:String = "") : void
      {
         var _sfl:* = new stringsFileLoader();
         stringsFileLoaderList.push(_sfl);
         _sfl.addEventListener(Event.COMPLETE,stringsFileLoaderHandler);
         _sfl.load(req_list,id);
      }
      
      private static function stringsFileLoaderHandler(event:Event) : void
      {
         var xml:XML = null;
         var p:String = null;
         var node:XML = null;
         var dict:Dictionary = null;
         var id:String = null;
         event.currentTarget.removeEvent();
         xml = event.currentTarget.stringsFormatXml;
         if(xml)
         {
            for(p in xml.string)
            {
               id = xml.string[p].@id.toString();
               _format_dictionary[id] = xml.string[p];
            }
            for(p in xml..font)
            {
               node = xml..font[p];
               _fonts[node.@id.toString()] = node;
            }
         }
         xml = event.currentTarget.stringsXml;
         if(xml)
         {
            for(p in xml.string)
            {
               id = xml.string[p].@id.toString();
               _dictionary[id] = xml.string[p];
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function removeEvent() : void
      {
         for(var i:* = 0; i < stringsFileLoaderList.length; i++)
         {
            stringsFileLoaderList[i].removeEvent();
         }
      }
      
      public static function close() : void
      {
         for(var i:* = 0; i < stringsFileLoaderList.length; i++)
         {
            stringsFileLoaderList[i].close();
         }
      }
      
      public static function loadedCheckId(id:*) : Boolean
      {
         var ret:Boolean = false;
         for(var i:* = 0; i < stringsFileLoaderList.length; i++)
         {
            if(stringsFileLoaderList[i].fileId == id && Boolean(stringsFileLoaderList[i].checkLoaded))
            {
               ret = true;
               break;
            }
         }
         return ret;
      }
      
      public static function set defaultFontNameM(nm:String) : void
      {
         default_font_name_M = nm;
      }
      
      public static function set defaultFontNameB(nm:String) : void
      {
         default_font_name_B = nm;
      }
      
      public static function setAntiAlias(tf:*, id:*, tfm:*) : void
      {
         var anti:String = null;
         var fontNode:XML = null;
         var gridFit:String = null;
         var node:XML = _format_dictionary[id];
         if(Boolean(node) && node.@font.toString() != "")
         {
            fontNode = _fonts[node.@font.toString()];
            tfm.font = fontNode.@name.toString();
            if(fontNode.@font === "normal")
            {
               anti = AntiAliasType.NORMAL;
            }
            else if(fontNode.@font === "advanced")
            {
               anti = AntiAliasType.ADVANCED;
            }
            if(fontNode.@gridFitType.toString() != "")
            {
               anti = AntiAliasType.ADVANCED;
            }
            if(anti)
            {
               tf.antiAliasType = anti;
            }
            if(fontNode.@gridFitType === "none")
            {
               gridFit = GridFitType.NONE;
            }
            else if(fontNode.@gridFitType === "pixel")
            {
               gridFit = GridFitType.PIXEL;
            }
            else if(fontNode.@gridFitType === "subpixel")
            {
               gridFit = GridFitType.SUBPIXEL;
            }
            if(gridFit)
            {
               tf.gridFitType = gridFit;
            }
            if(fontNode.@sharpness.toString() != "")
            {
               tf.sharpness = fontNode.@sharpness;
            }
            if(fontNode.@thickness.toString() != "")
            {
               tf.thickness = fontNode.@thickness;
            }
         }
         else
         {
            anti = AntiAliasType.ADVANCED;
            tf.antiAliasType = anti;
            gridFit = GridFitType.PIXEL;
            tf.gridFitType = gridFit;
            tf.sharpness = 0;
            tf.thickness = 0;
         }
      }
      
      public static function createTextFormat(tf:TextField, id:String, tfmt:TextFormat = null) : Object
      {
         var tfm:TextFormat = null;
         var align:String = null;
         var ret_o:* = new Object();
         ret_o.boldFlag = false;
         var node:XML = _format_dictionary[id];
         if(node)
         {
            if(!tfmt)
            {
               tfm = new TextFormat();
            }
            else
            {
               tfm = tfmt;
            }
            setAntiAlias(tf,id,tfm);
            if(node.@indent.toString() != "")
            {
               tfm.indent = node.@indent;
            }
            if(node.@blockIndent.toString() != "")
            {
               tfm.blockIndent = node.@blockIndent;
            }
            if(node.@size.toString() != "")
            {
               tfm.size = node.@size;
            }
            if(node.@color.toString() != "")
            {
               tfm.color = node.@color;
            }
            if(node.@underline.toString() != "")
            {
               tfm.underline = true;
            }
            if(node.@align.toString() != "")
            {
               if(node.@align === "left")
               {
                  align = TextFormatAlign.LEFT;
               }
               else if(node.@align === "center")
               {
                  align = TextFormatAlign.CENTER;
               }
               else if(node.@align === "right")
               {
                  align = TextFormatAlign.RIGHT;
               }
               else if(node.@align === "justify")
               {
                  align = TextFormatAlign.JUSTIFY;
               }
               if(align)
               {
                  tfm.align = align;
               }
            }
            if(node.@width.toString() != "")
            {
               tf.width = node.@width;
               tf.wordWrap = true;
               tf.multiline = true;
            }
            else if(node.@align === "left")
            {
               tf.autoSize = TextFieldAutoSize.LEFT;
            }
            if(node.@color.toString() != "")
            {
               tfm.color = node.@color;
            }
            if(node.@leading.toString() != "")
            {
               tfm.leading = node.@leading;
            }
            else
            {
               tfm.leading = 0;
            }
            if(node.@kerning.toString() != "")
            {
               tfm.kerning = true;
            }
            if(node.@letterSpacing.toString() != "")
            {
               tfm.letterSpacing = node.@letterSpacing;
            }
            if(node.@bold.toString() == "true")
            {
               ret_o.boldFlag = true;
            }
            if(node.@baselineShift.toString() != "")
            {
               ret_o.baselineShift = node.@baselineShift;
            }
            if(node.@baselinePosition.toString() != "")
            {
               ret_o.baselinePosition = node.@baselinePosition;
            }
            if(node.@baselineMode.toString() != "")
            {
               ret_o.baselineMode = node.@baselineMode;
            }
            if(!tfmt)
            {
               tf.embedFonts = true;
            }
            tf.defaultTextFormat = tfm;
         }
         return ret_o;
      }
      
      public static function createTextFormatTag(id:String) : Object
      {
         var font_atr:* = undefined;
         var tfm:String = null;
         var italic_flag:* = undefined;
         var ret_string:* = undefined;
         var fontNode:XML = null;
         var wk:* = undefined;
         var ret_o:* = new Object();
         ret_o.leftTag = "";
         ret_o.rightTag = "";
         ret_o.boldFlag = false;
         var node:XML = _format_dictionary[id];
         if(node)
         {
            font_atr = "";
            tfm = "";
            italic_flag = false;
            if(node.@font.toString() != "")
            {
               fontNode = _fonts[node.@font.toString()];
               if(fontNode.@name)
               {
                  font_atr += " face=\'" + fontNode.@name.toString() + "\'";
               }
            }
            if(node.@indent.toString() != "")
            {
               tfm += " indent = \'" + node.@indent + "\'";
            }
            if(node.@blockIndent.toString() != "")
            {
               tfm += " blockIndent = \'" + node.@blockInden + "\'";
            }
            if(node.@size.toString() != "")
            {
               font_atr += " size = \'" + node.@size + "\'";
            }
            if(node.@color.toString() != "")
            {
               wk = node.@color;
               if(wk.substr(0,2) == "0x" || wk.substr(0,2) == "0X")
               {
                  wk = "#" + wk.substr(2);
               }
               font_atr += " color = \'" + wk + "\'";
            }
            if(node.@kerning.toString() != "")
            {
               font_atr += " kerning =\'" + node.@kerning + "\'";
            }
            if(node.@letterSpacing.toString() != "")
            {
               font_atr += " letterSpacing =\'" + node.@letterSpacing + "\'";
            }
            if(node.@leading.toString() != "")
            {
               tfm += " leading = \'" + node.@leading + "\'";
            }
            if(node.@bold.toString() == "true")
            {
               ret_o.boldFlag = true;
            }
            if(node.@italic.toString() == "true")
            {
               italic_flag = true;
            }
            if(node.@baselineShift.toString() != "")
            {
               ret_o.baselineShift = node.@baselineShift;
            }
            if(node.@baselinePosition.toString() != "")
            {
               ret_o.baselinePosition = node.@baselinePosition;
            }
            if(node.@baselineMode.toString() != "")
            {
               ret_o.baselineMode = node.@baselineMode;
            }
            ret_string = "";
            if(tfm.length > 0)
            {
               ret_o.leftTag += "<textformat " + tfm + " >";
               ret_o.rightTag += "</textformat>";
            }
            if(font_atr.length > 0)
            {
               ret_o.leftTag += "<font " + font_atr + " >";
               ret_o.rightTag += "</font>";
            }
         }
         return ret_o;
      }
      
      public static function getIdText(id:String) : String
      {
         var string:* = _dictionary[id];
         if(!string)
         {
            string = "";
         }
         return string;
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function dispatchEvent(event:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(event);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
   }
}


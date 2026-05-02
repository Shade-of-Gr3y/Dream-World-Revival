package bfp.pdw.common_y
{
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.common.textFieldManager;
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
   
   public class Localize
   {
      
      private static var _dictionary:Dictionary;
      
      private static var _fonts:Dictionary;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var isAlone:Boolean = false;
      
      private static var stringXMLPathList:Array = [];
      
      private static var formatXMLPathList:Array = [];
      
      private static var stringFarmXMLPathList:Array = [];
      
      private static var stringShareXMLPathList:Array = [];
      
      private static var stringRoomXMLPathList:Array = [];
      
      private static var stringBoardXMLPathList:Array = [];
      
      private static var stringCommonXMLPathList:Array = [];
      
      private static var stringTakarabakoXMLPathList:Array = [];
      
      private static var fontPath:String = "";
      
      private static var basePath:String = "";
      
      public function Localize()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         Localize.stringFarmXMLPathList = param1.strings_farm;
         Localize.stringCommonXMLPathList = param1.strings_common;
         Localize.stringRoomXMLPathList = param1.strings_room;
         Localize.stringShareXMLPathList = param1.strings_share;
         Localize.stringBoardXMLPathList = param1.strings_board;
         Localize.stringTakarabakoXMLPathList = param1.strings_takarabako;
         Localize.fontPath = param1.font;
         FontManager.addEventListener(FontManager.LOADED,onFontLoadedHandler);
         FontManager.standalone(fontPath);
      }
      
      private static function onFontLoadedHandler(param1:Event) : *
      {
         FontManager.addEventListener(Event.COMPLETE,completeHandler);
         FontManager.loadStringsXml(Localize.stringCommonXMLPathList,"pdw_file2");
      }
      
      private static function completeHandler(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler);
         FontManager.addEventListener(Event.COMPLETE,completeHandler2);
         FontManager.loadStringsXml(Localize.stringFarmXMLPathList,"pdw_file1");
      }
      
      private static function completeHandler2(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler2);
         FontManager.addEventListener(Event.COMPLETE,completeHandler3);
         FontManager.loadStringsXml(Localize.stringRoomXMLPathList,"pdw_file3");
      }
      
      private static function completeHandler3(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler3);
         FontManager.addEventListener(Event.COMPLETE,completeHandler4);
         FontManager.loadStringsXml(Localize.stringShareXMLPathList,"pdw_file4");
      }
      
      private static function completeHandler4(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler4);
         FontManager.addEventListener(Event.COMPLETE,completeHandler5);
         FontManager.loadStringsXml(Localize.stringBoardXMLPathList,"pdw_file5");
      }
      
      private static function completeHandler5(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler5);
         FontManager.addEventListener(Event.COMPLETE,completeHandler6);
         FontManager.loadStringsXml(Localize.stringTakarabakoXMLPathList,"pdw_file6");
      }
      
      private static function completeHandler6(param1:Event) : *
      {
         FontManager.removeEventListener(Event.COMPLETE,completeHandler6);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public static function getIDText(param1:*) : *
      {
         return textFieldManager.getIdText(param1);
      }
      
      public static function setText(param1:TextField, param2:String, ... rest) : void
      {
         var _loc4_:* = textFieldManager.getIdText(param2);
         if(PokemonBridge.lang == "ko")
         {
            if(rest.length > 0)
            {
            }
         }
         _loc4_ = _loc4_.replace(/\[arg0\]/ig,rest[0]);
         _loc4_ = _loc4_.replace(/\[arg1\]/ig,rest[1]);
         _loc4_ = _loc4_.replace(/\[arg2\]/ig,rest[2]);
         _loc4_ = _loc4_.replace(/\[arg3\]/ig,rest[3]);
         _loc4_ = _loc4_.replace(/\[arg4\]/ig,rest[4]);
         _loc4_ = _loc4_.replace(/\[arg5\]/ig,rest[5]);
         _loc4_ = _loc4_.replace(/\[arg6\]/ig,rest[6]);
         _loc4_ = _loc4_.replace(/\[arg7\]/ig,rest[7]);
         _loc4_ = _loc4_.replace(/\[arg8\]/ig,rest[8]);
         _loc4_ = _loc4_.replace(/\[arg9\]/ig,rest[9]);
         _loc4_ = _loc4_.replace(/\[n\]/ig,"\n");
         if(PokemonBridge.lang == "ko" && rest.length > 0)
         {
         }
         FontManager.setTextAndFormat(param1,_loc4_,param2);
      }
      
      public static function setTextString(param1:TextField, param2:String) : *
      {
         FontManager.setText(param1,param2);
      }
      
      public static function setTextM(param1:TextField) : void
      {
         FontManager.setTextM(param1);
      }
      
      public static function setTextB(param1:TextField) : void
      {
         FontManager.setTextB(param1);
      }
      
      public static function setFFFCompact(param1:TextField) : void
      {
         FontManager.setFFFCompact(param1);
      }
      
      public static function setFFFCorporateBold(param1:TextField) : void
      {
         FontManager.setFFFCorporateBold(param1);
      }
      
      public static function setTextAndFormatTag(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = FontManager.markupMultilingualText(param2);
         FontManager.setTextAndFormatTag(param1,_loc4_,param3);
      }
      
      public static function setTextAndFormatTagFFF(param1:*, param2:*, param3:*) : *
      {
         FontManager.setFFFCompact(param1);
      }
      
      public static function setAutoFontTextString(param1:TextField, param2:String, ... rest) : void
      {
         var _loc4_:* = textFieldManager.getIdText(param2);
         _loc4_ = _loc4_.replace(/\[arg0\]/ig,rest[0]);
         _loc4_ = _loc4_.replace(/\[arg1\]/ig,rest[1]);
         _loc4_ = _loc4_.replace(/\[arg2\]/ig,rest[2]);
         _loc4_ = _loc4_.replace(/\[arg3\]/ig,rest[3]);
         _loc4_ = _loc4_.replace(/\[arg4\]/ig,rest[4]);
         _loc4_ = _loc4_.replace(/\[arg5\]/ig,rest[5]);
         _loc4_ = _loc4_.replace(/\[arg6\]/ig,rest[6]);
         _loc4_ = _loc4_.replace(/\[arg7\]/ig,rest[7]);
         _loc4_ = _loc4_.replace(/\[arg8\]/ig,rest[8]);
         _loc4_ = _loc4_.replace(/\[arg9\]/ig,rest[9]);
         _loc4_ = _loc4_.replace(/\[n\]/ig,"\n");
         var _loc5_:Object = textFieldManager.createTextFormatTag(param2);
         setBaseline(param1,_loc5_);
         textFieldManager.setAntiAlias(param1,param2,param1.getTextFormat());
         param1.text = _loc4_;
         var _loc6_:String = FontManager.markupMultilingualText(param1.text,_loc5_.boldFlag);
         var _loc7_:* = _loc5_.leftTag + _loc6_ + _loc5_.rightTag;
         param1.embedFonts = true;
         param1.htmlText = _loc7_;
      }
      
      private static function setBaseline(param1:TextField, param2:Object) : void
      {
         if(param2.baselineShift)
         {
            param1.y += parseInt(param2.baselineShift,10);
         }
         else if(param2.baselinePosition)
         {
            param1.y = parseInt(param2.baselinePosition,10);
         }
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


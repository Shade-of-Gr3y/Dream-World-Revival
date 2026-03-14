package com.google.analytics.debug
{
   import flash.net.URLLoader;
   import flash.text.StyleSheet;
   
   public class _Style
   {
      
      public var borderColor:uint;
      
      public var backgroundColor:uint;
      
      private var _sheet:StyleSheet;
      
      public var roundedCorner:uint;
      
      public var alertColor:uint;
      
      public var infoColor:uint;
      
      public var successColor:uint;
      
      private var _loader:URLLoader;
      
      public var failureColor:uint;
      
      private var _defaultSheet:String;
      
      public var warningColor:uint;
      
      public function _Style()
      {
         super();
         _sheet = new StyleSheet();
         _loader = new URLLoader();
         _init();
      }
      
      private function _parseSheet(param1:String) : void
      {
         _sheet.parseCSS(param1);
      }
      
      public function get sheet() : StyleSheet
      {
         return _sheet;
      }
      
      private function _init() : void
      {
         _defaultSheet = "";
         _defaultSheet += "a{text-decoration: underline;}\n";
         _defaultSheet += ".uiLabel{color: #000000;font-family: Arial;font-size: 12;margin-left: 2;margin-right: 2;}\n";
         _defaultSheet += ".uiWarning{color: #ffffff;font-family: Arial;font-size: 14;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiAlert{color: #ffffff;font-family: Arial;font-size: 14;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiInfo{color: #000000;font-family: Arial;font-size: 14;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiSuccess{color: #ffffff;font-family: Arial;font-size: 12;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiFailure{color: #ffffff;font-family: Arial;font-size: 12;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiAlertAction{color: #ffffff;text-align: center;font-family: Arial;font-size: 12;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += ".uiAlertTitle{color: #ffffff;font-family: Arial;font-size: 16;font-weight: bold;margin-left: 6;margin-right: 6;}\n";
         _defaultSheet += "\n";
         roundedCorner = 6;
         backgroundColor = 13421772;
         borderColor = 5592405;
         infoColor = 16777113;
         alertColor = 16763904;
         warningColor = 13369344;
         successColor = 65280;
         failureColor = 16711680;
         _parseSheet(_defaultSheet);
      }
   }
}


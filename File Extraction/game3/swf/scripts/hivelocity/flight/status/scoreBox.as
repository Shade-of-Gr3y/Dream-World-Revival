package hivelocity.flight.status
{
   import bfp.common.FontManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol672")]
   public class scoreBox extends MovieClip
   {
      
      public var gamepoint:TextField;
      
      private var _totalGamePoint:int;
      
      private var _langCode:String = "";
      
      public function scoreBox()
      {
         super();
         this.__init();
      }
      
      public function set setGamePoint(param1:int) : void
      {
         this._totalGamePoint += param1;
         this.setpoint();
      }
      
      public function get getGameScore() : int
      {
         return this._totalGamePoint;
      }
      
      public function set selangCode(param1:String) : void
      {
         this._langCode = param1;
         switch(this._langCode)
         {
            case "ja":
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               break;
            case "ko":
               FontManager.lang_code = FontManager.LANG_CODE_KO;
               break;
            case "de":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "en":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "es":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "fr":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "it":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            default:
               FontManager.lang_code = FontManager.LANG_CODE_JA;
         }
         this.setpoint();
      }
      
      public function reset() : void
      {
         this.__init();
         this.setpoint();
      }
      
      private function __init() : void
      {
         this._totalGamePoint = 0;
         this.setpoint();
      }
      
      private function setpoint() : void
      {
         var spaceFormat:TextFormat = null;
         try
         {
            if(this["gamepoint"])
            {
               FontManager.setAutoFontText(this["gamepoint"],String(this._totalGamePoint),false);
               if(this._langCode != "ja")
               {
                  spaceFormat = new TextFormat();
                  spaceFormat.letterSpacing = 3;
                  this["gamepoint"].setTextFormat(spaceFormat);
               }
            }
         }
         catch($e:Error)
         {
         }
      }
   }
}


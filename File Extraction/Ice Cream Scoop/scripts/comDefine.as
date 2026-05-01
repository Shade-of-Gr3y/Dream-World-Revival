package
{
   import flash.display.MovieClip;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class comDefine
   {
      
      public static var rootMc:*;
      
      public static var errorDialog:AssetPDWError;
      
      public static const ScreenWidth:* = 800;
      
      public static const ScreenHeight:* = 600;
      
      public static const barrelType01:* = 1;
      
      public static const barrelType02:* = 2;
      
      public static const barrelType03:* = 3;
      
      public static const DEBUG:* = false;
      
      public static const DEBUG_TEXT:* = false;
      
      public static var g_Dir:String = "";
      
      public static var debugWindow:Object = null;
      
      public static var nLanguage:* = "ja";
      
      public static var bMouse:Boolean = true;
      
      public static var bEnableMouse:Boolean = true;
      
      public static var bEnableMouseBack:Boolean = true;
      
      public static var cursorName:String = MouseCursor.ARROW;
      
      public static var cursorBack:String = MouseCursor.ARROW;
      
      public function comDefine()
      {
         super();
      }
      
      public static function mouseEnable(param1:Boolean) : void
      {
         if(bMouse != param1)
         {
            bMouse = param1;
            bEnableMouse = param1;
         }
      }
      
      public static function ErrorDialog(param1:String) : void
      {
         errorDialog = new AssetPDWError();
         errorDialog.setText(param1);
         rootMc.addChild(errorDialog);
      }
      
      public static function getTextMc(param1:MovieClip) : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc3_:* = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_) as MovieClip;
            if(_loc4_ != null)
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
         switch(comDefine.nLanguage)
         {
            case "ja":
               _loc2_ = param1.getChildByName("jpnMC") as MovieClip;
               break;
            case "en":
               _loc2_ = param1.getChildByName("engMC") as MovieClip;
               break;
            case "fr":
               _loc2_ = param1.getChildByName("fraMC") as MovieClip;
               break;
            case "de":
               _loc2_ = param1.getChildByName("gerMC") as MovieClip;
               break;
            case "it":
               _loc2_ = param1.getChildByName("itaMC") as MovieClip;
               break;
            case "es":
               _loc2_ = param1.getChildByName("spaMC") as MovieClip;
               break;
            case "ko":
               _loc2_ = param1.getChildByName("korMC") as MovieClip;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1.getChildByName("defMC") as MovieClip;
            if(_loc2_ == null)
            {
               _loc2_ = param1;
            }
         }
         _loc2_.visible = true;
         return _loc2_;
      }
      
      public static function mouseCursor(param1:*, param2:Boolean = false) : void
      {
         cursorName = param1;
      }
      
      public static function mouse() : void
      {
         if(cursorName != cursorBack)
         {
            Mouse.cursor = cursorName;
            cursorBack = cursorName;
         }
         if(bEnableMouse != bEnableMouseBack)
         {
            if(bEnableMouse)
            {
               Mouse.show();
            }
            else
            {
               Mouse.hide();
            }
            bEnableMouseBack = bEnableMouse;
         }
      }
      
      public static function loadExchange(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:String = null;
         var _loc7_:MovieClip = null;
         var _loc3_:LoadSwfMovieClip = new LoadSwfMovieClip();
         var _loc5_:* = 0;
         while(_loc5_ < param1.numChildren)
         {
            _loc7_ = param1.getChildAt(_loc5_) as MovieClip;
            if(_loc7_ != null)
            {
               _loc7_.visible = false;
               _loc7_.alpha = 0;
            }
            _loc5_++;
         }
         switch(comDefine.nLanguage)
         {
            case "ja":
               _loc4_ = "jpn";
               break;
            case "en":
               _loc4_ = "eng";
               break;
            case "fr":
               _loc4_ = "fra";
               break;
            case "de":
               _loc4_ = "ger";
               break;
            case "it":
               _loc4_ = "ita";
               break;
            case "es":
               _loc4_ = "spa";
               break;
            case "ko":
               _loc4_ = "kor";
         }
         var _loc6_:* = comDefine.g_Dir + "poice_tex/playBG_" + _loc4_ + ".swf";
         DebugPrint("LangChange" + _loc6_);
         _loc3_.LoadSwf(_loc6_);
         param1.addChild(_loc3_);
      }
      
      public static function DebugPrint(param1:String) : *
      {
         if(DEBUG_TEXT == false)
         {
            return;
         }
         if(debugWindow != null)
         {
            debugWindow.text += "\n";
            debugWindow.text += param1;
         }
      }
   }
}


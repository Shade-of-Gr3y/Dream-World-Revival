package bfp.main
{
   import bfp.HelpBridge;
   import bfp.common.Analytics;
   import bfp.common.ConnectorDataBase;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.common.itemLoader;
   import com.adobe.serialization.json.JSON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.system.Security;
   import org.libspark.thread.EnterFrameThreadExecutor;
   import org.libspark.thread.Thread;
   
   public dynamic class MainDocument extends Sprite
   {
      
      private var _main:MainScene;
      
      public var main:MovieClip;
      
      private var _xmlloader:URLLoader;
      
      private var _connector:ConnectorDataBase;
      
      public function MainDocument()
      {
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         HelpBridge.HELP_HOME_TOP;
         itemLoader.ITEM_BASEPATH;
         if(!Thread.isReady)
         {
            Thread.initialize(new EnterFrameThreadExecutor());
         }
         PokemonBridge.PATH = this.loaderInfo.url.slice(0,this.loaderInfo.url.lastIndexOf("/") + 1);
         this.visible = false;
         this.tabEnabled = false;
         this.tabChildren = false;
         this.stage.stageFocusRect = false;
         this.stage.align = StageAlign.TOP_LEFT;
         this.stage.displayState = StageDisplayState.NORMAL;
         this.stage.scaleMode = StageScaleMode.SHOW_ALL;
         this.addEventListener(Event.ENTER_FRAME,this.preloadingHandler);
         var _loc1_:Analytics = new Analytics(PokemonBridge.TAG,"tag");
         _loc1_.init(this,"UA-17682532-1");
      }
      
      private function preloadingHandler(param1:Event = null) : void
      {
         var _loc2_:Number = loaderInfo.bytesLoaded;
         var _loc3_:Number = loaderInfo.bytesTotal;
         if(_loc2_ / _loc3_ >= 1 && _loc3_ > 8)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.preloadingHandler);
            this.init();
         }
      }
      
      private function init() : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc1_:Object = this.loaderInfo.parameters;
         if(_loc1_["json"])
         {
            Logger.log(_loc1_["json"]);
            if(_loc1_["json"] != "undefined")
            {
               _loc2_ = com.adobe.serialization.json.JSON.decode(_loc1_["json"]);
               Logger.log("//// -----------------------");
               this.visible = true;
               for(_loc3_ in _loc2_.member)
               {
                  if(_loc3_ == "rom_id")
                  {
                     if(!_loc2_.member.rom_id)
                     {
                        _loc2_.member.rom_id = NaN;
                     }
                  }
                  PokemonBridge[_loc3_] = _loc2_.member[_loc3_];
                  Logger.log("// " + _loc3_ + " : " + PokemonBridge[_loc3_]);
               }
               PokemonBridge.token = _loc2_.token;
               Logger.log("//// -----------------------");
            }
         }
         if(_loc1_["v"])
         {
            PokemonBridge.version = String(_loc1_["v"]);
            if(PokemonBridge.version.indexOf("debug",0) > 0)
            {
               PokemonBridge.version = String(Math.floor(Math.random() * 1000000000));
            }
         }
         if(_loc1_["api_host_name"])
         {
            PokemonBridge.setAPI(String(_loc1_["api_host_name"]));
         }
         if(_loc1_["page"])
         {
            PokemonBridge.site = String(_loc1_["page"]);
         }
         if(_loc1_["shortcut"])
         {
            if(String(_loc1_["shortcut"]) != "undefined")
            {
               PokemonBridge.shortcut_campaign = Number(_loc1_["shortcut"]);
               Logger.log("shortcut : " + String(_loc1_["shortcut"]));
            }
         }
         if(_loc1_["mailto"])
         {
            if(String(_loc1_["mailto"]) != "undefined")
            {
               PokemonBridge.MailerRequest = String(_loc1_["mailto"]);
               Logger.log("mailto : " + PokemonBridge.MailerRequest);
            }
         }
         if(_loc1_["rankingto"])
         {
            if(String(_loc1_["rankingto"]) != "undefined")
            {
               PokemonBridge.requestBattleHistory = String(_loc1_["rankingto"]);
               Logger.log("rankingto" + String(_loc1_["rankingto"]));
            }
         }
         if(_loc1_["infoto"])
         {
            if(String(_loc1_["infoto"]) != "undefined")
            {
               PokemonBridge.infoRequest = String(_loc1_["infoto"]);
               Logger.log("infoto" + String(_loc1_["infoto"]));
            }
         }
         if(_loc1_["forceid"])
         {
            if(String(_loc1_["forceid"]) != "undefined")
            {
               HelpBridge.forceId = String(_loc1_["forceid"]);
               Logger.log("forceid" + String(_loc1_["forceid"]));
            }
         }
         if(_loc1_["helpPDW"])
         {
            if(String(_loc1_["helpPDW"]) != "undefined")
            {
               HelpBridge.helpPDW = int(_loc1_["helpPDW"]);
               Logger.log("helpPDW" + String(_loc1_["helpPDW"]));
            }
         }
         if(_loc1_["toHelp"])
         {
            if(String(_loc1_["toHelp"]) != "undefined")
            {
               PokemonBridge.now = String(_loc1_["toHelp"]);
               Logger.log("toHelp" + String(_loc1_["toHelp"]));
            }
         }
         if(_loc1_["lang"])
         {
            _loc4_ = decodeURI(String(_loc1_["lang"]));
            _loc4_ = _loc4_.slice(0,_loc4_.indexOf(".",0));
            if(_loc4_.indexOf("-",0) != -1)
            {
               _loc4_ = _loc4_.slice(_loc4_.indexOf("-",0),_loc4_.length);
            }
            if(_loc4_.indexOf("es") != -1)
            {
               PokemonBridge.lang = "es";
            }
            if(_loc4_.indexOf("en") != -1)
            {
               PokemonBridge.lang = "en";
            }
            if(_loc4_.indexOf("fr") != -1)
            {
               PokemonBridge.lang = "fr";
            }
            if(_loc4_.indexOf("de") != -1)
            {
               PokemonBridge.lang = "de";
            }
            if(_loc4_.indexOf("it") != -1)
            {
               PokemonBridge.lang = "it";
            }
            if(_loc4_.indexOf("ko") != -1)
            {
               PokemonBridge.lang = "ko";
            }
            if(_loc4_.indexOf("ja") != -1)
            {
               PokemonBridge.lang = "ja";
            }
            Logger.log("比較→ " + _loc4_);
            Logger.log("言語 " + PokemonBridge.lang);
         }
         this.open();
      }
      
      public function open(param1:Event = null) : void
      {
         Logger.log("// ************************************************************************");
         Logger.log("// POKEMON SITE - START");
         Logger.log("// ************************************************************************");
         this._main = new MainScene(this.main);
         this._main.open();
         this.visible = true;
      }
   }
}


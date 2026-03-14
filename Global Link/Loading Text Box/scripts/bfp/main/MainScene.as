package bfp.main
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.common.VersionManager;
   import bfp.main.alert.PDWEnterBridge;
   import bfp.main.alert.PDWEnterCheck;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.properties.DisplayShortcuts;
   import caurina.transitions.properties.FilterShortcuts;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.events.ProgressEvent;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class MainScene
   {
      
      private var _loaderHelper:Loader;
      
      private var _container:MovieClip;
      
      private var fontPath:String = "./font.swf";
      
      private var sePath:String = "./se.swf";
      
      private var requestFlag:Boolean = true;
      
      private var _assetmanager:AssetManager;
      
      private var versionXML:String = "version.xml";
      
      private var formatXML:String = "format.xml";
      
      private var alertPath:String = "alert.swf";
      
      private var alertXML:String = "alert_strings.xml";
      
      private var _src:MovieClip;
      
      private var _site:String = "";
      
      private var _cnt:Number = 0;
      
      private var _soundcontroller:SoundController;
      
      private var _pokemonloading:PokemonLoading;
      
      private var _loader:Loader;
      
      private var _helper:MovieClip;
      
      private var _connector:ConnectorDataBase;
      
      private var soundPath:String = "./sound.swf";
      
      private var _minigame:String = PokemonBridge.MINI_GAME_PLAY;
      
      private var _enter:MovieClip;
      
      private var _wrapper:MovieClip;
      
      private var _alert:MainAlert;
      
      private var _bmpd:BitmapData;
      
      private var copyXML:String = "strings.xml";
      
      private var pokePath:String = "./poke.swf";
      
      private var _bm:Bitmap;
      
      private var _romalert:RomAlert;
      
      private var _filter1:BlurFilter;
      
      private var _so:SharedObject;
      
      public function MainScene(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._wrapper = this._container.wrapper;
         this._helper = this._container.helper;
         this._enter = this._container.enter;
         this._alert = new MainAlert(this._container.alert);
         this._romalert = new RomAlert(this._container.romalert);
         this._pokemonloading = new PokemonLoading(this._container.pokemonloading);
         this._soundcontroller = new SoundController();
         this._src = this._container.src;
         this._bmpd = new BitmapData(1003,570,true,16777215);
         this._bm = new Bitmap(this._bmpd,"auto",true);
         this._src.addChild(this._bm);
         this._src.visible = false;
         this._filter1 = new BlurFilter(18,18,2);
         Tweener.addTween(this._src,{
            "_colorTransform":new ColorTransform(0.5,0.5,0.5,1,150,150,150,0),
            "time":0,
            "transition":"linear"
         });
         Tweener.addTween(this._src,{
            "_saturation":0.1,
            "time":0,
            "transition":"linear"
         });
         ColorShortcuts.init();
         FilterShortcuts.init();
         DisplayShortcuts.init();
      }
      
      private function sharedObjectStatusHandler(param1:NetStatusEvent) : void
      {
         this._so.removeEventListener(NetStatusEvent.NET_STATUS,this.sharedObjectStatusHandler);
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               break;
            case "SharedObject.Flush.Failed":
               PokemonBridge.alertWindow(FontManager.getIdText("pg_amg_1"),PokemonBridge.WITH_RELOAD);
         }
         this._so = null;
      }
      
      private function pdwFinishHandler(param1:Event) : void
      {
         PDWEnterBridge.PDWfinish();
      }
      
      private function loadingProgressHandler(param1:Event) : void
      {
         PokemonBridge.percent = this._assetmanager.percent;
      }
      
      private function alertLoadedHandler(param1:Event) : void
      {
         PokemonBridge.ClearConnect();
         this._assetmanager.removeEventListener(AssetManager.COMPLETE_LOADING,this.alertLoadedHandler);
         this._enter.addChild(Sprite(this._assetmanager.getAsset(this.alertPath).content));
         PokemonBridge.addEventListener(PokemonBridge.CHANGE_SITE,this.otherAssetLoad);
      }
      
      private function copyLoadedHandler(param1:Event) : void
      {
         FontManager.removeEventListener(Event.COMPLETE,this.copyLoadedHandler);
         var _loc2_:Boolean = true;
         switch(PokemonBridge.site)
         {
            case PokemonBridge.PAGE_CUSTOMIZE:
               if(!CheckUserInformation.isLogin)
               {
                  _loc2_ = false;
                  PokemonBridge.href("/introduction/");
               }
               else if(!CheckUserInformation.isRom)
               {
                  if(isNaN(PokemonBridge.rom_id))
                  {
                     _loc2_ = false;
                     this._romalert.open(RomAlert.NOT_SYNC);
                  }
                  else if(PokemonBridge.rom_id == 0)
                  {
                     _loc2_ = false;
                     this._romalert.open(RomAlert.NO_ID);
                  }
               }
               break;
            case PokemonBridge.SITE_PDW:
            case PokemonBridge.PAGE_MAIL:
            case PokemonBridge.SITE_GBU:
               if(!CheckUserInformation.isLogin)
               {
                  _loc2_ = false;
                  PokemonBridge.href("/introduction/");
               }
               else if(isNaN(PokemonBridge.rom_id))
               {
                  _loc2_ = false;
                  this._romalert.open(RomAlert.NOT_SYNC);
               }
               break;
            case PokemonBridge.PAGE_CAMPAIGN:
               if(CheckUserInformation.isLogin)
               {
                  if(isNaN(PokemonBridge.rom_id))
                  {
                     _loc2_ = false;
                     this._romalert.open(RomAlert.NOT_SYNC);
                  }
               }
         }
         if(_loc2_)
         {
            PokemonBridge.DataConnect();
            FontManager.addEventListener(FontManager.LOADED,this.loadedFontHandler);
            FontManager.standalone(this.fontPath);
            this._container.addEventListener(Event.ENTER_FRAME,this.fontloadingProgressHandler);
         }
      }
      
      private function loadedSoundEffectsHandler(param1:Event) : void
      {
         PokemonBridge.ClearConnect();
         this._assetmanager.removeEventListener(AssetManager.COMPLETE_LOADING,this.loadedSoundEffectsHandler);
         switch(PokemonBridge.site)
         {
            case PokemonBridge.PAGE_CAMPAIGN:
            case PokemonBridge.PAGE_CUSTOMIZE:
            case PokemonBridge.PAGE_INFORMATION:
            case PokemonBridge.PAGE_MAIL:
               this._soundcontroller.init(Loader(this._assetmanager.getAsset(this.soundPath).loader),true);
               break;
            default:
               this._soundcontroller.init(Loader(this._assetmanager.getAsset(this.sePath).loader));
         }
         switch(PokemonBridge.site)
         {
            case PokemonBridge.PAGE_CAMPAIGN:
            case PokemonBridge.SITE_PDW:
            case PokemonBridge.SITE_GBU:
               PokemonBridge.DataConnect();
               PokemonBridge.addEventListener(PokemonBridge.RENDER_LOADED,this.renderLoadedCompleteHandler);
               PokemonBridge.POKEMONPATH = PokemonBridge.PATH + "../global/parts/pokemon/scaled";
               PokemonBridge.POKEMONPATH2 = PokemonBridge.PATH + "../global/parts/pokemon/scaled2";
               PokemonBridge.standalone(PokemonBridge.PATH + this.pokePath);
               break;
            default:
               this.renderLoadedCompleteHandler();
         }
      }
      
      private function renderLoadedCompleteHandler(param1:Event = null) : void
      {
         PokemonBridge.ClearConnect();
         PokemonBridge.removeEventListener(PokemonBridge.RENDER_LOADED,this.renderLoadedCompleteHandler);
         this.contentLoadStart();
      }
      
      private function versionXMLHandler(param1:Event) : void
      {
         PokemonBridge.ClearConnect();
         this._assetmanager.removeEventListener(AssetManager.COMPLETE_LOADING,this.versionXMLHandler);
         VersionManager.xml = XML(this._assetmanager.getAsset(this.versionXML).data);
         this.copyXML = PokemonBridge.PATH + "../" + PokemonBridge.lang + "/xml/" + this.copyXML;
         this.formatXML = PokemonBridge.PATH + "../" + PokemonBridge.lang + "/xml/" + this.formatXML;
         this.fontPath = PokemonBridge.PATH + this.fontPath;
         this.sePath = PokemonBridge.PATH + this.sePath;
         this.soundPath = PokemonBridge.PATH + this.soundPath;
         this.alertPath = PokemonBridge.PATH + "../../../pdw/assets/" + this.alertPath;
         if(PokemonBridge.version != "standalone")
         {
            this.fontPath += "?appver=" + PokemonBridge.version;
            this.fontPath += "&ver=" + VersionManager.xml.common.font.toString();
            this.copyXML += "?appver=" + PokemonBridge.version;
            this.copyXML += "&ver=" + VersionManager.xml.common.strings[PokemonBridge.lang].toString();
            this.formatXML += "?appver=" + PokemonBridge.version;
            this.formatXML += "&ver=" + VersionManager.xml.common.format[PokemonBridge.lang].toString();
            this.sePath += "?appver=" + PokemonBridge.version;
            this.sePath += "&ver=" + VersionManager.xml.common.se.toString();
            this.pokePath += "?appver=" + PokemonBridge.version;
            this.pokePath += "&ver=" + VersionManager.xml.common.poke.toString();
            this.alertPath += "?appver=" + PokemonBridge.version;
            this.alertPath += "&ver=" + VersionManager.xml.pdw.alert.toString();
            this.soundPath += "?appver=" + PokemonBridge.version;
            this.soundPath += "&ver=" + VersionManager.xml.common.sound.toString();
         }
         FontManager.addEventListener(Event.COMPLETE,this.copyLoadedHandler);
         FontManager.loadStringsXml([this.copyXML,""],"pgl_file");
      }
      
      private function contentLoadStart(param1:Event = null) : void
      {
         PokemonBridge.percent = 0;
         this._site = PokemonBridge.site;
         switch(PokemonBridge.site)
         {
            case PokemonBridge.PAGE_CAMPAIGN:
            case PokemonBridge.PAGE_CUSTOMIZE:
            case PokemonBridge.PAGE_INFORMATION:
            case PokemonBridge.PAGE_MAIL:
               this._soundcontroller.playBGM();
         }
         var _loc2_:* = "";
         switch(this._site)
         {
            case PokemonBridge.SITE_PDW:
               _loc2_ = PokemonBridge.PATH + "../../../pdw/assets/pdw.swf";
               break;
            case PokemonBridge.SITE_GTS:
               _loc2_ = PokemonBridge.PATH + "../../../gts/assets/gts.swf";
               break;
            case PokemonBridge.SITE_GBU:
               _loc2_ = PokemonBridge.PATH + "../../../gbu/assets/gbu.swf";
               break;
            case PokemonBridge.PAGE_INFORMATION:
               _loc2_ = PokemonBridge.PATH + "../../../information/assets/info.swf";
               break;
            case PokemonBridge.PAGE_CAMPAIGN:
               _loc2_ = PokemonBridge.PATH + "../../../campaign/assets/campaign.swf";
               break;
            case PokemonBridge.PAGE_CUSTOMIZE:
               _loc2_ = PokemonBridge.PATH + "../../../customize/assets/present.swf";
               break;
            case PokemonBridge.PAGE_MAIL:
               _loc2_ = PokemonBridge.PATH + "../../../mailer/assets/mailer.swf";
               break;
            case PokemonBridge.PAGE_HELP:
               _loc2_ = PokemonBridge.PATH + "../../../help/assets/help.swf";
         }
         if(PokemonBridge.version != "standalone")
         {
            _loc2_ += "?appver=" + PokemonBridge.version;
            switch(this._site)
            {
               case PokemonBridge.SITE_PDW:
                  _loc2_ += "&ver=" + VersionManager.xml.pdw.swf.toString();
                  break;
               case PokemonBridge.SITE_GTS:
                  _loc2_ += "&ver=" + VersionManager.xml.gts.swf.toString();
                  break;
               case PokemonBridge.SITE_GBU:
                  _loc2_ += "&ver=" + VersionManager.xml.gbu.swf.toString();
                  break;
               case PokemonBridge.PAGE_INFORMATION:
                  _loc2_ += "&ver=" + VersionManager.xml.pgl.information.swf.toString();
                  break;
               case PokemonBridge.PAGE_CAMPAIGN:
                  _loc2_ += "&ver=" + VersionManager.xml.pgl.campaign.swf.toString();
                  break;
               case PokemonBridge.PAGE_CUSTOMIZE:
                  _loc2_ += "&ver=" + VersionManager.xml.pgl.present.swf.toString();
                  break;
               case PokemonBridge.PAGE_MAIL:
                  _loc2_ += "&ver=" + VersionManager.xml.mailer.swf.toString();
                  break;
               case PokemonBridge.PAGE_HELP:
                  _loc2_ += "&ver=" + VersionManager.xml.help.swf.toString();
            }
         }
         if(PokemonBridge.site != PokemonBridge.PAGE_CAMPAIGN)
         {
            HeartBeat.init();
         }
         PokemonBridge.DataConnect();
         PokemonBridge.addEventListener(PokemonBridge.LOADED_CHILD,this.loadedChildHandler);
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loaderProgressHandler);
         this._loader.load(new URLRequest(_loc2_),_loc3_);
      }
      
      private function loadedFontHandler(param1:Event) : void
      {
         PokemonBridge.ClearConnect();
         this._container.removeEventListener(Event.ENTER_FRAME,this.fontloadingProgressHandler);
         FontManager.removeEventListener(FontManager.LOADED,this.loadedFontHandler);
         FontManager.init();
         switch(PokemonBridge.lang)
         {
            case "ja":
               FontManager.langCode = FontManager.LANG_CODE_JA;
               break;
            case "ko":
               FontManager.langCode = FontManager.LANG_CODE_KO;
               break;
            default:
               FontManager.langCode = FontManager.LANG_CODE_EN;
         }
         FontManager.addEventListener(Event.COMPLETE,this.formatLoadedHandler);
         FontManager.loadStringsXml(["",this.formatXML],"pgl_file");
      }
      
      private function otherAssetLoad(param1:Event) : void
      {
         PokemonBridge.removeEventListener(PokemonBridge.CHANGE_SITE,this.otherAssetLoad);
         if(param1)
         {
            this._enter.removeChild(Sprite(this._assetmanager.getAsset(this.alertPath).content));
         }
         this._assetmanager.addEventListener(AssetManager.COMPLETE_LOADING,this.loadedSoundEffectsHandler);
         switch(PokemonBridge.site)
         {
            case PokemonBridge.PAGE_CAMPAIGN:
            case PokemonBridge.PAGE_CUSTOMIZE:
            case PokemonBridge.PAGE_INFORMATION:
            case PokemonBridge.PAGE_MAIL:
               this._assetmanager.addAssets([this.soundPath]);
               break;
            default:
               this._assetmanager.addAssets([this.sePath]);
         }
      }
      
      private function fontloadingProgressHandler(param1:Event) : void
      {
         PokemonBridge.percent = FontManager.bytesLoaded / FontManager.bytesTotal;
      }
      
      private function loadedChildHandler(param1:Event) : void
      {
         PokemonBridge.ClearConnect();
         PokemonBridge.removeEventListener(PokemonBridge.LOADED_CHILD,this.loadedChildHandler);
      }
      
      public function open() : void
      {
         this._container.visible = true;
         this.versionXML = PokemonBridge.PATH + this.versionXML;
         if(PokemonBridge.version != "standalone")
         {
            this.versionXML += "?random=" + Math.floor(Math.random() * 1000000);
         }
         this._assetmanager = new AssetManager(this._container as Sprite,[this.versionXML]);
         PokemonBridge.DataConnect();
         this._assetmanager.addEventListener(AssetManager.COMPLETE_LOADING,this.versionXMLHandler);
         this._assetmanager.loadAssets();
      }
      
      private function loaderCompleteHandler(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loaderProgressHandler);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         if(PokemonBridge.site != PokemonBridge.SITE_PDW)
         {
            PokemonBridge.percent = 1;
         }
         else
         {
            PokemonBridge.addEventListener(PokemonBridge.CHANGE_SITE,this.pdwFinishHandler);
         }
         this._wrapper.addChild(this._loader);
      }
      
      private function formatLoadedHandler(param1:Event) : void
      {
         var soName:String = null;
         var err:String = null;
         var e:Event = param1;
         FontManager.removeEventListener(Event.COMPLETE,this.formatLoadedHandler);
         PokemonBridge.ClearConnect();
         if(PokemonBridge.member_id)
         {
            soName = "pokemon-login";
            this._so = SharedObject.getLocal(soName,"/");
            this._so.data.token = PokemonBridge.token;
            try
            {
               err = this._so.flush();
               switch(err)
               {
                  case SharedObjectFlushStatus.PENDING:
                     this._so.addEventListener(NetStatusEvent.NET_STATUS,this.sharedObjectStatusHandler);
                     break;
                  case SharedObjectFlushStatus.FLUSHED:
                     Logger.log(this._so.data.token);
                     Logger.log(PokemonBridge.token);
                     this._so = null;
               }
            }
            catch(e:*)
            {
               PokemonBridge.alertWindow(FontManager.getIdText("pg_amg_1"),PokemonBridge.WITH_RELOAD);
               _so = null;
            }
         }
         if(PokemonBridge.site == PokemonBridge.SITE_PDW)
         {
            PDWEnterCheck.init();
            PokemonBridge.DataConnect();
            this._assetmanager.addEventListener(AssetManager.COMPLETE_LOADING,this.alertLoadedHandler);
            this._assetmanager.addAssets([this.alertPath]);
         }
         else
         {
            this.otherAssetLoad(null);
         }
      }
      
      private function loaderProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesTotal;
         var _loc3_:Number = param1.bytesLoaded;
         switch(this._site)
         {
            case PokemonBridge.SITE_PDW:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.3 + 0.2;
               break;
            case PokemonBridge.SITE_GTS:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.3 + 0.2;
               break;
            case PokemonBridge.SITE_GBU:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
               break;
            case PokemonBridge.PAGE_INFORMATION:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
               break;
            case PokemonBridge.PAGE_CAMPAIGN:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
               break;
            case PokemonBridge.PAGE_CUSTOMIZE:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
               break;
            case PokemonBridge.PAGE_MAIL:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
               break;
            case PokemonBridge.PAGE_HELP:
               PokemonBridge.percent = _loc3_ / _loc2_ * 0.8 + 0.2;
         }
      }
   }
}


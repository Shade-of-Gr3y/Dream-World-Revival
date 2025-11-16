package bfp.tpc.pdw.main
{
   import bfp.PDWBridge;
   import bfp.PDWBridgeEvent;
   import bfp.PDWHomeData;
   import bfp.PDWSharedObject;
   import bfp.PDWTutorial;
   import bfp.PDWTutorialEvent;
   import bfp.common.Connection;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.common.VersionManager;
   import bfp.tpc.pdw.PDWURL;
   import bfp.tpc.pdw.common.campaignData;
   import bfp.tpc.pdw.dialog.IDialog;
   import bfp.tpc.pdw.info.Info;
   import bfp.tpc.pdw.movieplayer.*;
   import bfp.tpc.pdw.news.News;
   import bfp.tpc.pdw.tutorial.Makomo;
   import bfp.tpc.pdw.tutorial.Message;
   import caurina.transitions.Tweener;
   import com.adobe.serialization.json.JSON;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import jp.feb19.utils.NumberUtilities;
   import jp.feb19.utils.Tracer;
   
   public class Main extends Sprite
   {
       
      
      public var header:Header;
      
      public var news:News;
      
      public var makomo:Makomo;
      
      public var message:Message;
      
      public var info:Info;
      
      public var movie_panel:MoviePlayer;
      
      private var _capturemc:Sprite;
      
      private var _scene:String;
      
      private var _loader:Loader;
      
      private var _next:Loader;
      
      private var _tutorialLoader:Loader;
      
      private var _chestLoader:Loader;
      
      private var _bmp:Bitmap;
      
      private var _loadbmp:Bitmap;
      
      private var _isShowTutorial:Boolean;
      
      private var _pokemon:*;
      
      private var _isHelpButtonMode:Boolean;
      
      public function Main()
      {
         super();
         this._isShowTutorial = false;
         this._isHelpButtonMode = false;
         this.tabEnabled = false;
         this.tabChildren = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
      }
      
      public function init() : void
      {
         PDWHomeData.isMyHome = true;
         PDWHomeData.currentHomeType = PDWHomeData.HOME_MINE;
         PDWHomeData.isEndCorrectly = false;
         PDWHomeData.myMemberId = PokemonBridge.member_id;
         PDWHomeData.myMemberSaveDataId = PokemonBridge.member_savedata_id;
         PDWHomeData.myPGLName = PokemonBridge.pgl_name;
         PDWHomeData.myHomeFirstVisit = true;
         PDWHomeData.campaignHomeFirstVisit = [];
         if(PokemonBridge.country_id)
         {
            PDWHomeData.myCountryId = NumberUtilities.format(PokemonBridge.country_id,3);
         }
         else
         {
            PDWHomeData.myCountryId = "999";
         }
         PDWHomeData.anotherCountryId = "999";
         PDWBridge.mistBitmapData = new BmdMist(1003,528);
         PDWBridge.statusWindow = new AssetPDWPokemonStatusWindow();
         this.start();
      }
      
      public function start() : void
      {
         PDWBridge.addEventListener(PDWBridgeEvent.DIALOG,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.SHOW_HEADER,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.SHOW_NEWS,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.SHOW_INFO,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.START_MOVIE_PANEL,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.CHANGE_SCENE,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.BACK_TO_HOME,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.START_PDW,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.MINIGAME_HEADER,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.TUTORIAL_START,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.SHOW_INFO_BUTTON,this.pdwBridgeHandler);
         PDWBridge.addEventListener(PDWBridgeEvent.CHECK_AND_SHOW_INFO,this.pdwBridgeHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_APPEAR,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_DISAPPEAR,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_CHANGE_STATE,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_EMOTION_CHANGE,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_EMOTION_RESTART,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MESSAGE_OPEN,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MESSAGE_CLOSE,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MESSAGE_START,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MESSAGE_SEEK,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MESSAGE_NEXT,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.MAKOMO_CLOUD,this.pdwTutorialHandler);
         PDWTutorial.addEventListener(PDWTutorial.RESET_START_TUTORIAL,this.pdwTutorialHandler);
         this.visit();
      }
      
      private function dialogOKHandler(param1:PDWBridgeEvent) : void
      {
         if(Boolean(this._loader) && Boolean(this._loader.content))
         {
            Sprite(this._loader.content).mouseEnabled = true;
            Sprite(this._loader.content).mouseChildren = true;
         }
         this.header.mouseEnabled = true;
         this.header.mouseChildren = true;
         this.message.mouseEnabled = true;
         this.message.mouseChildren = true;
         this.news.mouseEnabled = true;
         this.news.mouseChildren = true;
         if(this._chestLoader)
         {
            this._chestLoader.mouseEnabled = true;
            this._chestLoader.mouseChildren = true;
         }
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CANCEL,this.dialogCancelHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_OK,this.dialogOKHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
         var _loc2_:String = String(param1.data.dialog);
         if(this._isHelpButtonMode && (_loc2_ == PDWBridge.DIALOG_TYPE_BECAME_FRIEND || _loc2_ == PDWBridge.DIALOG_TYPE_INVITED_FRIEND))
         {
            this._isHelpButtonMode = false;
            PokemonBridge.buttonMode = true;
         }
      }
      
      private function dialogCancelHandler(param1:PDWBridgeEvent) : void
      {
         if(Boolean(this._loader) && Boolean(this._loader.content))
         {
            Sprite(this._loader.content).mouseEnabled = true;
            Sprite(this._loader.content).mouseChildren = true;
         }
         this.header.mouseEnabled = true;
         this.header.mouseChildren = true;
         this.message.mouseEnabled = true;
         this.message.mouseChildren = true;
         this.news.mouseEnabled = true;
         this.news.mouseChildren = true;
         if(this._chestLoader)
         {
            this._chestLoader.mouseEnabled = true;
            this._chestLoader.mouseChildren = true;
         }
         if(this._isHelpButtonMode)
         {
            this._isHelpButtonMode = false;
            PokemonBridge.buttonMode = true;
         }
         PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CANCEL,this.dialogCancelHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_OK,this.dialogOKHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
      }
      
      private function dialogCloseHandler(param1:PDWBridgeEvent) : void
      {
         var event:PDWBridgeEvent = param1;
         if(Boolean(this._loader) && Boolean(this._loader.content))
         {
            Sprite(this._loader.content).mouseEnabled = true;
            Sprite(this._loader.content).mouseChildren = true;
         }
         this.header.mouseEnabled = true;
         this.header.mouseChildren = true;
         this.message.mouseEnabled = true;
         this.message.mouseChildren = true;
         this.news.mouseEnabled = true;
         this.news.mouseChildren = true;
         if(this._chestLoader)
         {
            this._chestLoader.mouseEnabled = true;
            this._chestLoader.mouseChildren = true;
         }
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CANCEL,this.dialogCancelHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_OK,this.dialogOKHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
         if(this._isHelpButtonMode)
         {
            this._isHelpButtonMode = false;
            PokemonBridge.buttonMode = true;
            PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
         }
         trace("dialogCloseHandler " + event.data.dialog);
         switch(event.data.dialog)
         {
            case PDWBridge.DIALOG_TYPE_RETRY:
               if(this._loader)
               {
                  this.loadScene(this._scene);
               }
               break;
            case PDWBridge.DIALOG_ERROR_REMOVE_CAPTURE:
               if(this._bmp)
               {
                  this._loader.content.visible = true;
                  Tweener.addTween(this._bmp,{
                     "time":0.3,
                     "transition":"easeNone",
                     "alpha":0,
                     "onComplete":function():void
                     {
                        _capturemc.removeChild(this);
                        _bmp.bitmapData.dispose();
                        _bmp = null;
                     }
                  });
               }
         }
      }
      
      private function pdwTutorialHandler(param1:PDWTutorialEvent) : void
      {
         var pt:Point = null;
         var light:MovieClip = null;
         var cloud:MovieClip = null;
         var event:PDWTutorialEvent = param1;
         switch(event.type)
         {
            case PDWTutorial.MAKOMO_APPEAR:
               this.makomo.appear(event.data.state,event.data.time);
               break;
            case PDWTutorial.MAKOMO_DISAPPEAR:
               this.makomo.disappear(event.data.time);
               if(this._pokemon)
               {
                  Tweener.addTween(this._pokemon.display,{
                     "time":event.data.time,
                     "alpha":0,
                     "transition":"easeNone",
                     "onComplete":function():void
                     {
                        if(_pokemon)
                        {
                           if(Boolean(_pokemon.display) && Boolean(_pokemon.display.parent))
                           {
                              removeChild(_pokemon.display);
                           }
                           _pokemon.dispose();
                           _pokemon = null;
                        }
                     }
                  });
               }
               break;
            case PDWTutorial.MAKOMO_CHANGE_STATE:
               this.makomo.changeState(event.data.state,event.data.time,event.data.transition);
               break;
            case PDWTutorial.MAKOMO_EMOTION_CHANGE:
               this.makomo.changeEmotion(event.data.emotionId);
               break;
            case PDWTutorial.MAKOMO_EMOTION_RESTART:
               this.makomo.restartEmotion();
               break;
            case PDWTutorial.MESSAGE_OPEN:
               this.message.open();
               break;
            case PDWTutorial.MESSAGE_CLOSE:
               this.message.close();
               break;
            case PDWTutorial.MESSAGE_START:
               this.message.start(event.data.messageData);
               break;
            case PDWTutorial.MESSAGE_SEEK:
               this.message.setMessage(event.data.pageNum);
               break;
            case PDWTutorial.MESSAGE_NEXT:
               this.message.nextpage();
               break;
            case PDWTutorial.MAKOMO_CLOUD:
               pt = this.makomo.localToGlobal(new Point(129,37));
               light = new AssetPokemonLight();
               light.x = pt.x;
               light.y = pt.y;
               light.scaleX = 0;
               light.scaleY = 0;
               light.mouseEnabled = false;
               light.mouseChildren = false;
               addChild(light);
               cloud = new AssetPokemonCloud();
               addChild(cloud);
               cloud.x = pt.x;
               cloud.y = pt.y;
               cloud.mouseEnabled = false;
               cloud.mouseChildren = false;
               Tweener.addTween(light,{
                  "time":1,
                  "scaleX":1,
                  "scaleY":1,
                  "transition":"easeInOutQuint"
               });
               Tweener.addTween(light,{
                  "time":2,
                  "x":375,
                  "transition":"easeOutQuart"
               });
               Tweener.addTween(light,{
                  "time":2,
                  "y":300,
                  "transition":"easeOutBounce"
               });
               Tweener.addTween(light,{
                  "time":0.2,
                  "alpha":1,
                  "transition":"easeNone"
               });
               Tweener.addTween(light,{
                  "delay":1.6,
                  "time":0.2,
                  "alpha":0,
                  "transition":"easeNone"
               });
               if(this._pokemon)
               {
                  addChild(this._pokemon.display);
                  this._pokemon.display.alpha = 0;
                  Tweener.addTween(this._pokemon.display,{
                     "delay":1.6,
                     "time":0.4,
                     "alpha":1,
                     "transition":"easeNone"
                  });
                  if(this._pokemon.animator)
                  {
                     this._pokemon.animator.play();
                  }
               }
               break;
            case PDWTutorial.RESET_START_TUTORIAL:
               if(this._pokemon)
               {
                  Tweener.removeTweens(this._pokemon.display);
                  Tweener.addTween(this._pokemon.display,{
                     "time":0.5,
                     "alpha":0,
                     "transition":"easeNone"
                  });
               }
         }
      }
      
      private function pdwBridgeHandler(param1:PDWBridgeEvent) : void
      {
         var isShow:Boolean = false;
         var type:String = null;
         var alert:IDialog = null;
         var flvlist:* = undefined;
         var rtmplist:* = undefined;
         var scene:String = null;
         var bool:Boolean = false;
         var so:Object = null;
         var bmd:BitmapData = null;
         var bmd2:BitmapData = null;
         var i:* = undefined;
         var event:PDWBridgeEvent = param1;
         trace(">>>>pdwBridgeHandler " + event.type);
         switch(event.type)
         {
            case PDWBridgeEvent.DIALOG:
               type = String(event.data.type);
               switch(type)
               {
                  case PDWBridge.DIALOG_TYPE_GO_PROFILE:
                     alert = new AssetDialogGoProfile();
               }
               if(alert)
               {
                  if(Boolean(this._loader) && Boolean(this._loader.content))
                  {
                     Sprite(this._loader.content).mouseEnabled = false;
                     Sprite(this._loader.content).mouseChildren = false;
                  }
                  this.header.mouseEnabled = false;
                  this.header.mouseChildren = false;
                  this.message.mouseEnabled = false;
                  this.message.mouseChildren = false;
                  this.news.mouseEnabled = false;
                  this.news.mouseChildren = false;
                  if(this._chestLoader)
                  {
                     this._chestLoader.mouseEnabled = false;
                     this._chestLoader.mouseChildren = false;
                  }
                  PDWBridge.addEventListener(PDWBridgeEvent.DIALOG_CANCEL,this.dialogCancelHandler);
                  PDWBridge.addEventListener(PDWBridgeEvent.DIALOG_OK,this.dialogOKHandler);
                  PDWBridge.addEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
                  addChild(alert as DisplayObject);
               }
               break;
            case PDWBridgeEvent.SHOW_HEADER:
               if(event.data.isShow)
               {
                  this.header.visit();
               }
               else
               {
                  this.header.away();
               }
               break;
            case PDWBridgeEvent.SHOW_NEWS:
               if(!this._isShowTutorial)
               {
                  if(Boolean(this._loader) && Boolean(this._loader.content))
                  {
                     Sprite(this._loader.content).mouseEnabled = false;
                     Sprite(this._loader.content).mouseChildren = false;
                  }
                  this.header.mouseEnabled = false;
                  this.header.mouseChildren = false;
                  this.message.mouseEnabled = false;
                  this.message.mouseChildren = false;
                  if(this._chestLoader)
                  {
                     this._chestLoader.mouseEnabled = false;
                     this._chestLoader.mouseChildren = false;
                  }
               }
               if(this._loader.content)
               {
                  bmd = new BitmapData(1003,557,false,4294967295);
                  bmd.draw(this._loader.content);
                  bmd2 = new BitmapData(1003,557,false,4294967295);
                  bmd2.draw(this._chestLoader);
                  bmd.merge(bmd2,new Rectangle(0,0,1003,557),new Point(this._chestLoader.x,this._chestLoader.y),1,1,1,1);
                  this._bmp = new Bitmap(bmd,"never",false);
                  this._bmp.alpha = 0;
                  this._bmp.filters = [new BlurFilter(8,8,2)];
                  Tweener.addTween(this._bmp,{
                     "time":0.4,
                     "transition":"easeNone",
                     "alpha":1,
                     "onComplete":function():void
                     {
                        _loader.content.visible = false;
                     }
                  });
                  this._capturemc.addChild(this._bmp);
                  setChildIndex(this._capturemc,numChildren - 1);
                  setChildIndex(this.news,numChildren - 1);
                  setChildIndex(this.header,numChildren - 1);
                  this.news.addEventListener("willNewsClose",this.newsWillCloseHandler);
                  this.news.addEventListener(Event.CLOSE,this.newsCloseHandler);
               }
               this.news.visit();
               PDWBridge.sfx(PDWBridge.SFX_ID_NEWS);
               break;
            case PDWBridgeEvent.SHOW_INFO:
               this.showInfoMain(event);
               this.info.visit();
               PDWBridge.sfx(PDWBridge.SFX_ID_NEWS);
               break;
            case PDWBridgeEvent.START_MOVIE_PANEL:
               flvlist = [];
               rtmplist = campaignData.data.home.movieplayer.rtmp;
               i = 0;
               while(i < rtmplist.length())
               {
                  flvlist[i] = campaignData.data.home.movieplayer.rtmp.(@ratetype == i).@file;
                  trace("flvlist " + i + " " + flvlist[i]);
                  i++;
               }
               this.showMoviePanelMain(event);
               trace("check " + flvlist.length + " " + typeof flvlist);
               this.movie_panel.setData(campaignData.data.home.movieplayer.@basertmp,flvlist);
               this.movie_panel.visit();
               PDWBridge.sfx(PDWBridge.SFX_ID_NEWS);
               break;
            case PDWBridgeEvent.CHECK_AND_SHOW_INFO:
               trace("pdwBridgeHandler CHECK_AND_SHOW_INFO");
               if(this.info.checkCampaignBoardImage())
               {
                  this.showInfoMain(event);
                  this.info.visit(1);
                  PDWBridge.sfx(PDWBridge.SFX_ID_NEWS);
                  trace("pdwBridgeHandler CHECK_AND_SHOW_INFO 1");
               }
               else
               {
                  this.infoCloseHandler(null);
                  trace("pdwBridgeHandler CHECK_AND_SHOW_INFO 2");
               }
               break;
            case PDWBridgeEvent.SHOW_INFO_BUTTON:
               if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
               {
                  this.header.isCampaign = event.data.isShow;
               }
               break;
            case PDWBridgeEvent.CHANGE_SCENE:
               scene = String(event.data.scene);
               PDWBridge.currentScene = scene;
               this.changeScene(scene);
               break;
            case PDWBridgeEvent.BACK_TO_HOME:
               this.backToHome();
               break;
            case PDWBridgeEvent.START_PDW:
               PDWBridge.removeEventListener(PDWBridgeEvent.START_PDW,this.pdwBridgeHandler);
               this.startPDW();
               break;
            case PDWBridgeEvent.MINIGAME_HEADER:
               bool = event.data.bool as Boolean;
               if(bool)
               {
                  this.header.minigame();
               }
               else
               {
                  this.header.normal();
               }
               break;
            case PDWBridgeEvent.TUTORIAL_START:
               so = PDWSharedObject.load();
               switch(event.data.type)
               {
                  case PDWBridge.TUTORIAL_START:
                  case PDWBridge.TUTORIAL_HOME_TOP:
                  case PDWBridge.TUTORIAL_HOME_BIRDVIEW:
                  case PDWBridge.TUTORIAL_HOME_INDOOR:
                  case PDWBridge.TUTORIAL_HOME_SHARE:
                  case PDWBridge.TUTORIAL_HOME_SHARE_ANOTHER:
                  case PDWBridge.TUTORIAL_ISLAND:
                  case PDWBridge.TUTORIAL_ISLAND_TREE:
                  case PDWBridge.TUTORIAL_ISLAND_SIGN:
                  case PDWBridge.TUTORIAL_ISLAND_NO_CANDIDATE:
                  case PDWBridge.TUTORIAL_HOME_ORCHARD:
                  case PDWBridge.TUTORIAL_HOME_ARC:
                     if(so["member" + PokemonBridge.member_id]["tutorial" + event.data.type])
                     {
                        PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TUTORIAL_COMPLETE,{"type":event.data.type}));
                     }
                     else
                     {
                        this.loadTutorial(event.data.type);
                     }
                     break;
                  default:
                     PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TUTORIAL_COMPLETE,{"type":event.data.type}));
               }
         }
      }
      
      private function showInfoMain(param1:PDWBridgeEvent) : void
      {
         var bmd_i:BitmapData = null;
         var bmd2_i:BitmapData = null;
         var event:PDWBridgeEvent = param1;
         if(!this._isShowTutorial)
         {
            if(Boolean(this._loader) && Boolean(this._loader.content))
            {
               Sprite(this._loader.content).mouseEnabled = false;
               Sprite(this._loader.content).mouseChildren = false;
            }
            this.header.mouseEnabled = false;
            this.header.mouseChildren = false;
            this.message.mouseEnabled = false;
            this.message.mouseChildren = false;
            if(this._chestLoader)
            {
               this._chestLoader.mouseEnabled = false;
               this._chestLoader.mouseChildren = false;
            }
         }
         if(this._loader.content)
         {
            bmd_i = new BitmapData(1003,557,false,4294967295);
            bmd_i.draw(this._loader.content);
            bmd2_i = new BitmapData(1003,557,false,4294967295);
            bmd2_i.draw(this._chestLoader);
            bmd_i.merge(bmd2_i,new Rectangle(0,0,1003,557),new Point(this._chestLoader.x,this._chestLoader.y),1,1,1,1);
            this._bmp = new Bitmap(bmd_i,"never",false);
            this._bmp.alpha = 0;
            this._bmp.filters = [new BlurFilter(8,8,2)];
            Tweener.addTween(this._bmp,{
               "time":0.4,
               "transition":"easeNone",
               "alpha":1,
               "onComplete":function():void
               {
                  _loader.content.visible = false;
               }
            });
            this._capturemc.addChild(this._bmp);
            setChildIndex(this._capturemc,numChildren - 1);
            setChildIndex(this.info,numChildren - 1);
            setChildIndex(this.header,numChildren - 1);
            this.info.addEventListener("willInfoClose",this.infoWillCloseHandler);
            this.info.addEventListener(Event.CLOSE,this.infoCloseHandler);
         }
      }
      
      private function showMoviePanelMain(param1:PDWBridgeEvent) : void
      {
         var bmd_i:BitmapData = null;
         var bmd2_i:BitmapData = null;
         var event:PDWBridgeEvent = param1;
         if(!this._isShowTutorial)
         {
            if(Boolean(this._loader) && Boolean(this._loader.content))
            {
               Sprite(this._loader.content).mouseEnabled = false;
               Sprite(this._loader.content).mouseChildren = false;
            }
            this.header.mouseEnabled = false;
            this.header.mouseChildren = false;
            this.message.mouseEnabled = false;
            this.message.mouseChildren = false;
            if(this._chestLoader)
            {
               this._chestLoader.mouseEnabled = false;
               this._chestLoader.mouseChildren = false;
            }
         }
         if(this._loader.content)
         {
            bmd_i = new BitmapData(1003,557,false,4294967295);
            bmd_i.draw(this._loader.content);
            bmd2_i = new BitmapData(1003,557,false,4294967295);
            bmd2_i.draw(this._chestLoader);
            bmd_i.merge(bmd2_i,new Rectangle(0,0,1003,557),new Point(this._chestLoader.x,this._chestLoader.y),1,1,1,1);
            this._bmp = new Bitmap(bmd_i,"never",false);
            this._bmp.alpha = 0;
            this._bmp.filters = [new BlurFilter(8,8,2)];
            Tweener.addTween(this._bmp,{
               "time":0.4,
               "transition":"easeNone",
               "alpha":1,
               "onComplete":function():void
               {
                  _loader.content.visible = false;
               }
            });
            this._capturemc.addChild(this._bmp);
            setChildIndex(this._capturemc,numChildren - 1);
            setChildIndex(this.movie_panel,numChildren - 1);
            setChildIndex(this.header,numChildren - 1);
            this.movie_panel.addEventListener("willMoviePanelClose",this.moviepanelWillCloseHandler);
            this.movie_panel.addEventListener(Event.CLOSE,this.moviepanelCloseHandler);
         }
      }
      
      public function loadTutorial(param1:uint) : void
      {
         var _loc6_:String = null;
         PDWBridge.showConnecting();
         this._isShowTutorial = true;
         var _loc2_:String = this.loaderInfo.url;
         var _loc3_:* = _loc2_.substr(0,_loc2_.lastIndexOf("/")) + "/";
         var _loc4_:LoaderContext = new LoaderContext(false,this.loaderInfo.applicationDomain);
         var _loc5_:String = !PDWBridge.isLocal ? "?appver=" + PokemonBridge.version : "";
         switch(param1)
         {
            case 0:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial0.toString() : "";
               break;
            case 1:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial1.toString() : "";
               break;
            case 2:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial2.toString() : "";
               break;
            case 3:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial3.toString() : "";
               break;
            case 4:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial4.toString() : "";
               break;
            case 5:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial5.toString() : "";
               break;
            case 6:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial6.toString() : "";
               break;
            case 7:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial7.toString() : "";
               break;
            case 8:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial8.toString() : "";
               break;
            case 9:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial9.toString() : "";
               break;
            case 10:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial10.toString() : "";
               break;
            case 11:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial11.toString() : "";
         }
         this._tutorialLoader = new Loader();
         this._tutorialLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.tutorialLoadIOErrorHandler);
         this._tutorialLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.tutorialLoadCompleteHandler);
         this._tutorialLoader.load(new URLRequest(_loc3_ + "parts/tutorial/tutorial" + param1 + ".swf" + _loc5_ + _loc6_),_loc4_);
      }
      
      private function tutorialLoadIOErrorHandler(param1:IOErrorEvent) : void
      {
         PDWBridge.showConnecting(false);
         this._isShowTutorial = false;
         this._tutorialLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.tutorialLoadIOErrorHandler);
         this._tutorialLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.tutorialLoadCompleteHandler);
         PDWBridge.dialogError(param1.text,PDWBridge.DIALOG_ERROR_NONE);
         PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.TUTORIAL_COMPLETE,{"type":-1}));
      }
      
      private function tutorialLoadCompleteHandler(param1:Event) : void
      {
         this._tutorialLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.tutorialLoadIOErrorHandler);
         this._tutorialLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.tutorialLoadCompleteHandler);
         if(Boolean(this._loader) && Boolean(this._loader.content))
         {
            Sprite(this._loader.content).mouseEnabled = false;
            Sprite(this._loader.content).mouseChildren = false;
         }
         this.header.mouseEnabled = false;
         this.header.mouseChildren = false;
         this.message.mouseEnabled = true;
         this.message.mouseChildren = true;
         addChild(this._tutorialLoader.content);
         PDWBridge.addEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.tutorialCompleteHandler);
      }
      
      private function tutorialCompleteHandler(param1:PDWBridgeEvent) : void
      {
         var _loc3_:Object = null;
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.tutorialCompleteHandler);
         this._isShowTutorial = false;
         if(this._tutorialLoader)
         {
            this._tutorialLoader.unloadAndStop();
            if(this._tutorialLoader.parent)
            {
               removeChild(this._tutorialLoader.content);
            }
            this._tutorialLoader = null;
         }
         var _loc2_:int = int(param1.data.type);
         if(_loc2_ > 0)
         {
            _loc3_ = PDWSharedObject.load();
            _loc3_["member" + PokemonBridge.member_id]["tutorial" + _loc2_] = true;
            PDWSharedObject.save(_loc3_);
         }
         if(Boolean(this._loader) && Boolean(this._loader.content))
         {
            Sprite(this._loader.content).mouseEnabled = true;
            Sprite(this._loader.content).mouseChildren = true;
         }
         this.header.mouseEnabled = true;
         this.header.mouseChildren = true;
         this.message.mouseEnabled = true;
         this.message.mouseChildren = true;
         if(this._chestLoader)
         {
            this._chestLoader.mouseEnabled = true;
            this._chestLoader.mouseChildren = true;
         }
      }
      
      private function newsWillCloseHandler(param1:Event) : void
      {
         var event:Event = param1;
         trace("*** newsWillCloseHandler");
         this.news.removeEventListener("willNewsClose",this.newsWillCloseHandler);
         this._loader.content.visible = true;
         if(this._bmp)
         {
            Tweener.addTween(this._bmp,{
               "time":0.3,
               "transition":"easeNone",
               "alpha":0,
               "onComplete":function():void
               {
                  _capturemc.removeChild(this);
                  _bmp.bitmapData.dispose();
                  _bmp = null;
               }
            });
         }
      }
      
      private function newsCloseHandler(param1:Event) : void
      {
         trace("*** newsCloseHandler " + this._isShowTutorial + " " + this._scene + " " + this._chestLoader + " " + this._loader);
         PDWBridge.dispatchEvent(new Event("closeNews"));
         this.news.removeEventListener(Event.CLOSE,this.newsCloseHandler);
         if(!this._isShowTutorial)
         {
            trace("*** newsCloseHandler check1");
            if(Boolean(this._loader) && Boolean(this._loader.content))
            {
               Sprite(this._loader.content).mouseEnabled = true;
               Sprite(this._loader.content).mouseChildren = true;
            }
            this.header.mouseEnabled = true;
            this.header.mouseChildren = true;
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
            if(this._scene == PDWBridge.SCENE_HOME || this._scene == PDWBridge.SCENE_HOME_DEFAULT)
            {
               trace("*** => showHomeButtons");
               PDWBridge.dispatchEvent(new Event("showHomeButtons"));
            }
            if(this._chestLoader)
            {
               this._chestLoader.mouseEnabled = true;
               this._chestLoader.mouseChildren = true;
            }
         }
         else
         {
            trace("*** newsCloseHandler check2");
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
         }
      }
      
      private function infoWillCloseHandler(param1:Event) : void
      {
         var event:Event = param1;
         trace(">>> infoWillCloseHandler");
         this.info.removeEventListener("willInfoClose",this.infoWillCloseHandler);
         this._loader.content.visible = true;
         if(this._bmp)
         {
            Tweener.addTween(this._bmp,{
               "time":0.3,
               "transition":"easeNone",
               "alpha":0,
               "onComplete":function():void
               {
                  _capturemc.removeChild(this);
                  _bmp.bitmapData.dispose();
                  _bmp = null;
               }
            });
         }
      }
      
      private function moviepanelWillCloseHandler(param1:Event) : void
      {
         var event:Event = param1;
         trace(">>> infoWillCloseHandler");
         this.movie_panel.removeEventListener("willMoviePanelClose",this.moviepanelWillCloseHandler);
         this._loader.content.visible = true;
         if(this._bmp)
         {
            Tweener.addTween(this._bmp,{
               "time":0.3,
               "transition":"easeNone",
               "alpha":0,
               "onComplete":function():void
               {
                  _capturemc.removeChild(this);
                  _bmp.bitmapData.dispose();
                  _bmp = null;
               }
            });
         }
      }
      
      private function infoCloseHandler(param1:Event) : void
      {
         trace(">>> infoCloseHandler");
         PDWBridge.dispatchEvent(new Event("closeInfo"));
         this.info.removeEventListener(Event.CLOSE,this.infoCloseHandler);
         if(!this._isShowTutorial)
         {
            if(Boolean(this._loader) && Boolean(this._loader.content))
            {
               Sprite(this._loader.content).mouseEnabled = true;
               Sprite(this._loader.content).mouseChildren = true;
            }
            this.header.mouseEnabled = true;
            this.header.mouseChildren = true;
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
            trace(">>> infoCloseHandler --- scene=" + this._scene);
            if(this._scene == PDWBridge.SCENE_HOME_CAMPAIGN)
            {
               trace(">> >dispatchEvent showInfoButtons");
               PDWBridge.dispatchEvent(new Event("showInfoButtons"));
            }
            if(this._chestLoader)
            {
               this._chestLoader.mouseEnabled = true;
               this._chestLoader.mouseChildren = true;
            }
         }
         else
         {
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
         }
      }
      
      private function moviepanelCloseHandler(param1:Event) : void
      {
         trace(">>> infoCloseHandler");
         PDWBridge.dispatchEvent(new Event("closeMoviePanel"));
         this.movie_panel.removeEventListener(Event.CLOSE,this.moviepanelCloseHandler);
         if(!this._isShowTutorial)
         {
            if(Boolean(this._loader) && Boolean(this._loader.content))
            {
               Sprite(this._loader.content).mouseEnabled = true;
               Sprite(this._loader.content).mouseChildren = true;
            }
            this.header.mouseEnabled = true;
            this.header.mouseChildren = true;
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
            trace(">>> infoCloseHandler --- scene=" + this._scene);
            if(this._scene == PDWBridge.SCENE_HOME_CAMPAIGN)
            {
               trace(">> >dispatchEvent showInfoButtons");
               PDWBridge.dispatchEvent(new Event("showMoviePanelButtons"));
            }
            if(this._chestLoader)
            {
               this._chestLoader.mouseEnabled = true;
               this._chestLoader.mouseChildren = true;
            }
         }
         else
         {
            this.message.mouseEnabled = true;
            this.message.mouseChildren = true;
         }
      }
      
      public function release() : void
      {
         PDWBridge.removeEventListener(PDWBridgeEvent.DIALOG,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.SHOW_HEADER,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.SHOW_NEWS,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.SHOW_INFO,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.START_MOVIE_PANEL,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.CHANGE_SCENE,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.BACK_TO_HOME,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.START_PDW,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.MINIGAME_HEADER,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_START,this.pdwBridgeHandler);
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.tutorialCompleteHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_APPEAR,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_DISAPPEAR,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_CHANGE_STATE,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_EMOTION_CHANGE,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_EMOTION_RESTART,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MESSAGE_OPEN,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MESSAGE_CLOSE,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MESSAGE_START,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MESSAGE_SEEK,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MESSAGE_NEXT,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.MAKOMO_CLOUD,this.pdwTutorialHandler);
         PDWTutorial.removeEventListener(PDWTutorial.RESET_START_TUTORIAL,this.pdwTutorialHandler);
         if(this._pokemon)
         {
            if(Boolean(this._pokemon.display) && Boolean(this._pokemon.display.parent))
            {
               removeChild(this._pokemon.display);
            }
            this._pokemon.dispose();
            this._pokemon = null;
         }
         if(this._loadbmp)
         {
            removeChild(this._loadbmp);
            this._loadbmp.bitmapData.dispose();
            this._loadbmp = null;
         }
         if(this._capturemc)
         {
            removeChild(this._capturemc);
            this._capturemc = null;
         }
         if(this._chestLoader)
         {
            this._chestLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.chestLoadCompleteHandler);
            this._chestLoader.unloadAndStop();
            if(this._chestLoader.parent)
            {
               removeChild(this._chestLoader);
            }
            this._chestLoader = null;
         }
         if(this.news)
         {
            this.news.removeEventListener("willNewsClose",this.newsWillCloseHandler);
            this.news.removeEventListener(Event.CLOSE,this.newsCloseHandler);
         }
         if(this.info)
         {
            this.info.removeEventListener("willInfoClose",this.infoWillCloseHandler);
            this.info.removeEventListener(Event.CLOSE,this.infoCloseHandler);
         }
         if(this.movie_panel)
         {
            this.movie_panel.removeEventListener("willInfoClose",this.infoWillCloseHandler);
            this.movie_panel.removeEventListener(Event.CLOSE,this.infoCloseHandler);
         }
         PDWBridge.dispose();
      }
      
      public function visit() : void
      {
         this.loadChest();
      }
      
      public function away() : void
      {
         this.release();
      }
      
      public function loadChest() : void
      {
         Tracer.add("loadChest");
         var _loc1_:String = this.loaderInfo.url;
         var _loc2_:* = _loc1_.substr(0,_loc1_.lastIndexOf("/")) + "/";
         var _loc3_:String = !PDWBridge.isLocal ? "?appver=" + PokemonBridge.version : "";
         var _loc4_:String = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.takarabako.toString() : "";
         this._chestLoader = new Loader();
         this._chestLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.chestLoadIOErrorHandler);
         this._chestLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.chestLoadCompleteHandler);
         this._chestLoader.load(new URLRequest(_loc2_ + "takarabako.swf" + _loc3_ + _loc4_));
         addChild(this._chestLoader);
      }
      
      private function chestLoadIOErrorHandler(param1:IOErrorEvent) : void
      {
         this._chestLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.chestLoadIOErrorHandler);
         this._chestLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.chestLoadCompleteHandler);
         var _loc2_:String = FontManager.getIdText("dialog_2");
         PDWBridge.dialogError(_loc2_,PDWBridge.DIALOG_ERROR_CLOSE);
      }
      
      private function chestLoadCompleteHandler(param1:Event) : void
      {
         Tracer.add("chestLoadCompleteHandler");
         this._chestLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.chestLoadIOErrorHandler);
         this._chestLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.chestLoadCompleteHandler);
         this.makomo = new AssetMakomo();
         addChild(this.makomo);
         this.message = new AssetMessage();
         addChild(this.message);
         this._capturemc = new Sprite();
         addChild(this._capturemc);
         this.header = new AssetHeader();
         addChild(this.header);
         this.header.x = stage.stageWidth;
         this.header.y = 0;
         this.news = new AssetNews();
         addChild(this.news);
         this.info = new AssetInfo();
         addChild(this.info);
         this.movie_panel = new AssetMoviePlayer();
         addChild(this.movie_panel);
         if(Boolean(PokemonBridge.first_flag) && PokemonBridge.first_flag != 0)
         {
            Tracer.add("chestLoadCompleteHandler A");
            PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
            this.startPDW();
         }
         else
         {
            Tracer.add("chestLoadCompleteHandler B");
            PokemonBridge.dispatchEvent(new Event(PokemonBridge.FOOTER_ON));
            this.changeScene(PDWBridge.SCENE_START);
         }
      }
      
      public function startPDW() : void
      {
         var _loc1_:Connection = null;
         Tracer.add("startPDW");
         PDWBridge.showConnecting();
         if(!isNaN(PokemonBridge.first_flag) || PokemonBridge.first_flag == 0)
         {
            Tracer.add("startPDW state");
            _loc1_ = new Connection();
            _loc1_.addEventListener(Event.COMPLETE,this.startPDWConnectionCompleteHandler);
            _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.startPDWConnectionIOErrorHandler);
            _loc1_.request["token"] = PokemonBridge.token;
            _loc1_.request["state"] = 1;
            _loc1_.open(PDWURL.PDW_MY_STATE,"GET");
         }
         else
         {
            this.startPDW2();
         }
      }
      
      private function startPDWConnectionIOErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.startPDWConnectionCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.startPDWConnectionIOErrorHandler);
         var _loc3_:Boolean = false;
         var _loc4_:Array;
         var _loc5_:uint = (_loc4_ = _loc2_.keys).length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc4_[_loc6_] === "gsid")
            {
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            this.startPDW2();
         }
         else
         {
            PDWBridge.dialogError(param1.text,PDWBridge.DIALOG_ERROR_REFRESH);
         }
      }
      
      private function startPDWConnectionCompleteHandler(param1:Event) : void
      {
         Tracer.add("startPDWConnectionCompleteHandler");
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.startPDWConnectionCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.startPDWConnectionIOErrorHandler);
         this.startPDW2();
      }
      
      public function startPDW2() : void
      {
         Tracer.add("startPDW2");
         PokemonBridge.first_flag = 1;
         if(this._pokemon)
         {
            Tweener.removeTweens(this._pokemon.display);
            if(Boolean(this._pokemon.display) && Boolean(this._pokemon.display.parent))
            {
               removeChild(this._pokemon.display);
            }
            this._pokemon.dispose();
            this._pokemon = null;
         }
         var _loc1_:Connection = new Connection();
         _loc1_.addEventListener(Event.COMPLETE,this.startPDW2ConnectionCompleteHandler);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.startPDW2ConnectionIOErrorHandler);
         _loc1_.request["token"] = PokemonBridge.token;
         _loc1_.open(PDWURL.PDW_START,"POST");
      }
      
      private function startPDW2ConnectionIOErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         PDWBridge.showConnecting(false);
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.startPDW2ConnectionCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.startPDW2ConnectionIOErrorHandler);
         if(_loc2_.statusCode == 0)
         {
            _loc3_ = FontManager.getIdText("dialog_1");
            PDWBridge.dialogError(_loc3_,PDWBridge.DIALOG_ERROR_REFRESH);
         }
         else if(_loc2_.errordata.error.details["default"])
         {
            PDWBridge.dialogError(_loc2_.errordata.error.details["default"],PDWBridge.DIALOG_ERROR_CLOSE);
         }
         else if(_loc2_.errordata.error.details["countcheck"])
         {
            PDWBridge.dialogError(_loc2_.errordata.error.details["countcheck"],PDWBridge.DIALOG_ERROR_REFRESH);
         }
         else
         {
            _loc4_ = FontManager.getIdText("dialog_1");
            PDWBridge.dialogError(_loc4_,PDWBridge.DIALOG_ERROR_REFRESH);
         }
         _loc2_.close();
      }
      
      private function startPDW2ConnectionCompleteHandler(param1:Event) : void
      {
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.startPDW2ConnectionCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.startPDW2ConnectionIOErrorHandler);
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(String(_loc2_.data));
         PokemonBridge.PDWStartTimeStamp(Number(_loc3_["started_at"]));
         _loc2_.close();
         this.checkNews();
      }
      
      private function checkNews() : void
      {
         var _loc1_:Connection = new Connection();
         _loc1_.request["token"] = PokemonBridge.token;
         _loc1_.request["offset"] = 0;
         _loc1_.request["rowcount"] = 8;
         _loc1_.request["weekly_flag"] = 0;
         _loc1_.addEventListener(Event.COMPLETE,this.checkNewsCompleteHandler);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.checkNewsIOErrorHandler);
         _loc1_.open(PDWURL.PDW_INFO,"GET");
      }
      
      private function checkNewsIOErrorHandler(param1:IOErrorEvent) : void
      {
         PDWBridge.showConnecting(false);
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.checkNewsCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.checkNewsIOErrorHandler);
         PDWBridge.newsdata = [];
         PDWBridge.changeScene(PDWBridge.SCENE_OPENING);
      }
      
      private function checkNewsCompleteHandler(param1:Event) : void
      {
         PDWBridge.showConnecting(false);
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.checkNewsCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.checkNewsIOErrorHandler);
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(_loc2_.data.toString());
         var _loc4_:uint = uint(_loc3_.list.length);
         var _loc5_:int;
         if((_loc5_ = int(_loc3_.total_count)) > 0)
         {
            trace("total_count");
            PDWBridge.newsdata = _loc3_.list;
         }
         else
         {
            trace("new total_count empty");
            PDWBridge.newsdata = [];
         }
         if(PDWBridge.isLocal)
         {
            PDWBridge.changeScene(PDWBridge.SCENE_HOME);
         }
         else
         {
            PDWBridge.changeScene(PDWBridge.SCENE_OPENING);
         }
      }
      
      public function changeScene(param1:String = "scene_world", param2:Boolean = false) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Bitmap = null;
         trace("******* changeScene " + param1 + " " + param2);
         if(param1 == PDWBridge.SCENE_WORLD_CAMPAIGN && !param2)
         {
            _loc3_ = new BitmapData(1003,557,false,4294967295);
            _loc3_.draw(this._loader.content);
            this._bmp = new Bitmap(_loc3_,"never",false);
            this._capturemc.addChild(this._bmp);
            this.loadWorldCampaign();
         }
         else
         {
            if(this._loader)
            {
               if(this._loadbmp)
               {
                  removeChild(this._loadbmp);
                  this._loadbmp.bitmapData.dispose();
                  this._loadbmp = null;
               }
               (_loc4_ = new BitmapData(1003,557,true,4294967295)).draw(this._loader.content);
               (_loc5_ = new Bitmap(_loc4_,"never",false)).filters = [new BlurFilter(8,8,2)];
               Tweener.addTween(_loc5_,{
                  "time":0.4,
                  "transition":"easeNone",
                  "alpha":1
               });
               addChildAt(_loc5_,0);
               this._loadbmp = _loc5_;
               removeChild(this._loader.content);
               this._loader.unloadAndStop();
               this._loader = null;
            }
            this.loadScene(param1);
         }
      }
      
      public function loadScene(param1:String = "scene_world") : void
      {
         var _loc3_:* = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         trace("loadScene " + param1);
         var _loc2_:String = this.loaderInfo.url;
         _loc3_ = _loc2_.substr(0,_loc2_.lastIndexOf("/")) + "/";
         PDWBridge.loadingPercentage = 0;
         PDWBridge.showLoading();
         var _loc4_:Loader;
         (_loc4_ = new Loader()).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
         _loc4_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         _loc5_ = !PDWBridge.isLocal ? "?appver=" + PokemonBridge.version : "";
         switch(param1)
         {
            case PDWBridge.SCENE_HOME_DEFAULT:
               PDWHomeData.isCampaign = false;
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_home.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_home.swf" + _loc5_ + _loc6_));
               this.header.checkCampaign();
               break;
            case PDWBridge.SCENE_HOME:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_home.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_home.swf" + _loc5_ + _loc6_));
               this.header.checkCampaign();
               break;
            case PDWBridge.SCENE_OPENING:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_opening.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_opening.swf" + _loc5_ + _loc6_));
               break;
            case PDWBridge.SCENE_WORLD:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_world.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_world.swf" + _loc5_ + _loc6_));
               break;
            case PDWBridge.SCENE_MOVE:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_move.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_move.swf" + _loc5_ + _loc6_));
               break;
            case PDWBridge.SCENE_START:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.tutorial0.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "parts/tutorial/tutorial0.swf" + _loc5_ + _loc6_));
               if(isNaN(PokemonBridge.rom_id) || PokemonBridge.rom_id == 0)
               {
                  if(_loc8_ = PokemonBridge.createRenderer())
                  {
                     try
                     {
                        _loc8_.display.x = 361;
                        _loc8_.display.y = 384;
                        _loc8_.shadowOpacity = 0;
                        _loc8_.load(517,0,0.7);
                        _loc8_.display.tabEnabled = false;
                        _loc8_.display.tabChildren = false;
                        this._pokemon = _loc8_;
                     }
                     catch(error:Error)
                     {
                     }
                  }
               }
               break;
            case PDWBridge.SCENE_ISLAND:
               if(campaignData.data && Boolean(campaignData.data.hasOwnProperty("yumeshima")) && PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
               {
                  trace("PDW_ISLAND_CAMPAIN LOAD");
                  _loc9_ = "pdw_island_campaign" + PDWHomeData.campaignId;
                  _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw[_loc9_].toString() : "";
                  _loc4_.load(new URLRequest(_loc3_ + _loc9_ + ".swf" + _loc5_ + _loc6_));
               }
               else
               {
                  trace("PDW_ISLAND LOAD");
                  _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_island.toString() : "";
                  _loc4_.load(new URLRequest(_loc3_ + "pdw_island.swf" + _loc5_ + _loc6_));
               }
               break;
            case PDWBridge.SCENE_WORLD_CAMPAIGN:
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_world_ca.toString() : "";
               _loc4_.load(new URLRequest(_loc3_ + "pdw_world_ca.swf" + _loc5_ + _loc6_));
               this.header.checkCampaign();
               break;
            case PDWBridge.SCENE_HOME_CAMPAIGN:
               PDWHomeData.isCampaign = true;
               _loc6_ = !PDWBridge.isLocal ? "&ver=" + VersionManager.xml.pdw.pdw_home.toString() : "";
               _loc7_ = _loc3_ + "pdw_home.swf" + _loc5_ + _loc6_;
               _loc4_.load(new URLRequest(_loc7_));
               this.header.checkCampaign();
         }
         this._scene = param1;
         this._loader = _loc4_;
      }
      
      private function loadWorldCampaign() : void
      {
         this.loadCampaignIslandList();
      }
      
      private function loadCampaignIslandList() : void
      {
         var _loc1_:Connection = new Connection();
         _loc1_.addEventListener(Event.COMPLETE,this.loadCampaignIslandListCompleteHandler);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.loadCampaignIslandListIOErrorHandler);
         _loc1_.open(PDWURL.PDW_CAMPAIGN_ISLAND_LIST,"GET");
      }
      
      private function loadCampaignIslandListIOErrorHandler(param1:IOErrorEvent) : void
      {
         if(this._bmp)
         {
            this._capturemc.removeChild(this._bmp);
            this._bmp.bitmapData.dispose();
            this._bmp = null;
         }
         PDWBridge.showConnecting(false);
         var _loc2_:Connection = Connection(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadCampaignIslandListCompleteHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.loadCampaignIslandListIOErrorHandler);
      }
      
      private function loadCampaignIslandListCompleteHandler(param1:Event) : void
      {
         var data:Object;
         var l:uint;
         var dialog:IDialog = null;
         var bmd:BitmapData = null;
         var event:Event = param1;
         var connection:Connection = Connection(event.currentTarget);
         connection.removeEventListener(Event.COMPLETE,this.loadCampaignIslandListCompleteHandler);
         connection.removeEventListener(IOErrorEvent.IO_ERROR,this.loadCampaignIslandListIOErrorHandler);
         data = com.adobe.serialization.json.JSON.decode(connection.data.toString());
         l = 0;
         if(data.campaign_island_list != "" && data.campaign_island_list != undefined && data.campaign_island_list != null)
         {
            l = uint(data.campaign_island_list.length);
         }
         if(this._bmp)
         {
            this._capturemc.removeChild(this._bmp);
            this._bmp.bitmapData.dispose();
            this._bmp = null;
         }
         PDWHomeData.isCampaign = false;
         if(l > 0)
         {
            trace("set campaign list length=" + l);
            PDWBridge.campaignIslandList = data;
            PDWHomeData.campaignName = "";
            this.changeScene(PDWBridge.SCENE_WORLD_CAMPAIGN,true);
         }
         else
         {
            trace("no campaing list");
            PDWBridge.campaignIslandList = [];
            PDWHomeData.campaignName = "";
            PDWBridge.loadingPercentage = 100;
            PDWBridge.showLoading(false);
            if(!this._bmp)
            {
               bmd = new BitmapData(1003,557,false,4294967295);
               bmd.draw(this._loader.content);
               this._bmp = new Bitmap(bmd,"never",false);
            }
            this._bmp.alpha = 0;
            this._bmp.filters = [new BlurFilter(8,8,2)];
            Tweener.addTween(this._bmp,{
               "time":0.4,
               "transition":"easeNone",
               "alpha":1,
               "onComplete":function():void
               {
                  _loader.content.visible = false;
               }
            });
            this._capturemc.addChild(this._bmp);
            setChildIndex(this._capturemc,numChildren - 1);
            dialog = new AssetDialogNoCampaign();
            PDWBridge.addEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
            addChild(dialog as DisplayObject);
         }
      }
      
      public function backToHome() : void
      {
         switch(this._scene)
         {
            case PDWBridge.SCENE_ISLAND:
               this.changeScene(PDWBridge.SCENE_HOME);
         }
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         PDWBridge.loadingPercentage = int(param1.bytesLoaded / param1.bytesTotal * 100);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         trace("ioErrorHandler " + param1.text);
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         var _loc3_:IDialog = new AssetDialogRetry();
         PDWBridge.addEventListener(PDWBridgeEvent.DIALOG_CLOSE,this.dialogCloseHandler);
         addChild(_loc3_ as DisplayObject);
         PDWBridge.showLoading(false);
      }
      
      private function loadCompleteHandler(param1:Event) : void
      {
         var loaderInfo:LoaderInfo;
         var loader:Loader;
         var event:Event = param1;
         trace("loadCompleteHandler ");
         loaderInfo = LoaderInfo(event.currentTarget);
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         loaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         PDWBridge.loadingPercentage = 100;
         PDWBridge.showLoading(false);
         if(this._loadbmp)
         {
            Tweener.addTween(this._loadbmp,{
               "time":0.4,
               "transition":"easeNone",
               "alpha":0,
               "onComplete":function():void
               {
                  removeChild(this);
                  _loadbmp.bitmapData.dispose();
                  _loadbmp = null;
               }
            });
         }
         loader = loaderInfo.loader;
         addChildAt(loader.content,0);
         if(this._bmp)
         {
            loader.content.visible = false;
         }
         else
         {
            loader.content.visible = true;
         }
      }
   }
}

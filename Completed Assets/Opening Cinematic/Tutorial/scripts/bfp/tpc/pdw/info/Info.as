package bfp.tpc.pdw.info
{
   import adobe.utils.*;
   import bfp.PDWBridge;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.tpc.pdw.common.*;
   import caurina.transitions.Tweener;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import jp.feb19.display.CircleSlicePreloader;
   import jp.feb19.utils.ButtonUtilities;
   import jp.feb19.utils.ColorUtilities;
   
   public class Info extends Sprite
   {
      
      private static const PRODUCT:String = "product";
      
      private static const TRIAL:String = "trial";
       
      
      public var closeButton:MovieClip;
      
      public var bgmc:MovieClip;
      
      public var urlButton:MovieClip;
      
      private var _urlLoader:URLLoader;
      
      private var _preloader:CircleSlicePreloader;
      
      private var _loader:*;
      
      private var _click_url:*;
      
      private var _click_target:*;
      
      public function Info()
      {
         super();
         this.tabEnabled = false;
         this.tabChildren = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         this.x = 181;
         this.y = -484;
      }
      
      public function release() : void
      {
      }
      
      public function checkCampaignBoardUrl() : Boolean
      {
         var ret:Boolean = false;
         var wk:String = "";
         if(PokemonBridge.rom_id == 20 || PokemonBridge.rom_id == 21)
         {
            wk = String(campaignData.data.home.board.(@type == PRODUCT).@url);
         }
         else
         {
            wk = String(campaignData.data.home.board.(@type == TRIAL).@url);
         }
         if(wk == null || wk == "")
         {
            ret = false;
         }
         else
         {
            ret = true;
         }
         trace("checkCampaignBoardUrl " + wk + " " + ret);
         return ret;
      }
      
      public function checkCampaignBoardImage() : Boolean
      {
         var ret:Boolean = false;
         var wk:String = "";
         if(PokemonBridge.rom_id == 20 || PokemonBridge.rom_id == 21)
         {
            wk = String(campaignData.data.home.board.(@type == PRODUCT).@image);
         }
         else
         {
            wk = String(campaignData.data.home.board.(@type == TRIAL).@image);
         }
         if(wk == null || wk == "")
         {
            ret = false;
         }
         else
         {
            ret = true;
         }
         trace("checkCampaignBoardImage " + wk + " " + ret);
         return ret;
      }
      
      public function visit(param1:Number = 0) : void
      {
         trace("visit ----------->>>>>>>>>>>>>>>>>");
         Tweener.addTween(this,{
            "delay":param1,
            "time":0.6,
            "y":0,
            "transition":"easeOutExpo"
         });
         var _loc2_:Boolean = this.checkCampaignBoardUrl();
         trace("############ info visit " + _loc2_);
         if(!_loc2_)
         {
            this.urlButton.visible = false;
            this.closeButton.x = 255;
         }
         else
         {
            this.urlButton.visible = true;
            this.closeButton.x = 185;
            FontManager.setTextID(this.urlButton.tf,"h_ca_12");
            ButtonUtilities.setBtn(this.urlButton,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
         }
         FontManager.setTextID(this.closeButton.tf,"dialog_36");
         ButtonUtilities.setBtn(this.closeButton,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.loadPage();
      }
      
      public function away() : void
      {
         ButtonUtilities.unsetBtn(this.urlButton,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.closeButton,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         dispatchEvent(new Event("willInfoClose"));
         Tweener.addTween(this,{
            "time":0.3,
            "y":-484,
            "transition":"easeInQuad",
            "onComplete":function():*
            {
               if(_loader)
               {
                  removeChild(_loader);
               }
               _loader = null;
               dispatchEvent(new Event(Event.CLOSE));
            }
         });
      }
      
      public function loadPage(param1:uint = 0) : void
      {
         var path:*;
         var pageId:uint = param1;
         this._preloader = new CircleSlicePreloader();
         addChild(this._preloader);
         this._preloader.x = 352;
         this._preloader.y = 270;
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         path = this.root.loaderInfo.url.substr(0,this.root.loaderInfo.url.lastIndexOf("/"));
         this._click_url = "";
         this._click_target = "_blank";
         if(PokemonBridge.rom_id == 20 || PokemonBridge.rom_id == 21)
         {
            path += "/" + PokemonBridge.lang + "/spimg/" + campaignData.data.home.board.(@type == PRODUCT).@image;
            this._click_url = campaignData.data.home.board.(@type == PRODUCT).@url;
            this._click_target = campaignData.data.home.board.(@type == PRODUCT).@target;
         }
         else
         {
            path += "/" + PokemonBridge.lang + "/spimg/" + campaignData.data.home.board.(@type == TRIAL).@image;
            this._click_url = campaignData.data.home.board.(@type == TRIAL).@url;
            this._click_target = campaignData.data.home.board.(@type == TRIAL).@target;
         }
         trace("PokemonBridge.rom_id=" + PokemonBridge.rom_id);
         trace("path=" + path);
         this._loader.load(new URLRequest(path));
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         if(this._preloader)
         {
            this._preloader.destroy();
            removeChild(this._preloader);
            this._preloader = null;
         }
         if(this._loader && Boolean(this._loader.contentLoaderInfo))
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         }
         var _loc2_:String = FontManager.getIdText("dialog_2");
         PDWBridge.dialogError(_loc2_,PDWBridge.DIALOG_ERROR_NONE);
         this._loader = null;
      }
      
      private function loadCompleteHandler(param1:Event) : void
      {
         if(this._preloader)
         {
            this._preloader.destroy();
            removeChild(this._preloader);
            this._preloader = null;
         }
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         addChild(this._loader);
         this._loader.x = 30;
         this._loader.y = 62;
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "urlButton":
               ColorUtilities.paint(this.urlButton.bgmc,PDWBridge.ROLLOVER_COLOR);
               break;
            case "closeButton":
               ColorUtilities.paint(this.closeButton.bgmc,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "urlButton":
               ColorUtilities.reset(this.urlButton.bgmc);
               break;
            case "closeButton":
               ColorUtilities.reset(this.closeButton.bgmc);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = undefined;
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "urlButton":
               ColorUtilities.reset(this.urlButton.bgmc);
               _loc3_ = new URLRequest(this._click_url);
               navigateToURL(_loc3_,this._click_target);
               break;
            case "closeButton":
               ColorUtilities.reset(this.closeButton.bgmc);
               this.away();
         }
      }
   }
}

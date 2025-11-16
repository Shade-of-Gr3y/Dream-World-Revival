package bfp.tpc.pdw.movieplayer
{
   import adobe.utils.*;
   import bfp.*;
   import bfp.common.*;
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
   import jp.feb19.utils.*;
   
   public class MoviePlayer extends MovieClip
   {
       
      
      public var b_pp:MovieClip;
      
      public var return_btn:MovieClip;
      
      public var b_rep:MovieClip;
      
      public var videomain:MovieClip;
      
      public var bannerarea:MovieClip;
      
      public var slider:MovieClip;
      
      private var moviecontroller_ob:*;
      
      private var _bannerLoader:*;
      
      public function MoviePlayer()
      {
         super();
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
         this.x = 182;
         this.y = -523;
         this.visible = false;
         FontManager.setTextID(this.return_btn.label,"dialog_36");
      }
      
      public function release() : void
      {
      }
      
      public function visit(param1:Number = 0) : void
      {
         this.visible = true;
         Tweener.addTween(this,{
            "delay":param1,
            "time":0.6,
            "y":7,
            "transition":"easeOutExpo",
            "onComplete":this.start
         });
      }
      
      public function setData(param1:*, param2:*, param3:String = "") : *
      {
         this.moviecontroller_ob = new MovieController(this);
         this.moviecontroller_ob.base_rtmp = param1;
         this.moviecontroller_ob.flvlist = param2;
         this.loadBanner();
      }
      
      public function start() : *
      {
         this.moviecontroller_ob.start();
         this.moviecontroller_ob.addEventListener("onComplete",this.onComplete);
         this.moviecontroller_ob.addEventListener("onStart",this.onStart);
         this.setButtonEvent();
      }
      
      private function loadBanner() : void
      {
         this._bannerLoader = new Loader();
         var _loc1_:* = this.root.loaderInfo.url.substr(0,this.root.loaderInfo.url.lastIndexOf("/"));
         _loc1_ += "/" + PokemonBridge.lang + "/spimg/" + campaignData.data.home.movieplayer.banner.@file;
         var _loc2_:* = new URLRequest(_loc1_);
         trace("loadBanner =" + _loc1_);
         this._bannerLoader.load(_loc2_);
         this.bannerarea.addChild(this._bannerLoader);
      }
      
      private function setButtonEvent() : void
      {
         this.return_btn.addEventListener(MouseEvent.CLICK,this.returnButtonClickHandler);
         this.return_btn.addEventListener(MouseEvent.MOUSE_OVER,this.returnButtonOverHandler);
         this.return_btn.addEventListener(MouseEvent.MOUSE_OUT,this.returnButtonOutHandler);
         this.return_btn.mouseEnabled = true;
         this.return_btn.mouseChildren = false;
         this.return_btn.buttonMode = true;
      }
      
      private function removeButtonEvent() : void
      {
         this.return_btn.removeEventListener(MouseEvent.CLICK,this.returnButtonClickHandler);
         this.return_btn.removeEventListener(MouseEvent.MOUSE_OVER,this.returnButtonOverHandler);
         this.return_btn.removeEventListener(MouseEvent.MOUSE_OUT,this.returnButtonOutHandler);
         this.return_btn.mouseEnabled = false;
         this.return_btn.mouseChildren = false;
         this.return_btn.buttonMode = false;
      }
      
      private function returnButtonOverHandler(param1:Event) : void
      {
         var _loc2_:* = param1.currentTarget;
         ColorUtilities.paint(_loc2_.bg,PDWBridge.ROLLOVER_COLOR);
         PDWBridge.sfxMouseOver();
      }
      
      private function returnButtonOutHandler(param1:Event) : void
      {
         var _loc2_:* = param1.currentTarget;
         ColorUtilities.reset(_loc2_.bg);
      }
      
      private function returnButtonClickHandler(param1:Event) : void
      {
         var _loc2_:* = param1.currentTarget;
         ColorUtilities.reset(_loc2_.bg);
         PDWBridge.sfxClick();
         this.close();
      }
      
      public function onStart(param1:Event) : void
      {
         PDWBridge.changeBGMVolume(0,1);
      }
      
      public function onComplete(param1:Event) : void
      {
         PDWBridge.changeBGMVolume(1,1);
      }
      
      public function close() : *
      {
         this.moviecontroller_ob.close_streaming_all();
         this.removeButtonEvent();
         this.away();
         PDWBridge.changeBGMVolume(1,1);
      }
      
      private function removeAll() : void
      {
         if(this._bannerLoader)
         {
            this.bannerarea.removeChild(this._bannerLoader);
            this._bannerLoader = null;
         }
      }
      
      public function away() : void
      {
         dispatchEvent(new Event("willMoviePanelClose"));
         Tweener.addTween(this,{
            "time":0.3,
            "y":-523,
            "transition":"easeInQuad",
            "onComplete":function():*
            {
               removeAll();
               this.visible = false;
               dispatchEvent(new Event(Event.CLOSE));
            }
         });
      }
   }
}

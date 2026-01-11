package bfp.tpc.pdw.movieplayer
{
   import adobe.utils.*;
   import bfp.*;
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
   
   public class MovieController extends EventDispatcher
   {
       
      
      private var basemc:MovieClip;
      
      private var mainmc:*;
      
      private var video_mc:*;
      
      private var slider_mc:*;
      
      private var slider_btn:MovieClip;
      
      private var playPause_btn:MovieClip;
      
      private var replay_btn:MovieClip;
      
      private var t_duration:*;
      
      private var fms_ob:*;
      
      public var flvlist:*;
      
      public var base_rtmp:* = "";
      
      public function MovieController(param1:*)
      {
         this.flvlist = [""];
         super();
         this.mainmc = this.basemc = param1;
         this.fms_ob = new fms();
         this.init();
      }
      
      public function start_flv(param1:*) : *
      {
         this.fms_ob.close();
         this.fms_ob.clear();
      }
      
      private function init() : *
      {
         this.video_mc = this.mainmc.videomain;
         this.slider_mc = this.mainmc.slider;
         this.slider_btn = this.slider_mc.btn;
         this.slider_btn.mouseEnabled = false;
         this.playPause_btn = this.mainmc.b_pp;
         this.replay_btn = this.mainmc.b_rep;
      }
      
      internal function start() : *
      {
         this.video_mc.myvideo.visible = false;
         this.start_sub();
      }
      
      internal function start_sub() : *
      {
         this.video_mc.addEventListener(Event.REMOVED,this.close_streaming_all);
         this.video_mc.addEventListener(Event.REMOVED_FROM_STAGE,this.close_streaming_all);
         this.fms_ob.init(this.video_mc);
         this.set_slider();
         this.set_fms_button();
         this.fms_ob.addEventListener("onMetaData",this.onMetaData);
         this.fms_ob.addEventListener("onComplete",this.onComplete);
         this.fms_ob.addEventListener("onStart",this.onStart);
         this.fms_ob.addEventListener("onFailed",this.onFailed);
         this.t_duration = undefined;
         var _loc1_:* = 0;
         this.fms_ob.start(this.base_rtmp,this.flvlist,_loc1_);
      }
      
      internal function set_fms_button() : *
      {
         this.playPause_btn.addEventListener(MouseEvent.CLICK,this.playPauseClickHandler);
         this.playPause_btn.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOverHandler);
         this.playPause_btn.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOutHandler);
         this.playPause_btn.mouseEnabled = true;
         this.playPause_btn.mouseChildren = false;
         this.playPause_btn.buttonMode = true;
         this.replay_btn.addEventListener(MouseEvent.CLICK,this.replayClickHandler);
         this.replay_btn.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOverHandler);
         this.replay_btn.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOutHandler);
         this.replay_btn.mouseEnabled = true;
         this.replay_btn.mouseChildren = false;
         this.replay_btn.buttonMode = true;
      }
      
      internal function fms_prev(param1:*) : *
      {
         if(this.fms_ob.playing_flag == false)
         {
            this.playPauseClickHandler(null);
         }
         else
         {
            this.fms_ob.seek(0);
         }
      }
      
      internal function fms_next(param1:*) : *
      {
         this.fms_ob.seek(this.fms_ob.du);
      }
      
      internal function playPauseClickHandler(param1:*) : *
      {
         if(this.playPause_btn.currentFrame == 1)
         {
            this.fms_ob.pause();
            this.playPause_btn.gotoAndStop(2);
         }
         else
         {
            this.fms_ob.restart();
            this.playPause_btn.gotoAndStop(1);
         }
         PDWBridge.sfxClick();
      }
      
      private function replayClickHandler(param1:Event) : void
      {
         PDWBridge.sfxClick();
         this.replay();
      }
      
      private function replay() : void
      {
         this.fms_ob.seek(0);
      }
      
      internal function buttonOverHandler(param1:*) : *
      {
         var _loc2_:* = param1.currentTarget;
         ColorUtilities.paint(_loc2_.bg,PDWBridge.ROLLOVER_COLOR);
         PDWBridge.sfxMouseOver();
      }
      
      internal function buttonOutHandler(param1:*) : *
      {
         var _loc2_:* = param1.currentTarget;
         ColorUtilities.reset(_loc2_.bg);
      }
      
      internal function fms_close(param1:*) : *
      {
         var _loc2_:* = this.fms_ob.close();
         if(_loc2_)
         {
            this.close_streaming();
         }
      }
      
      internal function onMetaData(param1:*) : *
      {
         this.t_duration = this.fms_ob.du;
         dispatchEvent(new Event("onMetaData"));
      }
      
      internal function onStart(param1:*) : *
      {
         this.removeReplayScreenButton();
         this.video_mc.myvideo.visible = true;
         dispatchEvent(new Event("onStart"));
      }
      
      internal function onComplete(param1:*) : *
      {
         this.setReplayScreenButton();
         this.fms_close(null);
         this.playPause_btn.gotoAndStop(2);
         dispatchEvent(new Event("onComplete"));
      }
      
      internal function onFailed(param1:*) : *
      {
         this.close_streaming();
      }
      
      internal function set_slider() : *
      {
         this.slider_mc.addEventListener(Event.ENTER_FRAME,this.sld_onEnterFrame);
         this.slider_mc.barbg.addEventListener(MouseEvent.CLICK,this.sld_onRelease);
         this.slider_mc.barbg.buttonMode = true;
         this.slider_mc.flag = false;
      }
      
      private function sld_onEnterFrame(param1:*) : *
      {
         var _loc2_:* = undefined;
         if(this.slider_mc.flag == false)
         {
            _loc2_ = this.fms_ob.get_percent();
            if(_loc2_ < 0 || isNaN(_loc2_))
            {
               _loc2_ = 0;
            }
            if(_loc2_ > 1)
            {
               _loc2_ = 1;
            }
            this.slider_btn.x = this.slider_mc.barbg.width * _loc2_ - 5;
         }
      }
      
      private function sld_onRelease(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(Boolean(this.slider_mc.hasEventListener(Event.ENTER_FRAME)) && this.t_duration != undefined)
         {
            _loc2_ = this.slider_mc.barbg.width;
            _loc3_ = this.slider_mc.mouseX;
            if((_loc4_ = _loc3_ / _loc2_) < 0)
            {
               _loc4_ = 0;
            }
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
            this.slider_btn.x = _loc2_ * _loc4_;
            this.fms_ob.seek(this.t_duration * _loc4_);
         }
      }
      
      private function setReplayScreenButton() : void
      {
         this.video_mc.replay_button.visible = true;
         this.video_mc.addEventListener(MouseEvent.CLICK,this.replayScreenButtonClickHandler);
         this.video_mc.buttonMode = true;
      }
      
      private function removeReplayScreenButton() : void
      {
         this.video_mc.replay_button.visible = false;
         this.video_mc.removeEventListener(MouseEvent.CLICK,this.replayScreenButtonClickHandler);
         this.video_mc.buttonMode = false;
      }
      
      private function replayScreenButtonClickHandler(param1:Event) : void
      {
         this.fms_ob.restart();
         this.playPause_btn.gotoAndStop(1);
      }
      
      public function close_streaming() : *
      {
         trace("close_streaming");
         this.fms_ob.clear();
         this.fms_close(null);
         this.playPause_btn.gotoAndStop(1);
      }
      
      public function close_streaming_all(param1:Event = null) : *
      {
         this.fms_ob.clear();
         this.fms_close(null);
         this.playPause_btn.gotoAndStop(1);
         this.removeReplayScreenButton();
         this.removeAllEvent();
         this.video_mc.myvideo.visible = false;
         this.slider_btn.x = -5;
         trace("close_streaming_all");
      }
      
      private function removeAllEvent() : void
      {
         trace("removeAllEvent");
         if(this.fms_ob)
         {
            this.fms_ob.removeEventListener("onMetaData",this.onMetaData);
            this.fms_ob.removeEventListener("onComplete",this.onComplete);
            this.fms_ob.removeEventListener("onStart",this.onStart);
            this.fms_ob.removeEventListener("onFailed",this.onFailed);
            this.fms_ob = null;
         }
         this.playPause_btn.removeEventListener(MouseEvent.CLICK,this.playPauseClickHandler);
         this.playPause_btn.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOverHandler);
         this.playPause_btn.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOutHandler);
         this.replay_btn.removeEventListener(MouseEvent.CLICK,this.replayClickHandler);
         this.replay_btn.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOverHandler);
         this.replay_btn.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOutHandler);
         this.slider_mc.removeEventListener(Event.ENTER_FRAME,this.sld_onEnterFrame);
         this.slider_mc.barbg.removeEventListener(MouseEvent.CLICK,this.sld_onRelease);
      }
   }
}

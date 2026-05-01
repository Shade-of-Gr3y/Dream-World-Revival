package org.libspark.betweenas3.tweens
{
   import flash.events.IEventDispatcher;
   
   public interface ITween extends IEventDispatcher
   {
      
      function get duration() : Number;
      
      function get position() : Number;
      
      function get isPlaying() : Boolean;
      
      function get stopOnComplete() : Boolean;
      
      function set stopOnComplete(param1:Boolean) : void;
      
      function get onPlay() : Function;
      
      function set onPlay(param1:Function) : void;
      
      function get onPlayParams() : Array;
      
      function set onPlayParams(param1:Array) : void;
      
      function get onStop() : Function;
      
      function set onStop(param1:Function) : void;
      
      function get onStopParams() : Array;
      
      function set onStopParams(param1:Array) : void;
      
      function get onUpdate() : Function;
      
      function set onUpdate(param1:Function) : void;
      
      function get onUpdateParams() : Array;
      
      function set onUpdateParams(param1:Array) : void;
      
      function get onComplete() : Function;
      
      function set onComplete(param1:Function) : void;
      
      function get onCompleteParams() : Array;
      
      function set onCompleteParams(param1:Array) : void;
      
      function play() : void;
      
      function stop() : void;
      
      function togglePause() : void;
      
      function gotoAndPlay(param1:Number) : void;
      
      function gotoAndStop(param1:Number) : void;
      
      function clone() : ITween;
   }
}


package core.util
{
   import caurina.transitions.Tweener;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SoundData extends EventDispatcher
   {
      
      public static const COMPLETE:String = "COMPLETE";
      
      private var _ch:SoundChannel;
      
      private var _name:String;
      
      private var _st:SoundTransform;
      
      private var _sound:Sound;
      
      private var _volume:Number;
      
      public function SoundData(param1:Class, param2:String)
      {
         super();
         this._name = param2;
         this._volume = 1;
         this._sound = new param1();
         this._ch = this._sound.play(0,1,new SoundTransform(0,0));
         this._st = new SoundTransform(this._volume,0);
      }
      
      public function setChange(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this._volume = param1;
         var _loc5_:SoundUtility = new SoundUtility(this._ch);
         Tweener.addTween(_loc5_,{
            "volume":this._volume * param1,
            "time":param3,
            "delay":param4,
            "transition":"linear"
         });
      }
      
      public function playSE() : void
      {
         this._ch = this._sound.play(0,1,this._st);
         this._ch.addEventListener(Event.SOUND_COMPLETE,this.completeHandler);
      }
      
      public function clear() : void
      {
         this._ch.removeEventListener(Event.SOUND_COMPLETE,this.completeHandler);
         this._ch.stop();
         this._ch = null;
         this._name = null;
         this._sound = null;
         this._st = null;
         this._volume = NaN;
      }
      
      public function volumeChange(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:SoundUtility = new SoundUtility(this._ch);
         Tweener.addTween(_loc5_,{
            "volume":this._volume * param1,
            "time":param3,
            "delay":param4,
            "transition":"linear"
         });
      }
      
      private function completeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(COMPLETE));
      }
      
      public function playBGM() : void
      {
         this._ch = this._sound.play(0,9999999,this._st);
         this._ch.addEventListener(Event.SOUND_COMPLETE,this.completeHandler);
      }
   }
}


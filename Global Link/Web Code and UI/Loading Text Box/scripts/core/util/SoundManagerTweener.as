package core.util
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SoundManagerTweener extends EventDispatcher
   {
      
      private var _bgm:Array;
      
      private var _se:Array;
      
      public function SoundManagerTweener()
      {
         super();
         this._bgm = new Array();
         this._se = new Array();
      }
      
      public function returnSWF() : void
      {
         var _loc5_:* = undefined;
         var _loc6_:SoundData = null;
         var _loc1_:Number = 1;
         var _loc2_:Number = 0;
         var _loc3_:Number = 2;
         var _loc4_:Number = 0;
         for(_loc5_ in this._bgm)
         {
            _loc6_ = SoundData(this._bgm[_loc5_]);
            _loc6_.volumeChange(_loc1_,_loc2_,_loc3_,_loc4_);
         }
      }
      
      public function jumpSWF() : void
      {
         var _loc5_:* = undefined;
         var _loc6_:SoundData = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 2;
         var _loc4_:Number = 0;
         for(_loc5_ in this._bgm)
         {
            _loc6_ = SoundData(this._bgm[_loc5_]);
            _loc6_.volumeChange(_loc1_,_loc2_,_loc3_,_loc4_);
         }
      }
      
      public function setBGM(param1:Class, param2:String) : void
      {
         var _loc3_:SoundData = new SoundData(param1,param2);
         this._bgm.push(_loc3_);
      }
      
      private function soundHandler(param1:Event) : void
      {
         var _loc2_:SoundData = SoundData(param1.currentTarget);
         _loc2_.removeEventListener(Event.SOUND_COMPLETE,this.soundHandler);
         this.playBGM();
      }
      
      public function set volume(param1:Number) : void
      {
         this.changeVols(param1);
      }
      
      public function playSE(param1:Number) : void
      {
         var _loc2_:SoundData = SoundData(this._se[param1]);
         _loc2_.playSE();
      }
      
      public function changeVols(param1:Number = 1, param2:Number = 0) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:SoundData = null;
         var _loc3_:Number = 0.25;
         var _loc4_:Number = 0;
         for(_loc5_ in this._bgm)
         {
            _loc6_ = SoundData(this._bgm[_loc5_]);
            _loc6_.volumeChange(param1,param2,_loc3_,_loc4_);
         }
      }
      
      public function setSE(param1:Class, param2:String) : void
      {
         var _loc3_:SoundData = new SoundData(param1,param2);
         this._se.push(_loc3_);
      }
      
      public function changeSet(param1:Array, param2:Object = null) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:Number = NaN;
         var _loc9_:SoundData = null;
         var _loc3_:Number = 2;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         for(_loc6_ in param2)
         {
            if(_loc6_ == "time")
            {
               _loc3_ = Number(param2[_loc6_]);
            }
            if(_loc6_ == "delay")
            {
               _loc4_ = Number(param2[_loc6_]);
            }
         }
         for(_loc7_ in this._bgm)
         {
            _loc8_ = Number(param1[_loc7_]);
            if(_loc8_ == 0 && !param2)
            {
               _loc4_ = 2;
            }
            _loc9_ = SoundData(this._bgm[_loc7_]);
            _loc9_.setChange(_loc8_,_loc5_,_loc3_,_loc4_);
         }
      }
      
      public function get volume() : Number
      {
         return 1;
      }
      
      public function playBGM() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:SoundData = null;
         for(_loc1_ in this._bgm)
         {
            _loc2_ = SoundData(this._bgm[_loc1_]);
            _loc2_.playBGM();
         }
         _loc2_.addEventListener(Event.COMPLETE,this.soundHandler);
      }
      
      public function clear(param1:* = null) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:SoundData = null;
         var _loc5_:SoundData = null;
         for(_loc2_ in this._bgm)
         {
            _loc4_ = SoundData(this._bgm[_loc2_]);
            _loc4_.clear();
         }
         this._bgm = null;
         for(_loc3_ in this._se)
         {
            _loc5_ = SoundData(this._se[_loc3_]);
            _loc5_.clear();
         }
         this._se = null;
      }
   }
}


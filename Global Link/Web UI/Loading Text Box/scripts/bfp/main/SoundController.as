package bfp.main
{
   import bfp.common.PokemonBridge;
   import core.util.SoundManagerTweener;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   
   public class SoundController extends SoundManagerTweener
   {
      
      public const VOLUME_CHANGE:String = "VOLUME_CHANGE";
      
      private var my_so:SharedObject;
      
      public function SoundController()
      {
         super();
      }
      
      public function init(param1:Loader, param2:Boolean = false) : void
      {
         if(param2)
         {
            setBGM(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("LEAD")),"LEAD");
            setBGM(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("RHYTHM")),"RHYTHM");
         }
         setSE(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("M_OVER")),"M_OVER");
         setSE(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("M_CLICK")),"M_CLICK");
         setSE(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("M_DRAG")),"M_DRAG");
         setSE(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("M_DROP")),"M_DROP");
         setSE(Class(param1.contentLoaderInfo.applicationDomain.getDefinition("SE_ALERT")),"SE_ALERT");
         PokemonBridge.addEventListener(PokemonBridge.MOUSE_CLICK_SOUND,this.seHandler);
         PokemonBridge.addEventListener(PokemonBridge.MOUSE_OVER_SOUND,this.seHandler);
         PokemonBridge.addEventListener(PokemonBridge.MOUSE_DRAG_SOUND,this.seHandler);
         PokemonBridge.addEventListener(PokemonBridge.MOUSE_DROP_SOUND,this.seHandler);
         PokemonBridge.addEventListener(PokemonBridge.SE_ALERT_SOUND,this.seHandler);
         PokemonBridge.addEventListener(PokemonBridge.SOUND_FADEIN,this.volumeHandler);
         PokemonBridge.addEventListener(PokemonBridge.SOUND_FADEOUT,this.volumeHandler);
         ExternalInterface.addCallback("sendVolume",this.receivedFromJavaScript);
         this.my_so = SharedObject.getLocal("defaultVolume","/");
         var _loc3_:Number = Number(this.my_so.data.defaultVolume);
         if(isNaN(_loc3_))
         {
            _loc3_ = 100;
         }
         this.receivedFromJavaScript(_loc3_);
      }
      
      private function volumeHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case PokemonBridge.SOUND_FADEIN:
               changeSet([1,1],{
                  "time":0.5,
                  "delay":0
               });
               break;
            case PokemonBridge.SOUND_FADEOUT:
               changeSet([0,0],{
                  "time":0.5,
                  "delay":0
               });
         }
      }
      
      private function seHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case PokemonBridge.MOUSE_OVER_SOUND:
               playSE(0);
               break;
            case PokemonBridge.MOUSE_CLICK_SOUND:
               playSE(1);
               break;
            case PokemonBridge.MOUSE_DRAG_SOUND:
               playSE(2);
               break;
            case PokemonBridge.MOUSE_DROP_SOUND:
               playSE(3);
               break;
            case PokemonBridge.SE_ALERT_SOUND:
               playSE(4);
         }
      }
      
      private function receivedFromJavaScript(param1:*) : void
      {
         var _loc2_:SoundTransform = SoundMixer.soundTransform;
         _loc2_.volume = param1 / 100;
         SoundMixer.soundTransform = _loc2_;
      }
      
      override public function clear(param1:* = null) : void
      {
         PokemonBridge.removeEventListener(PokemonBridge.MOUSE_CLICK_SOUND,this.seHandler);
         PokemonBridge.removeEventListener(PokemonBridge.MOUSE_OVER_SOUND,this.seHandler);
         PokemonBridge.removeEventListener(PokemonBridge.MOUSE_DRAG_SOUND,this.seHandler);
         PokemonBridge.removeEventListener(PokemonBridge.MOUSE_DROP_SOUND,this.seHandler);
         PokemonBridge.removeEventListener(PokemonBridge.SE_ALERT_SOUND,this.seHandler);
         PokemonBridge.removeEventListener(PokemonBridge.SOUND_FADEIN,this.volumeHandler);
         PokemonBridge.removeEventListener(PokemonBridge.SOUND_FADEOUT,this.volumeHandler);
         super.clear();
      }
   }
}


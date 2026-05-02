package bfp.pdw.farm.objects
{
   import bfp.common.PokemonBridge;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import caurina.transitions.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class DigdaArea extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var digdaObj:*;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function DigdaArea(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.alpha = 0;
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.targetMC);
         if(this.data.digdaLoader != null)
         {
            if(this.targetMC.contains(this.data.digdaLoader))
            {
               this.targetMC.removeChild(this.data.digdaLoader);
            }
         }
      }
      
      public function run() : *
      {
      }
      
      public function show(param1:* = 0) : *
      {
         this.addDigda();
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.2,
            "transition":"linear",
            "_autoAlpha":1,
            "onComplete":this.showEnd
         });
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideEnd
         });
      }
      
      private function hideEnd() : *
      {
         this.removeDigda();
         this.stop();
         this.reset();
      }
      
      private function addDigda() : *
      {
         this.digdaObj = PokemonBridge.createRenderer();
         if(this.digdaObj)
         {
            this.digdaObj.addEventListener(Event.COMPLETE,this.onDigdaLoadComplete);
            this.digdaObj.addEventListener(IOErrorEvent.IO_ERROR,this.onDigdaLoadIOError);
            this.digdaObj.load(50,0);
            this.digdaObj.display.buttonMode = true;
            this.targetMC.addChild(this.digdaObj.display);
            this.digdaObj.animator.play();
         }
      }
      
      private function onDigdaLoadComplete(param1:Event) : *
      {
         this.digdaObj.removeEventListener(Event.COMPLETE,this.onDigdaLoadComplete);
         this.digdaObj.removeEventListener(IOErrorEvent.IO_ERROR,this.onDigdaLoadIOError);
         var _loc2_:Sprite = Sprite(this.digdaObj.display);
         _loc2_.tabChildren = false;
         _loc2_.tabEnabled = false;
      }
      
      private function onDigdaLoadIOError(param1:Event) : *
      {
      }
      
      private function removeDigda() : *
      {
         if(this.digdaObj)
         {
            if(this.targetMC.contains(this.digdaObj.display))
            {
               this.targetMC.removeChild(this.digdaObj.display);
            }
         }
      }
   }
}


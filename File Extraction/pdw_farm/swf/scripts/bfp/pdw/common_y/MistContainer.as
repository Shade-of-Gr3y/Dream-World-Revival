package bfp.pdw.common_y
{
   import bfp.PDWBridge;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   
   public class MistContainer extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var bmd:BitmapData;
      
      private var bm:Bitmap;
      
      public function MistContainer(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.targetMC.mouseChildren = false;
         this.targetMC.mouseEnabled = false;
         this.bm = new Bitmap();
      }
      
      public function reset() : *
      {
         if(this.targetMC.contains(this.bm))
         {
            this.targetMC.removeChild(this.bm);
         }
         if(this.bmd != null)
         {
            this.bmd.dispose();
            this.bmd = null;
         }
      }
      
      public function stop() : *
      {
      }
      
      public function run() : *
      {
         if(this.bmd != null)
         {
            this.bmd.dispose();
            this.bmd = null;
         }
         this.bmd = PDWBridge.mistBitmapData.clone();
         this.bm.bitmapData = this.bmd;
         this.targetMC.addChild(this.bm);
      }
   }
}


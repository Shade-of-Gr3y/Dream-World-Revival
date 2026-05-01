package
{
   import adobe.utils.*;
   import as3.hivelocity.flight.events.flightEvent;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol365")]
   public dynamic class flightEnergy extends MovieClip
   {
      
      public var energyDF_mc:MovieClip;
      
      public var mm:MovieClip;
      
      public var energyHitArea_mc:MovieClip;
      
      public var coins:MovieClip;
      
      public function flightEnergy()
      {
         super();
         addFrameScript(0,this.frame1,6,this.frame7,20,this.frame21);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame7() : *
      {
         this.coins.coin.gotoAndPlay("lot");
         this.mm.gotoAndPlay("_hit");
      }
      
      internal function frame21() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.ENERGY_GET));
      }
   }
}


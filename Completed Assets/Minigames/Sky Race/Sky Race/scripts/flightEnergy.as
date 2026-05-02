package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   
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
      
      function frame1() : *
      {
         stop();
      }
      
      function frame7() : *
      {
         this.coins.coin.gotoAndPlay("lot");
         this.mm.gotoAndPlay("_hit");
      }
      
      function frame21() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.ENERGY_GET));
      }
   }
}

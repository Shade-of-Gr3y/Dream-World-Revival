package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol190")]
   public dynamic class speedup extends MovieClip
   {
      
      public var se:soundController;
      
      public function speedup()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,34,this.frame35);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("speedUp");
      }
      
      internal function frame35() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.SPEED_UP_ANIME_FIN));
      }
   }
}


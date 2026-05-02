package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class goal extends MovieClip
   {
       
      
      public var se:soundController;
      
      public function goal()
      {
         super();
         addFrameScript(0,this.frame1,33,this.frame34,84,this.frame85);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame34() : *
      {
         this.se = new soundController();
         this.se.playSound("gole");
      }
      
      function frame85() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.GOAL_ANIME_FIN));
      }
   }
}

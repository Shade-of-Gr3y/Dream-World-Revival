package game3_fla
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class _321_mc_79 extends MovieClip
   {
       
      
      public var se:soundController;
      
      public function _321_mc_79()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,31,this.frame32,61,this.frame62,89,this.frame90,90,this.frame91);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("count1");
      }
      
      function frame32() : *
      {
         this.se.playSound("count1");
      }
      
      function frame62() : *
      {
         this.se.playSound("count1");
      }
      
      function frame90() : *
      {
      }
      
      function frame91() : *
      {
         this.se.soundReset();
         dispatchEvent(new flightEvent(flightEvent.COUNT_FINISH));
      }
   }
}

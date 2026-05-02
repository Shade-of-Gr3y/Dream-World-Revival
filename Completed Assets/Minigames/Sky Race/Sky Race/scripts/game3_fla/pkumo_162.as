package game3_fla
{
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class pkumo_162 extends MovieClip
   {
       
      
      public var se:soundController;
      
      public function pkumo_162()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,29,this.frame30);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("cloud");
      }
      
      function frame30() : *
      {
         this.se = null;
         gotoAndPlay("hit");
      }
   }
}

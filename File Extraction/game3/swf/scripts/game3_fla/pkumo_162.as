package game3_fla
{
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol339")]
   public dynamic class pkumo_162 extends MovieClip
   {
      
      public var se:soundController;
      
      public function pkumo_162()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,29,this.frame30);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("cloud");
      }
      
      internal function frame30() : *
      {
         this.se = null;
         gotoAndPlay("hit");
      }
   }
}


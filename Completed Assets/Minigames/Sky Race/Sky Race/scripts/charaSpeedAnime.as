package
{
   import flash.display.MovieClip;
   
   public dynamic class charaSpeedAnime extends MovieClip
   {
       
      
      public function charaSpeedAnime()
      {
         super();
         addFrameScript(0,this.frame1,32,this.frame33,94,this.frame95);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame33() : *
      {
         gotoAndPlay("step1");
      }
      
      function frame95() : *
      {
         gotoAndPlay("step2");
      }
   }
}

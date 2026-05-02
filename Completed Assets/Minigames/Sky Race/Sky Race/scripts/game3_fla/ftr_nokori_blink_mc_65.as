package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class ftr_nokori_blink_mc_65 extends MovieClip
   {
       
      
      public function ftr_nokori_blink_mc_65()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame20() : *
      {
         gotoAndStop(1);
      }
   }
}

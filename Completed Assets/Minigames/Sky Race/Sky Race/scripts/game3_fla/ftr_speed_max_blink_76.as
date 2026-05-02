package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class ftr_speed_max_blink_76 extends MovieClip
   {
       
      
      public function ftr_speed_max_blink_76()
      {
         super();
         addFrameScript(0,this.frame1,29,this.frame30);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame30() : *
      {
         gotoAndPlay("loop");
      }
   }
}

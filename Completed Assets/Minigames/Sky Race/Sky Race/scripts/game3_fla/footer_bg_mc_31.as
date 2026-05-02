package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class footer_bg_mc_31 extends MovieClip
   {
       
      
      public function footer_bg_mc_31()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this);
      }
   }
}

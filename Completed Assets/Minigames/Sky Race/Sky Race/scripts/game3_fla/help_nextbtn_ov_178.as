package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class help_nextbtn_ov_178 extends MovieClip
   {
       
      
      public function help_nextbtn_ov_178()
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

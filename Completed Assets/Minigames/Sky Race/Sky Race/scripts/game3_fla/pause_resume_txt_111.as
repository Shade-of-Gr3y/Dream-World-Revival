package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class pause_resume_txt_111 extends MovieClip
   {
       
      
      public function pause_resume_txt_111()
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

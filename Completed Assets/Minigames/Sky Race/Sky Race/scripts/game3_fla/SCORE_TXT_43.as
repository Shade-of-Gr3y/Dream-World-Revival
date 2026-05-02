package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class SCORE_TXT_43 extends MovieClip
   {
       
      
      public function SCORE_TXT_43()
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

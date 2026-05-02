package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class goal_txt_194 extends MovieClip
   {
       
      
      public function goal_txt_194()
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

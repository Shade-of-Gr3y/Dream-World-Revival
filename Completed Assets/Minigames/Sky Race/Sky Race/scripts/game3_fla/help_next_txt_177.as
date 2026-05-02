package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class help_next_txt_177 extends MovieClip
   {
       
      
      public function help_next_txt_177()
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

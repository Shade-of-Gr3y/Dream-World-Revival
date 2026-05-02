package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class help_back_txt_174 extends MovieClip
   {
       
      
      public function help_back_txt_174()
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

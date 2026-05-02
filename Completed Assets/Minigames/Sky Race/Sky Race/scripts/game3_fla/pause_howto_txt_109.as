package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class pause_howto_txt_109 extends MovieClip
   {
       
      
      public function pause_howto_txt_109()
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

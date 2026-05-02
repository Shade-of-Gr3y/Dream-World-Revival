package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class timeup_txt_219 extends MovieClip
   {
       
      
      public function timeup_txt_219()
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

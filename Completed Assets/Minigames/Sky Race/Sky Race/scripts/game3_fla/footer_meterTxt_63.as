package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class footer_meterTxt_63 extends MovieClip
   {
       
      
      public function footer_meterTxt_63()
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

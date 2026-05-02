package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class TIME_TXT_39 extends MovieClip
   {
       
      
      public function TIME_TXT_39()
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

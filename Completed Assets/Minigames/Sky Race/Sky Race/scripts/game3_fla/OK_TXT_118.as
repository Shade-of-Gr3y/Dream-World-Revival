package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class OK_TXT_118 extends MovieClip
   {
       
      
      public function OK_TXT_118()
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

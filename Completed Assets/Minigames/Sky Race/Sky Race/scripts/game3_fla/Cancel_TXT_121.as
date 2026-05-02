package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Cancel_TXT_121 extends MovieClip
   {
       
      
      public function Cancel_TXT_121()
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

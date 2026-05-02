package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class speeddown_152 extends MovieClip
   {
       
      
      public function speeddown_152()
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

package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class ge_13 extends MovieClip
   {
       
      
      public function ge_13()
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

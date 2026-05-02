package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Timeline_192 extends MovieClip
   {
       
      
      public function Timeline_192()
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

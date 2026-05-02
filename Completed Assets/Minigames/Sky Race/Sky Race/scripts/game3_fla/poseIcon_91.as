package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class poseIcon_91 extends MovieClip
   {
       
      
      public function poseIcon_91()
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

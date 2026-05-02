package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class pause_mark_parent_100 extends MovieClip
   {
       
      
      public function pause_mark_parent_100()
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

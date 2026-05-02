package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class goal_A_15 extends MovieClip
   {
       
      
      public function goal_A_15()
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

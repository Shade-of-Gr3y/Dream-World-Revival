package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class title_3 extends MovieClip
   {
       
      
      public function title_3()
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

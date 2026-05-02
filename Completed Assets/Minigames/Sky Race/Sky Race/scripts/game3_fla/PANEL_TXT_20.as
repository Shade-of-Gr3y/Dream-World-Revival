package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class PANEL_TXT_20 extends MovieClip
   {
       
      
      public function PANEL_TXT_20()
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

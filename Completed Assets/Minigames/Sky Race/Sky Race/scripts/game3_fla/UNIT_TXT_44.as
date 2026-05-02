package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class UNIT_TXT_44 extends MovieClip
   {
       
      
      public function UNIT_TXT_44()
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

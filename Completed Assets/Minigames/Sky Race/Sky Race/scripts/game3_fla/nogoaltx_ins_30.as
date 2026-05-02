package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class nogoaltx_ins_30 extends MovieClip
   {
       
      
      public function nogoaltx_ins_30()
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

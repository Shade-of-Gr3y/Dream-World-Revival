package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class tophelpbtn_tx_ins_5 extends MovieClip
   {
       
      
      public function tophelpbtn_tx_ins_5()
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

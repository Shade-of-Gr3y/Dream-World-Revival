package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class topstartbtn_tx_ins_7 extends MovieClip
   {
       
      
      public function topstartbtn_tx_ins_7()
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

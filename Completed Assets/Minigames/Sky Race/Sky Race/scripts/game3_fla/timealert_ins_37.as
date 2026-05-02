package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class timealert_ins_37 extends MovieClip
   {
       
      
      public function timealert_ins_37()
      {
         super();
         addFrameScript(0,this.frame1,40,this.frame41);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame41() : *
      {
         gotoAndPlay("loop");
      }
   }
}

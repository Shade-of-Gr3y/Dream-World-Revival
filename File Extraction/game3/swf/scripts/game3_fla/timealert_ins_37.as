package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol639")]
   public dynamic class timealert_ins_37 extends MovieClip
   {
      
      public function timealert_ins_37()
      {
         super();
         addFrameScript(0,this.frame1,40,this.frame41);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame41() : *
      {
         gotoAndPlay("loop");
      }
   }
}


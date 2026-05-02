package pdw_opening_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol26")]
   public dynamic class red_bright_6 extends MovieClip
   {
      
      public var dest:int;
      
      public function red_bright_6()
      {
         super();
         addFrameScript(0,this.frame1,66,this.frame67);
      }
      
      internal function frame1() : *
      {
         visible = false;
         this.dest = Math.floor(Math.random() * 64) + 2;
         if(this.dest >= 51)
         {
            visible = true;
         }
         gotoAndPlay(this.dest);
      }
      
      internal function frame67() : *
      {
         if(!visible)
         {
            visible = true;
         }
         gotoAndPlay(2);
      }
   }
}


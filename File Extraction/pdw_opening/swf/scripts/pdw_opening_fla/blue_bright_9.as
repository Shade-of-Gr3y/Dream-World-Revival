package pdw_opening_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol35")]
   public dynamic class blue_bright_9 extends MovieClip
   {
      
      public var dest:int;
      
      public function blue_bright_9()
      {
         super();
         addFrameScript(0,this.frame1,67,this.frame68);
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
      
      internal function frame68() : *
      {
         if(!visible)
         {
            visible = true;
         }
         gotoAndPlay(2);
      }
   }
}


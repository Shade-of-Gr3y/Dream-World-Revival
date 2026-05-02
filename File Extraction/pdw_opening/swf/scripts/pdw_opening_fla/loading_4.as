package pdw_opening_fla
{
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol23")]
   public dynamic class loading_4 extends MovieClip
   {
      
      public var tf:TextField;
      
      public var loaded:Number;
      
      public var total:Number;
      
      public var info:LoaderInfo;
      
      public function loading_4()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function start(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.start);
         this.info = parent.loaderInfo;
         trace(this.info);
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function enterFrameHandler(param1:Event) : void
      {
         this.loaded = this.info.bytesLoaded;
         this.total = this.info.bytesTotal;
         this.tf.text = String(Math.floor(this.loaded / this.total * 100));
         if(this.loaded == this.total)
         {
            removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            visible = false;
            MovieClip(parent).play();
         }
      }
      
      internal function frame1() : *
      {
         if(stage)
         {
            this.start();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.start);
         }
      }
   }
}


package org.libspark.thread
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class EnterFrameThreadExecutor implements IThreadExecutor
   {
      
      private var _clip:MovieClip;
      
      public function EnterFrameThreadExecutor()
      {
         super();
      }
      
      public function stop() : void
      {
         if(this._clip == null)
         {
            return;
         }
         this._clip.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._clip = null;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         Thread.executeAllThreads();
      }
      
      public function start() : void
      {
         if(this._clip != null)
         {
            return;
         }
         this._clip = new MovieClip();
         this._clip.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
   }
}


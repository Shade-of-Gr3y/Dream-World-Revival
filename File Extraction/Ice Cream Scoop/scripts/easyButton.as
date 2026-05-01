package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.MouseCursor;
   
   public class easyButton
   {
      
      private var m_seMouseOver:SeMouseOver;
      
      private var m_func:Function;
      
      private var m_seCommit:SeCommit;
      
      private var m_enable:Boolean;
      
      private var m_movie:MovieClip;
      
      public function easyButton(param1:MovieClip, param2:Function)
      {
         super();
         this.m_movie = param1;
         this.m_func = param2;
         this.m_movie.mouseChildren = false;
         this.m_movie.gotoAndStop(1);
         this.m_seCommit = new SeCommit();
         this.m_seMouseOver = new SeMouseOver();
         this._addEventListener();
         this.enable(true);
         this.m_enable = true;
      }
      
      private function _clickButton(param1:MouseEvent) : void
      {
         if(this.m_enable == true)
         {
            comDefine.mouseCursor(MouseCursor.AUTO);
            this.m_seCommit.play();
            this.m_func(param1);
            this.m_movie.gotoAndStop(1);
         }
      }
      
      public function enable(param1:Boolean) : void
      {
         this.m_enable = param1;
         this.m_movie.gotoAndStop(1);
         if(this.m_enable == true)
         {
            this.m_movie.alpha = 1;
            this._addEventListener();
         }
         else
         {
            this.m_movie.alpha = 0.5;
            this._removeEventListener();
         }
      }
      
      private function _addEventListener() : void
      {
         this.m_movie.addEventListener(MouseEvent.CLICK,this._clickButton);
         this.m_movie.addEventListener(MouseEvent.MOUSE_OVER,this._onButton);
         this.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this._offButton);
      }
      
      public function release() : void
      {
         this._removeEventListener();
      }
      
      private function _offButton(param1:MouseEvent) : void
      {
         if(this.m_enable == true)
         {
            comDefine.mouseCursor(MouseCursor.AUTO);
            this.m_movie.gotoAndStop(1);
         }
      }
      
      private function _onButton(param1:MouseEvent) : void
      {
         if(this.m_enable == true)
         {
            this.m_seMouseOver.play();
            comDefine.mouseCursor(MouseCursor.BUTTON,true);
            this.m_movie.gotoAndStop(2);
         }
      }
      
      private function _removeEventListener() : void
      {
         this.m_movie.removeEventListener(MouseEvent.CLICK,this._clickButton);
         this.m_movie.removeEventListener(MouseEvent.MOUSE_OVER,this._onButton);
         this.m_movie.removeEventListener(MouseEvent.MOUSE_OUT,this._offButton);
         comDefine.mouseCursor(MouseCursor.AUTO);
      }
   }
}


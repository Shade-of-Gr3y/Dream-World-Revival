package
{
   import bfp.common.*;
   import common.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ExitDialog extends DialogBase
   {
      
      private var m_cancelBtn:easyButton;
      
      public function ExitDialog(param1:MovieClip, param2:MovieClip, param3:int = 0)
      {
         super(param1,param2,param3);
         this.m_cancelBtn = new easyButton(param1.cancelMc,this._cancelFunc);
      }
      
      override protected function _exitDialog() : void
      {
         this.m_cancelBtn.enable(false);
         super._exitDialog();
      }
      
      private function _cancelFunc(param1:MouseEvent) : void
      {
         this._exitDialog();
      }
      
      override public function release() : void
      {
         this.m_cancelBtn.release();
         super.release();
      }
   }
}


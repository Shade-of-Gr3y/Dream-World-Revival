package
{
   import bfp.chest.chestBridge;
   import flash.display.MovieClip;
   import flash.events.Event;
   import game.message.MessageMgr;
   
   public class seedMgr extends MovieClip
   {
      
      private static const SEED_TOP_NO:* = 149;
      
      private var m_bInit:Boolean = false;
      
      private var m_seedNo:int = -1;
      
      private var m_mc:MovieClip;
      
      private var m_bError:Boolean = false;
      
      public function seedMgr(param1:MovieClip)
      {
         super();
         this.m_mc = param1;
      }
      
      public function isSelect() : Boolean
      {
         return this.m_seedNo != -1;
      }
      
      public function release() : void
      {
         if(this.m_bInit == true)
         {
            chestBridge.removeEventListener(chestBridge.SELECTED_YES,this._selectedHandler);
            chestBridge.removeEventListener(chestBridge.SELECTED_NO,this._selectedHandler);
            chestBridge.removeEventListener(chestBridge.SELECTED_CLOSE,this._selectedHandler);
            chestBridge.removeEventListener(chestBridge.NO_ITEM,this._failureHandler);
            chestBridge.close();
         }
         this.m_bInit = false;
      }
      
      public function getSeedNo() : int
      {
         return this.m_seedNo;
      }
      
      private function _selectedHandler(param1:Event) : void
      {
         if(param1.type == chestBridge.SELECTED_YES)
         {
            this.m_seedNo = chestBridge.selectedItem - SEED_TOP_NO;
         }
         else
         {
            this._openChest();
         }
      }
      
      private function _failureHandler(param1:Event) : void
      {
         this.m_bError = true;
      }
      
      public function initialize() : void
      {
         chestBridge.addEventListener(chestBridge.NO_ITEM,this._failureHandler);
         chestBridge.addEventListener(chestBridge.SELECTED_YES,this._selectedHandler);
         chestBridge.addEventListener(chestBridge.SELECTED_NO,this._selectedHandler);
         chestBridge.addEventListener(chestBridge.SELECTED_CLOSE,this._selectedHandler);
         this.m_bInit = true;
         this._openChest();
      }
      
      public function setSeedNo(param1:int) : *
      {
         this.m_seedNo = param1;
      }
      
      private function _openChest() : void
      {
         chestBridge.messageWindow(MessageMgr.getInstance().getMessage(MessageMgr.ID_SEED_SELECT),chestBridge.TYPE_YES_NO);
         chestBridge.windowTitle = MessageMgr.getInstance().getMessage(MessageMgr.ID_USE_ICESEED);
         chestBridge.open(chestBridge.MODE_NUTS,chestBridge.DESIGN_CENTER,chestBridge.NO_POST_WINDOW,chestBridge.BUTTON_NO_CLOSE);
         chestBridge.swapChild(this.m_mc);
         this.m_bError = false;
      }
      
      public function used() : void
      {
         chestBridge.usedItemID = this.m_seedNo + SEED_TOP_NO;
      }
      
      public function isError() : Boolean
      {
         return this.m_bError;
      }
   }
}


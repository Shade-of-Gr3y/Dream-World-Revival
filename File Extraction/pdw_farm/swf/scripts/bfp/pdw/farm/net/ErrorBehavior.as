package bfp.pdw.farm.net
{
   import bfp.PDWBridge;
   import bfp.common.Logger;
   import bfp.pdw.farm.FarmFilePath;
   import flash.events.EventDispatcher;
   
   public class ErrorBehavior extends EventDispatcher
   {
      
      private var filePath:FarmFilePath;
      
      public const FRIEND_MEMBER_SAVEDATA_ID:String = "friend_member_savedata_id";
      
      public const MY_CROFT_ID:String = "my_croft_id";
      
      public const POKEITEM_ID:String = "pokeitem_id";
      
      public const MEMBER_SAVEDATA_ID:String = "member_savedata_id";
      
      public const INTERIOR_ID:String = "interior_id";
      
      public function ErrorBehavior()
      {
         super();
         this.filePath = FarmFilePath.getInstance();
      }
      
      public function getErrorAfterBehavior(param1:*, param2:*, param3:*) : *
      {
         switch(param1)
         {
            case this.filePath.getStartTutorialAPI():
               Logger.log("はたけ　エラー　きのみ初回チュートリアル開始API");
               return this.checkStartTutorialError(param2,param3);
            case this.filePath.getEndTutorialAPI():
               Logger.log("はたけ　エラー　きのみ初回チュートリアル終了API");
               return this.checkEndTutorialEndTutorialError(param2,param3);
            case this.filePath.getMyCroftListAPI():
               Logger.log("はたけ　エラー　きのみばたけAPI");
               return this.checkMyCroftListError(param2,param3);
            case this.filePath.getFriendCroftListAPI():
               Logger.log("はたけ　エラー　フレンドきのみばたけAPI");
               return this.checkFriendCroftListError(param2,param3);
            case this.filePath.getSowAPI():
               Logger.log("はたけ　エラー　通常きのみ選択API");
               return this.checkSowError(param2,param3);
            case this.filePath.getWatringAPI():
               Logger.log("はたけ　エラー　みずやりAPI");
               return this.checkWatringError(param2,param3);
            case this.filePath.getFriendWatringAPI():
               Logger.log("はたけ　エラー　フレンドみずやりAPI");
               return this.checkFriendWatringError(param2,param3);
            case this.filePath.getHarvestAPI():
               Logger.log("はたけ　エラー　収穫API");
               return this.checkHarvestError(param2,param3);
            case this.filePath.getItemListAPI():
               Logger.log("はたけ　エラー　じょうろ一覧API");
               return this.checkItemListError(param2,param3);
            case this.filePath.getSprinklerListAPI():
               Logger.log("はたけ　エラー　じょうろ選択API");
               return this.checkSprinklerListError(param2,param3);
            default:
               return;
         }
      }
      
      private function checkStartTutorialError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkEndTutorialEndTutorialError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_BACK_HOME;
            case 404:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkMyCroftListError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_BACK_HOME;
            case 404:
               return PDWBridge.DIALOG_ERROR_BACK_HOME;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkFriendCroftListError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.FRIEND_MEMBER_SAVEDATA_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               switch(param2)
               {
                  case this.FRIEND_MEMBER_SAVEDATA_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 404:
               return PDWBridge.DIALOG_ERROR_BACK_HOME;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkSowError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_REFRESH;
                  case this.POKEITEM_ID:
                     return PDWBridge.DIALOG_ERROR_REFRESH;
                  default:
                     return PDWBridge.DIALOG_ERROR_REFRESH;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  case this.POKEITEM_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkWatringError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_NONE;
                  default:
                     return PDWBridge.DIALOG_ERROR_NONE;
               }
               break;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkFriendWatringError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.FRIEND_MEMBER_SAVEDATA_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  case this.MEMBER_SAVEDATA_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               switch(param2)
               {
                  case this.FRIEND_MEMBER_SAVEDATA_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 404:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_NONE;
                  default:
                     return PDWBridge.DIALOG_ERROR_NONE;
               }
               break;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkHarvestError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               switch(param2)
               {
                  case this.MY_CROFT_ID:
                     return PDWBridge.DIALOG_ERROR_NONE;
                  default:
                     return PDWBridge.DIALOG_ERROR_NONE;
               }
               break;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkItemListError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
      
      private function checkSprinklerListError(param1:*, param2:*) : *
      {
         switch(param1)
         {
            case 400:
               switch(param2)
               {
                  case this.INTERIOR_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 401:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 403:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 404:
               switch(param2)
               {
                  case this.INTERIOR_ID:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
                  default:
                     return PDWBridge.DIALOG_ERROR_BACK_HOME;
               }
               break;
            case 500:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 502:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            case 503:
               return PDWBridge.DIALOG_ERROR_REFRESH;
            default:
               return PDWBridge.DIALOG_ERROR_REFRESH;
         }
      }
   }
}


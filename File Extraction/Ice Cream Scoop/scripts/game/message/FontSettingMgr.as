package game.message
{
   import bfp.common.*;
   import common.*;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class FontSettingMgr
   {
      
      private var aKey:Array;
      
      private var aHash:Dictionary;
      
      public function FontSettingMgr()
      {
         super();
         this.aHash = new Dictionary();
         this.aKey = new Array();
         switch(comDefine.nLanguage)
         {
            case "ja":
               FontManager.langCode = FontManager.LANG_CODE_JA;
               break;
            case "ko":
               FontManager.langCode = FontManager.LANG_CODE_KO;
               break;
            default:
               FontManager.langCode = FontManager.LANG_CODE_EN;
         }
      }
      
      public function change(param1:MovieClip, param2:int, param3:Boolean, param4:Number = -1) : void
      {
         var _loc5_:String = MessageMgr.getInstance().getMessage(param2);
         this.changeString(param1,_loc5_,param3,param4);
      }
      
      public function changeString(param1:MovieClip, param2:String, param3:Boolean, param4:Number = -1) : void
      {
         if(this.aHash[param1] == true)
         {
            this.aHash[param1] = true;
         }
         else
         {
            this.aHash[param1] = true;
            this.aKey.push(new FontSetting(param1,param2,param3,param4));
         }
      }
      
      public function release() : *
      {
         this.aKey.splice(0);
      }
   }
}


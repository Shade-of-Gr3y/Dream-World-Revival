package bfp.pdw.farm.panel
{
   import bfp.pdw.farm.FarmData;
   import flash.events.EventDispatcher;
   
   public class Message extends EventDispatcher
   {
      
      private var data:FarmData;
      
      public function Message()
      {
         super();
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
      }
      
      public function getCloseBtnLabel() : *
      {
         return "とじる";
      }
      
      public function getTitleLabel(param1:*) : *
      {
         if(param1 == "" || param1 == null)
         {
            return "はたけ";
         }
         return param1 + "のはたけ";
      }
      
      public function getPlantCheckFinishMessage(param1:*) : *
      {
         return param1 + "を 植えました";
      }
      
      public function getWaterCheckPanelMessage(param1:*, param2:*) : *
      {
         var _loc3_:* = "";
         switch(param2)
         {
            case 0:
               _loc3_ = "ひだり";
               break;
            case 1:
               _loc3_ = "まんなか";
               break;
            case 2:
               _loc3_ = "みぎ";
         }
         return Number(param1) + 1 + "れつめ" + _loc3_;
      }
      
      public function getPlantStatusMessage(param1:*, param2:* = "", param3:* = "") : *
      {
         var _loc4_:* = "";
         switch(param1)
         {
            case this.data.PLANT_STATUS_NONE:
               _loc4_ = "きのみを植えますか？";
               break;
            case this.data.PLANT_STATUS_SOIL:
               _loc4_ = param2 + "が \n植えてある！";
               break;
            case this.data.PLANT_STATUS_SPROUT:
               _loc4_ = param2 + "の芽が \nでてきた！";
               break;
            case this.data.PLANT_STATUS_TRUNK:
               _loc4_ = param2 + "の幹が \nおおきくなってきた！";
               break;
            case this.data.PLANT_STATUS_FLOWER:
               _loc4_ = param2 + "の花が \nさいている！";
               break;
            case this.data.PLANT_STATUS_FRUIT:
               _loc4_ = param2 + "が\nできている！";
         }
         return _loc4_;
      }
      
      public function getPlantStatusNoPlantMessage() : *
      {
         if(this.data.isFriendMode)
         {
            return "ふかふかの土";
         }
         return "ふかふかの土に\nきのみを植えますか？";
      }
      
      public function getDetailBtnLabel() : *
      {
         return "くわしく見る";
      }
      
      public function getNoWaterMessage() : *
      {
         return "土はじゅうぶん、\nしめっているみたい！";
      }
      
      public function getHarvestFinishMessage(param1:*, param2:*) : *
      {
         var _loc3_:* = "";
         if(param2 <= 0)
         {
            _loc3_ = param1 + "をとりました。";
         }
         else
         {
            _loc3_ = param1 + "を" + param2 + "個とりました。";
         }
         return _loc3_;
      }
      
      public function getHarvestFinishSubMessage() : *
      {
         return "とったきのみを たからばこに入れました。";
      }
      
      public function getNoNutsMessage() : *
      {
         return "うえれるきのみがないよ！";
      }
      
      public function getNoNutsSubMessage() : *
      {
         return "きのみは、ゆめしま、おすそわけで\nゲットしよう！";
      }
      
      public function getShowDegdaMessage() : *
      {
         return "ディグダがあらわれた。";
      }
      
      public function getPlowMessage(param1:*) : *
      {
         return "ディグダが" + param1 + "\nのはたけをたがやしはじめた。";
      }
      
      public function getBackDigdaMessage() : *
      {
         return "ディグダが去っていった。";
      }
      
      public function getAddMessage() : *
      {
         return "はたけのうねがふえました。";
      }
      
      public function getUneIncrementMessage(param1:*) : *
      {
         return "ディグダがはたけをたがやしてくれたので、\nはたけのうねが" + param1 + "段になった。";
      }
      
      public function getBackHomeBtnLabel() : *
      {
         return "自分のホームにもどる";
      }
      
      public function getNowUneLabel() : *
      {
         return "今いる うね";
      }
      
      public function getUseSprinklerLabel() : *
      {
         return "使用中のじょうろ";
      }
      
      public function getSprinklerInfoMessage(param1:*) : *
      {
         switch(param1)
         {
            case this.data.SPRINKLER_ID_NORMAL:
               return "きのみに水をやれる\nふつうのじょうろ。";
            case this.data.SPRINKLER_ID_DELIBIRD:
               return "ひとの畑に水やりしたとき\nいつもより いっぱい\nかんしゃされるじょうろ。";
            case this.data.SPRINKLER_ID_ZENIGAME:
               return "きのみの育ちが\n少し早くなるじょうろ。";
            case this.data.SPRINKLER_ID_DONFAN:
               return "いちれつのきのみに\nまとめて水やりができ\nきのみの育ちも\n少し早くなるじょうろ。";
            case this.data.SPRINKLER_ID_KAIOUGA:
               return "ぜんぶのきのみに\nまとめて水やりができ\nきのみの育ちも\n少し早くなるじょうろ。";
            case this.data.SPRINKLER_ID_KODAK:
               return "きのみの育ちが\nすごく早くなるじょうろ。";
            default:
               return;
         }
      }
      
      public function getPokemonProfileNickNameLabel() : *
      {
         return "ニックネーム：";
      }
      
      public function getPokemonProfilePGLNickNameLabel() : *
      {
         return "PGLニックネーム：";
      }
      
      public function getPokemonProfilePokemonLabel() : *
      {
         return "ポケモン：";
      }
      
      public function getPokemonProfileParentLabel() : *
      {
         return "親：";
      }
      
      public function getPokemonProfileLevelLabel() : *
      {
         return "レベル：";
      }
      
      public function getPokemonProfileTypeLabel() : *
      {
         return "タイプ：";
      }
      
      public function getPokemonProfileSexLabel() : *
      {
         return "性別：";
      }
      
      public function getPokemonProfilePersonalityLabel() : *
      {
         return "性格：";
      }
      
      public function getPokemonProfileMonsterBallLabel() : *
      {
         return "つかまえた\nモンスターボール：";
      }
   }
}


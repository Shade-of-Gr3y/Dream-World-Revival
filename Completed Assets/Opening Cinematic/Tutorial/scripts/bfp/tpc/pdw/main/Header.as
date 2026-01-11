package bfp.tpc.pdw.main
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.PDWTutorial;
   import bfp.PDWTutorialEvent;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import jp.feb19.transitions.Tweening;
   import jp.feb19.utils.ButtonUtilities;
   import jp.feb19.utils.ColorUtilities;
   
   public class Header extends Sprite
   {
       
      
      public var logoutmc:MovieClip;
      
      public var infomc:MovieClip;
      
      public var ballonlogoutmc:MovieClip;
      
      public var ballonnewsmc:MovieClip;
      
      public var newsmc:MovieClip;
      
      public var balloninfomc:MovieClip;
      
      public function Header()
      {
         super();
         this.tabEnabled = false;
         this.tabChildren = false;
         this.infomc.y = -37;
         this.infomc.visible = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         var _loc4_:Font = null;
         this.visible = false;
         this.y = -50;
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            if((_loc4_ = Font.enumerateFonts()[_loc2_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
            }
         }
         _loc3_ = new TextFormat();
         _loc3_.font = "PokemonFontShingoM";
         _loc3_.color = 4202765;
         _loc3_.size = 11;
         _loc3_.align = TextFormatAlign.RIGHT;
         this.ballonnewsmc.tf.multiline = false;
         this.ballonnewsmc.tf.defaultTextFormat = _loc3_;
         this.ballonnewsmc.tf.embedFonts = _loc1_;
         this.ballonnewsmc.tf.wordWrap = false;
         this.ballonnewsmc.tf.autoSize = TextFieldAutoSize.RIGHT;
         this.ballonnewsmc.tf.y = 11;
         FontManager.setTextID(this.ballonnewsmc.tf,"h_ca_9");
         this.ballonnewsmc.tf.x = this.ballonnewsmc.rightmc.x - 1 - this.ballonnewsmc.tf.width;
         this.ballonnewsmc.bgmc.width = this.ballonnewsmc.tf.width + 3;
         this.ballonnewsmc.bgmc.x = this.ballonnewsmc.rightmc.x - this.ballonnewsmc.bgmc.width;
         this.ballonnewsmc.leftmc.x = this.ballonnewsmc.bgmc.x - this.ballonnewsmc.leftmc.width;
         this.ballonlogoutmc.tf.multiline = false;
         this.ballonlogoutmc.tf.defaultTextFormat = _loc3_;
         this.ballonlogoutmc.tf.embedFonts = _loc1_;
         this.ballonlogoutmc.tf.wordWrap = false;
         this.ballonlogoutmc.tf.autoSize = TextFieldAutoSize.RIGHT;
         this.ballonlogoutmc.tf.y = 11;
         FontManager.setTextID(this.ballonlogoutmc.tf,"h_ca_10");
         this.ballonlogoutmc.tf.x = this.ballonlogoutmc.rightmc.x - 1 - this.ballonlogoutmc.tf.width;
         this.ballonlogoutmc.bgmc.width = this.ballonlogoutmc.tf.width + 3;
         this.ballonlogoutmc.bgmc.x = this.ballonlogoutmc.rightmc.x - this.ballonlogoutmc.bgmc.width;
         this.ballonlogoutmc.leftmc.x = this.ballonlogoutmc.bgmc.x - this.ballonlogoutmc.leftmc.width;
         this.balloninfomc.tf.multiline = false;
         this.balloninfomc.tf.defaultTextFormat = _loc3_;
         this.balloninfomc.tf.embedFonts = _loc1_;
         this.balloninfomc.tf.wordWrap = false;
         this.balloninfomc.tf.autoSize = TextFieldAutoSize.RIGHT;
         this.balloninfomc.tf.y = 11;
         FontManager.setTextID(this.balloninfomc.tf,"h_ca_11");
         this.balloninfomc.tf.x = this.balloninfomc.rightmc.x - 1 - this.balloninfomc.tf.width;
         this.balloninfomc.bgmc.width = this.balloninfomc.tf.width + 3;
         this.balloninfomc.bgmc.x = this.balloninfomc.rightmc.x - this.balloninfomc.bgmc.width;
         this.balloninfomc.leftmc.x = this.balloninfomc.bgmc.x - this.balloninfomc.leftmc.width;
         this.checkCampaign();
         ButtonUtilities.setBtn(this.newsmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.logoutmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.infomc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.ballonnewsmc.visible = false;
         this.ballonlogoutmc.visible = false;
         this.balloninfomc.visible = false;
         PDWTutorial.addEventListener(PDWTutorial.BACKGROUND_ATTENTION,this.backgroundAttentionHandler);
      }
      
      public function release() : void
      {
         PDWTutorial.removeEventListener(PDWTutorial.BACKGROUND_ATTENTION,this.backgroundAttentionHandler);
         this.ballonnewsmc.visible = false;
         this.ballonlogoutmc.visible = false;
         this.balloninfomc.visible = false;
         ButtonUtilities.unsetBtn(this.newsmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.logoutmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.infomc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
      }
      
      public function set isCampaign(param1:Boolean) : void
      {
         var v:Boolean = param1;
         if(v)
         {
            ButtonUtilities.setBtn(this.infomc,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this.infomc.visible = true;
            Tweening.add(this.infomc,{
               "time":0.3,
               "y":6,
               "easing":"easeOutCubic"
            });
         }
         else
         {
            ButtonUtilities.unsetBtn(this.infomc,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            Tweening.add(this.infomc,{
               "time":0.3,
               "y":-37,
               "easing":"easeInCubic",
               "onComplete":function():*
               {
                  infomc.visible = false;
               }
            });
         }
      }
      
      public function checkCampaign() : void
      {
         if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
         {
            this.isCampaign = true;
         }
         else
         {
            this.isCampaign = false;
         }
      }
      
      public function visit() : void
      {
         this.visible = true;
         Tweening.add(this,{
            "time":1,
            "y":0,
            "easing":"easeOutBack"
         });
      }
      
      public function away() : void
      {
         Tweening.add(this,{
            "time":1,
            "y":-50,
            "easing":"easeOutBack"
         });
      }
      
      private function backgroundAttentionHandler(param1:PDWTutorialEvent) : void
      {
         switch(param1.data["attentionId"])
         {
            case PDWTutorial.ATTENTION_CLOSE:
               if(param1.data["isShow"])
               {
                  this.focusInClose();
                  Tweener.addTween(this,{
                     "delay":0.7 * 0,
                     "time":0.5,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 1,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 2,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 3,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 4,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 5,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 6,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 7,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 8,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 9,
                     "time":0.5,
                     "onStart":this.focusInClose,
                     "onComplete":this.focusOutClose
                  });
               }
               else
               {
                  Tweener.removeTweens(this);
                  this.focusOutClose();
               }
         }
      }
      
      public function focusInClose() : void
      {
         this["ballonlogoutmc"].visible = true;
         ColorUtilities.paint(this.logoutmc.bgmc,PDWBridge.ROLLOVER_COLOR);
      }
      
      public function focusOutClose() : void
      {
         this["ballonlogoutmc"].visible = false;
         ColorUtilities.reset(this.logoutmc.bgmc);
      }
      
      public function normal() : void
      {
         this.newsmc.alpha = 1;
         this.logoutmc.alpha = 1;
         ButtonUtilities.setBtn(this.newsmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.logoutmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
      }
      
      public function minigame() : void
      {
         this.newsmc.alpha = 0.5;
         this.logoutmc.alpha = 0.5;
         ButtonUtilities.unsetBtn(this.newsmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.logoutmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "newsmc":
            case "logoutmc":
            case "infomc":
               this["ballon" + _loc2_.name].visible = true;
               ColorUtilities.paint(_loc2_.bgmc,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "newsmc":
            case "logoutmc":
            case "infomc":
               this["ballon" + _loc2_.name].visible = false;
               ColorUtilities.reset(_loc2_.bgmc);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "newsmc":
               PokemonBridge.tag("pdw.home_info");
               this["ballon" + _loc2_.name].visible = false;
               ColorUtilities.reset(_loc2_.bgmc);
               PDWBridge.showNews();
               break;
            case "logoutmc":
               PokemonBridge.tag("pdw.home_end");
               this["ballon" + _loc2_.name].visible = false;
               ColorUtilities.reset(_loc2_.bgmc);
               if(PDWHomeData.myTrialFlag == 1)
               {
                  PDWBridge.dialog(PDWBridge.DIALOG_TYPE_WAKEUP_TRIAL);
               }
               else
               {
                  PDWBridge.dialog(PDWBridge.DIALOG_TYPE_WAKEUP);
               }
               break;
            case "infomc":
               this["ballon" + _loc2_.name].visible = false;
               ColorUtilities.reset(_loc2_.bgmc);
               PDWBridge.showInfo();
         }
      }
   }
}

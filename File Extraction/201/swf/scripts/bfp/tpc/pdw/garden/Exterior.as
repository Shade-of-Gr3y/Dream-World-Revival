package bfp.tpc.pdw.garden
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.PDWTutorial;
   import bfp.PDWTutorialEvent;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import jp.feb19.utils.ButtonUtilities;
   
   public class Exterior extends Sprite
   {
      
      public var footprintmc:MovieClip;
      
      public var doormc:MovieClip;
      
      public var door_btn:MovieClip;
      
      private var _panel_mc:*;
      
      private var _panel_btn:*;
      
      private var _panel_glow:*;
      
      public function Exterior()
      {
         ColorShortcuts.init();
         super();
         this._panel_mc = this["panel_mc"];
         this._panel_btn = this["panel_btn"];
         this._panel_glow = this["panel_glow"];
         this.tabEnabled = false;
         this.tabChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(event:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         ExteriorConfig.footprintX = this.footprintmc.x;
         ExteriorConfig.footprintY = this.footprintmc.y;
         ExteriorConfig.footprintW = this.footprintmc.width;
         ExteriorConfig.footprintH = this.footprintmc.height;
         ExteriorConfig.doorX = this.door_btn.x;
         ExteriorConfig.doorY = this.door_btn.y;
         ExteriorConfig.doorW = this.door_btn.width;
         ExteriorConfig.doorH = this.door_btn.height;
         if(this._panel_btn)
         {
            ExteriorConfig.panelX = this._panel_btn.x;
            ExteriorConfig.panelY = this._panel_btn.y;
            ExteriorConfig.panelW = this._panel_btn.width;
            ExteriorConfig.panelH = this._panel_btn.height;
         }
         ButtonUtilities.setBtn(this.footprintmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.door_btn,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         if(this._panel_btn)
         {
            ButtonUtilities.setBtn(this._panel_btn,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
         }
         Tweener.addTween(this.footprintmc,{
            "time":0,
            "_brightness":0,
            "transition":"easeInQuad"
         });
         if(PDWHomeData.isMyHome)
         {
            if(PDWHomeData.myRequestedFlag)
            {
               this.bright();
            }
            this.footprintmc.visible = true;
         }
         else
         {
            this.footprintmc.visible = false;
         }
         if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
         {
            if(this.door_btn)
            {
               this.blinkDoor();
            }
            if(this._panel_btn)
            {
               this.blinkPanel();
               this._panel_glow.alpha = 0;
            }
         }
         PDWTutorial.addEventListener(PDWTutorial.BACKGROUND_ATTENTION,this.backgroundAttentionHandler);
         dispatchEvent(new Event(ExteriorConfig.INIT_DATA));
      }
      
      private function blinkDoor() : void
      {
         Tweener.addTween(this.door_btn,{
            "time":2.5,
            "onComplete":function():*
            {
               Tweener.removeTweens(doormc);
               Tweener.addTween(doormc,{
                  "time":0.2,
                  "_brightness":0.7,
                  "transition":"easeInQuad"
               });
               Tweener.addTween(doormc,{
                  "delay":0.2,
                  "time":0.7,
                  "_brightness":0,
                  "transition":"linear"
               });
               Tweener.addTween(doormc,{
                  "time":1.2,
                  "onComplete":hideBallonDoor
               });
               blinkDoor();
            }
         });
         this.dispatchEvent(new Event(ExteriorConfig.SHOW_BALLON_DOOR));
      }
      
      private function blinkPanel() : void
      {
         Tweener.addTween(this._panel_btn,{
            "time":2.5,
            "onComplete":function():*
            {
               Tweener.removeTweens(_panel_mc);
               Tweener.addTween(_panel_mc,{
                  "time":0.2,
                  "_brightness":0.7,
                  "transition":"easeInQuad"
               });
               Tweener.addTween(_panel_mc,{
                  "delay":0.2,
                  "time":0.7,
                  "_brightness":0,
                  "transition":"linear"
               });
               Tweener.addTween(_panel_mc,{
                  "time":1.2,
                  "onComplete":hideBallonPanel
               });
               Tweener.removeTweens(_panel_glow);
               Tweener.addTween(_panel_glow,{
                  "time":0.2,
                  "alpha":1,
                  "transition":"linear"
               });
               Tweener.addTween(_panel_glow,{
                  "delay":0.2,
                  "time":0.7,
                  "alpha":0,
                  "transition":"linear"
               });
               blinkPanel();
            }
         });
         this.dispatchEvent(new Event(ExteriorConfig.SHOW_BALLON_PANEL));
      }
      
      private function hideBallonDoor() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.HIDE_BALLON_DOOR));
      }
      
      private function hideBallonPanel() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.HIDE_BALLON_PANEL));
      }
      
      private function removeBlinkDoor() : void
      {
         Tweener.removeTweens(this.door_btn);
      }
      
      private function removeBlinkPanel() : void
      {
         Tweener.removeTweens(this._panel_btn);
      }
      
      private function backgroundAttentionHandler(event:PDWTutorialEvent) : void
      {
         switch(event.data["attentionId"])
         {
            case PDWTutorial.ATTENTION_DOOR:
               if(event.data["isShow"])
               {
                  this.focusInDoor();
                  Tweener.addTween(this,{
                     "delay":0.7 * 0,
                     "time":0.5,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 1,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 2,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 3,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 4,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 5,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 6,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 7,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 8,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 9,
                     "time":0.5,
                     "onStart":this.focusInDoor,
                     "onComplete":this.focusOutDoor
                  });
               }
               else
               {
                  Tweener.removeTweens(this);
                  this.focusOutDoor();
               }
               break;
            case PDWTutorial.ATTENTION_FOOTPRINT:
               if(event.data["isShow"])
               {
                  this.focusInFootprint();
                  Tweener.addTween(this,{
                     "delay":0.7 * 0,
                     "time":0.5,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 1,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 2,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 3,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 4,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 5,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 6,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 7,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 8,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
                  Tweener.addTween(this,{
                     "delay":0.7 * 9,
                     "time":0.5,
                     "onStart":this.focusInFootprint,
                     "onComplete":this.focusOutFootprint
                  });
               }
               else
               {
                  Tweener.removeTweens(this);
                  this.focusOutFootprint();
               }
         }
      }
      
      public function focusInDoor() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.SHOW_BALLON_DOOR));
         Tweener.removeTweens(this.doormc);
         Tweener.addTween(this.doormc,{
            "time":0,
            "_brightness":0.55,
            "transition":"easeInQuad"
         });
      }
      
      public function focusOutDoor() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.HIDE_BALLON_DOOR));
         Tweener.removeTweens(this.doormc);
         Tweener.addTween(this.doormc,{
            "time":0,
            "_brightness":0,
            "transition":"easeInQuad"
         });
      }
      
      public function focusInPanel() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.SHOW_BALLON_PANEL));
         Tweener.removeTweens(this._panel_mc);
         Tweener.addTween(this._panel_mc,{
            "time":0,
            "_brightness":0.55,
            "transition":"easeInQuad"
         });
         Tweener.removeTweens(this._panel_glow);
         Tweener.addTween(this._panel_glow,{
            "time":0,
            "alpha":1,
            "transition":"easeInQuad"
         });
      }
      
      public function focusOutPanel() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.HIDE_BALLON_PANEL));
         Tweener.removeTweens(this._panel_mc);
         Tweener.addTween(this._panel_mc,{
            "time":0,
            "_brightness":0,
            "transition":"easeInQuad"
         });
         Tweener.removeTweens(this._panel_glow);
         Tweener.addTween(this._panel_glow,{
            "time":0,
            "alpha":0,
            "transition":"easeInQuad"
         });
      }
      
      public function focusInFootprint() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.SHOW_BALLON_FOOTPRINT));
         Tweener.removeTweens(this.footprintmc);
         Tweener.addTween(this.footprintmc,{
            "time":0,
            "_brightness":0.55,
            "transition":"easeInQuad"
         });
      }
      
      public function focusOutFootprint() : void
      {
         this.dispatchEvent(new Event(ExteriorConfig.HIDE_BALLON_FOOTPRINT));
         Tweener.removeTweens(this.footprintmc);
         Tweener.addTween(this.footprintmc,{
            "time":0,
            "_brightness":0,
            "transition":"easeInQuad"
         });
         if(PDWHomeData.isMyHome)
         {
            if(PDWHomeData.myRequestedFlag)
            {
               this.bright();
            }
         }
      }
      
      private function bright() : void
      {
         Tweener.addTween(this.footprintmc,{
            "time":0.8,
            "_brightness":1,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this.footprintmc,{
            "delay":0.8,
            "time":0.8,
            "_brightness":0,
            "transition":"easeInQuad"
         });
         Tweener.addTween(this.footprintmc,{
            "time":1.8,
            "onComplete":this.bright
         });
      }
      
      public function release() : void
      {
         this.removeBlinkDoor();
         this.removeBlinkPanel();
         PDWTutorial.removeEventListener(PDWTutorial.BACKGROUND_ATTENTION,this.backgroundAttentionHandler);
         Tweener.removeTweens(this.footprintmc);
         Tweener.addTween(this.footprintmc,{
            "time":0,
            "_brightness":0,
            "transition":"easeInQuad"
         });
         ButtonUtilities.unsetBtn(this.footprintmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.door_btn,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         if(this._panel_btn)
         {
            ButtonUtilities.unsetBtn(this._panel_btn,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
         }
      }
      
      private function mouseOverHandler(event:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(event.currentTarget);
         switch(target.name)
         {
            case "footprintmc":
               PokemonBridge.mouseOverSound();
               this.focusInFootprint();
               break;
            case "door_btn":
               this.removeBlinkDoor();
               PokemonBridge.mouseOverSound();
               this.focusInDoor();
               break;
            case "panel_btn":
               this.removeBlinkPanel();
               PokemonBridge.mouseOverSound();
               this.focusInPanel();
         }
      }
      
      private function mouseOutHandler(event:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(event.currentTarget);
         switch(target.name)
         {
            case "footprintmc":
               this.focusOutFootprint();
               break;
            case "door_btn":
               this.focusOutDoor();
               if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
               {
                  if(this.door_btn)
                  {
                     this.blinkDoor();
                  }
               }
               break;
            case "panel_btn":
               this.focusOutPanel();
               this.blinkPanel();
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(event.currentTarget);
         switch(target.name)
         {
            case "footprintmc":
               PokemonBridge.tag("pdw.home_mat2");
               PDWBridge.sfxClick();
               this.focusOutFootprint();
               PDWBridge.showFootprint();
               break;
            case "door_btn":
               PokemonBridge.tag("pdw.home_in2");
               PDWBridge.sfx(PDWBridge.SFX_ID_DOOR);
               this.focusOutDoor();
               PDWBridge.intoRoom();
               this.removeBlinkDoor();
               break;
            case "panel_btn":
               PDWBridge.sfx(PDWBridge.SFX_ID_CLICK);
               this.focusOutPanel();
               this.removeBlinkPanel();
               PDWBridge.startMoviePanel();
         }
      }
   }
}


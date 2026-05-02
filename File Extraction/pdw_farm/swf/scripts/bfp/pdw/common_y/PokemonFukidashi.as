package bfp.pdw.common_y
{
   import caurina.transitions.*;
   import caurina.transitions.properties.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol72")]
   public class PokemonFukidashi extends MovieClip
   {
      
      public var icon0:MovieClip;
      
      public var icon1:MovieClip;
      
      public var icon2:MovieClip;
      
      public var icon3:MovieClip;
      
      public var icon4:MovieClip;
      
      public var icon5:MovieClip;
      
      public var icon6:MovieClip;
      
      public var icon7:MovieClip;
      
      public var icon8:MovieClip;
      
      public var icon9:MovieClip;
      
      private var _isShow:Boolean;
      
      public var defX:Number;
      
      public var defY:Number;
      
      public var dx:Number = 0;
      
      public var dy:Number = 0;
      
      private var viewType:Number = 0;
      
      private var iconMC:MovieClip;
      
      private var _cnt:Number = 0;
      
      public const VIEW_TYPE_NONE:Number = 1;
      
      public const VIEW_TYPE_SMAIL:Number = 2;
      
      public const VIEW_TYPE_MUSIC:Number = 3;
      
      public const VIEW_TYPE_HEART:Number = 4;
      
      public const VIEW_TYPE_IMPORTANT:Number = 5;
      
      public const VIEW_TYPE_REVERSE_NONE:Number = 6;
      
      public const VIEW_TYPE_REVERSE_SMAIL:Number = 7;
      
      public const VIEW_TYPE_REVERSE_MUSIC:Number = 8;
      
      public const VIEW_TYPE_REVERSE_HEART:Number = 9;
      
      public const VIEW_TYPE_REVERSE_IMPORTANT:Number = 10;
      
      public function PokemonFukidashi()
      {
         addFrameScript(0,this.frame1);
         super();
         this._isShow = false;
         this.defX = 0;
         this.defY = 0;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.release();
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.defX = this.x;
         this.defY = this.y;
         this.visit();
      }
      
      public function release() : void
      {
         Tweener.removeTweens(this);
         this._isShow = false;
      }
      
      public function visit() : void
      {
         var yy:*;
         if(this._isShow)
         {
            return;
         }
         this._isShow = true;
         this.x = this.defX;
         this.y = this.defY;
         yy = -16;
         this._cnt = 0;
         if(this.iconMC != null)
         {
            this.iconMC.gotoAndStop(1);
         }
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         Tweener.removeTweens(this);
         switch(this.viewType)
         {
            case this.VIEW_TYPE_NONE:
            case this.VIEW_TYPE_SMAIL:
            case this.VIEW_TYPE_MUSIC:
            case this.VIEW_TYPE_HEART:
            case this.VIEW_TYPE_IMPORTANT:
               yy = -16;
               break;
            case this.VIEW_TYPE_REVERSE_NONE:
            case this.VIEW_TYPE_REVERSE_SMAIL:
            case this.VIEW_TYPE_REVERSE_MUSIC:
            case this.VIEW_TYPE_REVERSE_HEART:
            case this.VIEW_TYPE_REVERSE_IMPORTANT:
               yy = 16;
         }
         Tweener.addTween(this,{
            "time":0.1,
            "y":this.defY + yy,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this,{
            "delay":0.1,
            "time":0.2,
            "y":this.defY,
            "transition":"easeInQuad"
         });
         Tweener.addTween(this,{
            "time":1.1,
            "onComplete":function():*
            {
               _isShow = false;
               if(this.parent)
               {
                  addEventListener(Event.ENTER_FRAME,enterFrameHandler);
                  this.parent.removeChild(this);
               }
            }
         });
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         ++this._cnt;
         if(this._cnt > 8)
         {
            this._cnt = 0;
            if(this.iconMC != null)
            {
               if(this.iconMC.currentFrame == 1)
               {
                  this.iconMC.gotoAndStop(2);
               }
               else
               {
                  this.iconMC.gotoAndStop(1);
               }
            }
         }
      }
      
      public function changeView(param1:*) : *
      {
         this.viewType = param1;
         switch(param1)
         {
            case this.VIEW_TYPE_NONE:
               this.gotoAndStop(1);
               this.iconMC = this.icon0;
               break;
            case this.VIEW_TYPE_SMAIL:
               this.gotoAndStop(2);
               this.iconMC = this.icon1;
               break;
            case this.VIEW_TYPE_MUSIC:
               this.gotoAndStop(3);
               this.iconMC = this.icon2;
               break;
            case this.VIEW_TYPE_HEART:
               this.gotoAndStop(4);
               this.iconMC = this.icon3;
               break;
            case this.VIEW_TYPE_IMPORTANT:
               this.gotoAndStop(5);
               this.iconMC = this.icon4;
               break;
            case this.VIEW_TYPE_REVERSE_NONE:
               this.gotoAndStop(6);
               this.iconMC = this.icon5;
               break;
            case this.VIEW_TYPE_REVERSE_SMAIL:
               this.gotoAndStop(7);
               this.iconMC = this.icon6;
               break;
            case this.VIEW_TYPE_REVERSE_MUSIC:
               this.gotoAndStop(8);
               this.iconMC = this.icon7;
               break;
            case this.VIEW_TYPE_REVERSE_HEART:
               this.gotoAndStop(9);
               this.iconMC = this.icon8;
               break;
            case this.VIEW_TYPE_REVERSE_IMPORTANT:
               this.gotoAndStop(10);
               this.iconMC = this.icon9;
         }
      }
      
      internal function frame1() : *
      {
         this.stop();
      }
   }
}


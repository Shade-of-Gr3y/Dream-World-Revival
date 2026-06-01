package com.google.analytics.debug
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class UISprite extends Sprite
   {
      
      private var _forcedHeight:uint;
      
      protected var listenResize:Boolean;
      
      public var alignement:Align;
      
      private var _forcedWidth:uint;
      
      public var margin:Margin;
      
      protected var alignTarget:DisplayObject;
      
      public function UISprite(param1:DisplayObject = null)
      {
         super();
         listenResize = false;
         alignement = Align.none;
         this.alignTarget = param1;
         margin = new Margin();
         addEventListener(Event.ADDED_TO_STAGE,_onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,_onRemovedFromStage);
      }
      
      protected function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_);
            if(_loc1_)
            {
               removeChild(_loc1_);
            }
            _loc2_++;
         }
      }
      
      protected function layout() : void
      {
      }
      
      public function get forcedHeight() : uint
      {
         if(_forcedHeight)
         {
            return _forcedHeight;
         }
         return height;
      }
      
      public function alignTo(param1:Align, param2:DisplayObject = null) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:UISprite = null;
         if(param2 == null)
         {
            if(parent is Stage)
            {
               param2 = this.stage;
            }
            else
            {
               param2 = parent;
            }
         }
         if(param2 == this.stage)
         {
            if(this.stage == null)
            {
               return;
            }
            _loc3_ = uint(this.stage.stageHeight);
            _loc4_ = uint(this.stage.stageWidth);
            _loc5_ = 0;
            _loc6_ = 0;
         }
         else
         {
            _loc7_ = param2 as UISprite;
            if(_loc7_.forcedHeight)
            {
               _loc3_ = _loc7_.forcedHeight;
            }
            else
            {
               _loc3_ = _loc7_.height;
            }
            if(_loc7_.forcedWidth)
            {
               _loc4_ = _loc7_.forcedWidth;
            }
            else
            {
               _loc4_ = _loc7_.width;
            }
            _loc5_ = 0;
            _loc6_ = 0;
         }
         switch(param1)
         {
            case Align.top:
               x = _loc4_ / 2 - forcedWidth / 2;
               y = _loc6_ + margin.top;
               break;
            case Align.bottom:
               x = _loc4_ / 2 - forcedWidth / 2;
               y = _loc6_ + _loc3_ - forcedHeight - margin.bottom;
               break;
            case Align.left:
               x = _loc5_ + margin.left;
               y = _loc3_ / 2 - forcedHeight / 2;
               break;
            case Align.right:
               x = _loc5_ + _loc4_ - forcedWidth - margin.right;
               y = _loc3_ / 2 - forcedHeight / 2;
               break;
            case Align.center:
               x = _loc4_ / 2 - forcedWidth / 2;
               y = _loc3_ / 2 - forcedHeight / 2;
               break;
            case Align.topLeft:
               x = _loc5_ + margin.left;
               y = _loc6_ + margin.top;
               break;
            case Align.topRight:
               x = _loc5_ + _loc4_ - forcedWidth - margin.right;
               y = _loc6_ + margin.top;
               break;
            case Align.bottomLeft:
               x = _loc5_ + margin.left;
               y = _loc6_ + _loc3_ - forcedHeight - margin.bottom;
               break;
            case Align.bottomRight:
               x = _loc5_ + _loc4_ - forcedWidth - margin.right;
               y = _loc6_ + _loc3_ - forcedHeight - margin.bottom;
         }
         if(!listenResize && param1 != Align.none)
         {
            param2.addEventListener(Event.RESIZE,onResize,false,0,true);
            listenResize = true;
         }
         this.alignement = param1;
         this.alignTarget = param2;
      }
      
      public function get forcedWidth() : uint
      {
         if(_forcedWidth)
         {
            return _forcedWidth;
         }
         return width;
      }
      
      protected function onResize(param1:Event) : void
      {
         resize();
      }
      
      private function _onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,_onAddedToStage);
         removeEventListener(Event.REMOVED_FROM_STAGE,_onRemovedFromStage);
         dispose();
      }
      
      public function resize() : void
      {
         if(alignement != Align.none)
         {
            alignTo(alignement,alignTarget);
         }
      }
      
      private function _onAddedToStage(param1:Event) : void
      {
         layout();
         resize();
      }
      
      public function set forcedHeight(param1:uint) : void
      {
         _forcedHeight = param1;
      }
      
      public function set forcedWidth(param1:uint) : void
      {
         _forcedWidth = param1;
      }
   }
}


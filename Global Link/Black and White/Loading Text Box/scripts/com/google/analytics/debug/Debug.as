package com.google.analytics.debug
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class Debug extends Label
   {
      
      public static var count:uint = 0;
      
      private var _lines:Array;
      
      private var _preferredForcedWidth:uint = 540;
      
      public var maxLines:uint = 16;
      
      private var _linediff:int = 0;
      
      public function Debug(param1:uint = 0, param2:Align = null, param3:Boolean = false)
      {
         if(param2 == null)
         {
            param2 = Align.bottom;
         }
         super("","uiLabel",param1,param2,param3);
         this.name = "Debug" + count++;
         _lines = [];
         selectable = true;
         addEventListener(KeyboardEvent.KEY_DOWN,onKey);
      }
      
      public function close() : void
      {
         dispose();
      }
      
      public function writeBold(param1:String) : void
      {
         write(param1,true);
      }
      
      override protected function dispose() : void
      {
         removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
         super.dispose();
      }
      
      override public function get forcedWidth() : uint
      {
         if(this.parent)
         {
            if(UISprite(this.parent).forcedWidth > _preferredForcedWidth)
            {
               return _preferredForcedWidth;
            }
            return UISprite(this.parent).forcedWidth;
         }
         return super.forcedWidth;
      }
      
      private function onKey(param1:KeyboardEvent = null) : void
      {
         var _loc2_:Array = null;
         switch(param1.keyCode)
         {
            case Keyboard.DOWN:
               _loc2_ = _getLinesToDisplay(1);
               break;
            case Keyboard.UP:
               _loc2_ = _getLinesToDisplay(-1);
               break;
            default:
               _loc2_ = null;
         }
         if(_loc2_ == null)
         {
            return;
         }
         text = _loc2_.join("\n");
      }
      
      public function write(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         if(param1.indexOf("") > -1)
         {
            _loc3_ = param1.split("\n");
         }
         else
         {
            _loc3_ = [param1];
         }
         _loc4_ = "";
         _loc5_ = "";
         if(param2)
         {
            _loc4_ = "<b>";
            _loc5_ = "</b>";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _lines.push(_loc4_ + _loc3_[_loc6_] + _loc5_);
            _loc6_++;
         }
         _loc7_ = _getLinesToDisplay();
         text = _loc7_.join("\n");
      }
      
      private function _getLinesToDisplay(param1:int = 0) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(_lines.length - 1 > maxLines)
         {
            if(_linediff <= 0)
            {
               _linediff += param1;
            }
            else if(_linediff > 0 && param1 < 0)
            {
               _linediff += param1;
            }
            _loc3_ = uint(_lines.length - maxLines + _linediff);
            _loc4_ = _loc3_ + maxLines;
            _loc2_ = _lines.slice(_loc3_,_loc4_);
         }
         else
         {
            _loc2_ = _lines;
         }
         return _loc2_;
      }
   }
}


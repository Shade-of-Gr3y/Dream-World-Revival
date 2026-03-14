package com.google.analytics.debug
{
   import com.google.analytics.core.GIFRequest;
   import flash.net.URLRequest;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class DebugConfiguration
   {
      
      public var showHideKey:Number = Keyboard.SPACE;
      
      private var _mode:VisualDebugMode = VisualDebugMode.basic;
      
      private var _verbose:Boolean = false;
      
      public var destroyKey:Number = Keyboard.BACKSPACE;
      
      public var GIFRequests:Boolean = false;
      
      public var infoTimeout:Number = 1000;
      
      public var showInfos:Boolean = true;
      
      public var minimizedOnStart:Boolean = false;
      
      private var _active:Boolean = false;
      
      public var traceOutput:Boolean = false;
      
      public var layout:ILayout;
      
      public var warningTimeout:Number = 1500;
      
      public var javascript:Boolean = false;
      
      public var showWarnings:Boolean = true;
      
      private var _visualInitialized:Boolean = false;
      
      public function DebugConfiguration()
      {
         super();
      }
      
      public function get verbose() : Boolean
      {
         return _verbose;
      }
      
      public function set verbose(param1:Boolean) : void
      {
         _verbose = param1;
      }
      
      public function set mode(param1:*) : void
      {
         if(param1 is String)
         {
            switch(param1)
            {
               case "geek":
                  param1 = VisualDebugMode.geek;
                  break;
               case "advanced":
                  param1 = VisualDebugMode.advanced;
                  break;
               case "basic":
               default:
                  param1 = VisualDebugMode.basic;
            }
         }
         _mode = param1;
      }
      
      public function success(param1:String) : void
      {
         if(layout)
         {
            layout.createSuccessAlert(param1);
         }
         if(traceOutput)
         {
            trace("[+] " + param1 + " !!");
         }
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      private function _initializeVisual() : void
      {
         if(layout)
         {
            layout.init();
            _visualInitialized = true;
         }
      }
      
      private function _destroyVisual() : void
      {
         if(Boolean(layout) && _visualInitialized)
         {
            layout.destroy();
         }
      }
      
      public function warning(param1:String, param2:VisualDebugMode = null) : void
      {
         if(_filter(param2))
         {
            return;
         }
         if(Boolean(layout) && showWarnings)
         {
            layout.createWarning(param1);
         }
         if(traceOutput)
         {
            trace("## " + param1 + " ##");
         }
      }
      
      private function _filter(param1:VisualDebugMode = null) : Boolean
      {
         return Boolean(param1) && int(param1) >= int(this.mode);
      }
      
      public function failure(param1:String) : void
      {
         if(layout)
         {
            layout.createFailureAlert(param1);
         }
         if(traceOutput)
         {
            trace("[-] " + param1 + " !!");
         }
      }
      
      public function get mode() : *
      {
         return _mode;
      }
      
      public function set active(param1:Boolean) : void
      {
         _active = param1;
         if(_active)
         {
            _initializeVisual();
         }
         else
         {
            _destroyVisual();
         }
      }
      
      protected function trace(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         _loc2_ = [];
         _loc3_ = "";
         _loc4_ = "";
         if(this.mode == VisualDebugMode.geek)
         {
            _loc3_ = getTimer() + " - ";
            _loc4_ = new Array(_loc3_.length).join(" ") + " ";
         }
         if(param1.indexOf("\n") > -1)
         {
            _loc7_ = param1.split("\n");
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               if(_loc7_[_loc8_] != "")
               {
                  if(_loc8_ == 0)
                  {
                     _loc2_.push(_loc3_ + _loc7_[_loc8_]);
                  }
                  else
                  {
                     _loc2_.push(_loc4_ + _loc7_[_loc8_]);
                  }
               }
               _loc8_++;
            }
         }
         else
         {
            _loc2_.push(_loc3_ + param1);
         }
         _loc5_ = int(_loc2_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            trace(_loc2_[_loc6_]);
            _loc6_++;
         }
      }
      
      public function alert(param1:String) : void
      {
         if(layout)
         {
            layout.createAlert(param1);
         }
         if(traceOutput)
         {
            trace("!! " + param1 + " !!");
         }
      }
      
      public function info(param1:String, param2:VisualDebugMode = null) : void
      {
         if(_filter(param2))
         {
            return;
         }
         if(Boolean(layout) && showInfos)
         {
            layout.createInfo(param1);
         }
         if(traceOutput)
         {
            trace(param1);
         }
      }
      
      public function alertGifRequest(param1:String, param2:URLRequest, param3:GIFRequest) : void
      {
         if(layout)
         {
            layout.createGIFRequestAlert(param1,param2,param3);
         }
         if(traceOutput)
         {
            trace(">> " + param1 + " <<");
         }
      }
   }
}


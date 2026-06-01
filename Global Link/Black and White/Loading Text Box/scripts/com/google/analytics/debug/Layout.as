package com.google.analytics.debug
{
   import com.google.analytics.GATracker;
   import com.google.analytics.core.GIFRequest;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.net.URLRequest;
   
   public class Layout implements ILayout
   {
      
      private var _display:DisplayObject;
      
      private var _infoQueue:Array;
      
      private var _maxCharPerLine:int = 85;
      
      private var _hasInfo:Boolean;
      
      private var _warningQueue:Array;
      
      private var _hasDebug:Boolean;
      
      private var _hasWarning:Boolean;
      
      private var _mainPanel:Panel;
      
      private var _GRAlertQueue:Array;
      
      private var _debug:DebugConfiguration;
      
      public var visualDebug:Debug;
      
      private var _hasGRAlert:Boolean;
      
      public function Layout(param1:DebugConfiguration, param2:DisplayObject)
      {
         super();
         _display = param2;
         _debug = param1;
         _hasWarning = false;
         _hasInfo = false;
         _hasDebug = false;
         _hasGRAlert = false;
         _warningQueue = [];
         _infoQueue = [];
         _GRAlertQueue = [];
      }
      
      private function onKey(param1:KeyboardEvent = null) : void
      {
         switch(param1.keyCode)
         {
            case _debug.showHideKey:
               _mainPanel.visible = !_mainPanel.visible;
               break;
            case _debug.destroyKey:
               destroy();
         }
      }
      
      public function bringToFront(param1:DisplayObject) : void
      {
         _display.stage.setChildIndex(param1,_display.stage.numChildren - 1);
      }
      
      public function createFailureAlert(param1:String) : void
      {
         var _loc2_:AlertAction = null;
         var _loc3_:Alert = null;
         if(_debug.verbose)
         {
            param1 = _filterMaxChars(param1);
            _loc2_ = new AlertAction("Close","close","close");
         }
         else
         {
            _loc2_ = new AlertAction("X","close","close");
         }
         _loc3_ = new FailureAlert(_debug,param1,[_loc2_]);
         addToPanel("analytics",_loc3_);
         if(_hasDebug)
         {
            if(_debug.verbose)
            {
               param1 = param1.split("\n").join("");
               param1 = _filterMaxChars(param1,66);
            }
            visualDebug.writeBold(param1);
         }
      }
      
      public function init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Panel = null;
         _loc1_ = 10;
         _loc2_ = uint(_display.stage.stageWidth - _loc1_ * 2);
         _loc3_ = uint(_display.stage.stageHeight - _loc1_ * 2);
         _loc4_ = new Panel("analytics",_loc2_,_loc3_);
         _loc4_.alignement = Align.top;
         _loc4_.stickToEdge = false;
         _loc4_.title = "Google Analytics v" + GATracker.version;
         _mainPanel = _loc4_;
         addToStage(_loc4_);
         bringToFront(_loc4_);
         if(_debug.minimizedOnStart)
         {
            _mainPanel.onToggle();
         }
         createVisualDebug();
         _display.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey,false,0,true);
      }
      
      public function addToPanel(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Panel = null;
         _loc3_ = _display.stage.getChildByName(param1);
         if(_loc3_)
         {
            _loc4_ = _loc3_ as Panel;
            _loc4_.addData(param2);
         }
         else
         {
            trace("panel \"" + param1 + "\" not found");
         }
      }
      
      private function _clearInfo(param1:Event) : void
      {
         _hasInfo = false;
         if(_infoQueue.length > 0)
         {
            createInfo(_infoQueue.shift());
         }
      }
      
      private function _filterMaxChars(param1:String, param2:int = 0) : String
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         _loc3_ = "\n";
         _loc4_ = [];
         _loc5_ = param1.split(_loc3_);
         if(param2 == 0)
         {
            param2 = _maxCharPerLine;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc7_];
            while(_loc6_.length > param2)
            {
               _loc4_.push(_loc6_.substr(0,param2));
               _loc6_ = _loc6_.substring(param2);
            }
            _loc4_.push(_loc6_);
            _loc7_++;
         }
         return _loc4_.join(_loc3_);
      }
      
      public function createWarning(param1:String) : void
      {
         var _loc2_:Warning = null;
         if(_hasWarning || !isAvailable())
         {
            _warningQueue.push(param1);
            return;
         }
         param1 = _filterMaxChars(param1);
         _hasWarning = true;
         _loc2_ = new Warning(param1,_debug.warningTimeout);
         addToPanel("analytics",_loc2_);
         _loc2_.addEventListener(Event.REMOVED_FROM_STAGE,_clearWarning,false,0,true);
         if(_hasDebug)
         {
            visualDebug.writeBold(param1);
         }
      }
      
      private function _clearGRAlert(param1:Event) : void
      {
         _hasGRAlert = false;
         if(_GRAlertQueue.length > 0)
         {
            createGIFRequestAlert.apply(this,_GRAlertQueue.shift());
         }
      }
      
      public function createSuccessAlert(param1:String) : void
      {
         var _loc2_:AlertAction = null;
         var _loc3_:Alert = null;
         if(_debug.verbose)
         {
            param1 = _filterMaxChars(param1);
            _loc2_ = new AlertAction("Close","close","close");
         }
         else
         {
            _loc2_ = new AlertAction("X","close","close");
         }
         _loc3_ = new SuccessAlert(_debug,param1,[_loc2_]);
         addToPanel("analytics",_loc3_);
         if(_hasDebug)
         {
            if(_debug.verbose)
            {
               param1 = param1.split("\n").join("");
               param1 = _filterMaxChars(param1,66);
            }
            visualDebug.writeBold(param1);
         }
      }
      
      public function isAvailable() : Boolean
      {
         return _display.stage != null;
      }
      
      public function createAlert(param1:String) : void
      {
         var _loc2_:Alert = null;
         param1 = _filterMaxChars(param1);
         _loc2_ = new Alert(param1,[new AlertAction("Close","close","close")]);
         addToPanel("analytics",_loc2_);
         if(_hasDebug)
         {
            visualDebug.writeBold(param1);
         }
      }
      
      public function createInfo(param1:String) : void
      {
         var _loc2_:Info = null;
         if(_hasInfo || !isAvailable())
         {
            _infoQueue.push(param1);
            return;
         }
         param1 = _filterMaxChars(param1);
         _hasInfo = true;
         _loc2_ = new Info(param1,_debug.infoTimeout);
         addToPanel("analytics",_loc2_);
         _loc2_.addEventListener(Event.REMOVED_FROM_STAGE,_clearInfo,false,0,true);
         if(_hasDebug)
         {
            visualDebug.write(param1);
         }
      }
      
      public function createGIFRequestAlert(param1:String, param2:URLRequest, param3:GIFRequest) : void
      {
         var f:Function = null;
         var gra:GIFRequestAlert = null;
         var message:String = param1;
         var request:URLRequest = param2;
         var ref:GIFRequest = param3;
         if(_hasGRAlert)
         {
            _GRAlertQueue.push([message,request,ref]);
            return;
         }
         _hasGRAlert = true;
         f = function():void
         {
            ref.sendRequest(request);
         };
         message = _filterMaxChars(message);
         gra = new GIFRequestAlert(message,[new AlertAction("OK","ok",f),new AlertAction("Cancel","cancel","close")]);
         addToPanel("analytics",gra);
         gra.addEventListener(Event.REMOVED_FROM_STAGE,_clearGRAlert,false,0,true);
         if(_hasDebug)
         {
            if(_debug.verbose)
            {
               message = message.split("\n").join("");
               message = _filterMaxChars(message,66);
            }
            visualDebug.write(message);
         }
      }
      
      public function createVisualDebug() : void
      {
         if(!visualDebug)
         {
            visualDebug = new Debug();
            visualDebug.alignement = Align.bottom;
            visualDebug.stickToEdge = true;
            addToPanel("analytics",visualDebug);
            _hasDebug = true;
         }
      }
      
      public function addToStage(param1:DisplayObject) : void
      {
         _display.stage.addChild(param1);
      }
      
      private function _clearWarning(param1:Event) : void
      {
         _hasWarning = false;
         if(_warningQueue.length > 0)
         {
            createWarning(_warningQueue.shift());
         }
      }
      
      public function createPanel(param1:String, param2:uint, param3:uint) : void
      {
         var _loc4_:Panel = null;
         _loc4_ = new Panel(param1,param2,param3);
         _loc4_.alignement = Align.center;
         _loc4_.stickToEdge = false;
         addToStage(_loc4_);
         bringToFront(_loc4_);
      }
      
      public function destroy() : void
      {
         _mainPanel.close();
         _debug.layout = null;
      }
   }
}


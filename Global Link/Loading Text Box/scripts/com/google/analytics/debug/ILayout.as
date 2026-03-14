package com.google.analytics.debug
{
   import com.google.analytics.core.GIFRequest;
   import flash.display.DisplayObject;
   import flash.net.URLRequest;
   
   public interface ILayout
   {
      
      function createWarning(param1:String) : void;
      
      function addToStage(param1:DisplayObject) : void;
      
      function createGIFRequestAlert(param1:String, param2:URLRequest, param3:GIFRequest) : void;
      
      function createPanel(param1:String, param2:uint, param3:uint) : void;
      
      function createInfo(param1:String) : void;
      
      function createFailureAlert(param1:String) : void;
      
      function addToPanel(param1:String, param2:DisplayObject) : void;
      
      function init() : void;
      
      function createSuccessAlert(param1:String) : void;
      
      function createVisualDebug() : void;
      
      function createAlert(param1:String) : void;
      
      function destroy() : void;
      
      function bringToFront(param1:DisplayObject) : void;
      
      function isAvailable() : Boolean;
   }
}


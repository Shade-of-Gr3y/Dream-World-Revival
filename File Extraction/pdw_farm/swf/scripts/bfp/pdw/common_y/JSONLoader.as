package bfp.pdw.common_y
{
   import bfp.common.Connection;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pokemon.liby.event.CustomEvent;
   import caurina.transitions.*;
   import caurina.transitions.properties.*;
   import com.adobe.serialization.json.*;
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
   
   public class JSONLoader extends EventDispatcher
   {
      
      public static const ON_JSON_LOAD_COMPLETE:String = "onJSONLoadComplete";
      
      public static const ON_JSON_LOAD_ERROR:String = "onJSONLoadError";
      
      private var _object:Object;
      
      private var connectionObj:Connection;
      
      public var data:String = "";
      
      public function JSONLoader()
      {
         super();
         this.connectionObj = new Connection();
      }
      
      public function load(param1:String, param2:String = "POST", param3:Object = null) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         Logger.log("---------------------------");
         Logger.log("at JSONLoader LoadStart url:" + param1);
         this.connectionObj.method = param2;
         if(param3 != null)
         {
            for(_loc4_ in param3)
            {
               if(param3[_loc4_] is Array)
               {
                  Logger.log("at JSONLoader load Array parameter");
                  _loc5_ = 0;
                  while(_loc5_ < param3[_loc4_].length)
                  {
                     Logger.log("at JSONLoader " + _loc4_ + "[" + _loc5_ + "]:" + param3[_loc4_][_loc5_]);
                     _loc5_++;
                  }
               }
               else
               {
                  Logger.log("at JSONLoader request paramaters " + _loc4_ + ":" + param3[_loc4_]);
               }
            }
            this.connectionObj.request = param3;
         }
         this.connectionObj.request.token = PokemonBridge.token;
         this.connectionObj.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this.connectionObj.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.connectionObj.open(param1);
      }
      
      private function onLoadComplete(param1:Event) : *
      {
         Logger.log("at JSONLoader loadComplete");
         Logger.log("response ////" + this.connectionObj.data);
         Logger.log("---------------------------");
         this._object = com.adobe.serialization.json.JSON.decode(String(this.connectionObj.data));
         this.connectionObj.close();
         dispatchEvent(new CustomEvent(ON_JSON_LOAD_COMPLETE,this._object));
      }
      
      private function onIOError(param1:IOErrorEvent) : *
      {
         Logger.log("at JSONLoader loadError");
         Logger.log("---------------------------");
         var _loc2_:* = this.connectionObj.statusCode;
         var _loc3_:* = {};
         switch(_loc2_)
         {
            case null:
            case 0:
               _loc3_.error = {};
               _loc3_.error.code = 0;
               _loc3_.error.details = {};
               _loc3_.error.details.message = "";
               _loc3_.error.details.keys = ["none"];
               break;
            default:
               _loc3_.error = {};
               _loc3_.error.code = _loc2_;
               _loc3_.error.details = {};
               _loc3_.error.details.message = param1.text;
               if(_loc3_.error.details.message == "" || _loc3_.error.details.message == null)
               {
                  _loc3_.error.details.message = "";
               }
               _loc3_.error.details.keys = this.connectionObj.keys;
         }
         this.connectionObj.close();
         dispatchEvent(new CustomEvent(ON_JSON_LOAD_ERROR,_loc3_));
      }
      
      public function get object() : Object
      {
         return this._object;
      }
   }
}


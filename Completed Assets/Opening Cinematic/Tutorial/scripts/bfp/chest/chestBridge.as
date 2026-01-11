package bfp.chest
{
   import flash.display.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.*;
   
   public class chestBridge
   {
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var chest_mode:*;
      
      private static var design_type:*;
      
      private static var post_window:*;
      
      private static var button_close:*;
      
      private static var window_title:*;
      
      private static var message_title:*;
      
      private static var message_type:*;
      
      private static var message_body:*;
      
      private static var selected_item_data:*;
      
      private static var check_item_data:*;
      
      private static var request_item_set:*;
      
      private static var target_displayObject:*;
      
      public static const MODE_ALL:String = "mode_all";
      
      public static const MODE_NUTS:String = "mode_nuts";
      
      public static const DESIGN_SIDE:String = "design_side";
      
      public static const DESIGN_CENTER:String = "desingn_center";
      
      public static const POST_WINDOW:String = "post_window";
      
      public static const NO_POST_WINDOW:String = "no_post_window";
      
      public static const TYPE_CLICK:String = "type_click";
      
      public static const TYPE_YES_NO:String = "type_yes_no";
      
      public static const TYPE_CLOSE:String = "type_close";
      
      public static const BUTTON_NO_CLOSE:String = "button_no_close";
      
      public static const BUTTON_CLOSE:String = "button_close";
      
      public static const OPEN_CHEST:String = "open_chest";
      
      public static const CLOSE_CHEST:String = "close_chest";
      
      public static const SELECTED_YES:String = "selected_yes";
      
      public static const SELECTED_NO:String = "selected_no";
      
      public static const SELECTED_ONE:String = "selected_one";
      
      public static const SELECTED_CLOSE:String = "selected_close";
      
      public static const REQUEST_ITEM_RESULT:String = "request_item_result";
      
      public static const SWAP_CHILD:String = "swap_child";
      
      public static const NO_ITEM:String = "no_item";
      
      public static const SAME_ITEM:String = "same_item";
      
      public static var dreamland_top_url:* = "pdw.dreamland.top";
      
      public static const NUTS_BASEPATH:* = "../../global/parts/nuts/";
      
      public static const ITEM_BASEPATH:* = "../../global/parts/item/";
      
      private static var nuts_base_url:* = NUTS_BASEPATH;
      
      private static var item_base_url:* = ITEM_BASEPATH;
      
      public static var item_base_path:* = "";
      
      public static var workclass:*;
       
      
      public function chestBridge()
      {
         super();
      }
      
      public static function open(param1:String, param2:String = "desingn_center", param3:String = "post_window", param4:String = "button_close") : void
      {
         chest_mode = param1;
         design_type = param2;
         post_window = param3;
         button_close = param4;
         check_item_data = null;
         dispatchEvent(new Event(OPEN_CHEST));
      }
      
      public static function checkAndOpen(param1:String, param2:String = "desingn_center", param3:String = "post_window", param4:String = "button_close", param5:Object = null) : void
      {
         chest_mode = param1;
         design_type = param2;
         post_window = param3;
         button_close = param4;
         check_item_data = param5;
         dispatchEvent(new Event(OPEN_CHEST));
      }
      
      public static function close() : void
      {
         dispatchEvent(new Event(CLOSE_CHEST));
      }
      
      public static function loadDebugChest(param1:*, param2:String = "takarabako.swf") : void
      {
         var _loc3_:* = new URLRequest(param2);
         var _loc4_:* = new Loader();
         param1.addChild(_loc4_);
         _loc4_.load(_loc3_);
      }
      
      public static function set usedItemID(param1:*) : void
      {
         request_item_set = param1;
         dispatchEvent(new Event(REQUEST_ITEM_RESULT));
      }
      
      public static function get usedItemID() : *
      {
         return request_item_set;
      }
      
      public static function set requestItemSet(param1:*) : *
      {
         request_item_set = param1;
      }
      
      public static function get selectedItemData() : *
      {
         return selected_item_data;
      }
      
      public static function set selectedItemData(param1:*) : *
      {
         selected_item_data = param1;
      }
      
      public static function get selectedItem() : *
      {
         if(selected_item_data)
         {
            return selected_item_data.pokeitem_id;
         }
         return undefined;
      }
      
      public static function set selectedItem(param1:*) : *
      {
         if(selected_item_data)
         {
            selected_item_data.pokeitem_id = param1;
         }
      }
      
      public static function messageWindow(param1:String, param2:String) : void
      {
         message_title = param1;
         message_type = param2;
         message_body = null;
      }
      
      public static function messageWindow2(param1:String, param2:String, param3:String) : void
      {
         message_title = param1;
         message_body = param2;
         message_type = param3;
      }
      
      public static function get chestMode() : *
      {
         return chest_mode;
      }
      
      public static function set chestMode(param1:*) : *
      {
         chest_mode = param1;
      }
      
      public static function get designType() : *
      {
         return design_type;
      }
      
      public static function set designType(param1:*) : *
      {
         design_type = param1;
      }
      
      public static function get postWindow() : *
      {
         return post_window;
      }
      
      public static function set postWindow(param1:*) : *
      {
         post_window = param1;
      }
      
      public static function set windowTitle(param1:*) : *
      {
         window_title = param1;
      }
      
      public static function get windowTitle() : *
      {
         return window_title;
      }
      
      public static function get messageTitle() : *
      {
         return message_title;
      }
      
      public static function get messageType() : *
      {
         return message_type;
      }
      
      public static function set messageType(param1:String) : *
      {
         message_type = param1;
      }
      
      public static function get messageBody() : *
      {
         return message_body;
      }
      
      public static function get buttonClose() : *
      {
         return button_close;
      }
      
      public static function set buttonClose(param1:String) : *
      {
         button_close = param1;
      }
      
      public static function set itemBasePath(param1:*) : void
      {
         item_base_path = param1;
         nuts_base_url = param1 + "/" + NUTS_BASEPATH;
         item_base_url = param1 + "/" + ITEM_BASEPATH;
      }
      
      public static function get nutsBaseUrl() : *
      {
         return nuts_base_url;
      }
      
      public static function get itemBaseUrl() : *
      {
         return item_base_url;
      }
      
      public static function swapChild(param1:DisplayObject) : void
      {
         target_displayObject = param1;
         dispatchEvent(new Event(SWAP_CHILD));
      }
      
      public static function get targetDisplayObject() : *
      {
         return target_displayObject;
      }
      
      public static function get checkItemData() : *
      {
         return check_item_data;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
   }
}

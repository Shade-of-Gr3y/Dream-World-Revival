package common
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class gameBridge
   {
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var game_result:String;
      
      private static var game_rank:Number;
      
      private static var my_pokemon_id;
      
      private static var my_form_id;
      
      private static var encount_pokemon_id;
      
      private static var encount_form_id;
      
      private static var encount_pokemon_name;
      
      private static var rom_id;
      
      private static var pause_flag;
      
      private static var lang_code:String;
      
      private static var area_no;
      
      private static var course_data:Array;
       
      
      public function gameBridge()
      {
         super();
      }
      
      public static function startGame() : void
      {
         dispatchEvent(new gameBridgeEvent(gameBridgeEvent.START_GAME));
      }
      
      public static function closeGame() : void
      {
         dispatchEvent(new gameBridgeEvent(gameBridgeEvent.CLOSE_GAME));
      }
      
      public static function finishGame() : void
      {
         dispatchEvent(new gameBridgeEvent(gameBridgeEvent.FINISH_GAME));
      }
      
      public static function pauseGame() : void
      {
         dispatchEvent(new gameBridgeEvent(gameBridgeEvent.PAUSE_GAME));
      }
      
      public static function reStartGame() : void
      {
         dispatchEvent(new gameBridgeEvent(gameBridgeEvent.RESTART_GAME));
      }
      
      public static function set result(param1:*) : void
      {
         game_result = param1;
      }
      
      public static function get result() : String
      {
         return game_result;
      }
      
      public static function set rank(param1:*) : void
      {
         game_rank = param1;
      }
      
      public static function get rank() : Number
      {
         return game_rank;
      }
      
      public static function set myPokemonId(param1:*) : *
      {
         my_pokemon_id = param1;
      }
      
      public static function get myPokemonId() : *
      {
         return my_pokemon_id;
      }
      
      public static function set myFormId(param1:*) : *
      {
         my_form_id = param1;
      }
      
      public static function get myFormId() : *
      {
         return my_form_id;
      }
      
      public static function set encountPokemonId(param1:*) : *
      {
         encount_pokemon_id = param1;
      }
      
      public static function get encountPokemonId() : *
      {
         return encount_pokemon_id;
      }
      
      public static function set encountFormId(param1:*) : *
      {
         encount_form_id = param1;
      }
      
      public static function get encountFormId() : *
      {
         return encount_form_id;
      }
      
      public static function set encountPokemonName(param1:*) : *
      {
         encount_pokemon_name = param1;
      }
      
      public static function get encountPokemonName() : *
      {
         return encount_pokemon_name;
      }
      
      public static function set courseData(param1:*) : *
      {
         course_data = param1;
      }
      
      public static function get courseData() : *
      {
         return course_data;
      }
      
      public static function set areaNo(param1:*) : *
      {
         area_no = param1;
      }
      
      public static function get areaNo() : *
      {
         return area_no;
      }
      
      public static function set romID(param1:*) : void
      {
         rom_id = param1;
      }
      
      public static function get romID() : Number
      {
         return rom_id;
      }
      
      public static function set pauseFlag(param1:*) : void
      {
         pause_flag = param1;
      }
      
      public static function get pauseFlag() : Boolean
      {
         return pause_flag;
      }
      
      public static function set langCode(param1:*) : void
      {
         lang_code = param1;
      }
      
      public static function get langCode() : String
      {
         return lang_code;
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

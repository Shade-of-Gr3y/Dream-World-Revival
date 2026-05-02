package common
{
    import flash.events.*;

    public class gameBridge extends Object
    {
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        private static var game_result:String;
        private static var game_rank:Number;
        private static var my_pokemon_id:Object;
        private static var my_form_id:Object;
        private static var encount_pokemon_id:Object;
        private static var encount_form_id:Object;
        private static var encount_pokemon_name:Object;
        private static var rom_id:Object;
        private static var pause_flag:Object;
        private static var lang_code:String;
        private static var area_no:Object;
        private static var course_data:Array;

        public function gameBridge()
        {
            return;
        }// end function

        public static function startGame() : void
        {
            dispatchEvent(new gameBridgeEvent(gameBridgeEvent.START_GAME));
            return;
        }// end function

        public static function closeGame() : void
        {
            dispatchEvent(new gameBridgeEvent(gameBridgeEvent.CLOSE_GAME));
            return;
        }// end function

        public static function finishGame() : void
        {
            dispatchEvent(new gameBridgeEvent(gameBridgeEvent.FINISH_GAME));
            return;
        }// end function

        public static function pauseGame() : void
        {
            dispatchEvent(new gameBridgeEvent(gameBridgeEvent.PAUSE_GAME));
            return;
        }// end function

        public static function reStartGame() : void
        {
            dispatchEvent(new gameBridgeEvent(gameBridgeEvent.RESTART_GAME));
            return;
        }// end function

        public static function set result(param1) : void
        {
            game_result = param1;
            return;
        }// end function

        public static function get result() : String
        {
            return game_result;
        }// end function

        public static function set rank(param1) : void
        {
            game_rank = param1;
            return;
        }// end function

        public static function get rank() : Number
        {
            return game_rank;
        }// end function

        public static function set myPokemonId(param1)
        {
            my_pokemon_id = param1;
            return;
        }// end function

        public static function get myPokemonId()
        {
            return my_pokemon_id;
        }// end function

        public static function set myFormId(param1)
        {
            my_form_id = param1;
            return;
        }// end function

        public static function get myFormId()
        {
            return my_form_id;
        }// end function

        public static function set encountPokemonId(param1)
        {
            encount_pokemon_id = param1;
            return;
        }// end function

        public static function get encountPokemonId()
        {
            return encount_pokemon_id;
        }// end function

        public static function set encountFormId(param1)
        {
            encount_form_id = param1;
            return;
        }// end function

        public static function get encountFormId()
        {
            return encount_form_id;
        }// end function

        public static function set encountPokemonName(param1)
        {
            encount_pokemon_name = param1;
            return;
        }// end function

        public static function get encountPokemonName()
        {
            return encount_pokemon_name;
        }// end function

        public static function set courseData(param1)
        {
            course_data = param1;
            return;
        }// end function

        public static function get courseData()
        {
            return course_data;
        }// end function

        public static function set areaNo(param1)
        {
            area_no = param1;
            return;
        }// end function

        public static function get areaNo()
        {
            return area_no;
        }// end function

        public static function set romID(param1) : void
        {
            rom_id = param1;
            return;
        }// end function

        public static function get romID() : Number
        {
            return rom_id;
        }// end function

        public static function set pauseFlag(param1) : void
        {
            pause_flag = param1;
            return;
        }// end function

        public static function get pauseFlag() : Boolean
        {
            return pause_flag;
        }// end function

        public static function set langCode(param1) : void
        {
            lang_code = param1;
            return;
        }// end function

        public static function get langCode() : String
        {
            return lang_code;
        }// end function

        public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public static function dispatchEvent(event:Event) : Boolean
        {
            return _dispatcher.dispatchEvent(event);
        }// end function

        public static function hasEventListener(param1:String) : Boolean
        {
            return _dispatcher.hasEventListener(param1);
        }// end function

        public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public static function willTrigger(param1:String) : Boolean
        {
            return _dispatcher.willTrigger(param1);
        }// end function

    }
}

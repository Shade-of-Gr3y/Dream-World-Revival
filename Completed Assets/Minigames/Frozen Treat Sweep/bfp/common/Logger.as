package bfp.common
{
    import flash.events.*;

    public class Logger extends Object
    {
        public static const LOG:String = "LOG";
        private static var _dispatcher:EventDispatcher = new EventDispatcher();
        public static var text:String = "";

        public function Logger()
        {
            return;
        }// end function

        public static function log(param1:Object) : void
        {
            text = param1 as String;
            dispatchEvent(new Event(LOG));
            return;
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

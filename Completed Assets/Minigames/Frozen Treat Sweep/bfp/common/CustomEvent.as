package bfp.common
{
    import flash.events.*;

    public class CustomEvent extends Event
    {
        private var _data:Object;
        public static const CUSTOM_EVENT:String = "CUSTOM_EVENT";

        public function CustomEvent(param1:String, param2:Object = null)
        {
            this._data = param2;
            super(param1);
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

    }
}

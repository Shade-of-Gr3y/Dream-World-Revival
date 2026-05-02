package jp.co.pokemon.games.hsc
{

    public class Global extends Object
    {
        public static var isStandalone:Boolean;
        public static var windowMessageID:String;
        public static var windowMessageID_Current:String;
        public static var windowMessageAutoClose:Boolean;

        public function Global()
        {
            return;
        }// end function

        public static function windowMessageGo(param1:String) : void
        {
            Global.windowMessageID = param1;
            windowMessageID_Current = null;
            Global.windowMessageAutoClose = true;
            return;
        }// end function

    }
}

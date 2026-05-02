package 
{
    import flash.display.*;
    import jp.co.pokemon.games.hsc.*;

    dynamic public class mclCountDown extends MovieClip
    {
        public var start:MovieClip;
        public var count1:MovieClip;
        public var count2:MovieClip;
        public var count3:MovieClip;

        public function mclCountDown()
        {
            addFrameScript(5, this.frame6, 35, this.frame36, 65, this.frame66, 95, this.frame96);
            return;
        }// end function

        function frame6()
        {
            ZSound.play("count");
            return;
        }// end function

        function frame36()
        {
            ZSound.play("count");
            return;
        }// end function

        function frame66()
        {
            ZSound.play("count");
            return;
        }// end function

        function frame96()
        {
            ZSound.play("count_start");
            return;
        }// end function

    }
}

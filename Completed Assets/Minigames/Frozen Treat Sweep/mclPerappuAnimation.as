package 
{
    import flash.display.*;

    dynamic public class mclPerappuAnimation extends MovieClip
    {
        public var mciIt:poke_perappu;

        public function mclPerappuAnimation()
        {
            addFrameScript(0, this.frame1, 27, this.frame28, 41, this.frame42, 58, this.frame59);
            return;
        }// end function

        function frame1()
        {
            this.isSweetsGo = false;
            this.isTuraraFront = false;
            this.isEnd = false;
            return;
        }// end function

        function frame28()
        {
            this.isSweetsGo = true;
            return;
        }// end function

        function frame42()
        {
            this.isTuraraFront = true;
            return;
        }// end function

        function frame59()
        {
            this.isEnd = true;
            stop();
            return;
        }// end function

    }
}

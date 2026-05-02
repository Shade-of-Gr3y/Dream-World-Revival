package 
{
    import flash.display.*;

    dynamic public class mclFuwarideAnimation extends MovieClip
    {
        public var mciIt:MovieClip;

        public function mclFuwarideAnimation()
        {
            addFrameScript(0, this.frame1, 61, this.frame62, 148, this.frame149);
            return;
        }// end function

        function frame1()
        {
            this.isSweetsGo = false;
            this.isEnd = false;
            return;
        }// end function

        function frame62()
        {
            this.isSweetsGo = true;
            return;
        }// end function

        function frame149()
        {
            this.isEnd = true;
            stop();
            return;
        }// end function

    }
}

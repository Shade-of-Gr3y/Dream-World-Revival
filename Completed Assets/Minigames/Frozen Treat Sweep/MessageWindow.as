package 
{
    import flash.display.*;
    import flash.text.*;

    dynamic public class MessageWindow extends MovieClip
    {
        public var texti_MESSAGE_WINDOW:TextField;

        public function MessageWindow()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            this.visible = false;
            return;
        }// end function

    }
}

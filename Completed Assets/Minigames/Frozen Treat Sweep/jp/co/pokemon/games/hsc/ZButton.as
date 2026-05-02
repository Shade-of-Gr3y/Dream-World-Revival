package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    public class ZButton extends MovieClip
    {
        public var texti_DIALOG_BUTTON_NO_S:TextField;
        public var texti_DIALOG_BUTTON_NO:TextField;
        public var texti_BUTTON_TOP_EXIT:TextField;
        public var texti_DIALOG_BUTTON_START_S:TextField;
        public var texti_DIALOG_BUTTON_YES:TextField;
        public var texti_DIALOG_BUTTON_CLOSE:TextField;
        public var texti_DIALOG_BUTTON_YES_S:TextField;
        public var texti_DIALOG_BUTTON_START:TextField;
        public var texti_DIALOG_BUTTON_CLOSE_S:TextField;
        public var mciBase:MovieClip;
        public var isRollover:Boolean = false;
        public var isDown:Boolean = false;
        private var isClicked:Boolean = false;
        private var clickDisplayRemain:int = 0;
        private var isActiveValue:Boolean = true;
        private var isActiveValue2:Boolean = true;
        public var tfTextMain:TextField;
        public var tfTextShadow:TextField;
        public var orgPos:Pos2;
        public static const F_NORMAL:uint = 1;
        public static const F_ROLLOVER:uint = 2;
        public static const F_CLICK:uint = 3;
        private static const clickDisplayRemainStart:int = 10;

        public function ZButton()
        {
            var _loc_2:Object = null;
            var _loc_3:TextField = null;
            addEventListener(MouseEvent.CLICK, this.click);
            addEventListener(MouseEvent.MOUSE_DOWN, this.down);
            addEventListener(MouseEvent.MOUSE_UP, this.up);
            addEventListener(MouseEvent.ROLL_OVER, this.rollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.rollOut);
            addEventListener(Event.ENTER_FRAME, this.enterFrame);
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            buttonMode = true;
            mouseChildren = false;
            this.mciBase.mouseEnabled = false;
            this.mciBase.gotoAndStop(F_NORMAL);
            this.orgPos = new Pos2(this.x, this.y);
            var _loc_1:int = 0;
            while (_loc_1 < this.numChildren)
            {
                
                _loc_2 = this.getChildAt(_loc_1);
                if (_loc_2.name.indexOf("texti_") != -1)
                {
                    _loc_3 = TextField(_loc_2);
                    if (_loc_3.name.substr(_loc_2.name.length - 2) == "_S")
                    {
                        this.tfTextShadow = TextField(_loc_3);
                        this.tfTextShadow.mouseEnabled = false;
                    }
                    else
                    {
                        this.tfTextMain = TextField(_loc_3);
                        this.tfTextMain.mouseEnabled = false;
                    }
                }
                _loc_1++;
            }
            if (this.tfTextShadow)
            {
                this.tfTextShadow.y = this.tfTextShadow.y + 4;
                this.tfTextMain.y = this.tfTextMain.y + 4;
            }
            else if (this.tfTextMain)
            {
                this.tfTextMain.y = this.tfTextMain.y + 2;
            }
            this.displayUpdate();
            return;
        }// end function

        private function removedFromStageHandler(event:Event) : void
        {
            removeEventListener(MouseEvent.CLICK, this.click);
            removeEventListener(MouseEvent.MOUSE_DOWN, this.down);
            removeEventListener(MouseEvent.MOUSE_UP, this.up);
            removeEventListener(MouseEvent.ROLL_OVER, this.rollOver);
            removeEventListener(MouseEvent.ROLL_OUT, this.rollOut);
            removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            return;
        }// end function

        public function set isActive2(param1:Boolean) : void
        {
            if (this.isActiveValue2 == param1)
            {
                return;
            }
            this.isActiveValue2 = param1;
            this.activeRefresh();
            return;
        }// end function

        public function set isActive(param1:Boolean) : void
        {
            if (this.isActiveValue == param1)
            {
                return;
            }
            this.isActiveValue = param1;
            this.activeRefresh();
            return;
        }// end function

        public function activeRefresh() : void
        {
            mouseEnabled = this.isActive;
            this.isRollover = false;
            this.isDown = false;
            this.clickDisplayRemain = 0;
            this.isClicked = false;
            this.displayUpdate();
            return;
        }// end function

        public function get isActive() : Boolean
        {
            return this.isActiveValue && this.isActiveValue2;
        }// end function

        public function clearClick() : void
        {
            this.isClicked = false;
            this.isDown = false;
            this.displayUpdate();
            return;
        }// end function

        private function down(event:Event) : void
        {
            if (!this.isActive)
            {
                return;
            }
            this.isDown = true;
            this.displayUpdate();
            return;
        }// end function

        private function up(event:Event) : void
        {
            if (!this.isActive)
            {
                return;
            }
            this.isDown = false;
            this.displayUpdate();
            return;
        }// end function

        private function click(event:Event) : void
        {
            if (!this.isActive)
            {
                return;
            }
            this.clickForce();
            return;
        }// end function

        public function clickForce() : void
        {
            this.isClicked = true;
            this.clickDisplayRemain = clickDisplayRemainStart;
            this.displayUpdate();
            return;
        }// end function

        private function rollOut(event:Event) : void
        {
            this.isRollover = false;
            this.isDown = false;
            this.displayUpdate();
            return;
        }// end function

        private function rollOver(event:Event) : void
        {
            if (this.isDown)
            {
                return;
            }
            this.isRollover = true;
            this.displayUpdate();
            ZSound.play("rollOver");
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            if (this.clickDisplayRemain > 0)
            {
                var _loc_2:String = this;
                var _loc_3:* = this.clickDisplayRemain - 1;
                _loc_2.clickDisplayRemain = _loc_3;
                if (this.clickDisplayRemain == 0)
                {
                    this.displayUpdate();
                }
            }
            return;
        }// end function

        private function displayUpdate() : void
        {
            var _loc_1:MovieClip = null;
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            if (this.isActive)
            {
                _loc_2 = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
                filters = [new ColorMatrixFilter(_loc_2)];
                this.mcResetOffset();
                if (this.clickDisplayRemain > 0 || this.isDown)
                {
                    this.mciBase.gotoAndStop(F_CLICK);
                    this.mcSetOffset();
                }
                else if (this.isRollover)
                {
                    this.mciBase.gotoAndStop(F_ROLLOVER);
                }
                else
                {
                    this.mciBase.gotoAndStop(F_NORMAL);
                }
            }
            else
            {
                _loc_2 = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 0.5, 0];
                _loc_3 = [new ColorMatrixFilter(_loc_2)];
                filters = _loc_3;
                this.mciBase.gotoAndStop(F_NORMAL);
            }
            if (this.tfTextShadow)
            {
                this.tfTextShadow.visible = !this.isDown;
            }
            return;
        }// end function

        private function mcSetOffset() : void
        {
            var _loc_1:* = this.height / 30;
            this.x = this.orgPos.x + _loc_1;
            this.y = this.orgPos.y + _loc_1;
            return;
        }// end function

        private function mcResetOffset() : void
        {
            this.x = this.orgPos.x;
            this.y = this.orgPos.y;
            return;
        }// end function

        public function getIsClicked() : Boolean
        {
            var _loc_1:* = this.isClicked;
            this.isClicked = false;
            if (_loc_1)
            {
                if (this.tfTextShadow)
                {
                    ZSound.play("click_big");
                }
                else
                {
                    ZSound.play("click_small");
                }
            }
            return _loc_1;
        }// end function

    }
}

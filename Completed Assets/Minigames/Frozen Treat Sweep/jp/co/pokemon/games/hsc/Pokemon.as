package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.filters.*;

    public class Pokemon extends Object
    {
        public var index:int;
        public var type:int;
        public var mclName:String;
        public var ppos:Pos2;
        public var dpos:Pos2;
        public var pposPass:Pos2;
        private var jumpStartPos:Pos2;
        public var dir4:int;
        public var mcDraw:MovieClip;
        public var mcThis:MovieClip;
        public var mcForStatus:MovieClip;
        private var mcWaterspout:MovieClip;
        private var mcShadow:MovieClip;
        public var routeLine:RouteLine;
        public var moveStepInPanel:int;
        private var state:State;
        public var boardShakeOffsetY:int = 0;
        public var ReturnFromDropY:Number = 0;
        public var swReturnFromDropShadow:Boolean = false;
        public var dropOffset:Number;
        public var dropOffsetDisplay:int;
        public var dropSpeed:Number = 0;
        public var defaultScale:Number;
        private const dropMaxY:int = 100;
        private const NON_DISPLAY_APLHA:Number = 0.01;
        private var noDisplayShadow:MovieClip;
        public static const moveDurationAtPanel:int = 30;

        public function Pokemon(param1:int, param2:Object)
        {
            this.mcDraw = new MovieClip();
            this.mcShadow = new RoundShadow();
            this.noDisplayShadow = new MovieClip();
            this.index = param1;
            this.type = param2.type;
            this.mclName = param2.name;
            this.mcThis = param2.mc;
            if (this.index == 0)
            {
                this.mcThis.filters = [new GlowFilter(16675840, 1, 4, 4, 6)];
            }
            this.mcForStatus = param2.mcForStatus;
            this.ppos = new Pos2(0, 0);
            this.dpos = new Pos2(0, 0);
            this.pposPass = null;
            this.dir4 = 0;
            this.mcDraw.addChild(this.mcThis);
            this.mcDraw.cacheAsBitmap = true;
            this.mcDraw.mouseChildren = false;
            this.mcDraw.mouseEnabled = false;
            this.mcThis.cacheAsBitmap = true;
            this.mcThis.mouseChildren = false;
            this.mcThis.mouseEnabled = false;
            Tools.shadowInit(this.mcShadow);
            this.mcThis.gotoAndStop(3);
            var _loc_3:* = param2.scale;
            this.mcThis.scaleY = param2.scale;
            var _loc_3:* = _loc_3;
            this.mcThis.scaleX = _loc_3;
            this.defaultScale = _loc_3;
            this.routeLine = new RouteLine(RouteLine.LINE_TYPE_NON_DISPLAY);
            this.moveStepInPanel = 0;
            this.dropOffset = 0;
            this.state = new State("Pokemon" + param1);
            this.mcWaterspout = new mclWaterspout();
            this.mcWaterspout.gotoAndStop(1);
            this.mcWaterspout.mouseChildren = false;
            this.mcWaterspout.mouseEnabled = false;
            this.mcWaterspout.visible = false;
            if (this.index != 0)
            {
                this.state.appoint("Main");
                this.update();
            }
            return;
        }// end function

        public function isCom() : Boolean
        {
            return this.index != 0;
        }// end function

        public function isMan() : Boolean
        {
            return this.index == 0;
        }// end function

        public function setPos(param1:Pos2) : void
        {
            this.ppos = param1.clone();
            Tools.alert(this.ppos.x < PanelAll.whMax, "err");
            this.calcNewPosition();
            return;
        }// end function

        public function getPPos() : Pos2
        {
            return this.ppos;
        }// end function

        public function getNextPPos() : Pos2
        {
            if (this.routeLine.lineTbl.length <= 1)
            {
                return this.ppos;
            }
            return this.routeLine.lineTbl[1].ppos;
        }// end function

        public function get dir() : Number
        {
            return Tools.dir4ToDir(this.dir4);
        }// end function

        public function isStop() : Boolean
        {
            return this.routeLine.lineTbl.length == 0;
        }// end function

        public function isPanelCenter() : Boolean
        {
            return this.moveStepInPanel == 0;
        }// end function

        public function routeClear() : void
        {
            this.routeLine.lineTbl.length = 0;
            this.moveStepInPanel = 0;
            return;
        }// end function

        public function isMoveAble() : Boolean
        {
            return this.state.getValue() == "Main";
        }// end function

        public function isDrop() : Boolean
        {
            return this.state.getValue() == "Drop" || this.state.getValue() == "DropEnd";
        }// end function

        public function getState() : String
        {
            return this.state.getValue();
        }// end function

        public function appointState(param1:String) : void
        {
            return this.state.appoint(param1);
        }// end function

        public function goDrop() : void
        {
            this.routeClear();
            this.state.appoint("Drop");
            this.update();
            return;
        }// end function

        public function goFlyIn() : void
        {
            if (this.isMan())
            {
                ZSound.play("jump_in");
            }
            this.state.pushCall("IdleMove", "ReturnFromDrop");
            return;
        }// end function

        public function goPlayStart() : void
        {
            this.state.appoint("Main");
            return;
        }// end function

        public function goPlayFromDrop() : void
        {
            if (this.isMan())
            {
                ZSound.play("get_back");
            }
            this.state.pushCall("Main", "ReturnFromDrop");
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:Pos2 = null;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:Pos2 = null;
            var _loc_6:Pos2 = null;
            this.pposPass = null;
            switch(this.state.update())
            {
                case "Begin":
                {
                    break;
                }
                case "Wait":
                {
                    if (this.state.isFirst())
                    {
                        Tools.shadowScaleAlphaSetting(this.mcShadow, 1, this.boardShakeOffsetY, this.dpos);
                    }
                    break;
                }
                case "Main":
                {
                    if (this.state.isFirst())
                    {
                        this.dropOffsetDisplay = 0;
                        this.mcThis.visible = true;
                        this.mcWaterspout.visible = false;
                    }
                    Tools.shadowScaleAlphaSetting(this.mcShadow, 1, this.boardShakeOffsetY, this.dpos);
                    this.pposPass = this.moveNext();
                    break;
                }
                case "Drop":
                {
                    if (this.state.isFirst())
                    {
                        this.routeClear();
                        this.dropOffset = 0;
                        this.dropOffsetDisplay = 0;
                        this.dropSpeed = 0;
                        this.dpos = PanelAll.getPPos2DPos(this.ppos).clone();
                        this.mcWaterspout.visible = false;
                        ZSound.play("fall_falling");
                    }
                    if (!this.mcWaterspout.visible && this.dropOffset > 60)
                    {
                        this.mcWaterspout.visible = true;
                        this.mcWaterspout.x = this.dpos.x;
                        this.mcWaterspout.y = this.dpos.y + PanelAll.dposy2Scale(this.dpos.y) * 80;
                        var _loc_7:* = PanelAll.dposy2Scale(this.dpos.y) * 1.3;
                        this.mcWaterspout.scaleY = PanelAll.dposy2Scale(this.dpos.y) * 1.3;
                        this.mcWaterspout.scaleX = _loc_7;
                        this.mcWaterspout.gotoAndPlay(1);
                        ZSound.play("fall_splash");
                    }
                    this.dropOffset = this.dropOffset + this.dropSpeed;
                    (this.dropSpeed + 1);
                    this.dropOffsetDisplay = PanelAll.dposy2Scale(this.dpos.y) * this.dropOffset;
                    if (this.dropOffset > this.dropMaxY)
                    {
                        this.state.appoint("DropAfterUD");
                    }
                    break;
                }
                case "DropAfterUD":
                {
                    if (this.state.isFirst())
                    {
                        this.mcThis.alpha = this.NON_DISPLAY_APLHA;
                    }
                    if (Tools.mcIsEnd(this.mcWaterspout))
                    {
                        this.mcThis.visible = false;
                        this.mcThis.alpha = 1;
                        this.mcWaterspout.visible = false;
                        this.dropOffsetDisplay = 0;
                        this.state.appoint("DropEnd");
                    }
                    break;
                }
                case "DropEnd":
                {
                    if (this.state.isFirst())
                    {
                    }
                    break;
                }
                case "IdleMove":
                {
                    _loc_1 = PanelAll.getPPos2DPos(this.ppos);
                    _loc_2 = [2, 6, 7, 11, 6, 0, 0, 2, 6, 7, 11, 6, 0];
                    _loc_3 = _loc_2[this.state.getTime()];
                    this.dpos.y = _loc_1.y - _loc_3;
                    if (this.state.getTime() >= (_loc_2.length - 1))
                    {
                        this.state.appoint("Wait");
                    }
                    Tools.shadowScaleAlphaSetting(this.mcShadow, 1, this.boardShakeOffsetY, _loc_1);
                    break;
                }
                case "ReturnFromDrop":
                {
                    if (this.state.isFirst())
                    {
                        if (this.ppos.x > Number(PanelAll.whMax) / 2)
                        {
                            _loc_5 = PanelAll.getPPos2DPos(new Pos2(PanelAll.whMax - 2, this.ppos.y));
                            _loc_6 = PanelAll.getPPos2DPos(new Pos2((PanelAll.whMax - 1), this.ppos.y));
                            this.mcThis.gotoAndStop(4);
                        }
                        else
                        {
                            _loc_5 = PanelAll.getPPos2DPos(new Pos2(1, this.ppos.y));
                            _loc_6 = PanelAll.getPPos2DPos(new Pos2(0, this.ppos.y));
                            this.mcThis.gotoAndStop(2);
                        }
                        this.dpos.x = _loc_6.x + (_loc_6.x - _loc_5.x);
                        this.dpos.y = _loc_6.y;
                        this.jumpStartPos = this.dpos.clone();
                        var _loc_7:* = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
                        this.mcThis.scaleY = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
                        this.mcThis.scaleX = _loc_7;
                        this.mcThis.visible = true;
                        this.mcDraw.x = this.dpos.x;
                        this.mcDraw.y = this.dpos.y;
                        this.dir4 = 2;
                    }
                    _loc_4 = Tools.calcJumpParabola(this.ppos, this.jumpStartPos, 100, 15, this.state.getTime());
                    this.ReturnFromDropY = _loc_4.yHeight;
                    this.dpos = _loc_4.dpos;
                    this.swReturnFromDropShadow = _loc_4.isNeedShadow;
                    if (_loc_4.isEnd)
                    {
                        this.state.popReturn();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function draw(param1:MovieClip, param2:int) : void
        {
            var _loc_3:MovieClip = null;
            if (!this.mcThis.visible)
            {
                return;
            }
            switch(this.state.getValue())
            {
                case "Main":
                case "Wait":
                case "IdleMove":
                case "Drop":
                case "DropAfterUD":
                {
                    if (param2 != this.ppos.y)
                    {
                        break;
                    }
                    if (this.state.getValue() == "Main" || this.state.getValue() == "IdleMove" || this.state.getValue() == "Wait")
                    {
                        _loc_3 = this.getShadowMask();
                        if (_loc_3 != this.noDisplayShadow)
                        {
                            this.mcShadow.mask = null;
                            param1.addChild(this.mcShadow);
                            if (_loc_3 != null)
                            {
                                param1.addChild(_loc_3);
                                this.mcShadow.mask = _loc_3;
                            }
                        }
                    }
                    if (this.mcThis.alpha != this.NON_DISPLAY_APLHA)
                    {
                        param1.addChild(this.mcDraw);
                    }
                    this.mcDraw.x = this.dpos.x;
                    this.mcDraw.y = this.dpos.y + this.dropOffsetDisplay;
                    if (this.state.getValue() == "Main")
                    {
                        this.mcDraw.y = this.mcDraw.y + this.boardShakeOffsetY;
                    }
                    var _loc_4:* = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
                    this.mcThis.scaleY = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
                    this.mcThis.scaleX = _loc_4;
                    this.mcThis.gotoAndStop((this.dir4 + 1) % 4 + 1);
                    if (this.mcWaterspout.visible)
                    {
                        param1.addChild(this.mcWaterspout);
                    }
                    break;
                }
                case "ReturnFromDrop":
                {
                    if (param2 != this.ppos.y)
                    {
                        break;
                    }
                    this.mcShadow.mask = null;
                    param1.addChild(this.mcDraw);
                    this.mcDraw.x = this.dpos.x;
                    this.mcDraw.y = this.dpos.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function moveNext() : Pos2
        {
            if (this.routeLine.lineTbl.length == 0)
            {
                return null;
            }
            var _loc_1:* = this.ppos;
            this.dir4 = this.routeLine.lineTbl[0].dir4;
            var _loc_2:String = this;
            var _loc_3:* = this.moveStepInPanel + 1;
            _loc_2.moveStepInPanel = _loc_3;
            if (this.moveStepInPanel >= moveDurationAtPanel)
            {
                this.moveStepInPanel = 0;
                this.routeLine.shift();
                this.dir4 = this.routeLine.lineTbl[0].dir4;
                if (this.routeLine.lineTbl.length <= 1)
                {
                    this.routeLine.lineTbl.length = 0;
                }
            }
            this.calcNewPosition();
            Tools.alert(this.ppos.x < 5, "msg");
            if (!this.ppos.isEq(_loc_1))
            {
                return _loc_1;
            }
            return null;
        }// end function

        private function calcNewPosition() : void
        {
            var _loc_1:Pos2 = null;
            var _loc_2:Pos2 = null;
            var _loc_3:Pos2 = null;
            var _loc_4:Pos2 = null;
            var _loc_5:Pos2 = null;
            if (this.routeLine.lineTbl.length == 0)
            {
                this.dpos = PanelAll.getPPos2DPos(this.ppos).clone();
            }
            else
            {
                _loc_1 = this.routeLine.lineTbl[0].ppos;
                _loc_2 = this.routeLine.lineTbl[1].ppos;
                _loc_3 = PanelAll.getPPos2DPos(_loc_1);
                _loc_4 = PanelAll.getPPos2DPos(_loc_2);
                _loc_5 = _loc_4.subFrom(_loc_3);
                this.dpos = _loc_3.add(_loc_5.mul(this.moveStepInPanel / moveDurationAtPanel));
                this.ppos = PanelAll.getDPos2PanelPosForPokemon(this.dpos);
            }
            Tools.alert(PanelAll.isDPositionValid(this.ppos), "calcNewPosition");
            return;
        }// end function

        private function getShadowMask() : MovieClip
        {
            var _loc_5:Panel = null;
            if (this.routeLine.lineTbl.length == 0)
            {
                _loc_5 = PanelAll.getPPos2PanelObj(this.ppos);
                if (_loc_5.isMelted())
                {
                    return this.noDisplayShadow;
                }
                return null;
            }
            var _loc_1:* = this.routeLine.lineTbl[0].ppos;
            var _loc_2:* = PanelAll.getPPos2PanelObj(_loc_1);
            if (this.moveStepInPanel == 0)
            {
                if (_loc_2.isMelted())
                {
                    return this.noDisplayShadow;
                }
                return null;
            }
            var _loc_3:* = this.routeLine.lineTbl[1].ppos;
            var _loc_4:* = PanelAll.getPPos2PanelObj(_loc_3);
            if (_loc_2.isMelted() && _loc_4.isMelted())
            {
                return this.noDisplayShadow;
            }
            if (!_loc_2.isMelted() && !_loc_4.isMelted())
            {
                return null;
            }
            if (_loc_2.isMelted())
            {
                return _loc_4.mcMask;
            }
            if (_loc_4.isMelted())
            {
                return _loc_2.mcMask;
            }
            return null;
        }// end function

    }
}

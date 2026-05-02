package jp.co.pokemon.games.hsc
{
    import caurina.transitions.*;
    import flash.display.*;
    import flash.utils.*;

    public class Crowd extends Object
    {
        public var mcDraw:MovieClip;
        public var mcThis:MovieClip;
        public var dpos:Pos2;
        public var mclName:String;
        public var isAbleFallSweets:Boolean;
        private var state:State;
        private var startY:Number;
        private var speed:Number;
        private var jumpY:Number = 0;
        private var acceleration:Number;
        private var flagIsSweetsGo:Boolean = false;
        private var putInType:String;
        private var ToIdleMoveDuration:int;
        private var IdleMoveRepeat:int;
        private var mcShadow:MovieClip;
        public var defaultScale:Number;

        public function Crowd(param1:String, param2:Pos2, param3:Boolean)
        {
            this.mcDraw = new MovieClip();
            this.mcShadow = new RoundShadow();
            this.mclName = param1;
            this.isAbleFallSweets = param3;
            this.dpos = param2;
            this.defaultScale = PokeMc.getNameToScale(this.mclName);
            var _loc_4:* = getDefinitionByName(param1) as Class;
            this.mcThis = new _loc_4;
            this.mcThis.gotoAndStop(1);
            var _loc_6:* = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
            this.mcThis.scaleY = this.defaultScale * PanelAll.dposy2Scale(this.dpos.y);
            this.mcThis.scaleX = _loc_6;
            this.mcThis.cacheAsBitmap = true;
            var _loc_5:Number = 1;
            Tools.shadowInit(this.mcShadow);
            var _loc_6:* = _loc_5 * PanelAll.dposy2Scale(this.dpos.y);
            this.mcShadow.scaleY = _loc_5 * PanelAll.dposy2Scale(this.dpos.y);
            this.mcShadow.scaleX = _loc_6;
            this.mcShadow.visible = true;
            this.mcShadow.cacheAsBitmap = true;
            this.mcShadow.x = 0;
            this.mcShadow.y = 0;
            this.mcDraw.x = this.dpos.x;
            this.mcDraw.y = this.dpos.y;
            this.mcDraw.cacheAsBitmap = true;
            this.mcDraw.addChild(this.mcShadow);
            this.mcDraw.addChild(this.mcThis);
            this.state = new State("Crowd", false);
            return;
        }// end function

        public function getPanelPos() : Pos2
        {
            return PanelAll.getDPos2PanelPos(this.dpos);
        }// end function

        public function update() : void
        {
            var timeRate:Number;
            var rate0:Number;
            var rate1:Number;
            var duration:Number;
            var twCallback:Function;
            var yaddTbl:Array;
            var n:int;
            twCallback = function ()
            {
                this.isEnd = true;
                return;
            }// end function
            ;
            switch(this.state.update())
            {
                case "Begin":
                {
                    this.state.appoint("DefaultPose");
                    break;
                }
                case "DefaultPose":
                {
                    if (this.state.isFirst())
                    {
                        this.mcDraw.y = this.dpos.y;
                        this.jumpY = 0;
                        this.flagIsSweetsGo = false;
                        this.mcThis.gotoAndStop(1);
                        this.ToIdleMoveDuration = Tools.randomLessInt(120) + 20;
                    }
                    if (this.state.getTime() > this.ToIdleMoveDuration)
                    {
                        this.IdleMoveRepeat = Tools.randomLessInt(3);
                        this.state.appoint("IdleMove");
                    }
                    break;
                }
                case "IdleMove":
                {
                    if (this.state.isFirst())
                    {
                    }
                    yaddTbl;
                    n = yaddTbl[this.state.getTime()];
                    this.mcThis.y = -n;
                    if (this.state.getTime() >= (yaddTbl.length - 1))
                    {
                        var _loc_2:String = this;
                        var _loc_3:* = this.IdleMoveRepeat - 1;
                        _loc_2.IdleMoveRepeat = _loc_3;
                        if (this.IdleMoveRepeat <= 0)
                        {
                            this.state.appoint("DefaultPose");
                        }
                        else
                        {
                            this.state.appoint("IdleMove");
                        }
                    }
                    break;
                }
                case "SweetsThrowGo":
                {
                    if (this.state.isFirst())
                    {
                        if (this.mcThis.totalFrames >= 2)
                        {
                            this.mcThis.gotoAndStop(2);
                        }
                        this.mcThis.isEnd = false;
                        Tweener.addTween(this.mcThis, {time:0.1, y:-23, transition:"easeOutCubic"});
                        Tweener.addTween(this.mcThis, {delay:0.1, time:0.3, y:0, transition:"easeInCubic", onComplete:twCallback});
                        ZSound.play("throw_in");
                    }
                    if (this.mcThis.isEnd)
                    {
                        this.mcThis.gotoAndStop(1);
                        this.state.appoint("DefaultPose");
                    }
                    break;
                }
                case "SweetsFallGo":
                {
                    if (this.mclName == "poke_hihidaruma")
                    {
                        this.state.appoint("SweetsFallHihidaruma");
                    }
                    else
                    {
                        this.state.appoint("SweetsFallDefault");
                    }
                    break;
                }
                case "SweetsFallHihidaruma":
                {
                    if (this.state.isFirst())
                    {
                        this.mcThis.gotoAndStop(2);
                        this.mcThis.isEnd = false;
                        Tweener.addTween(this.mcThis, {time:0.4, scaleY:this.mcThis.scaleY * 1.1, transition:"easeOutCubic"});
                        Tweener.addTween(this.mcThis, {delay:0.4, time:0.2, scaleY:this.mcThis.scaleY * 1, transition:"easeInCubic", onComplete:twCallback});
                    }
                    if (this.state.getTime() == 10)
                    {
                        ZSound.play("slam");
                    }
                    if (this.mcThis.isEnd)
                    {
                        this.mcThis.gotoAndStop(1);
                        this.state.appoint("SweetsFallEnd");
                    }
                    break;
                }
                case "SweetsFallDefault":
                {
                    if (this.state.isFirst())
                    {
                        this.mcThis.isEnd = false;
                        Tweener.addTween(this.mcThis, {time:0.4, y:-23, transition:"easeOutCubic"});
                        Tweener.addTween(this.mcThis, {delay:0.4, time:0.2, y:0, transition:"easeInCubic", onComplete:twCallback});
                    }
                    if (this.state.getTime() == 10)
                    {
                        ZSound.play("slam");
                    }
                    if (this.mcThis.isEnd)
                    {
                        this.state.appoint("SweetsFallEnd");
                    }
                    break;
                }
                case "SweetsFallEnd":
                {
                    this.flagIsSweetsGo = true;
                    this.state.appoint("DefaultPose");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function isSweetsGo() : Boolean
        {
            return this.flagIsSweetsGo;
        }// end function

        public function isIdle() : Boolean
        {
            return this.state.getValue() == "DefaultPose";
        }// end function

        public function draw(param1:MovieClip, param2:int) : void
        {
            var _loc_3:* = this.getPanelPos();
            if (param2 != _loc_3.y)
            {
                return;
            }
            param1.addChild(this.mcDraw);
            return;
        }// end function

        public function goPutInSweets(param1:String) : void
        {
            this.putInType = param1;
            if (this.putInType == "Throw")
            {
                this.state.appoint("SweetsThrowGo");
            }
            else
            {
                this.state.appoint("SweetsFallGo");
            }
            this.update();
            return;
        }// end function

    }
}

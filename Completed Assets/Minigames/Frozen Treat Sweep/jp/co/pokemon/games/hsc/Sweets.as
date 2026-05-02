package jp.co.pokemon.games.hsc
{
    import flash.display.*;

    public class Sweets extends Object
    {
        private var shadowDefaultScale:Number = 1;
        public var type:int;
        public var putInType:String;
        public var state:State;
        public var ppos:Pos2;
        public var panel:Panel;
        public var firstDPos:Pos2;
        public var centerDPos:Pos2;
        public var mcDraw:MovieClip;
        public var mcThis:MovieClip;
        private var mcShadow:MovieClip;
        public var boardShakeOffsetY:int = 0;
        private var speed:Number = 0;
        public static const TYPE_A:int = 0;
        public static const TYPE_B:int = 1;
        public static const TYPE_C:int = 2;
        public static const TYPE_D:int = 3;
        public static const TYPE_MAX:int = 4;
        public static const scoreTbl:Array = [500, 1000, 2000, 5000];
        public static const appearanceRateTbl:Array = [40, 30, 20, 10];
        private static const shadowDefaultScaleTbl:Array = [0.7, 0.8, 0.9, 1];
        private static const typeToFallAcceralateTbl:Array = [1.8, 1.8, 1.8, 1.8];
        public static const fallDuration:int = Setting.frameRate;

        public function Sweets(param1:Pos2, param2:int, param3:String, param4:Pos2 = null)
        {
            this.mcDraw = new MovieClip();
            this.mcThis = new mclSweets();
            this.mcShadow = new RoundShadow();
            this.ppos = param1.clone();
            this.type = param2;
            this.putInType = param3;
            if (param4 == null)
            {
                this.firstDPos = new Pos2();
            }
            else
            {
                this.firstDPos = param4.clone();
            }
            this.panel = PanelAll.getPPos2PanelObj(this.ppos);
            this.mcThis.gotoAndStop((this.type + 1));
            this.mcThis.mouseEnabled = false;
            this.mcThis.mouseChildren = false;
            this.mcThis.cacheAsBitmap = true;
            Tools.shadowInit(this.mcShadow);
            this.mcShadow.visible = false;
            this.mcDraw.addChild(this.mcShadow);
            this.mcDraw.addChild(this.mcThis);
            this.mcDraw.cacheAsBitmap = true;
            this.mcDraw.mouseEnabled = false;
            this.mcDraw.mouseChildren = false;
            this.centerDPos = PanelAll.getPPos2DPos(this.ppos);
            this.state = new State("Sweets" + this.type + this.putInType, true);
            this.state.appoint("StandBy");
            this.state.setTrace(false);
            this.shadowDefaultScale = shadowDefaultScaleTbl[this.type];
            return;
        }// end function

        public function standByToGo(param1:Pos2 = null) : void
        {
            if (param1 != null)
            {
                this.firstDPos = param1.clone();
            }
            this.state.appoint(this.putInType);
            return;
        }// end function

        public function goMeltPanelDrop() : void
        {
            this.state.appoint("MeltPanelDrop");
            return;
        }// end function

        public function isPutInMoving() : Boolean
        {
            switch(this.state.getValue())
            {
                case "Throw":
                case "Fall":
                {
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function isPokemonGetAble() : Boolean
        {
            return this.state.getValue() == "OnPanel";
        }// end function

        public function update() : void
        {
            while (this.updatePrime())
            {
                
            }
            return;
        }// end function

        public function scaleSetting() : void
        {
            var _loc_1:* = PanelAll.dposy2Scale(this.centerDPos.y) * Setting.sweetsScale;
            this.mcThis.scaleY = PanelAll.dposy2Scale(this.centerDPos.y) * Setting.sweetsScale;
            this.mcThis.scaleX = _loc_1;
            return;
        }// end function

        public function shadowSetting() : void
        {
            this.mcShadow.visible = true;
            this.mcShadow.x = 0;
            this.mcShadow.y = this.centerDPos.y - this.mcDraw.y + 5;
            var _loc_1:* = this.shadowDefaultScale * PanelAll.dposy2Scale(this.centerDPos.y);
            this.mcShadow.scaleY = this.shadowDefaultScale * PanelAll.dposy2Scale(this.centerDPos.y);
            this.mcShadow.scaleX = _loc_1;
            return;
        }// end function

        public function updatePrime() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_2:Boolean = false;
            switch(this.state.update())
            {
                case "StandBy":
                {
                    break;
                }
                case "Throw":
                {
                    if (this.state.isFirst())
                    {
                        this.scaleSetting();
                        this.mcShadow.visible = false;
                    }
                    _loc_3 = Tools.calcJumpParabola(this.ppos, this.firstDPos, 280, 18, this.state.getTime());
                    _loc_3.dpos.setMc(this.mcDraw);
                    if (_loc_3.isEnd)
                    {
                        if (this.panel.isMelted())
                        {
                            this.state.appoint("MeltPanelDropMove");
                        }
                        else
                        {
                            this.state.appoint("BoundDown");
                        }
                    }
                    break;
                }
                case "BoundDown":
                {
                    if (this.state.isFirst())
                    {
                        this.scaleSetting();
                        ZSound.play("put_sweet");
                    }
                    if (this.panel.isMelted())
                    {
                        this.state.appoint("MeltPanelDropMove");
                    }
                    _loc_4 = [-3, -5, -3, 0];
                    _loc_5 = _loc_4[this.state.getTime()];
                    this.mcDraw.y = this.centerDPos.y + _loc_5;
                    if (_loc_5 == 0)
                    {
                        this.state.appoint("OnPanel");
                    }
                    this.shadowSetting();
                    break;
                }
                case "Fall":
                case "FlierUD":
                case "FlierLR":
                {
                    if (this.state.isFirst())
                    {
                        this.scaleSetting();
                        this.mcShadow.visible = false;
                    }
                    if (this.state.getValue() == "Fall")
                    {
                        this.mcDraw.x = this.centerDPos.x;
                        this.mcDraw.y = 0;
                    }
                    else
                    {
                        this.firstDPos.setMc(this.mcDraw);
                    }
                    this.speed = 0;
                    _loc_2 = true;
                    this.state.appoint("DownMoving");
                    break;
                }
                case "DownMoving":
                {
                    this.mcDraw.y = this.mcDraw.y + this.speed;
                    this.speed = this.speed + typeToFallAcceralateTbl[this.type];
                    if (this.mcDraw.y >= this.centerDPos.y)
                    {
                        this.mcDraw.y = this.centerDPos.y;
                        if (this.panel.isMelted())
                        {
                            this.state.appoint("MeltPanelDropMove");
                        }
                        else
                        {
                            this.state.appoint("BoundDown");
                        }
                    }
                    if (this.mcDraw.y >= this.centerDPos.y - 10)
                    {
                        this.shadowSetting();
                    }
                    break;
                }
                case "OnPanel":
                {
                    if (this.state.isFirst())
                    {
                        this.scaleSetting();
                        if (this.panel.sweets == this)
                        {
                        }
                        else if (this.panel.sweets != null)
                        {
                            if (this.panel.sweets.type < this.type)
                            {
                                this.panel.sweets.state.appoint("DeleteMe");
                                this.panel.sweets.update();
                                this.panel.sweets = this;
                            }
                            else
                            {
                                this.state.appoint("DeleteMe");
                            }
                        }
                        else
                        {
                            this.panel.sweets = this;
                        }
                    }
                    this.mcDraw.x = this.centerDPos.x;
                    this.mcDraw.y = this.centerDPos.y + this.boardShakeOffsetY;
                    this.shadowSetting();
                    break;
                }
                case "MeltPanelDrop":
                {
                    this.mcShadow.visible = false;
                    this.speed = 0;
                    this.state.appoint("MeltPanelDropMove");
                    break;
                }
                case "MeltPanelDropMove":
                {
                    if (this.state.isFirst())
                    {
                        this.mcShadow.visible = false;
                    }
                    this.mcDraw.y = this.mcDraw.y + this.speed;
                    this.speed = this.speed + typeToFallAcceralateTbl[this.type];
                    if (this.mcDraw.y > this.centerDPos.y + 50)
                    {
                        this.state.appoint("DeleteMe");
                    }
                    break;
                }
                case "DeleteMe":
                {
                    if (this.state.isFirst())
                    {
                        this.mcShadow.visible = false;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function draw(param1:MovieClip, param2:int) : void
        {
            switch(this.state.getValue())
            {
                case "StandBy":
                {
                    break;
                }
                case "Throw":
                {
                    if (param2 != PanelAll.whMax)
                    {
                        break;
                    }
                    param1.addChild(this.mcDraw);
                    break;
                }
                case "Fall":
                case "FlierUD":
                case "FlierLR":
                case "DownMoving":
                case "BoundDown":
                {
                    if (param2 != PanelAll.whMax)
                    {
                        break;
                    }
                    param1.addChild(this.mcDraw);
                    break;
                }
                case "OnPanel":
                {
                    if (this.ppos.y != param2)
                    {
                        break;
                    }
                    param1.addChild(this.mcDraw);
                    break;
                }
                case "MeltPanelDrop":
                case "MeltPanelDropMove":
                {
                    if (this.ppos.y != param2)
                    {
                        break;
                    }
                    param1.addChild(this.mcDraw);
                    break;
                }
                case "DeleteMe":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}

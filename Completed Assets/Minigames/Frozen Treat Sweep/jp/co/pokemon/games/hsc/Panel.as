package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    class Panel extends Object
    {
        public var mc:MovieClip;
        public var mcIce:MovieClip;
        public var mcCrackSmall:MovieClip;
        public var mcCrackBig:MovieClip;
        public var mcMask:MovieClip;
        public var mcWaterspout:MovieClip;
        public var meltLevel:int;
        public var ppos:Pos2;
        public var centerDPos:Pos2;
        public var rect:RectI5;
        public var scale:Number;
        public var meltRecoverTimer:int;
        public var numStopOnPokemon:int;
        public var flagDropPokemon:Boolean;
        public var stopOnPokemonTimer:int;
        public var sweets:Sweets;
        public var rollState:String;
        private var isManMoveTarget:Boolean = false;
        private var colorTransFormTbl:Array;
        private var currentColorTransFormIndex:int = 0;
        public static const meltRecoverDuration:int = int(Setting.frameRate * 2.5);
        public static const stopOnPokemonMeltDuration:int = Setting.frameRate * 2;
        public static const wh:int = 100;
        public static const meltLevelMax:int = 4;
        public static const meltLevelLimit:int = 3;

        function Panel(param1:Pos2, param2:MovieClip, param3:RectI5, param4:Number)
        {
            this.colorTransFormTbl = [new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0), new ColorTransform(0.7, 0.7, 0.7, 1, 120, 120, 120, 0), new ColorTransform(1, 1, 0, 1, 0, 0, 0, 0)];
            this.ppos = param1.clone();
            this.rect = param3.clone();
            this.centerDPos = this.rect.center.clone();
            this.scale = param4;
            this.reset();
            this.mc = new MovieClip();
            this.mc.cacheAsBitmap = true;
            var _loc_5:* = getQualifiedClassName(param2);
            var _loc_6:* = getDefinitionByName(_loc_5) as Class;
            this.mcIce = new _loc_6;
            this.mc.addChild(this.mcIce);
            this.mcMask = new _loc_6;
            this.mcMask.cacheAsBitmap = true;
            var _loc_7:* = new _loc_6;
            new _loc_6.cacheAsBitmap = true;
            this.mc.addChild(_loc_7);
            _loc_7.visible = true;
            var _loc_8:* = new _loc_6;
            new _loc_6.cacheAsBitmap = true;
            this.mc.addChild(_loc_8);
            _loc_8.visible = true;
            this.mcCrackSmall = new mclCrackSmall();
            this.mcCrackSmall.visible = false;
            this.mcCrackSmall.cacheAsBitmap = true;
            this.mcCrackSmall.mask = _loc_7;
            this.mcCrackSmall.mouseChildren = false;
            this.mcCrackSmall.mouseEnabled = false;
            this.mc.addChild(this.mcCrackSmall);
            this.mcCrackBig = new mclCrackBig();
            this.mcCrackBig.visible = false;
            this.mcCrackBig.cacheAsBitmap = true;
            this.mcCrackBig.mask = _loc_8;
            this.mcCrackBig.mouseChildren = false;
            this.mcCrackBig.mouseEnabled = false;
            this.mc.addChild(this.mcCrackBig);
            var _loc_9:* = this.centerDPos.subFrom(this.rect.topLeft);
            var _loc_10:* = this.scale;
            this.mcCrackBig.scaleY = this.scale;
            this.mcCrackBig.scaleX = _loc_10;
            _loc_9.setMc(this.mcCrackBig);
            var _loc_10:* = this.scale;
            this.mcCrackSmall.scaleY = this.scale;
            this.mcCrackSmall.scaleX = _loc_10;
            _loc_9.setMc(this.mcCrackSmall);
            this.mc.addEventListener(MouseEvent.ROLL_OVER, this.rollOver);
            this.mc.addEventListener(MouseEvent.ROLL_OUT, this.rollOut);
            this.rollState = "none";
            this.mc.buttonMode = true;
            this.mc.x = param2.x;
            this.mc.y = param2.y;
            if (this.ppos.x <= 1)
            {
                this.mc.scaleX = -1;
            }
            return;
        }// end function

        private function rollOver(event:Event = null) : void
        {
            this.rollState = "rollOver";
            return;
        }// end function

        private function rollOut(event:Event = null) : void
        {
            this.rollState = "rollOut";
            return;
        }// end function

        public function reset() : void
        {
            this.meltLevel = 0;
            this.numStopOnPokemon = 0;
            this.flagDropPokemon = false;
            this.meltRecoverTimer = 0;
            this.stopOnPokemonTimer = 0;
            this.sweets = null;
            return;
        }// end function

        public function isMelted() : Boolean
        {
            return this.meltLevel == (meltLevelMax - 1);
        }// end function

        public function update() : void
        {
            if (this.isMelted())
            {
                var _loc_1:String = this;
                var _loc_2:* = this.meltRecoverTimer + 1;
                _loc_1.meltRecoverTimer = _loc_2;
                if (this.meltRecoverTimer >= meltRecoverDuration)
                {
                    this.meltLevel = 0;
                    this.meltRecoverTimer = 0;
                }
                this.stopOnPokemonTimer = 0;
            }
            else if (!Setting.isDebugPanelNoMelt)
            {
                this.meltRecoverTimer = 0;
                if (this.numStopOnPokemon != 0)
                {
                    var _loc_1:String = this;
                    var _loc_2:* = this.stopOnPokemonTimer + 1;
                    _loc_1.stopOnPokemonTimer = _loc_2;
                    if (this.stopOnPokemonTimer >= stopOnPokemonMeltDuration)
                    {
                        this.stopOnPokemonTimer = 0;
                        this.meltIncrement();
                    }
                }
                else
                {
                    this.stopOnPokemonTimer = 0;
                }
            }
            this.numStopOnPokemon = 0;
            this.flagDropPokemon = false;
            return;
        }// end function

        public function meltIncrement() : void
        {
            if (Setting.isDebugPanelNoMelt)
            {
                return;
            }
            if (Setting.isDebugPokemonDrop)
            {
                this.meltLevel = meltLevelMax - 1;
                return;
            }
            if (this.meltLevel < (meltLevelMax - 1))
            {
                var _loc_1:String = this;
                var _loc_2:* = this.meltLevel + 1;
                _loc_1.meltLevel = _loc_2;
                this.mcCrackBig.visible = false;
                this.mcCrackSmall.visible = false;
                if (this.meltLevel == 2)
                {
                    this.mcCrackBig.visible = true;
                }
                else if (this.meltLevel == 1)
                {
                    this.mcCrackSmall.visible = true;
                }
            }
            return;
        }// end function

        public function setRouteTarget(param1:Boolean) : void
        {
            this.isManMoveTarget = param1;
            return;
        }// end function

        private function getColorTransFormIndex() : int
        {
            if (this.isManMoveTarget)
            {
                return 2;
            }
            if (this.rollState == "rollOver")
            {
                return 1;
            }
            return 0;
        }// end function

        public function draw(param1:MovieClip) : void
        {
            if (this.meltLevel != (meltLevelMax - 1))
            {
                param1.addChild(this.mc);
            }
            var _loc_2:* = this.getColorTransFormIndex();
            if (this.currentColorTransFormIndex != _loc_2)
            {
                this.currentColorTransFormIndex = _loc_2;
                this.mc.transform.colorTransform = this.colorTransFormTbl[_loc_2];
            }
            return;
        }// end function

    }
}

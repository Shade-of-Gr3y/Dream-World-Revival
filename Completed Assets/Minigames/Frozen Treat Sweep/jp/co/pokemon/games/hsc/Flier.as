package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.utils.*;

    public class Flier extends Object
    {
        public var mc:MovieClip;
        public var dpos:Pos2;
        public var animMclName:String;
        public var pokeMclName:String;
        public var type:int;
        private var state:State;
        private var speed:Number;
        private var flagIsSweetsGo:Boolean;
        private var targetDpos:Pos2;
        private var moveUL2SweetsPutCount:int = -1;
        public var defaultScale:Number;
        public static const flierDataTbl:Array = [{animMclName:"mclFuwarideAnimation", pokeMclName:"poke_fuwaride"}, {animMclName:"mclPerappuAnimation", pokeMclName:"poke_perappu"}];
        public static const TYPE_poke_fuwaride:Object = 0;
        public static const TYPE_poke_perappu:Object = 1;
        public static const TYPE_MAX:Object = 2;
        public static const pokemonSizeSafe:int = 100;

        public function Flier(param1:int)
        {
            this.targetDpos = new Pos2();
            this.type = param1;
            this.animMclName = flierDataTbl[this.type].animMclName;
            var _loc_2:* = getDefinitionByName(this.animMclName) as Class;
            this.mc = new _loc_2;
            this.mc.gotoAndStop(1);
            this.pokeMclName = flierDataTbl[this.type].pokeMclName;
            this.defaultScale = PokeMc.getNameToScale(this.pokeMclName);
            this.state = new State("Flier " + this.animMclName, true);
            switch(this.type)
            {
                case TYPE_poke_fuwaride:
                {
                    break;
                }
                case TYPE_poke_perappu:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.dpos = new Pos2(0, 0);
            this.mc.visible = false;
            this.mc.gotoAndStop(1);
            this.mc.cacheAsBitmap = true;
            this.flagIsSweetsGo = false;
            this.state.appoint("Idle");
            this.update();
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            switch(this.state.update())
            {
                case "Idle":
                {
                    if (this.state.isFirst())
                    {
                        this.mc.visible = false;
                    }
                    break;
                }
                case "PerappuIn":
                {
                    if (this.state.isFirst())
                    {
                        this.dpos = new Pos2(this.targetDpos.x, 62 + this.targetDpos.y - PanelAll.getPanelTopLineY());
                        this.dpos.setMc(this.mc);
                        this.mc.gotoAndStop(1);
                        this.mc.visible = true;
                        var _loc_5:* = this.defaultScale * PanelAll.dposy2Scale(this.targetDpos.y);
                        this.mc.scaleY = this.defaultScale * PanelAll.dposy2Scale(this.targetDpos.y);
                        this.mc.scaleX = _loc_5;
                    }
                    else
                    {
                        Tools.mcPlayNext(this.mc);
                    }
                    this.mc.mciIt.gotoAndStop(1);
                    if (this.mc.isSweetsGo)
                    {
                        this.flagIsSweetsGo = true;
                        this.state.appoint("PerappuPutIn");
                    }
                    break;
                }
                case "PerappuPutIn":
                {
                    if (this.state.isFirst())
                    {
                    }
                    Tools.mcPlayNext(this.mc);
                    this.mc.mciIt.gotoAndStop(2);
                    if (this.mc.isTuraraFront)
                    {
                        this.state.appoint("PerappuOut");
                    }
                    break;
                }
                case "PerappuOut":
                {
                    if (this.state.isFirst())
                    {
                        this.mc.mciIt.gotoAndStop(3);
                    }
                    Tools.mcPlayNext(this.mc);
                    if (this.mc.isEnd)
                    {
                        this.state.appoint("Idle");
                    }
                    break;
                }
                case "FuwarideIn":
                {
                    if (this.state.isFirst())
                    {
                        this.dpos = new Pos2(0, 100 - 40 + this.targetDpos.y - PanelAll.getPanelTopLineY());
                        this.dpos.setMc(this.mc);
                        this.mc.gotoAndStop(1);
                        this.mc.visible = true;
                        var _loc_5:* = this.defaultScale * PanelAll.dposy2Scale(this.targetDpos.y);
                        this.mc.mciIt.mciIt.scaleY = this.defaultScale * PanelAll.dposy2Scale(this.targetDpos.y);
                        this.mc.mciIt.mciIt.scaleX = _loc_5;
                    }
                    else
                    {
                        Tools.mcPlayNext(this.mc);
                    }
                    if (this.mc.mciIt.x >= this.targetDpos.x)
                    {
                        this.flagIsSweetsGo = true;
                        this.state.appoint("FuwaridePutIn");
                    }
                    break;
                }
                case "FuwaridePutIn":
                {
                    Tools.mcPlayNext(this.mc);
                    if (this.mc.mciIt.x >= Setting.gameWidth)
                    {
                        this.state.appoint("Idle");
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

        public function getSweetsStartPosition() : Pos2
        {
            switch(this.type)
            {
                case TYPE_poke_fuwaride:
                {
                    return new Pos2(this.targetDpos.x, this.dpos.y);
                }
                case TYPE_poke_perappu:
                {
                    return this.dpos;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function isSweetsGo() : Boolean
        {
            var _loc_1:* = this.flagIsSweetsGo;
            this.flagIsSweetsGo = false;
            return _loc_1;
        }// end function

        public function isIdle() : Boolean
        {
            return this.state.getValue() == "Idle";
        }// end function

        public function draw(param1:MovieClip, param2:int) : void
        {
            if (param2 != PanelAll.whMax || !this.mc.visible)
            {
                return;
            }
            switch(this.type)
            {
                case TYPE_poke_fuwaride:
                {
                    param1.mciPanelPokemon.addChild(this.mc);
                    break;
                }
                case TYPE_poke_perappu:
                {
                    switch(this.state.getValue())
                    {
                        case "PerappuIn":
                        case "PerappuPutIn":
                        {
                            param1.mciPanelPokemon.addChild(this.mc);
                            break;
                        }
                        case "PerappuOut":
                        {
                            param1.mciTuraraFront.addChild(this.mc);
                            break;
                        }
                        default:
                        {
                            break;
                        }
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

        public function goPutInSweets(param1:Pos2) : void
        {
            this.targetDpos = param1.clone();
            this.flagIsSweetsGo = false;
            switch(this.type)
            {
                case TYPE_poke_fuwaride:
                {
                    this.state.appoint("FuwarideIn");
                    break;
                }
                case TYPE_poke_perappu:
                {
                    this.state.appoint("PerappuIn");
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

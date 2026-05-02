package jp.co.pokemon.games.hsc
{
    import flash.display.*;

    public class SweetsManage extends Object
    {
        private static const debugPokemon:String = null;
        public static var sweetsTbl:Array;
        private static var sweetsManageState:State = new State("SweetsManage", false);
        private static var sweetsManageFlierState:State = new State("SweetsManageFlier", false);
        private static var putInSweetsCrowd:Crowd = null;
        private static var putInSweetsFlier:Flier = null;
        private static var putInTargetPanel:Panel = null;
        private static var putInTargetPanelFlier:Panel = null;
        private static var SWEETS_LOW:Array = [70, 30, 0, 0];
        private static var SWEETS_MID:Array = [50, 30, 20, 0];
        private static var SWEETS_HI:Array = [20, 30, 40, 10];
        private static var SWEETS_EX:Array = [0, 0, 0, 100];
        private static var sweetsPutInDataCurrent:Object;
        private static var sweetsPutInDataCurrentFlier:Object;
        private static var sweetsPutInDataTblIndex:int = 0;
        private static var sweetsObjTbl:Array;
        private static var sweetsObjFlier:Sweets;
        private static const sweetsPutInDataTbl:Array = [{type:"Fall", sweetsSettingTbl:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3], time:99, isDebug:true}, {type:"Fall", sweetsSettingTbl:[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3], time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierUD", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"FlierLR", sweets:SWEETS_EX, time:99, isDebug:true}, {type:"Throw", sweets:SWEETS_LOW, time:59}, {type:"Throw", sweets:SWEETS_LOW, time:58.3}, {type:"Throw", sweets:SWEETS_MID, time:57}, {type:"Throw", sweets:SWEETS_LOW, time:56}, {type:"Throw", sweets:SWEETS_LOW, time:55.3}, {type:"FlierUD", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:54}, {type:"Throw", sweets:SWEETS_LOW, time:53.5}, {type:"Throw", sweets:SWEETS_MID, time:52.9}, {type:"Throw", sweets:SWEETS_LOW, time:51}, {type:"Throw", sweets:SWEETS_LOW, time:50.3}, {type:"FlierLR", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:49}, {type:"Throw", sweets:SWEETS_LOW, time:48.8}, {type:"Throw", sweets:SWEETS_LOW, time:47}, {type:"Throw", sweets:SWEETS_MID, time:46.1}, {type:"Throw", sweets:SWEETS_LOW, time:45.5}, {type:"FlierUD", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:44.5}, {type:"Throw", sweets:SWEETS_LOW, time:43}, {type:"Throw", sweets:SWEETS_LOW, time:42.3}, {type:"Throw", sweets:SWEETS_LOW, time:41}, {type:"Throw", sweets:SWEETS_MID, time:40.3}, {type:"FlierLR", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:39.2}, {type:"Throw", sweets:SWEETS_LOW, time:38}, {type:"Throw", sweets:SWEETS_LOW, time:37.5}, {type:"Throw", sweets:SWEETS_MID, time:36}, {type:"Throw", sweets:SWEETS_LOW, time:35.2}, {type:"FlierUD", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:34}, {type:"Throw", sweets:SWEETS_LOW, time:33.5}, {type:"Throw", sweets:SWEETS_LOW, time:32}, {type:"Throw", sweets:SWEETS_MID, time:31.1}, {type:"Throw", sweets:SWEETS_MID, time:30}, {type:"Fall", sweetsSettingTbl:[3, 2, 2, 2, 1, 1, 1, 0, 0, 0], time:99}, {type:"Msg", msg:"MESSAGE_WINDOW_IIOKASHI", time:99}, {type:"Throw", sweets:SWEETS_LOW, time:29.5}, {type:"Throw", sweets:SWEETS_LOW, time:28}, {type:"Throw", sweets:SWEETS_LOW, time:27.9}, {type:"Throw", sweets:SWEETS_LOW, time:26.4}, {type:"Throw", sweets:SWEETS_LOW, time:25.1}, {type:"FlierLR", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_LOW, time:24}, {type:"Throw", sweets:SWEETS_LOW, time:23.9}, {type:"Throw", sweets:SWEETS_LOW, time:22.3}, {type:"Throw", sweets:SWEETS_MID, time:21.2}, {type:"Throw", sweets:SWEETS_MID, time:20.7}, {type:"FlierUD", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_MID, time:19.5}, {type:"Throw", sweets:SWEETS_MID, time:18}, {type:"Throw", sweets:SWEETS_MID, time:17.3}, {type:"Throw", sweets:SWEETS_MID, time:16}, {type:"FlierLR", sweets:SWEETS_MID, time:99}, {type:"Throw", sweets:SWEETS_MID, time:15}, {type:"Throw", sweets:SWEETS_MID, time:14.3}, {type:"Throw", sweets:SWEETS_MID, time:13}, {type:"Throw", sweets:SWEETS_MID, time:12.9}, {type:"Msg", msg:"MESSAGE_WINDOW_GANBARE10", time:11}, {type:"Throw", sweets:SWEETS_MID, time:11}, {type:"Throw", sweets:SWEETS_MID, time:10}, {type:"Throw", sweets:SWEETS_MID, time:9.5}, {type:"Throw", sweets:SWEETS_MID, time:9}, {type:"Fall", sweetsSettingTbl:[3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0], time:9}, {type:"Throw", sweets:SWEETS_EX, time:8}, {type:"FlierUD", sweets:SWEETS_HI, time:99}, {type:"Throw", sweets:SWEETS_EX, time:7.2}, {type:"Throw", sweets:SWEETS_HI, time:7}, {type:"Throw", sweets:SWEETS_EX, time:6}, {type:"Throw", sweets:SWEETS_HI, time:5.4}, {type:"FlierLR", sweets:SWEETS_EX, time:99}, {type:"Throw", sweets:SWEETS_HI, time:5}, {type:"Throw", sweets:SWEETS_HI, time:4.3}, {type:"Throw", sweets:SWEETS_HI, time:4}, {type:"Throw", sweets:SWEETS_HI, time:3}, {type:"Throw", sweets:SWEETS_EX, time:3.2}, {type:"FlierUD", sweets:SWEETS_HI, time:99}, {type:"Throw", sweets:SWEETS_HI, time:2}, {type:"Throw", sweets:SWEETS_HI, time:1.3}, {type:"Throw", sweets:SWEETS_EX, time:1}, {type:"end", sweets:SWEETS_MID, time:-1}];
        private static var debugSweetsPutInY:int = 0;

        public function SweetsManage()
        {
            return;
        }// end function

        public static function init(param1:Array) : void
        {
            var _loc_3:Pos2 = null;
            var _loc_4:Sweets = null;
            sweetsTbl = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < Setting.firstSweetsQuantity)
            {
                
                _loc_3 = Tools.tableRandomGetAndDelete(param1) as Pos2;
                _loc_4 = newSweets(PanelAll.getPPos2PanelObj(_loc_3), SWEETS_LOW, "OnPanel");
                _loc_4.standByToGo();
                _loc_2++;
            }
            return;
        }// end function

        public static function newSweets(param1:Panel, param2:Array, param3:String, param4:Pos2 = null) : Sweets
        {
            var _loc_5:* = Tools.randopmRateTblToIndex(param2);
            var _loc_6:* = new Sweets(param1.ppos, _loc_5, param3, param4);
            sweetsTbl.push(_loc_6);
            if (param1.sweets == null)
            {
                param1.sweets = _loc_6;
            }
            return _loc_6;
        }// end function

        public static function goPlay() : void
        {
            sweetsManageState.appoint("Idle");
            sweetsManageFlierState.appoint("Idle");
            return;
        }// end function

        public static function deleteSweets(param1:Sweets) : void
        {
            var _loc_2:* = Tools.tblSearchIt(sweetsTbl, param1);
            if (param1.panel.sweets == param1)
            {
                param1.panel.sweets = null;
            }
            sweetsTbl.splice(_loc_2, 1);
            return;
        }// end function

        public static function update(param1:MovieClip, param2:Array, param3:Number = 9999999) : void
        {
            var _loc_4:Sweets = null;
            var _loc_6:Pos2 = null;
            var _loc_7:Panel = null;
            var _loc_8:Crowd = null;
            var _loc_9:int = 0;
            var _loc_10:State = null;
            var _loc_11:Pos2 = null;
            var _loc_12:Sweets = null;
            var _loc_13:int = 0;
            var _loc_14:Array = null;
            var _loc_15:Array = null;
            var _loc_16:Array = null;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_19:int = 0;
            var _loc_20:int = 0;
            var _loc_5:* = new Pos2(0, 0);
            _loc_9 = 0;
            while (_loc_9 < sweetsTbl.length)
            {
                
                _loc_4 = sweetsTbl[_loc_9];
                if (_loc_4.state.getValue() == "DeleteMe")
                {
                    deleteSweets(_loc_4);
                    continue;
                }
                _loc_9++;
            }
            _loc_9 = 0;
            while (_loc_9 < sweetsTbl.length)
            {
                
                _loc_4 = sweetsTbl[_loc_9];
                _loc_11 = _loc_4.ppos;
                _loc_7 = PanelAll.getPPos2PanelObj(_loc_11);
                if (_loc_4.state.getValue() == "OnPanel" && _loc_7.isMelted())
                {
                    _loc_4.goMeltPanelDrop();
                }
                _loc_4.update();
                _loc_9++;
            }
            _loc_10 = sweetsManageState;
            switch(_loc_10.update())
            {
                case "Begin":
                {
                    break;
                }
                case "Idle":
                {
                    if (_loc_10.isFirst())
                    {
                    }
                    if (!Setting.isSweetsManageSeqDebug)
                    {
                        while (true)
                        {
                            
                            sweetsPutInDataCurrent = sweetsPutInDataTbl[sweetsPutInDataTblIndex];
                            if (sweetsPutInDataCurrent.isDebug != true)
                            {
                                break;
                            }
                            var _loc_22:* = sweetsPutInDataTblIndex + 1;
                            sweetsPutInDataTblIndex = _loc_22;
                        }
                    }
                    sweetsPutInDataCurrent = sweetsPutInDataTbl[sweetsPutInDataTblIndex];
                    if (sweetsPutInDataCurrent.time >= param3)
                    {
                        var _loc_22:* = sweetsPutInDataTblIndex + 1;
                        sweetsPutInDataTblIndex = _loc_22;
                        _loc_10.appoint(sweetsPutInDataCurrent.type);
                    }
                    break;
                }
                case "Msg":
                {
                    Global.windowMessageGo(sweetsPutInDataCurrent.msg);
                    _loc_10.appoint("Idle");
                    break;
                }
                case "FlierUD":
                case "FlierLR":
                {
                    if (sweetsManageFlierState.getValue() == "Idle")
                    {
                        sweetsPutInDataCurrentFlier = sweetsPutInDataCurrent;
                        sweetsManageFlierState.appoint(sweetsPutInDataCurrentFlier.type);
                    }
                    _loc_10.appoint("Idle");
                    break;
                }
                case "Fall":
                {
                    putInSweetsCrowd = CrowdsAll.getLargeIdlePokemonRandom();
                    if (debugPokemon != null)
                    {
                        putInSweetsCrowd = CrowdsAll.getCrowdByName(debugPokemon);
                    }
                    if (putInSweetsCrowd == null)
                    {
                        break;
                    }
                    sweetsObjTbl = new Array();
                    _loc_9 = 0;
                    while (_loc_9 < sweetsPutInDataCurrent.sweetsSettingTbl.length)
                    {
                        
                        _loc_7 = choicePutInPanel();
                        if (_loc_7 == null)
                        {
                            break;
                        }
                        _loc_13 = sweetsPutInDataCurrent.sweetsSettingTbl[_loc_9];
                        _loc_14 = [0, 0, 0, 0];
                        _loc_14[_loc_13] = 100;
                        sweetsObjTbl.push(newSweets(_loc_7, _loc_14, sweetsPutInDataCurrent.type));
                        _loc_9++;
                    }
                    if (sweetsObjTbl.length == 0)
                    {
                        _loc_10.appoint("Idle");
                    }
                    putInSweetsCrowd.goPutInSweets(sweetsPutInDataCurrent.type);
                    _loc_10.appoint("FallPutIn");
                    break;
                }
                case "FallPutIn":
                {
                    if (putInSweetsCrowd.isSweetsGo())
                    {
                        _loc_10.appoint("FallSweetsGo");
                    }
                    break;
                }
                case "FallSweetsGo":
                {
                    _loc_9 = 0;
                    while (_loc_9 < sweetsObjTbl.length)
                    {
                        
                        sweetsObjTbl[_loc_9].standByToGo();
                        _loc_9++;
                    }
                    _loc_10.appoint("BoardShake");
                    break;
                }
                case "Throw":
                {
                    putInSweetsCrowd = CrowdsAll.getNonLargeIdlePokemonRandom();
                    if (debugPokemon != null)
                    {
                        putInSweetsCrowd = CrowdsAll.getCrowdByName(debugPokemon);
                    }
                    if (putInSweetsCrowd == null)
                    {
                        break;
                    }
                    _loc_7 = choicePutInPanel();
                    if (_loc_7 == null)
                    {
                        _loc_10.appoint("Idle");
                        break;
                    }
                    putInSweetsCrowd.goPutInSweets(sweetsPutInDataCurrent.type);
                    _loc_6 = putInSweetsCrowd.dpos.clone();
                    putInSweetsCrowd.dpos.clone().y = _loc_6.y - putInSweetsCrowd.mcDraw.height * 0.5;
                    _loc_12 = newSweets(_loc_7, sweetsPutInDataCurrent.sweets, sweetsPutInDataCurrent.type, _loc_6);
                    _loc_12.standByToGo();
                    _loc_10.appoint("Idle");
                    break;
                }
                case "BoardShake":
                {
                    if (_loc_10.getTime() == 0)
                    {
                        param1.mciTurara.orgY = param1.mciTurara.y;
                    }
                    _loc_15 = [5, 10, 8, 6, 4, 2, 2, 2, 2, 1, 1, 1, 1, 0];
                    _loc_16 = [0, 0, 0, 6, 4, 2, 2, 2, 2, 1, 1, 1, 1, 0];
                    _loc_17 = _loc_15[_loc_10.getTime()];
                    _loc_18 = 0;
                    if (_loc_10.getTime() >= 3)
                    {
                        _loc_18 = _loc_15[_loc_10.getTime() - 3];
                    }
                    param1.mciTurara.y = param1.mciTurara.orgY + _loc_18;
                    param1.mciPanelPokemon.y = _loc_17;
                    param1.mciBG.y = _loc_17;
                    _loc_19 = _loc_16[_loc_10.getTime()] - _loc_17;
                    _loc_9 = 0;
                    while (_loc_9 < sweetsTbl.length)
                    {
                        
                        sweetsTbl[_loc_9].boardShakeOffsetY = _loc_19;
                        _loc_9++;
                    }
                    _loc_9 = 0;
                    while (_loc_9 < param2.length)
                    {
                        
                        param2[_loc_9].boardShakeOffsetY = _loc_19;
                        _loc_9++;
                    }
                    if (_loc_10.getTime() >= (_loc_15.length - 1))
                    {
                        param1.mciTurara.y = param1.mciTurara.orgY;
                        param1.mciPanelPokemon.y = 0;
                        param1.mciBG.y = 0;
                        _loc_10.appoint("Idle");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_10 = sweetsManageFlierState;
            switch(_loc_10.update())
            {
                case "Begin":
                {
                    break;
                }
                case "Idle":
                {
                    break;
                }
                case "FlierUD":
                case "FlierLR":
                {
                    _loc_20 = _loc_10.getValue() == "FlierUD" ? (Flier.TYPE_poke_perappu) : (Flier.TYPE_poke_fuwaride);
                    putInSweetsFlier = CrowdsAll.getFlierToPutIn(_loc_20);
                    if (putInSweetsFlier == null)
                    {
                        break;
                    }
                    putInTargetPanelFlier = choicePutInPanel();
                    if (putInTargetPanelFlier == null)
                    {
                        _loc_10.appoint("Idle");
                        break;
                    }
                    putInSweetsFlier.goPutInSweets(putInTargetPanelFlier.centerDPos);
                    _loc_7 = putInTargetPanelFlier;
                    sweetsObjFlier = newSweets(_loc_7, sweetsPutInDataCurrentFlier.sweets, sweetsPutInDataCurrentFlier.type);
                    _loc_10.appoint("FlierPutIn");
                    break;
                }
                case "FlierPutIn":
                {
                    if (putInSweetsFlier.isSweetsGo())
                    {
                        _loc_6 = putInSweetsFlier.getSweetsStartPosition();
                        sweetsObjFlier.standByToGo(_loc_6);
                        _loc_10.appoint("Idle");
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

        private static function choicePutInPanel() : Panel
        {
            var _loc_3:Panel = null;
            var _loc_4:int = 0;
            var _loc_1:* = new Array();
            var _loc_2:* = new Pos2();
            if (Setting.isDebugSweetsPutInPos)
            {
                _loc_2.y = debugSweetsPutInY;
                _loc_2.x = 0;
                while (_loc_2.x < PanelAll.whMax)
                {
                    
                    _loc_3 = PanelAll.getPPos2PanelObj(_loc_2);
                    if (_loc_3.sweets == null && !_loc_3.isMelted())
                    {
                        _loc_1.push(_loc_3);
                    }
                    var _loc_5:* = _loc_2;
                    var _loc_6:* = _loc_2.x + 1;
                    _loc_5.x = _loc_6;
                }
                debugSweetsPutInY = (debugSweetsPutInY + 1) % PanelAll.whMax;
            }
            else
            {
                _loc_2.x = 0;
                while (_loc_2.x < PanelAll.whMax)
                {
                    
                    _loc_2.y = 0;
                    while (_loc_2.y < PanelAll.whMax)
                    {
                        
                        _loc_3 = PanelAll.getPPos2PanelObj(_loc_2);
                        if (_loc_3.sweets == null && !_loc_3.isMelted())
                        {
                            _loc_1.push(_loc_3);
                        }
                        var _loc_5:* = _loc_2;
                        var _loc_6:* = _loc_2.y + 1;
                        _loc_5.y = _loc_6;
                    }
                    var _loc_5:* = _loc_2;
                    var _loc_6:* = _loc_2.x + 1;
                    _loc_5.x = _loc_6;
                }
            }
            if (_loc_1.length == 0)
            {
                _loc_4 = 0;
                while (_loc_4 < Sweets.TYPE_MAX)
                {
                    
                    _loc_1 = collectPanelNonMelt(_loc_4);
                    if (_loc_1.length != 0)
                    {
                        break;
                    }
                    _loc_4++;
                }
            }
            _loc_3 = Tools.tableRandomGet(_loc_1) as Panel;
            return _loc_3;
        }// end function

        private static function collectPanelNonMelt(param1:int) : Array
        {
            var _loc_4:Panel = null;
            var _loc_2:* = new Array();
            var _loc_3:* = new Pos2();
            _loc_3.x = 0;
            while (_loc_3.x < PanelAll.whMax)
            {
                
                _loc_3.y = 0;
                while (_loc_3.y < PanelAll.whMax)
                {
                    
                    _loc_4 = PanelAll.getPPos2PanelObj(_loc_3);
                    if (!_loc_4.isMelted() && _loc_4.sweets != null && _loc_4.sweets.type == param1)
                    {
                        _loc_2.push(_loc_4);
                    }
                    var _loc_5:* = _loc_3;
                    var _loc_6:* = _loc_3.y + 1;
                    _loc_5.y = _loc_6;
                }
                var _loc_5:* = _loc_3;
                var _loc_6:* = _loc_3.x + 1;
                _loc_5.x = _loc_6;
            }
            return _loc_2;
        }// end function

    }
}

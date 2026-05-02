package jp.co.pokemon.games.hsc
{
    import bfp.common.*;
    import caurina.transitions.*;
    import common.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class Hsc extends MovieClip
    {
        public var mciGame:MovieClip;
        private var timeRemainMs:int;
        private var timeBeforMs:int = -1;
        private var stateMain:State;
        private var isClicked:Boolean = false;
        private var clickPos:Pos2 = null;
        private var isInitAtMcLoaded:Boolean = false;
        private var isTutorialFirst:Boolean = true;
        private var mciEffectIt:MovieClip;
        private var pokemonTbl:Array;
        private var pokemonMe:Pokemon;
        private var mcDebugText:TextField;
        private var gameData:GameData;
        private var routeLineAim:RouteLine;
        private var routeLineReal:RouteLine;
        private var isPause:Boolean = false;
        private var numPreload:int = 123;
        private var resourceFile:XML;
        private var bgm:Bgm;
        private var windowMessageTimer:int = 0;
        private var isAlreadyManMoveAim:Boolean = false;
        private var debugTextField:TextField;
        private var debugFrameCount:int = 0;
        private var screenEnabled:Boolean = false;
        private var messageWindowIsOpen:Boolean = false;
        private const barLength:int = 403;
        private var BarAnimationTime:int = 0;
        private const BarLastBlinkDuration:int = 10;
        private var timeRemainBarIsEnd:Boolean = false;
        private var effectObjTbl:Array;
        public var loadingCallbackCountCurrent:int = 0;

        public function Hsc()
        {
            this.stateMain = new State("Main", true);
            this.effectObjTbl = new Array();
            addFrameScript(0, this.frame1);
            Global.isStandalone = loaderInfo.loader == null;
            gameBridge.startGame();
            Tools.lang = gameBridge.langCode;
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            addEventListener(MouseEvent.CLICK, this.click);
            this.initAtConstruct();
            return;
        }// end function

        private function removedFromStageHandler(event:Event = null) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            removeEventListener(MouseEvent.CLICK, this.click);
            return;
        }// end function

        private function addedToStageHandler(event:Event = null) : void
        {
            arguments = new activation;
            var resourceFileLoader:URLLoader;
            var e:* = event;
            var arguments:* = arguments;
            removeEventListener(Event.ADDED_TO_STAGE, callee);
            addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
            if (!Global.isStandalone)
            {
                gameBridge.addEventListener(gameBridgeEvent.PAUSE_GAME, this.gameBridgeHandler);
                gameBridge.addEventListener(gameBridgeEvent.RESTART_GAME, this.gameBridgeHandler);
            }
            this.numPreload = 1;
            resourceFileLoader = new URLLoader();
            addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                resourceFile = XML(resourceFileLoader.data);
                FontManager.addEventListener(Event.COMPLETE, preLoadHandler);
                FontManager.loadStringsXml([getResourceURL("STRINGS"), getResourceURL("FORMAT")], "com.pokemon_gl.pdw.minigame.sweetscatch");
                return;
            }// end function
            );
            addEventListener(IOErrorEvent.IO_ERROR, function (event:Event) : void
            {
                resourceFileLoader.removeEventListener(IOErrorEvent.IO_ERROR, arguments.callee);
                return;
            }// end function
            );
            var req:* = new URLRequest(Tools.rootUrl(loaderInfo.url, 1) + "/resource.xml");
            if (Security.sandboxType == Security.REMOTE)
            {
                url = url + ("?now=" + new Date().getTime());
            }
            load();
            return;
        }// end function

        private function getResourceURL(param1:String) : String
        {
            var entry:XMLList;
            var url:String;
            var resName:* = param1;
            var _loc_4:int = 0;
            var _loc_5:* = this.resourceFile.entry;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_5[_loc_4];
                with (_loc_5[_loc_4])
                {
                    if (@name == resName)
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            entry = _loc_3;
            var _loc_4:int = 0;
            var _loc_5:* = entry;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_5[_loc_4];
                with (_loc_5[_loc_4])
                {
                    if (@lang == "*" || @lang.toString().indexOf(gameBridge.langCode) != -1)
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            entry = _loc_3;
            url = Tools.rootUrl(this.loaderInfo.url, 1) + "/" + entry.@source;
            if (Security.sandboxType == Security.REMOTE)
            {
                url = url + ("?version=" + entry.@version);
            }
            return url;
        }// end function

        private function preLoadHandler(event:Event) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this.numPreload - 1;
            _loc_2.numPreload = _loc_3;
            if (this.numPreload <= 0)
            {
                FontManager.removeEventListener(Event.COMPLETE, this.preLoadHandler);
            }
            return;
        }// end function

        private function gameBridgeHandler(event:gameBridgeEvent) : void
        {
            switch(event.type)
            {
                case gameBridgeEvent.PAUSE_GAME:
                {
                    this.isPause = true;
                    break;
                }
                case gameBridgeEvent.RESTART_GAME:
                {
                    this.isPause = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function click(event:Event) : void
        {
            if (this.mciGame.mciPanelPokemon == null)
            {
                return;
            }
            this.isClicked = true;
            this.clickPos = new Pos2(this.mciGame.mciPanelPokemon.mouseX, this.mciGame.mciPanelPokemon.mouseY);
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            this.frameUpdate();
            this.clickPos = null;
            if (this.bgm != null)
            {
                this.bgm.update();
            }
            return;
        }// end function

        private function frameUpdate() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Number = NaN;
            var _loc_6:MovieClip = null;
            var _loc_7:MovieClip = null;
            var _loc_8:Object = null;
            var _loc_9:String = null;
            var _loc_10:Object = null;
            var _loc_11:Array = null;
            var _loc_12:Pokemon = null;
            var _loc_13:Panel = null;
            var _loc_14:Pos2 = null;
            var _loc_15:Pos2 = null;
            var _loc_16:Pos2 = null;
            var _loc_17:RouteLine = null;
            var _loc_22:String = null;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            var _loc_25:String = null;
            var _loc_26:ZButton = null;
            var _loc_27:Number = NaN;
            var _loc_28:Pos2 = null;
            var _loc_29:int = 0;
            var _loc_30:int = 0;
            var _loc_31:int = 0;
            var _loc_32:Pos2 = null;
            var _loc_33:int = 0;
            var _loc_34:Boolean = false;
            var _loc_35:int = 0;
            var _loc_36:int = 0;
            var _loc_18:* = this.stateMain;
            if (this.timeBeforMs == -1)
            {
                this.timeBeforMs = getTimer();
            }
            var _loc_19:* = getTimer();
            var _loc_20:* = Number(_loc_19 - this.timeBeforMs) / 1000;
            var _loc_21:* = 1 / Setting.frameRate * 3;
            if (_loc_20 > _loc_21)
            {
                _loc_20 = _loc_21;
            }
            if (Setting.isDebugText && this.debugTextField != null)
            {
                var _loc_37:String = this;
                var _loc_38:* = this.debugFrameCount + 1;
                _loc_37.debugFrameCount = _loc_38;
                if (Math.floor(this.timeBeforMs / 1000) != Math.floor(_loc_19 / 1000))
                {
                    this.debugTextField.text = "" + this.debugFrameCount;
                    this.debugFrameCount = 0;
                }
            }
            this.timeBeforMs = _loc_19;
            if (this.isInitAtMcLoaded)
            {
                _loc_22 = Dialogs.dialogExitUpdate(this.mciGame.mciButtonTopExit);
                if (_loc_22 == "Active")
                {
                    return;
                }
                if (_loc_22 == "Exit")
                {
                    this.stateMain.appoint("ButtonTopExitPress");
                }
            }
            if (_loc_18.getValue() == "SceneMain" && _loc_18.isAppointed())
            {
                this.mciGame.mciButtonTopHelp.isActive = false;
            }
            switch(_loc_18.update())
            {
                case "Begin":
                {
                    _loc_23 = loaderInfo.bytesLoaded;
                    _loc_24 = loaderInfo.bytesTotal;
                    if (_loc_23 >= _loc_24 && _loc_24 > 4 && this.numPreload <= 0)
                    {
                        _loc_18.appoint("SceneEntryPre");
                        _loc_25 = FontManager.getIdText("WIN_RESULT_TITLE");
                    }
                    break;
                }
                case "SceneEntryPre":
                {
                    if (_loc_18.isFirst())
                    {
                        this.initAtMcLoded();
                        this.isInitAtMcLoaded = true;
                        if (Setting.isSoundTest)
                        {
                            _loc_18.appoint("SoundTest");
                        }
                        else
                        {
                            _loc_18.appoint("SceneTutorial", {useButton:"mciButtonStart"});
                        }
                    }
                    break;
                }
                case "SoundTest":
                {
                    if (_loc_18.isFirst())
                    {
                        ZSound.testStart();
                    }
                    if (this.clickPos != null)
                    {
                        ZSound.testOne();
                    }
                    break;
                }
                case "SceneTutorial":
                {
                    if (_loc_18.isFirst())
                    {
                        Dialogs.dialogMainStart("mciDialogTutorial", this.isTutorialFirst);
                    }
                    _loc_26 = Dialogs.dialogMain.mc[_loc_18.parameter.useButton];
                    if (_loc_18.isFirst())
                    {
                        Dialogs.dialogMain.mc["mciButtonStart"].visible = false;
                        Dialogs.dialogMain.mc["mciButtonClose"].visible = false;
                        _loc_26.visible = true;
                        _loc_26.clearClick();
                    }
                    if (Dialogs.dialogMainAnimationIsEnd())
                    {
                        if (_loc_26.getIsClicked())
                        {
                            _loc_18.pushCall("SceneTutorialEnd", "DialogClose");
                        }
                    }
                    break;
                }
                case "SceneTutorialEnd":
                {
                    if (this.isTutorialFirst)
                    {
                        this.isTutorialFirst = false;
                        _loc_18.appoint("CountDown");
                    }
                    else
                    {
                        _loc_18.appoint("SceneMain");
                    }
                    break;
                }
                case "DialogClose":
                {
                    if (_loc_18.isFirst())
                    {
                        Dialogs.dialogMainEnd();
                    }
                    if (Dialogs.dialogMainAnimationIsEnd())
                    {
                        _loc_18.popReturn();
                    }
                    break;
                }
                case "CountDown":
                {
                    if (_loc_18.isFirst())
                    {
                        this.mciEffectIt = new mclCountDown();
                        this.mciEffectIt.start.gotoAndStop(gameBridge.langCode);
                        this.mciGame.mciCountDownBase.addChild(this.mciEffectIt);
                        this.mciEffectIt.x = int(Setting.gameWidth / 2);
                        this.mciEffectIt.y = int(Setting.gameHeight / 2);
                    }
                    if (this.isPause)
                    {
                        break;
                    }
                    if (_loc_18.getTime() == 3)
                    {
                        this.pokemonTbl[0].goFlyIn();
                    }
                    _loc_1 = 0;
                    while (_loc_1 < this.pokemonTbl.length)
                    {
                        
                        this.pokemonTbl[_loc_1].update();
                        _loc_1++;
                    }
                    this.drawPanelPokemonAll();
                    if (this.mciEffectIt.currentFrame >= this.mciEffectIt.totalFrames)
                    {
                        this.mciGame.mciCountDownBase.removeChild(this.mciEffectIt);
                        this.mciEffectIt = null;
                        SweetsManage.goPlay();
                        _loc_1 = 0;
                        while (_loc_1 < this.pokemonTbl.length)
                        {
                            
                            this.pokemonTbl[_loc_1].goPlayStart();
                            _loc_1++;
                        }
                        _loc_18.appoint("SceneMain");
                    }
                    else
                    {
                        this.mciEffectIt.gotoAndStop((this.mciEffectIt.currentFrame + 1));
                    }
                    break;
                }
                case "SceneMain":
                {
                    if (_loc_18.isFirst())
                    {
                        _loc_20 = 0;
                        this.panelPokemonMouseSw(true);
                        this.mciGame.mciButtonTopHelp.isActive = true;
                        this.mciGame.mciButtonTopHelp.clearClick();
                        if (!this.gameData.isFirstMessageKick)
                        {
                            this.gameData.isFirstMessageKick = true;
                            Global.windowMessageID = "MESSAGE_WINDOW_PLAY_FIRST";
                            Global.windowMessageID_Current = null;
                            Global.windowMessageAutoClose = false;
                        }
                    }
                    if (Global.windowMessageID != null)
                    {
                        this.messageWindowOpen(Global.windowMessageID);
                        Global.windowMessageID_Current = Global.windowMessageID;
                        Global.windowMessageID = null;
                        this.windowMessageTimer = Setting.frameRate * 2;
                    }
                    if (Global.windowMessageAutoClose)
                    {
                        var _loc_37:String = this;
                        var _loc_38:* = this.windowMessageTimer - 1;
                        _loc_37.windowMessageTimer = _loc_38;
                        if (this.windowMessageTimer == 0)
                        {
                            this.messageWindowClose();
                        }
                    }
                    if (this.mciGame.mciButtonTopHelp.getIsClicked())
                    {
                        _loc_18.appoint("SceneTutorial", {useButton:"mciButtonClose"});
                    }
                    if (this.isPause)
                    {
                        break;
                    }
                    _loc_27 = this.gameData.timerSecond;
                    this.gameData.timerSecond = this.gameData.timerSecond - _loc_20;
                    if (this.gameData.timerSecond < 0)
                    {
                        this.gameData.timerSecond = 0;
                        ZSound.play("timeup");
                        _loc_18.appoint("SceneResult");
                    }
                    else if (this.gameData.timerSecond <= 5)
                    {
                        if (Math.floor(this.gameData.timerSecond) != Math.floor(_loc_27))
                        {
                            ZSound.play("count");
                        }
                    }
                    if (this.pokemonMe.getState() == "Main" && this.clickPos != null)
                    {
                        _loc_13 = PanelAll.getDPos2PanelObj(this.clickPos);
                        if (_loc_13 != null)
                        {
                            if (this.myRouteMaking(this.routeLineReal, _loc_13, true) != null)
                            {
                                this.isAlreadyManMoveAim = true;
                            }
                        }
                    }
                    if (this.pokemonMe.getState() == "Main" && this.clickPos == null)
                    {
                        this.routeLineAim.reset();
                        _loc_28 = new Pos2(this.mciGame.mciPanelPokemon.mouseX, this.mciGame.mciPanelPokemon.mouseY);
                        _loc_13 = PanelAll.getDPos2PanelObj(_loc_28);
                        if (_loc_13 != null)
                        {
                            this.myRouteMaking(this.routeLineAim, _loc_13, false);
                        }
                    }
                    SweetsManage.update(this.mciGame, this.pokemonTbl, this.gameData.timerSecond);
                    this.effectObjUpdate();
                    _loc_1 = 0;
                    while (_loc_1 < this.pokemonTbl.length)
                    {
                        
                        _loc_12 = this.pokemonTbl[_loc_1];
                        if (_loc_12.isMoveAble())
                        {
                            if (_loc_12.isCom() && _loc_12.isStop() && !Setting.isDebugComStop)
                            {
                                _loc_11 = PanelAll.createMoveAblePanelTbl(_loc_12.getPPos());
                                if (_loc_11.length != 0)
                                {
                                    _loc_29 = -1;
                                    _loc_30 = -1;
                                    _loc_31 = 0;
                                    while (_loc_31 < _loc_11.length)
                                    {
                                        
                                        _loc_13 = _loc_11[_loc_31] as Panel;
                                        if (_loc_13.sweets != null)
                                        {
                                            if (_loc_30 <= _loc_13.sweets.type)
                                            {
                                                _loc_29 = _loc_31;
                                                _loc_30 = _loc_13.sweets.type;
                                            }
                                        }
                                        _loc_31++;
                                    }
                                    if (_loc_29 == -1 || Tools.random100() < 50)
                                    {
                                        _loc_13 = Tools.tableRandomGet(_loc_11) as Panel;
                                    }
                                    else
                                    {
                                        _loc_13 = _loc_11[_loc_29];
                                    }
                                    _loc_12.routeLine.reset();
                                    _loc_12.routeLine.addPanelPosStart(_loc_12.getPPos());
                                    _loc_12.routeLine.addPanelPos(_loc_13.ppos);
                                }
                            }
                            if (!_loc_12.isStop() && _loc_12.isPanelCenter())
                            {
                                _loc_13 = PanelAll.getPPos2PanelObj(_loc_12.getNextPPos());
                                if (_loc_13.isMelted())
                                {
                                    _loc_12.routeClear();
                                }
                            }
                        }
                        _loc_12.update();
                        _loc_13 = PanelAll.getPPos2PanelObj(_loc_12.getPPos());
                        if (_loc_12.isDrop())
                        {
                            if (_loc_12.getState() == "DropEnd")
                            {
                                _loc_13 = PanelAll.getPPos2PanelObj(_loc_12.getPPos());
                                if (!_loc_13.isMelted())
                                {
                                    _loc_12.goPlayFromDrop();
                                }
                            }
                        }
                        else if (_loc_12.isMoveAble())
                        {
                            _loc_32 = _loc_12.pposPass;
                            if (_loc_32 != null)
                            {
                                _loc_13 = PanelAll.getPPos2PanelObj(_loc_32);
                                _loc_13.meltIncrement();
                                _loc_13 = this.getPanelObjAtPokemon(_loc_12);
                                this.pokemonCheckDrop(_loc_12, _loc_13);
                            }
                            else
                            {
                                var _loc_37:* = _loc_13;
                                var _loc_38:* = _loc_13.numStopOnPokemon + 1;
                                _loc_37.numStopOnPokemon = _loc_38;
                                this.pokemonCheckDrop(_loc_12, _loc_13);
                            }
                            this.sweetsGettingProcess(_loc_12);
                        }
                        _loc_1++;
                    }
                    _loc_12 = this.pokemonTbl[0];
                    this.panelPokemonMouseSw(_loc_12.isMoveAble());
                    CrowdsAll.update();
                    PanelAll.update();
                    this.drawPanelPokemonAll();
                    break;
                }
                case "SceneResult":
                {
                    if (_loc_18.isFirst())
                    {
                        this.timeRemainBarIsEnd = true;
                        this.bgm.setVolumeForEndGame();
                        Dialogs.dialogMainStart("mciDialogResult");
                        _loc_33 = 0;
                        _loc_1 = 0;
                        while (_loc_1 < Sweets.TYPE_MAX)
                        {
                            
                            _loc_2 = this.gameData.sweetsGetTbl[0][_loc_1];
                            if (Setting.isDebugScore)
                            {
                                _loc_2 = 1;
                            }
                            Tools.textFieldSetNumber(Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_SWEETS_" + _loc_1], _loc_2);
                            _loc_3 = _loc_2 * Sweets.scoreTbl[_loc_1];
                            Tools.textFieldSetNumber(Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_" + _loc_1], _loc_3);
                            _loc_33 = _loc_33 + _loc_3;
                            _loc_1++;
                        }
                        _loc_34 = this.gameData.getOrderMe() == 0;
                        if (Setting.isDebugScore)
                        {
                            _loc_34 = !Setting.isDebugScoreIsBonusNone;
                        }
                        if (_loc_34)
                        {
                            _loc_33 = _loc_33 + 5000;
                            _loc_36 = 20;
                            _loc_1 = 0;
                            while (_loc_1 < Sweets.TYPE_MAX)
                            {
                                
                                Dialogs.dialogMain.mc["mciSweets" + _loc_1].y = Dialogs.dialogMain.mc["mciSweets" + _loc_1].y - _loc_36;
                                Dialogs.dialogMain.mc["texti_DIALOG_RESULT_KO_" + _loc_1].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_KO_" + _loc_1].y - _loc_36;
                                Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_SWEETS_" + _loc_1].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_SWEETS_" + _loc_1].y - _loc_36;
                                Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_" + _loc_1].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_" + _loc_1].y - _loc_36;
                                Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_" + _loc_1].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_" + _loc_1].y - _loc_36;
                                _loc_1++;
                            }
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_BONUS"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_BONUS"].y - _loc_36;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_BONUS"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_BONUS"].y - _loc_36;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_4"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_4"].y - _loc_36;
                            Tools.textFieldSetNumber(Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_BONUS"], GameData.BonusPoint);
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_5"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_5"].y + _loc_36;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_TOTAL"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_TOTAL"].y + _loc_36;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_TOTAL"].y = Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_TOTAL"].y + _loc_36;
                        }
                        else
                        {
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_POINT_4"].visible = false;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_BONUS"].visible = false;
                            Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_BONUS"].visible = false;
                        }
                        Tools.textFieldSetNumber(Dialogs.dialogMain.mc["texti_DIALOG_RESULT_NUM_POINT_TOTAL"], _loc_33);
                        _loc_1 = 0;
                        while (_loc_1 < Setting.resultScoreRankTbl.length)
                        {
                            
                            if (_loc_33 >= Setting.resultScoreRankTbl[_loc_1])
                            {
                                break;
                            }
                            _loc_1++;
                        }
                        if (++_loc_1 > 5)
                        {
                            gameBridge.result = gameResult.FAILURE;
                            gameBridge.rank = 0;
                        }
                        else
                        {
                            gameBridge.result = gameResult.SUCCESS;
                            gameBridge.rank = _loc_1 + 1;
                        }
                    }
                    if (Dialogs.dialogMainAnimationIsEnd())
                    {
                        if (Dialogs.dialogMain.mc.mciButtonIt.getIsClicked())
                        {
                            _loc_18.pushCall("BgmFadeoutToEnd", "DialogClose");
                        }
                    }
                    break;
                }
                case "ButtonTopExitPress":
                {
                    gameBridge.result = gameResult.ABORT;
                    _loc_18.appoint("BgmFadeoutToEnd");
                    break;
                }
                case "BgmFadeoutToEnd":
                {
                    if (_loc_18.isFirst())
                    {
                        if (this.bgm.isStopOrVolumeZero())
                        {
                            this.bgm.stop();
                            _loc_18.appoint("End");
                        }
                        else
                        {
                            this.bgm.fadeout();
                        }
                    }
                    if (this.bgm.isFadeEnd())
                    {
                        this.bgm.stop();
                        _loc_18.appoint("End");
                    }
                    break;
                }
                case "End":
                {
                    if (gameBridge.result == gameResult.ABORT)
                    {
                        gameBridge.closeGame();
                    }
                    else
                    {
                        gameBridge.finishGame();
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

        private function pokemonCheckDrop(param1:Pokemon, param2:Panel) : void
        {
            if (!param2.isMelted() || Setting.isDebugNoPokemonDrop)
            {
                return;
            }
            param1.goDrop();
            if (param1.isMan())
            {
                var _loc_3:* = this.gameData;
                var _loc_4:* = this.gameData.drop + 1;
                _loc_3.drop = _loc_4;
                this.routeLineAim.reset();
            }
            return;
        }// end function

        private function getPanelObjAtPokemon(param1:Pokemon) : Panel
        {
            var _loc_2:* = param1.getPPos();
            var _loc_3:* = PanelAll.getPPos2PanelObj(_loc_2);
            return _loc_3;
        }// end function

        private function initAtConstruct() : void
        {
            this.gameData = new GameData();
            return;
        }// end function

        private function panelPokemonMouseSw(param1:Boolean) : void
        {
            this.mciGame.mciPanelPokemon.mouseChildren = param1;
            this.mciGame.mciPanelPokemon.mouseEnabled = param1;
            return;
        }// end function

        private function initAtMcLoded() : void
        {
            var _loc_2:int = 0;
            var _loc_3:Pos2 = null;
            var _loc_8:Object = null;
            var _loc_9:Pokemon = null;
            var _loc_10:MovieClip = null;
            var _loc_11:String = null;
            var _loc_12:MovieClip = null;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Rectangle = null;
            var _loc_19:TextFormat = null;
            this.bgm = new Bgm();
            this.bgm.kick();
            var _loc_1:* = PanelAll.getWH();
            PanelAll.init(this.mciGame.mciPanelMcGuide);
            this.panelPokemonMouseSw(false);
            PokeMc.init();
            var _loc_4:* = PanelAll.makeAllPositionTbl();
            var _loc_5:* = PokeMc.choicePcNpc();
            this.pokemonTbl = new Array();
            _loc_2 = 0;
            while (_loc_2 < GameData.pokemonMax)
            {
                
                _loc_9 = new Pokemon(_loc_2, _loc_5[_loc_2]);
                if (_loc_2 == 0)
                {
                    _loc_3 = new Pos2(2, (PanelAll.whMax - 1));
                    Pos2.tblEqualPositionDelete(_loc_4, _loc_3);
                }
                else
                {
                    _loc_3 = Tools.tableRandomGetAndDelete(_loc_4) as Pos2;
                }
                _loc_9.setPos(_loc_3);
                this.pokemonTbl[_loc_2] = _loc_9;
                _loc_9.dir4 = (_loc_2 + 1) % 4;
                _loc_2++;
            }
            this.pokemonMe = this.pokemonTbl[0];
            SweetsManage.init(_loc_4);
            CrowdsAll.init(this.mciGame.mciCrowdsGuide);
            var _loc_6:int = 0;
            while (_loc_6 < GameData.pokemonMax)
            {
                
                _loc_10 = this.mciGame["mciPokemonStatus" + _loc_6];
                if (_loc_6 == 0)
                {
                    _loc_11 = "POKEMON_NAME_PC_" + this.pokemonTbl[_loc_6].type;
                    PDWTools.setAutoFontTextIDsOne([_loc_10.texti_POKEMON_STATUS_NAME_ME, null, FontManager.getIdText(_loc_11)]);
                }
                else
                {
                    _loc_11 = "POKEMON_NAME_NPC_" + this.pokemonTbl[_loc_6].type;
                    PDWTools.setAutoFontTextIDsOne([_loc_10.texti_POKEMON_STATUS_NAME_ENEMY, null, FontManager.getIdText(_loc_11)]);
                }
                _loc_12 = this.pokemonTbl[_loc_6].mcForStatus;
                _loc_10.mciPokemon.addChild(_loc_12);
                _loc_12.gotoAndStop(2);
                _loc_13 = _loc_6 == 0 ? (74) : (50);
                _loc_14 = _loc_12.width;
                _loc_15 = _loc_12.height;
                _loc_16 = _loc_14 > _loc_15 ? (_loc_14) : (_loc_15);
                _loc_17 = _loc_13 / _loc_16;
                var _loc_20:* = _loc_17;
                _loc_12.scaleY = _loc_17;
                _loc_12.scaleX = _loc_20;
                _loc_18 = _loc_12.getBounds(_loc_10.mciPokemon);
                _loc_12.x = Math.floor(_loc_12.x - _loc_18.left + (_loc_13 - _loc_18.width) / 2);
                _loc_12.y = Math.floor(_loc_12.y - _loc_18.top + (_loc_13 - _loc_18.height) / 2);
                _loc_18 = _loc_12.getBounds(_loc_10.mciPokemon);
                _loc_6++;
            }
            this.pokemonStatusSetting();
            PDWTools.setAutoFontTextIDsButton(this.mciGame.mciButtonTopExit);
            this.mciGame.mciButtonTopHelp.isActive = false;
            this.mciGame.mciMessageWindows.visible = false;
            Dialogs.allDialogInit(this.mciGame, this.bgm);
            this.routeLineReal = new RouteLine(RouteLine.LINE_TYPE_REAL);
            this.routeLineAim = new RouteLine(RouteLine.LINE_TYPE_AIM);
            this.mciGame.mciPanelMcGuide.visible = false;
            this.mciGame.visible = true;
            SweetsManage.update(this.mciGame, this.pokemonTbl);
            var _loc_7:int = 50;
            _loc_8 = this.pokemonMcMake(gameBridge.myPokemonId, gameBridge.myFormId, _loc_7);
            if (_loc_8 != null)
            {
                this.mciGame.mciMeAndEncountPokemon.mciMe.addChild(_loc_8.display);
                PDWTools.setAutoFontTextIDsOne([this.mciGame.mciMeAndEncountPokemon.texti_ICON_ENCOUNT, null, FontManager.getIdText("ICON_ME")]);
            }
            _loc_8 = this.pokemonMcMake(gameBridge.encountPokemonId, gameBridge.encountFormId, _loc_7);
            if (_loc_8 != null)
            {
                this.mciGame.mciMeAndEncountPokemon.mciEncount.addChild(_loc_8.display);
                PDWTools.setAutoFontTextIDsOne([this.mciGame.mciMeAndEncountPokemon.texti_ICON_ME, null, FontManager.getIdText("ICON_ENCOUNT")]);
            }
            if (Setting.isDebugText)
            {
                _loc_19 = new TextFormat();
                _loc_19.color = 16711680;
                _loc_19.size = 20;
                this.debugTextField = new TextField();
                this.debugTextField.x = 0;
                this.debugTextField.y = 0;
                this.debugTextField.width = 200;
                this.debugTextField.height = 20;
                this.debugTextField.defaultTextFormat = _loc_19;
                this.debugTextField.text = "qwe";
                this.mciGame.addChild(this.debugTextField);
            }
            this.drawPanelPokemonAll();
            return;
        }// end function

        private function messageWindowOpen(param1:String) : void
        {
            var mc:MovieClip;
            var id:* = param1;
            var closeCallback:* = function ()
            {
                PDWTools.setAutoFontTextIDsOne([mc.texti_MESSAGE_WINDOW, null, FontManager.getIdText(id)]);
                return;
            }// end function
            ;
            mc = this.mciGame.mciMessageWindows;
            mc.visible = true;
            mc.alpha = 0;
            if (this.messageWindowIsOpen)
            {
                Tweener.addTween(mc, {time:0.3, alpha:0, transition:"linear", onComplete:closeCallback});
                Tweener.addTween(mc, {delay:0.3, time:0.3, alpha:1, transition:"linear"});
            }
            else
            {
                PDWTools.setAutoFontTextIDsOne([mc.texti_MESSAGE_WINDOW, null, FontManager.getIdText(id)]);
                Tweener.addTween(mc, {time:0.3, alpha:1, transition:"linear"});
            }
            this.messageWindowIsOpen = true;
            return;
        }// end function

        private function messageWindowClose() : void
        {
            var messageWindowCallback:* = function ()
            {
                this.visible = false;
                return;
            }// end function
            ;
            var mc:* = this.mciGame.mciMessageWindows;
            mc.visible = true;
            Tweener.addTween(mc, {time:0.3, alpha:0, transition:"linear", onComplete:messageWindowCallback});
            this.messageWindowIsOpen = false;
            Global.windowMessageID_Current = null;
            return;
        }// end function

        private function pokemonStatusSetting() : void
        {
            var _loc_3:Object = null;
            var _loc_4:MovieClip = null;
            var _loc_1:* = this.gameData.getOrderTbl();
            var _loc_2:int = 0;
            while (_loc_2 < GameData.pokemonMax)
            {
                
                _loc_3 = _loc_1[_loc_2];
                _loc_4 = this.mciGame["mciPokemonStatus" + _loc_3.pi];
                _loc_4.gotoAndStop((_loc_3.order + 1));
                if (_loc_3.pi == 0)
                {
                    Tools.textFieldSetNumber(_loc_4.texti_POKEMON_STATUS_SCORE_ME, _loc_3.score);
                }
                else
                {
                    Tools.textFieldSetNumber(_loc_4.texti_POKEMON_STATUS_SCORE_ENEMY, _loc_3.score);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function setTimeRemainBarNumber() : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Array = null;
            var _loc_10:Array = null;
            var _loc_11:Array = null;
            var _loc_12:int = 0;
            var _loc_1:* = this.gameData.timerSecond / Number(this.gameData.timerMax);
            this.mciGame.mciTimeBar.mciBar.y = Math.floor(this.barLength * (1 - _loc_1));
            var _loc_2:* = Math.ceil(this.gameData.timerSecond);
            if (this.gameData.timerSecond < this.BarLastBlinkDuration)
            {
                _loc_4 = 24;
                _loc_5 = this.BarAnimationTime % _loc_4;
                _loc_6 = 2 * Number(_loc_5) / Number(_loc_4);
                if (this.timeRemainBarIsEnd)
                {
                    _loc_6 = 0;
                }
                if (_loc_6 > 1)
                {
                    _loc_6 = 2 - _loc_6;
                }
                _loc_7 = _loc_6;
                _loc_8 = 1 - _loc_7;
                _loc_9 = new Array();
                _loc_10 = [0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0];
                _loc_11 = [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
                _loc_12 = 0;
                while (_loc_12 < _loc_10.length)
                {
                    
                    _loc_9[_loc_12] = _loc_10[_loc_12] * _loc_7 + _loc_11[_loc_12] * _loc_8;
                    _loc_12++;
                }
                this.mciGame.mciTimeBar.mciBar.filters = [new ColorMatrixFilter(_loc_9)];
                this.mciGame.mciTimeBar.mciTop.filters = [new ColorMatrixFilter(_loc_9)];
                this.mciGame.mciTimeBar.mciHightLight.filters = [new ColorMatrixFilter(_loc_9)];
                this.mciGame.mciTimeBar.mciHightLight.alpha = _loc_7;
            }
            var _loc_3:* = _loc_2 < 10 ? ("0" + String(_loc_2)) : (String(_loc_2));
            if (_loc_2 < 10)
            {
                this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER.visible = false;
                this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER_BIG.visible = true;
                Tools.textFieldSetString(this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER_BIG, _loc_3);
            }
            else
            {
                this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER.visible = true;
                this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER_BIG.visible = false;
                Tools.textFieldSetString(this.mciGame.mciTimeBar.texti_TIME_REMAIN_NUMBER, _loc_3);
            }
            var _loc_13:String = this;
            var _loc_14:* = this.BarAnimationTime + 1;
            _loc_13.BarAnimationTime = _loc_14;
            return;
        }// end function

        private function drawPanelPokemonAll() : void
        {
            Tools.removeChildrenAll(this.mciGame.mciPanelPokemon);
            Tools.removeChildrenAll(this.mciGame.mciTuraraFront);
            this.drawPanelPokemonAllOne();
            this.setTimeRemainBarNumber();
            return;
        }// end function

        private function drawPanelPokemonAllOne() : void
        {
            var _loc_1:int = 0;
            var _loc_3:Object = null;
            var _loc_6:int = 0;
            var _loc_2:* = new Array();
            _loc_1 = 0;
            while (_loc_1 < this.pokemonTbl.length)
            {
                
                _loc_3 = new Object();
                _loc_3.i = _loc_1;
                _loc_3.y = this.pokemonTbl[_loc_1].dpos.y;
                _loc_2[_loc_1] = _loc_3;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < (this.pokemonTbl.length - 1))
            {
                
                _loc_6 = _loc_1 + 1;
                while (_loc_6 < this.pokemonTbl.length)
                {
                    
                    if (_loc_2[_loc_1].y > _loc_2[_loc_6].y)
                    {
                        _loc_3 = _loc_2[_loc_1];
                        _loc_2[_loc_1] = _loc_2[_loc_6];
                        _loc_2[_loc_6] = _loc_3;
                    }
                    _loc_6++;
                }
                _loc_1++;
            }
            this.routeLineReal.setRouteLine(this.pokemonMe.routeLine);
            this.routeLineReal.drawInit(this.mciGame.mciPanelPokemon);
            this.routeLineAim.drawInit(this.mciGame.mciPanelPokemon);
            var _loc_4:* = this.routeLineReal.getLastPPos();
            if (this.routeLineReal.getLastPPos() != null)
            {
            }
            PanelAll.setRouteTargetPPos(_loc_4);
            var _loc_5:int = -1;
            while (_loc_5 <= PanelAll.whMax)
            {
                
                PanelAll.draw(this.mciGame.mciPanelPokemon, _loc_5);
                if (this.routeLineReal != null)
                {
                    this.routeLineReal.draw(this.mciGame.mciPanelPokemon, this.pokemonMe.dpos, _loc_5);
                }
                if (this.routeLineAim != null)
                {
                    this.routeLineAim.draw(this.mciGame.mciPanelPokemon, this.pokemonMe.dpos, _loc_5);
                }
                CrowdsAll.draw(this.mciGame, _loc_5);
                _loc_1 = 0;
                while (_loc_1 < SweetsManage.sweetsTbl.length)
                {
                    
                    SweetsManage.sweetsTbl[_loc_1].draw(this.mciGame.mciPanelPokemon, _loc_5);
                    _loc_1++;
                }
                _loc_1 = 0;
                while (_loc_1 < this.pokemonTbl.length)
                {
                    
                    this.pokemonTbl[_loc_2[_loc_1].i].draw(this.mciGame.mciPanelPokemon, _loc_5);
                    _loc_1++;
                }
                _loc_5++;
            }
            this.effectObjDraw(this.mciGame.mciPanelPokemon);
            return;
        }// end function

        private function sweetsGettingProcess(param1:Pokemon) : Boolean
        {
            var _loc_3:Number = NaN;
            var _loc_2:* = this.getPanelObjAtPokemon(param1);
            if (_loc_2.sweets == null)
            {
                return false;
            }
            if (param1.moveStepInPanel <= Pokemon.moveDurationAtPanel / 2)
            {
                _loc_3 = param1.moveStepInPanel;
            }
            else
            {
                _loc_3 = Pokemon.moveDurationAtPanel - param1.moveStepInPanel;
            }
            var _loc_4:* = Number(_loc_3) / Number(Pokemon.moveDurationAtPanel / 2);
            if (Number(_loc_3) / Number(Pokemon.moveDurationAtPanel / 2) > 0.5)
            {
                return false;
            }
            if (_loc_2.sweets.isPokemonGetAble())
            {
                this.sweetsGetExec(param1, _loc_2.sweets);
                return true;
            }
            return false;
        }// end function

        private function sweetsGetExec(param1:Pokemon, param2:Sweets) : void
        {
            var _loc_4:Pos2 = null;
            var _loc_3:* = PanelAll.getPPos2PanelObj(param2.ppos);
            _loc_3.sweets = null;
            var _loc_5:* = this.gameData.sweetsGetTbl[param1.index];
            var _loc_6:* = param2.type;
            var _loc_7:* = this.gameData.sweetsGetTbl[param1.index][param2.type] + 1;
            _loc_5[_loc_6] = _loc_7;
            this.pokemonStatusSetting();
            if (param1.isMan())
            {
                _loc_4 = PanelAll.getPPos2DPos(param2.ppos);
                this.goSweetsScoreEffect(_loc_4, param2.type);
                ZSound.play("get_sweet_" + param2.type);
                if (Global.windowMessageID_Current == "MESSAGE_WINDOW_PLAY_FIRST" && this.isAlreadyManMoveAim)
                {
                    this.messageWindowClose();
                }
            }
            SweetsManage.deleteSweets(param2);
            return;
        }// end function

        private function goSweetsScoreEffect(param1:Pos2, param2:int) : void
        {
            var dpos:* = param1;
            var sweetsType:* = param2;
            var mc:* = new SweetsScore();
            mc.gotoAndStop((sweetsType + 1));
            mc.x = dpos.x;
            mc.y = dpos.y;
            var obj:Object;
            this.effectObjTbl.push(obj);
            var callback:* = function ()
            {
                this.visible = false;
                return;
            }// end function
            ;
            Tweener.addTween(mc, {time:0.3, y:mc.y - 40, transition:"easeOutQuint", onComplete:callback});
            Tweener.addTween(mc, {time:0.3, alpha:0, transition:"easeInQuint"});
            return;
        }// end function

        private function effectObjCallBack() : void
        {
            return;
        }// end function

        private function effectObjUpdate() : void
        {
            var _loc_2:Object = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.effectObjTbl.length)
            {
                
                _loc_2 = this.effectObjTbl[_loc_1];
                if (_loc_2.type == "SweetsScoreEffect")
                {
                    if (!_loc_2.mc.visible)
                    {
                        this.effectObjTbl[_loc_1] = null;
                    }
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.effectObjTbl.length)
            {
                
                if (this.effectObjTbl[_loc_1] == null)
                {
                    this.effectObjTbl.splice(_loc_1, 1);
                    continue;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function effectObjDraw(param1:MovieClip) : void
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            while (_loc_2 < this.effectObjTbl.length)
            {
                
                _loc_3 = this.effectObjTbl[_loc_2];
                if (_loc_3.type == "SweetsScoreEffect")
                {
                    param1.addChild(_loc_3.mc);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function sweetsTblPrint() : void
        {
            return;
        }// end function

        private function myRouteMaking(param1:RouteLine, param2:Panel, param3:Boolean) : RouteLine
        {
            var _loc_4:Pos2 = null;
            var _loc_5:Pos2 = null;
            var _loc_6:RouteOne = null;
            var _loc_7:RouteOne = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            param1.reset();
            if (this.isClickPositionUDLR_Melt(param2))
            {
                return null;
            }
            if (this.pokemonMe.routeLine.lineTbl.length >= 1)
            {
                _loc_6 = this.pokemonMe.routeLine.lineTbl[0];
                _loc_5 = _loc_6.ppos;
            }
            else
            {
                _loc_5 = this.pokemonMe.getPPos();
            }
            param1.addPanelPosStart(_loc_5);
            if (this.pokemonMe.moveStepInPanel == 0)
            {
                _loc_5 = this.pokemonMe.getPPos();
                _loc_8 = this.pokemonMe.dir4;
            }
            else
            {
                if (this.pokemonMe.routeLine.lineTbl.length < 1)
                {
                }
                _loc_6 = this.pokemonMe.routeLine.lineTbl[1];
                _loc_5 = _loc_6.ppos;
                _loc_8 = _loc_6.dir4;
                param1.addPanelPos(this.pokemonMe.getNextPPos());
            }
            _loc_4 = param2.ppos.subFrom(_loc_5);
            if (_loc_4.x == 0 && _loc_4.y == 0)
            {
                if (this.pokemonMe.moveStepInPanel == 0)
                {
                    param1.lineTbl.length = 0;
                }
            }
            else if (_loc_4.x == 0 || _loc_4.y == 0)
            {
                param1.addPanelPos(param2.ppos);
            }
            else
            {
                _loc_9 = _loc_4.x < 0 ? (2) : (0);
                _loc_10 = _loc_4.y < 0 ? (3) : (1);
                _loc_11 = Tools.iabs(Tools.dir4MP(_loc_9 - _loc_8));
                _loc_12 = Tools.iabs(Tools.dir4MP(_loc_10 - _loc_8));
                if (_loc_11 <= _loc_12)
                {
                    param1.addPanelPos(new Pos2(param2.ppos.x, _loc_5.y));
                }
                else
                {
                    param1.addPanelPos(new Pos2(_loc_5.x, param2.ppos.y));
                }
                param1.addPanelPos(param2.ppos);
            }
            if (param1.lineTbl.length >= 3)
            {
                _loc_6 = param1.lineTbl[0];
                _loc_7 = param1.lineTbl[2];
                if (_loc_6.ppos.isEq(_loc_7.ppos))
                {
                    param1.lineTbl.splice(0, 1);
                    if (param3)
                    {
                        this.pokemonMe.moveStepInPanel = Pokemon.moveDurationAtPanel - this.pokemonMe.moveStepInPanel;
                    }
                }
            }
            if (param3)
            {
                this.pokemonMe.routeLine.setRouteLine(param1);
            }
            return param1;
        }// end function

        private function isClickPositionUDLR_Melt(param1:Panel) : Boolean
        {
            var _loc_3:Panel = null;
            var _loc_2:* = param1.ppos.subFrom(this.pokemonMe.getPPos());
            if (_loc_2.x == 0 && Math.abs(_loc_2.y) == 1 || _loc_2.y == 0 && Math.abs(_loc_2.x) == 1)
            {
                _loc_3 = PanelAll.getPPos2PanelObj(param1.ppos);
                return _loc_3.isMelted();
            }
            return false;
        }// end function

        private function isClickPositionBack(param1:Panel) : Boolean
        {
            var _loc_3:RouteOne = null;
            var _loc_2:* = Tools.posToDir4JustOnly(param1.ppos, this.pokemonMe.getPPos());
            if (_loc_2 != -1)
            {
                _loc_2 = Tools.dir4Quantize(_loc_2 + 2);
                _loc_3 = this.pokemonMe.routeLine.lineTbl[0];
                if (_loc_3.dir4 == _loc_2)
                {
                    return true;
                }
            }
            if (param1.ppos.isEq(this.pokemonMe.getPPos()))
            {
                return true;
            }
            return false;
        }// end function

        private function pokemonBridgeCompleteHandler(event:Event) : void
        {
            var _loc_2:String = this;
            var _loc_3:* = this.loadingCallbackCountCurrent - 1;
            _loc_2.loadingCallbackCountCurrent = _loc_3;
            return;
        }// end function

        private function pokemonMcMake(param1:int, param2:int, param3:int)
        {
            var _loc_5:Sprite = null;
            var _loc_4:* = PokemonBridge.createRenderer();
            if (PokemonBridge.createRenderer())
            {
                var _loc_6:String = this;
                var _loc_7:* = this.loadingCallbackCountCurrent + 1;
                _loc_6.loadingCallbackCountCurrent = _loc_7;
                _loc_4.addEventListener(Event.COMPLETE, this.pokemonBridgeCompleteHandler);
                _loc_4.loadToArea(param1, param2, param3, param3);
                _loc_4.shadowOpacity = 0;
                _loc_5 = Sprite(_loc_4.display);
                _loc_5.x = (-param3) / 2;
                _loc_5.y = (-param3) / 2;
                return _loc_4;
            }
            return null;
        }// end function

        private function test00() : void
        {
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

    }
}

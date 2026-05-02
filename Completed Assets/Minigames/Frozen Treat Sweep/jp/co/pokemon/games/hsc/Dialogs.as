package jp.co.pokemon.games.hsc
{
    import caurina.transitions.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class Dialogs extends Object
    {
        private static const dialogNameTbl:Array = ["DialogTutorial", "DialogResult", "DialogExit"];
        public static var dialogMain:Object;
        public static var dialogExit:Object;
        private static var dialogMcDic:Object;
        private static var mciDialogExit:MovieClip;
        private static var mciDialogMain:MovieClip;
        private static var stateDialogExit:Object = new State("DialogExit", true);
        private static var bgm:Bgm;
        private static var tweenerCompleteHandlerIsCome:Boolean = false;
        private static const dislogOffsetY:int = 40;

        public function Dialogs()
        {
            return;
        }// end function

        private static function tweenerCompleteHandler() : void
        {
            tweenerCompleteHandlerIsCome = true;
            return;
        }// end function

        private static function dialogMain_openCloseDialogCallback() : void
        {
            dialogMain.state = "callback";
            return;
        }// end function

        private static function dialogExit_openCloseDialogCallback() : void
        {
            dialogExit.state = "callback";
            return;
        }// end function

        private static function dialogTextFontSetting(param1:MovieClip, param2:String) : void
        {
            var _loc_3:TextField = null;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            _loc_5 = 0;
            while (_loc_5 < param1.numChildren)
            {
                
                _loc_4 = param1.getChildAt(_loc_5);
                if (_loc_4.name.indexOf("texti_") == 0)
                {
                    _loc_3 = TextField(_loc_4);
                    PDWTools.setAutoFontTextIDsOne([_loc_3]);
                }
                if (_loc_4.name.indexOf("mciButton") == 0)
                {
                    PDWTools.setAutoFontTextIDsButton(ZButton(_loc_4));
                }
                _loc_5++;
            }
            return;
        }// end function

        private static function dialogDataInit(param1:Function) : Object
        {
            var _loc_2:* = new Object();
            _loc_2.currentName = null;
            _loc_2.state = "close";
            _loc_2.calltype = null;
            _loc_2.callback = param1;
            return _loc_2;
        }// end function

        private static function dialog_openMotion3(param1, param2:Function) : void
        {
            param1.x = int(Setting.gameWidth / 2);
            param1.y = int(Setting.gameHeight / 2 - 29) + dislogOffsetY;
            param1.alpha = 0;
            param1.visible = true;
            Tweener.addTween(param1, {time:0.3, alpha:1, transition:"linear"});
            Tweener.addTween(param1, {time:0.3, y:param1.y - dislogOffsetY, transition:"easeOutQuint", onComplete:param2});
            return;
        }// end function

        private static function dialog_closeMotion3(param1, param2:Function) : void
        {
            var mc:* = param1;
            var callback:* = param2;
            Tweener.addTween(mc, {time:0.3, alpha:0, transition:"linear", onComplete:function ()
            {
                mc.visible = false;
                return;
            }// end function
            });
            Tweener.addTween(mc, {time:0.3, y:mc.y + dislogOffsetY, transition:"easeInQuint", onComplete:callback});
            return;
        }// end function

        public static function makeBG(param1:MovieClip, param2:Number) : MovieClip
        {
            var _loc_3:MovieClip = null;
            _loc_3 = new MovieClip();
            param1.addChild(_loc_3);
            var _loc_4:* = new Sprite();
            new Sprite().graphics.lineStyle(0, 0, 0);
            _loc_4.graphics.beginFill(0, 0.6);
            _loc_4.graphics.drawRect(0, 0, Setting.gameWidth, Setting.gameHeight);
            _loc_3.addChild(_loc_4);
            _loc_3.visible = false;
            return _loc_3;
        }// end function

        public static function allDialogInit(param1:MovieClip, param2:Bgm) : void
        {
            var _loc_4:int = 0;
            var _loc_5:MovieClip = null;
            var _loc_6:String = null;
            var _loc_7:Class = null;
            var _loc_3:* = param1.mciDialogBase;
            bgm = param2;
            dialogMain = dialogDataInit(dialogMain_openCloseDialogCallback);
            dialogExit = dialogDataInit(dialogExit_openCloseDialogCallback);
            dialogMain.mcBG_topButtonUnder = makeBG(param1.mciGlayRectTopButtonUnder, 0.3);
            dialogMain.mcBG = makeBG(_loc_3, 0.3);
            mciDialogMain = new MovieClip();
            _loc_3.addChild(mciDialogMain);
            dialogExit.mcBG = makeBG(_loc_3, 0.6);
            mciDialogExit = new MovieClip();
            _loc_3.addChild(mciDialogExit);
            dialogMcDic = new Object();
            _loc_4 = 0;
            while (_loc_4 < dialogNameTbl.length)
            {
                
                _loc_6 = dialogNameTbl[_loc_4];
                _loc_7 = getDefinitionByName("mcl" + _loc_6) as Class;
                _loc_5 = new _loc_7;
                if (_loc_6 == "DialogExit")
                {
                    mciDialogExit.addChild(_loc_5);
                }
                else
                {
                    mciDialogMain.addChild(_loc_5);
                }
                _loc_5.visible = false;
                dialogTextFontSetting(_loc_5, _loc_6);
                dialogMcDic["mci" + _loc_6] = _loc_5;
                _loc_4++;
            }
            return;
        }// end function

        public static function dialogStart(param1:Object, param2:String, param3:Boolean = false) : void
        {
            var _loc_4:* = dialogMcDic[param2];
            dialogMcDic[param2].visible = true;
            _loc_4.x = 0;
            _loc_4.y = 0;
            var _loc_5:int = 1;
            _loc_4.scaleY = 1;
            _loc_4.scaleX = _loc_5;
            _loc_4.alpha = 1;
            if (param1.state == "open")
            {
                mciDialogMain.setChildIndex(_loc_4, (mciDialogMain.numChildren - 1));
            }
            else
            {
                dialog_openMotion3(_loc_4, param1.callback);
            }
            param1.currentName = param2;
            param1.mc = _loc_4;
            param1.state = "open animation";
            param1.callType = "open";
            if (param3)
            {
                dialogMain.mcBG_topButtonUnder.visible = true;
            }
            else
            {
                param1.mcBG.visible = true;
            }
            return;
        }// end function

        public static function dialogMainStart(param1:String, param2:Boolean = false) : void
        {
            dialogStart(dialogMain, param1, param2);
            return;
        }// end function

        public static function dialogMainAnimationIsEnd() : Boolean
        {
            return dialogAnimationIsEnd(dialogMain);
        }// end function

        public static function dialogMainEnd() : void
        {
            dialogEnd(dialogMain);
            return;
        }// end function

        public static function dialogMainIsOpenWithButtonWait() : Boolean
        {
            return dialogIsOpen(dialogMain);
        }// end function

        public static function dialogAnimationIsEnd(param1:Object) : Boolean
        {
            var _loc_2:MovieClip = null;
            if (param1.state == "callback")
            {
                if (param1.callType == "close")
                {
                    _loc_2 = dialogMcDic[param1.currentName];
                    _loc_2.visible = false;
                    param1.state = "close";
                    if (param1.mcBG != null)
                    {
                        param1.mcBG.visible = false;
                    }
                    if (dialogMain.mcBG_topButtonUnder != null)
                    {
                        dialogMain.mcBG_topButtonUnder.visible = false;
                    }
                }
                else
                {
                    param1.state = "open";
                }
            }
            return param1.state == "close" || param1.state == "open";
        }// end function

        public static function dialogEnd(param1:Object) : void
        {
            if (param1.currentName == null)
            {
                return;
            }
            var _loc_2:* = dialogMcDic[param1.currentName];
            dialog_closeMotion3(_loc_2, param1.callback);
            param1.state = "close animation";
            param1.callType = "close";
            return;
        }// end function

        public static function dialogIsOpen(param1:Object) : Boolean
        {
            return param1.state == "open";
        }// end function

        public static function dialogExitUpdate(param1:ZButton) : String
        {
            if (stateDialogExit == null)
            {
                return "None";
            }
            var _loc_2:* = stateDialogExit;
            var _loc_3:* = Dialogs.dialogMcDic["mciDialogExit"];
            _loc_2.update();
            var _loc_4:Boolean = false;
            var _loc_5:Boolean = false;
            switch(_loc_2.getValue())
            {
                case "Begin":
                {
                    _loc_2.appoint("Close");
                    break;
                }
                case "Close":
                {
                    if (_loc_2.isFirst())
                    {
                        param1.isActive = true;
                        param1.clearClick();
                    }
                    if (param1.getIsClicked())
                    {
                        _loc_2.appoint("OpenIn");
                        _loc_5 = true;
                    }
                    break;
                }
                case "OpenIn":
                {
                    if (_loc_2.isFirst())
                    {
                        if (bgm != null)
                        {
                            bgm.fadeoutBase();
                        }
                        Dialogs.dialogStart(Dialogs.dialogExit, "mciDialogExit");
                    }
                    if (Dialogs.dialogAnimationIsEnd(Dialogs.dialogExit))
                    {
                        _loc_2.appoint("OpenMain");
                    }
                    _loc_5 = true;
                    break;
                }
                case "OpenMain":
                {
                    if (_loc_2.isFirst())
                    {
                        _loc_3.mciButtonYes.clearClick();
                        _loc_3.mciButtonNo.clearClick();
                    }
                    if (_loc_3.mciButtonYes.getIsClicked())
                    {
                        _loc_4 = true;
                        _loc_3.mciButtonYes.isActive = false;
                        _loc_3.mciButtonNo.isActive = false;
                        _loc_2.appoint("ToColdSleep");
                    }
                    else if (_loc_3.mciButtonNo.getIsClicked())
                    {
                        _loc_2.appoint("OpenOut");
                    }
                    _loc_5 = true;
                    break;
                }
                case "OpenOut":
                {
                    if (_loc_2.isFirst())
                    {
                        if (bgm != null)
                        {
                            bgm.fadeinBase();
                        }
                        Dialogs.dialogEnd(Dialogs.dialogExit);
                    }
                    if (Dialogs.dialogAnimationIsEnd(Dialogs.dialogExit))
                    {
                        _loc_2.appoint("Close");
                    }
                    _loc_5 = true;
                    break;
                }
                case "ToColdSleep":
                {
                    if (_loc_2.isFirst())
                    {
                        Dialogs.dialogEnd(Dialogs.dialogExit);
                    }
                    if (Dialogs.dialogAnimationIsEnd(Dialogs.dialogExit))
                    {
                        _loc_2.appoint("ColdSleep");
                    }
                    _loc_5 = true;
                    break;
                }
                case "ColdSleep":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_4)
            {
                return "Exit";
            }
            return _loc_5 ? ("Active") : ("None");
        }// end function

    }
}

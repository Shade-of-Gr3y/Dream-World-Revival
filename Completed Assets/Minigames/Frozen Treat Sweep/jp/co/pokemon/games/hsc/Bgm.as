package jp.co.pokemon.games.hsc
{
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;

    public class Bgm extends Object
    {
        private var volumeDefault:Number = 0.4;
        public var stateTop:int = 0;
        public var stateBase:int = 1;
        public var sound:Sound = null;
        public var channel:SoundChannel = null;
        public var volumeTbl:Array;
        private var isSoundComplete:Boolean = false;
        private var timeBeforMs:int = -1;
        private var fadeStepCurrent:Number = 0;
        public static const STATE_OFF:int = 0;
        public static const STATE_PLAY:int = 1;
        public static const STATE_FADEOUT:int = 2;
        public static const STATE_FADEIN:int = 3;
        public static const STATE_DEBUG_OFF:int = 4;
        public static const VOLUME_LAYER_BASE:int = 0;
        public static const VOLUME_LAYER_TOP:int = 1;
        public static const VOLUME_LAYER_MAX:int = 2;

        public function Bgm()
        {
            this.volumeTbl = new Array();
            this.volumeDefault = 0.4;
            if (Setting.isBgmOff)
            {
                this.volumeDefault = 0.0001;
            }
            this.sound = new soundBgm();
            this.volumeTbl[VOLUME_LAYER_BASE] = 1;
            this.volumeTbl[VOLUME_LAYER_TOP] = 0;
            return;
        }// end function

        public function update() : void
        {
            if (this.timeBeforMs == -1)
            {
                this.timeBeforMs = getTimer();
            }
            var _loc_1:* = getTimer();
            var _loc_2:* = _loc_1 - this.timeBeforMs;
            this.timeBeforMs = _loc_1;
            this.fadeStepCurrent = _loc_2 / 1000;
            switch(this.stateBase)
            {
                case STATE_PLAY:
                {
                    break;
                }
                case STATE_FADEOUT:
                {
                    if (this.layerFadeout(VOLUME_LAYER_BASE))
                    {
                        this.stateBase = STATE_PLAY;
                    }
                    break;
                }
                case STATE_FADEIN:
                {
                    if (this.layerFadein(VOLUME_LAYER_BASE))
                    {
                        this.stateBase = STATE_PLAY;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.stateTop)
            {
                case STATE_OFF:
                {
                    break;
                }
                case STATE_DEBUG_OFF:
                {
                    break;
                }
                case STATE_PLAY:
                {
                    if (this.isSoundComplete)
                    {
                        this.stateTop = STATE_OFF;
                    }
                    break;
                }
                case STATE_FADEOUT:
                {
                    if (this.layerFadeout(VOLUME_LAYER_TOP))
                    {
                        this.stateTop = STATE_PLAY;
                    }
                    break;
                }
                case STATE_FADEIN:
                {
                    if (this.layerFadein(VOLUME_LAYER_TOP))
                    {
                        this.stateTop = STATE_PLAY;
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

        public function setVolumeForEndGame() : void
        {
            this.setVolume(0.2);
            return;
        }// end function

        public function setVolume(param1:Number) : void
        {
            this.volumeTbl[VOLUME_LAYER_TOP] = param1;
            this.setVolumeToChannel();
            return;
        }// end function

        private function layerSetVolume(param1:int, param2:Number) : void
        {
            this.volumeTbl[param1] = param2;
            this.setVolumeToChannel();
            return;
        }// end function

        private function layerFadeout(param1:int) : Boolean
        {
            this.volumeTbl[param1] = this.volumeTbl[param1] - this.fadeStepCurrent;
            if (this.volumeTbl[param1] <= 0)
            {
                this.volumeTbl[param1] = 0;
            }
            this.setVolumeToChannel();
            return this.volumeTbl[param1] == 0;
        }// end function

        private function layerFadein(param1:int) : Boolean
        {
            this.volumeTbl[param1] = this.volumeTbl[param1] + this.fadeStepCurrent;
            if (this.volumeTbl[param1] >= 1)
            {
                this.volumeTbl[param1] = 1;
            }
            this.setVolumeToChannel();
            return this.volumeTbl[param1] == 1;
        }// end function

        public function isStop() : Boolean
        {
            return this.stateTop == STATE_OFF || this.stateTop == STATE_DEBUG_OFF;
        }// end function

        public function isStopOrVolumeZero() : Boolean
        {
            return this.stateTop == STATE_OFF || this.volumeTbl[VOLUME_LAYER_TOP] == 0;
        }// end function

        public function isFadeEnd() : Boolean
        {
            return this.stateTop == STATE_PLAY;
        }// end function

        public function debugOff() : void
        {
            this.stop();
            this.volumeTbl[VOLUME_LAYER_TOP] = 0;
            this.setVolumeToChannel();
            this.stateTop = STATE_DEBUG_OFF;
            return;
        }// end function

        public function kick() : void
        {
            if (this.stateTop == STATE_PLAY)
            {
                return;
            }
            this.stop();
            this.channel = this.sound.play(0, int.MAX_VALUE);
            this.volumeTbl[VOLUME_LAYER_TOP] = this.volumeDefault;
            this.setVolumeToChannel();
            this.stateTop = STATE_PLAY;
            return;
        }// end function

        public function kickOneTime() : void
        {
            if (this.stateTop == STATE_PLAY)
            {
                return;
            }
            this.stop();
            this.channel = this.sound.play();
            this.volumeTbl[VOLUME_LAYER_TOP] = this.volumeDefault;
            this.setVolumeToChannel();
            this.stateTop = STATE_PLAY;
            this.channel.addEventListener(Event.SOUND_COMPLETE, this.soundCompleteHandler);
            this.isSoundComplete = false;
            return;
        }// end function

        private function soundCompleteHandler(event:Event) : void
        {
            this.isSoundComplete = true;
            return;
        }// end function

        public function fadeout() : void
        {
            if (this.stateTop == STATE_DEBUG_OFF)
            {
                return;
            }
            if (this.stateTop == STATE_OFF || this.stateTop == STATE_FADEOUT)
            {
                return;
            }
            this.stateTop = STATE_FADEOUT;
            return;
        }// end function

        public function fadein() : void
        {
            if (this.stateTop == STATE_DEBUG_OFF)
            {
                return;
            }
            if (this.stateTop == STATE_OFF)
            {
                this.kick();
                this.volumeTbl[VOLUME_LAYER_TOP] = 0;
                this.setVolumeToChannel();
            }
            this.stateTop = STATE_FADEIN;
            return;
        }// end function

        public function stop() : void
        {
            if (this.channel != null)
            {
                this.channel.stop();
                this.channel = null;
            }
            this.volumeTbl[VOLUME_LAYER_TOP] = 0;
            this.stateTop = STATE_OFF;
            return;
        }// end function

        private function setVolumeToChannel() : void
        {
            if (this.channel == null)
            {
                return;
            }
            var _loc_1:* = this.volumeTbl[VOLUME_LAYER_TOP] * this.volumeTbl[VOLUME_LAYER_BASE];
            var _loc_2:* = new SoundTransform(_loc_1, 0);
            this.channel.soundTransform = _loc_2;
            return;
        }// end function

        public function fadeoutBase() : void
        {
            if (this.stateBase == STATE_OFF || this.stateBase == STATE_FADEOUT)
            {
                return;
            }
            this.stateBase = STATE_FADEOUT;
            return;
        }// end function

        public function fadeinBase() : void
        {
            if (this.stateBase == STATE_FADEIN)
            {
                return;
            }
            this.stateBase = STATE_FADEIN;
            return;
        }// end function

        public function isFadeEndBase() : Boolean
        {
            return this.stateBase == STATE_PLAY;
        }// end function

    }
}

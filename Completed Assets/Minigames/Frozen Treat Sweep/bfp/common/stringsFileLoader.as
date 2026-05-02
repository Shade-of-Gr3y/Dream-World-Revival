package bfp.common
{
    import flash.events.*;
    import flash.net.*;

    public class stringsFileLoader extends EventDispatcher
    {
        private var _stringsLoader:URLLoader;
        private var _stringsFormatLoader:URLLoader;
        private var reqList:Array;
        private var stringsFormat_xml:XML;
        private var strings_xml:XML;
        private var file_id:String;

        public function stringsFileLoader()
        {
            this._stringsLoader = new URLLoader();
            this._stringsFormatLoader = new URLLoader();
            this._stringsLoader.dataFormat = URLLoaderDataFormat.TEXT;
            this._stringsLoader.addEventListener(Event.COMPLETE, this.stringLoadCompleteHandler);
            this._stringsLoader.addEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
            this._stringsLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadErrorHandler);
            this._stringsFormatLoader.dataFormat = URLLoaderDataFormat.TEXT;
            this._stringsFormatLoader.addEventListener(Event.COMPLETE, this.stringFormatLoadCompleteHandler);
            this._stringsFormatLoader.addEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
            this._stringsFormatLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadErrorHandler);
            return;
        }// end function

        public function load(param1, param2:String = "") : void
        {
            this.file_id = param2;
            this.reqList = param1;
            if (this.reqList[0] && this.reqList[0].length > 0)
            {
                this._stringsLoader.load(new URLRequest(this.reqList[0]));
            }
            else
            {
                this.removeEventStringsLoader(false);
                this.loadFormat();
            }
            return;
        }// end function

        private function loadErrorHandler(event:ErrorEvent) : void
        {
            this.removeEvent();
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function stringLoadCompleteHandler(event:Event) : void
        {
            this.strings_xml = XML(this._stringsLoader.data);
            this.loadFormat();
            return;
        }// end function

        private function loadFormat() : void
        {
            if (this.reqList[1] && this.reqList[1].length > 0)
            {
                this._stringsFormatLoader.load(new URLRequest(this.reqList[1]));
            }
            else
            {
                this.removeEventStringsFormatLoader(false);
                dispatchEvent(new Event(Event.COMPLETE));
            }
            return;
        }// end function

        private function stringFormatLoadCompleteHandler(event:Event) : void
        {
            this.stringsFormat_xml = XML(this._stringsFormatLoader.data);
            dispatchEvent(new Event(Event.COMPLETE));
            this.removeEvent();
            return;
        }// end function

        public function get stringsXml() : XML
        {
            return this.strings_xml;
        }// end function

        public function get stringsFormatXml() : XML
        {
            return this.stringsFormat_xml;
        }// end function

        public function get fileId() : String
        {
            return this.file_id;
        }// end function

        public function get checkLoaded() : Boolean
        {
            var _loc_1:* = undefined;
            if (this.reqList)
            {
                _loc_1 = false;
                if (this.reqList[0] && !this.reqList[1] && this.strings_xml)
                {
                    _loc_1 = true;
                }
                if (!this.reqList[0] && this.reqList[1] && this.stringsFormat_xml)
                {
                    _loc_1 = true;
                }
                if (this.reqList[0] && this.reqList[1] && this.stringsFormat_xml && this.strings_xml)
                {
                    _loc_1 = true;
                }
                return _loc_1;
            }
            else
            {
                return false;
            }
        }// end function

        public function removeEvent() : void
        {
            this.removeEventStringsLoader();
            this.removeEventStringsFormatLoader();
            return;
        }// end function

        private function removeEventStringsLoader(param1:Boolean = false) : void
        {
            if (this._stringsLoader)
            {
                this._stringsLoader.removeEventListener(Event.COMPLETE, this.stringLoadCompleteHandler);
                this._stringsLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
                this._stringsLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadErrorHandler);
                if (param1)
                {
                    this._stringsLoader.close();
                }
                this._stringsLoader = null;
            }
            return;
        }// end function

        private function removeEventStringsFormatLoader(param1:Boolean = false) : void
        {
            if (this._stringsFormatLoader)
            {
                this._stringsFormatLoader.removeEventListener(Event.COMPLETE, this.stringFormatLoadCompleteHandler);
                this._stringsFormatLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.loadErrorHandler);
                this._stringsFormatLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadErrorHandler);
                if (param1)
                {
                    this._stringsFormatLoader.close();
                }
                this._stringsFormatLoader = null;
            }
            return;
        }// end function

        public function close() : void
        {
            this.removeEvent();
            this._stringsLoader = null;
            this._stringsFormatLoader = null;
            return;
        }// end function

    }
}

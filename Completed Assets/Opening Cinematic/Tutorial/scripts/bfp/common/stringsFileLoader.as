package bfp.common
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
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
         super();
         this._stringsLoader = new URLLoader();
         this._stringsFormatLoader = new URLLoader();
         this._stringsLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this._stringsLoader.addEventListener(Event.COMPLETE,this.stringLoadCompleteHandler);
         this._stringsLoader.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         this._stringsLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
         this._stringsFormatLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this._stringsFormatLoader.addEventListener(Event.COMPLETE,this.stringFormatLoadCompleteHandler);
         this._stringsFormatLoader.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         this._stringsFormatLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
      }
      
      public function load(param1:*, param2:String = "") : void
      {
         this.file_id = param2;
         this.reqList = param1;
         if(Boolean(this.reqList[0]) && this.reqList[0].length > 0)
         {
            this._stringsLoader.load(new URLRequest(this.reqList[0]));
         }
         else
         {
            this.removeEventStringsLoader(false);
            this.loadFormat();
         }
      }
      
      private function loadErrorHandler(param1:ErrorEvent) : void
      {
         this.removeEvent();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function stringLoadCompleteHandler(param1:Event) : void
      {
         this.strings_xml = XML(this._stringsLoader.data);
         this.loadFormat();
      }
      
      private function loadFormat() : void
      {
         if(Boolean(this.reqList[1]) && this.reqList[1].length > 0)
         {
            this._stringsFormatLoader.load(new URLRequest(this.reqList[1]));
         }
         else
         {
            this.removeEventStringsFormatLoader(false);
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function stringFormatLoadCompleteHandler(param1:Event) : void
      {
         this.stringsFormat_xml = XML(this._stringsFormatLoader.data);
         dispatchEvent(new Event(Event.COMPLETE));
         this.removeEvent();
      }
      
      public function get stringsXml() : XML
      {
         return this.strings_xml;
      }
      
      public function get stringsFormatXml() : XML
      {
         return this.stringsFormat_xml;
      }
      
      public function get fileId() : String
      {
         return this.file_id;
      }
      
      public function get checkLoaded() : Boolean
      {
         var _loc1_:* = undefined;
         if(this.reqList)
         {
            _loc1_ = false;
            if(this.reqList[0] && !this.reqList[1] && Boolean(this.strings_xml))
            {
               _loc1_ = true;
            }
            if(!this.reqList[0] && this.reqList[1] && Boolean(this.stringsFormat_xml))
            {
               _loc1_ = true;
            }
            if(this.reqList[0] && this.reqList[1] && this.stringsFormat_xml && Boolean(this.strings_xml))
            {
               _loc1_ = true;
            }
            return _loc1_;
         }
         return false;
      }
      
      public function removeEvent() : void
      {
         this.removeEventStringsLoader();
         this.removeEventStringsFormatLoader();
      }
      
      private function removeEventStringsLoader(param1:Boolean = false) : void
      {
         if(this._stringsLoader)
         {
            this._stringsLoader.removeEventListener(Event.COMPLETE,this.stringLoadCompleteHandler);
            this._stringsLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
            this._stringsLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
            if(param1)
            {
               this._stringsLoader.close();
            }
            this._stringsLoader = null;
         }
      }
      
      private function removeEventStringsFormatLoader(param1:Boolean = false) : void
      {
         if(this._stringsFormatLoader)
         {
            this._stringsFormatLoader.removeEventListener(Event.COMPLETE,this.stringFormatLoadCompleteHandler);
            this._stringsFormatLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
            this._stringsFormatLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
            if(param1)
            {
               this._stringsFormatLoader.close();
            }
            this._stringsFormatLoader = null;
         }
      }
      
      public function close() : void
      {
         this.removeEvent();
         this._stringsLoader = null;
         this._stringsFormatLoader = null;
      }
   }
}

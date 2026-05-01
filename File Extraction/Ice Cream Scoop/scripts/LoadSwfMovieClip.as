package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.errors.EOFError;
   import flash.events.*;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class LoadSwfMovieClip extends MovieClip
   {
      
      private var m_loadEndCallBack:Function = null;
      
      public var m_lpLoader:Loader = null;
      
      private var m_filename:String = "";
      
      public var m_lpImage:SwfImage = null;
      
      public var m_lpMovieClip:MovieClip = null;
      
      public function LoadSwfMovieClip()
      {
         super();
         this.m_lpLoader = new Loader();
      }
      
      public function LoadBytes(param1:ByteArray) : void
      {
         var version:uint;
         var inputBytes:ByteArray = param1;
         with(this.m_lpLoader.contentLoaderInfo)
         {
            addEventListener(Event.COMPLETE,_loaderInfoInitFunc);
            m_lpLoader.addEventListener(IOErrorEvent.IO_ERROR,_ioErrorHandler);
         }
         inputBytes.endian = Endian.LITTLE_ENDIAN;
         if(this.isCompressed(inputBytes))
         {
            this.uncompress(inputBytes);
         }
         version = uint(inputBytes[3]);
         if(version <= 10)
         {
            if(version == 8 || version == 9 || version == 10)
            {
               this.flagSWF9Bit(inputBytes);
            }
            else if(version <= 7)
            {
               this.insertFileAttributesTag(inputBytes);
            }
            this.updateVersion(inputBytes,9);
         }
         this.m_lpLoader.loadBytes(inputBytes);
      }
      
      protected function _ioErrorHandler(param1:IOErrorEvent) : void
      {
         removeEventListener(Event.COMPLETE,this._loaderInfoInitFunc);
         this.m_lpLoader.removeEventListener(IOErrorEvent.IO_ERROR,this._ioErrorHandler);
         this._onErrorLoader(param1);
      }
      
      private function flagSWF9Bit(param1:ByteArray) : void
      {
         var _loc2_:uint = this.findFileAttributesPosition(this.getBodyPosition(param1),param1);
         if(!isNaN(_loc2_))
         {
            param1[_loc2_ + 2] |= 8;
         }
      }
      
      private function isCompressed(param1:ByteArray) : Boolean
      {
         if(param1[0] == 67)
         {
            return true;
         }
         return false;
      }
      
      private function updateVersion(param1:ByteArray, param2:uint) : void
      {
         param1[3] = param2;
      }
      
      private function findFileAttributesPosition(param1:uint, param2:ByteArray) : uint
      {
         var byte:uint = 0;
         var tag:uint = 0;
         var length:uint = 0;
         var offset:uint = param1;
         var bytes:ByteArray = param2;
         bytes.position = offset;
         try
         {
            while(true)
            {
               byte = uint(bytes.readShort());
               tag = uint(byte >>> 6);
               if(tag == 69)
               {
                  break;
               }
               length = uint(byte & 0x3F);
               if(length == 63)
               {
                  length = uint(bytes.readInt());
               }
               bytes.position += length;
            }
            return bytes.position - 2;
         }
         catch(e:EOFError)
         {
         }
         return NaN;
      }
      
      protected function _loaderInfoInitFunc(param1:Event) : void
      {
         removeEventListener(Event.COMPLETE,this._loaderInfoInitFunc);
         this.m_lpLoader.removeEventListener(IOErrorEvent.IO_ERROR,this._ioErrorHandler);
         this.m_lpMovieClip = this.m_lpLoader.content as MovieClip;
         addChild(this.m_lpMovieClip);
         this._onEndLoader(param1);
         if(this.m_loadEndCallBack != null)
         {
            this.m_loadEndCallBack(this);
            this.m_loadEndCallBack = null;
         }
      }
      
      public function LoadSwf(param1:String) : void
      {
         if(param1.indexOf(":") == -1)
         {
         }
         this.m_lpImage = SwfImageMgr.GetInstance().createImage(param1);
         this.m_filename = param1;
         this.m_lpImage.setCompleteFunction(this._imageInitFunc);
      }
      
      protected function _onErrorLoader(param1:IOErrorEvent) : void
      {
         comDefine.ErrorDialog("読み込みに失敗しました / " + this.m_filename);
      }
      
      private function getBodyPosition(param1:ByteArray) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ += 3;
         _loc2_ += 1;
         _loc2_ += 4;
         var _loc3_:uint = uint(param1[_loc2_] >>> 3);
         _loc2_ += (5 + _loc3_ * 4) / 8;
         _loc2_ += 2;
         _loc2_ += 1;
         return uint(_loc2_ + 2);
      }
      
      public function free() : void
      {
         this.m_lpLoader = null;
         this.m_lpMovieClip = null;
         this.m_lpImage = null;
      }
      
      public function setLoadCallBack(param1:Function) : void
      {
         if(this.m_lpMovieClip != null)
         {
            param1(this);
         }
         else
         {
            this.m_loadEndCallBack = param1;
         }
      }
      
      private function insertFileAttributesTag(param1:ByteArray) : void
      {
         var _loc2_:uint = this.getBodyPosition(param1);
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeBytes(param1,_loc2_);
         param1.length = _loc2_;
         param1.position = _loc2_;
         param1.writeByte(68);
         param1.writeByte(17);
         param1.writeByte(8);
         param1.writeByte(0);
         param1.writeByte(0);
         param1.writeByte(0);
         param1.writeBytes(_loc3_);
         _loc3_.length = 0;
      }
      
      private function _imageInitFunc() : void
      {
         this.LoadBytes(this.m_lpImage.m_bytes);
         this.m_filename = "";
      }
      
      protected function _onEndLoader(param1:Event) : void
      {
      }
      
      private function uncompress(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,8);
         param1.length = 8;
         param1.position = 8;
         _loc2_.uncompress();
         param1.writeBytes(_loc2_);
         param1[0] = 70;
         _loc2_.length = 0;
      }
   }
}


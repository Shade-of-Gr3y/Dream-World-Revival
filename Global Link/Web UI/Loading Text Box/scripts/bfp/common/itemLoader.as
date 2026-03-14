package bfp.common
{
   import adobe.utils.*;
   import bfp.chest.*;
   import bfp.pdw.common.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.ui.*;
   
   public class itemLoader extends Loader
   {
      
      private static var nuts_path:* = NUTS_BASEPATH;
      
      private static var item_path:* = ITEM_BASEPATH;
      
      public static const NUTS_BASEPATH:* = "../../theme/assets/global/parts/nuts/";
      
      public static const ITEM_BASEPATH:* = "../../theme/assets/global/parts/item/";
      
      private var position_width:*;
      
      private var basesize:*;
      
      private var basepath:*;
      
      private var position_height:*;
      
      public function itemLoader(param1:Number = 28, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.basepath = "../../theme/assets/global/parts/";
         this.position_width = param2;
         this.position_height = param3;
         this.basesize = param1;
      }
      
      public static function itemBasePath(param1:*, param2:MovieClip = null) : void
      {
         if(param2)
         {
            param1 = param2.root.loaderInfo.url.substr(0,param2.root.loaderInfo.url.lastIndexOf("/"));
         }
         nuts_path = param1 + "/" + NUTS_BASEPATH;
         item_path = param1 + "/" + ITEM_BASEPATH;
      }
      
      private function loaderEnterFrameHandler(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = contentLoaderInfo;
         if(_loc2_.bytesLoaded >= _loc2_.bytesTotal && _loc2_.content && Boolean(_loc2_.content.myLoader) && Boolean(_loc2_.content.myLoader.content))
         {
            removeEventListener(Event.ENTER_FRAME,this.loaderEnterFrameHandler);
            _loc3_ = MovieClip(this.content);
            _loc3_.addChild(_loc3_.myLoader.content);
            if(this.position_width != 0)
            {
               _loc3_.myLoader.content.x = Math.floor((this.position_width - _loc3_.myLoader.content.width) / 2);
            }
            if(this.position_height != 0)
            {
               _loc3_.myLoader.content.y = Math.floor((this.position_height - _loc3_.myLoader.content.height) / 2);
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function unloadSwf() : void
      {
         var _loc1_:* = undefined;
         removeEventListener(Event.ENTER_FRAME,this.loaderEnterFrameHandler);
         contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.IOErrorHandler);
         if(this.content)
         {
            _loc1_ = MovieClip(this.content);
            if(_loc1_.myLoader)
            {
               if(Boolean(_loc1_.myLoader.content) && _loc1_.numChildren > 0)
               {
                  _loc1_.removeChild(_loc1_.myLoader.content);
               }
               _loc1_.myLoader.unload();
               _loc1_.myLoader = null;
            }
            unload();
         }
      }
      
      private function IOErrorHandler(param1:IOErrorEvent) : void
      {
         dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
      }
      
      public function loadSwf(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(149 <= param1 && param1 <= 213)
         {
            _loc2_ = crypt.encrypt_kinomi(param1 - 148) + ".swf";
            _loc3_ = nuts_path + this.basesize + "/" + _loc2_;
         }
         else
         {
            _loc2_ = crypt.encrypt_kinomi(param1) + ".swf";
            _loc3_ = item_path + this.basesize + "/" + _loc2_;
         }
         var _loc4_:* = new URLRequest(_loc3_);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.IOErrorHandler);
         load(_loc4_);
         addEventListener(Event.ENTER_FRAME,this.loaderEnterFrameHandler);
      }
   }
}


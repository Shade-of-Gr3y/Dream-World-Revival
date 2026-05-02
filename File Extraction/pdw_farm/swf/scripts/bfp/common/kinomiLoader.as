package bfp.common
{
   import adobe.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.ui.*;
   
   public class kinomiLoader extends Loader
   {
      
      private var basepath:*;
      
      private var position_width:*;
      
      private var position_height:*;
      
      public function kinomiLoader(param1:String = "", param2:Number = 0, param3:Number = 0)
      {
         super();
         this.basepath = param1;
         this.position_width = param2;
         this.position_height = param3;
      }
      
      public function loadSwf(param1:*) : *
      {
         var _loc2_:* = crypt.encrypt_kinomi(param1) + ".swf";
         var _loc3_:* = new URLRequest(this.basepath + _loc2_);
         load(_loc3_);
         addEventListener(Event.ENTER_FRAME,this.loaderEnterFrameHandler);
      }
      
      private function loaderEnterFrameHandler(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = contentLoaderInfo;
         if(Boolean(_loc2_.bytesLoaded >= _loc2_.bytesTotal) && Boolean(_loc2_.content) && Boolean(_loc2_.content.myLoader) && Boolean(_loc2_.content.myLoader.content))
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
   }
}


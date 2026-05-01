package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class PokeLoad extends MovieClip
   {
      
      private var m_loader:Loader;
      
      private var m_bLoad:Boolean;
      
      public function PokeLoad(param1:String)
      {
         super();
         var _loc2_:URLRequest = new URLRequest(param1);
         this.m_loader = new Loader();
         this.m_loader.load(_loc2_);
         addChild(this.m_loader);
         addEventListener(Event.ENTER_FRAME,this._enterListner);
         this.m_bLoad = false;
      }
      
      public function isLoad() : Boolean
      {
         return this.m_bLoad;
      }
      
      public function getMovieClip() : MovieClip
      {
         return Object(this.m_loader).content.myLoader.content;
      }
      
      private function _enterListner(param1:Event) : *
      {
         var _loc2_:* = this.m_loader.contentLoaderInfo;
         if(_loc2_.bytesLoaded >= _loc2_.bytesTotal && _loc2_.content && Boolean(_loc2_.content.myLoader) && Boolean(_loc2_.content.myLoader.content))
         {
            removeEventListener(Event.ENTER_FRAME,this._enterListner);
            Object(this.m_loader).content.addChild(Object(this.m_loader).content.myLoader.content);
            this.m_bLoad = true;
         }
      }
   }
}


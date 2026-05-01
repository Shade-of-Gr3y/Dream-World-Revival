package
{
   import flash.events.Event;
   import flash.net.*;
   import flash.utils.ByteArray;
   
   public class SwfImage
   {
      
      public var m_filename:String;
      
      private var m_funcArray:Array = new Array();
      
      private var m_loader:URLLoader;
      
      public var m_bLoad:Boolean = false;
      
      public var m_bytes:ByteArray;
      
      public function SwfImage(param1:String)
      {
         super();
         this.m_loader = new URLLoader();
         this.m_loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.m_loader.addEventListener(Event.COMPLETE,this.onCompleteLoad);
         this.m_loader.load(new URLRequest(param1));
         this.m_bLoad = false;
         this.m_filename = param1;
      }
      
      public function setCompleteFunction(param1:Function) : *
      {
         if(this.m_bLoad == false)
         {
            this.m_funcArray.push(param1);
         }
         else
         {
            param1();
         }
      }
      
      private function onCompleteLoad(param1:Event) : void
      {
         var _loc2_:int = 0;
         this.m_bytes = URLLoader(param1.target).data;
         this.m_bLoad = true;
         _loc2_ = 0;
         while(_loc2_ < this.m_funcArray.length)
         {
            this.m_funcArray[_loc2_]();
            _loc2_++;
         }
         this.m_funcArray.splice(0);
         this.m_loader.removeEventListener(Event.COMPLETE,this.onCompleteLoad);
      }
   }
}


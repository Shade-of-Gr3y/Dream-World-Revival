package bfp.common
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class ImageParser extends EventDispatcher
   {
      
      public static const ROLLOVER:String = "ROLLOVER";
      
      public static const ROLLOUT:String = "ROLLOUT";
      
      public static const CLICK:String = "CLICK";
      
      private var _container:MovieClip;
      
      private var _flag:Boolean;
      
      private var _connector:ConnectorSource;
      
      private var _obj:Object;
      
      public function ImageParser(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
      }
      
      public function btOpen(param1:Object = null) : void
      {
         this._obj = param1;
         this._container.buttonMode = true;
         this._container.addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         this._container.addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         this._container.addEventListener(MouseEvent.CLICK,this.mouseHandler);
      }
      
      private function mouseHandler(param1:MouseEvent = null) : void
      {
         switch(param1.type)
         {
            case MouseEvent.ROLL_OUT:
               PokemonBridge.mouseOverSound();
               dispatchEvent(new CustomEvent(ROLLOUT,null));
               break;
            case MouseEvent.ROLL_OVER:
               dispatchEvent(new CustomEvent(ROLLOVER,this._obj));
               break;
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               dispatchEvent(new CustomEvent(CLICK,null));
         }
      }
      
      public function open(param1:String = "", param2:Boolean = true) : void
      {
         this._flag = param2;
         this._container.mouseEnabled = false;
         this._container.visible = true;
         this._connector = new ConnectorSource();
         this._connector.addEventListener(ConnectorSource.SRC_ERROR,this.dbHandler);
         this._connector.addEventListener(ConnectorSource.SRC_PROGRESS,this.dbHandler);
         this._connector.addEventListener(ConnectorSource.SRC_SUCCESS,this.dbHandler);
         if(PokemonBridge.DEBUG)
         {
            param1 = "../../" + param1;
         }
         this._connector.connect(param1);
      }
      
      private function dbHandler(param1:Event = null) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:ConnectorSource = ConnectorSource(param1.currentTarget);
         switch(param1.type)
         {
            case ConnectorSource.SRC_ERROR:
            case ConnectorSource.SRC_PROGRESS:
               break;
            case ConnectorSource.SRC_SUCCESS:
               _loc2_.removeEventListener(ConnectorSource.SRC_ERROR,this.dbHandler);
               _loc2_.removeEventListener(ConnectorSource.SRC_PROGRESS,this.dbHandler);
               _loc2_.removeEventListener(ConnectorSource.SRC_SUCCESS,this.dbHandler);
               this._container.addChild(_loc2_.loader);
               _loc2_.loader.mouseEnabled = false;
               if(this._flag)
               {
                  _loc3_ = MovieClip(_loc2_.loader.content);
                  _loc3_.gotoAndStop(2);
                  _loc3_.scaleX = _loc3_.scaleY = 0.32;
               }
         }
      }
      
      public function clear() : void
      {
         this.close();
         this._flag = undefined;
         this._obj = null;
         this._container = null;
         this._connector = null;
      }
      
      public function set scale(param1:Number) : void
      {
         this._container.scaleX = this._container.scaleY = param1;
      }
      
      private function init() : void
      {
      }
      
      public function close() : void
      {
         if(this._connector)
         {
            if(Boolean(this._connector.loader) && !this._connector.hasEventListener(ConnectorSource.SRC_SUCCESS))
            {
               this._container.removeChild(this._connector.loader);
            }
            this._container.buttonMode = false;
            this._container.removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
            this._container.removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
            this._container.removeEventListener(MouseEvent.CLICK,this.mouseHandler);
            this._container.visible = false;
            this._connector.removeEventListener(ConnectorSource.SRC_ERROR,this.dbHandler);
            this._connector.removeEventListener(ConnectorSource.SRC_PROGRESS,this.dbHandler);
            this._connector.removeEventListener(ConnectorSource.SRC_SUCCESS,this.dbHandler);
            this._connector.disconnect();
            this._connector = null;
         }
      }
   }
}


package bfp.pgl.campaign
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
   import bfp.common.CustomEvent;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pgl.common.CampaignBridge;
   import com.adobe.crypto.MD5;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.LoaderContext;
   
   public class CampaignGame extends EventDispatcher
   {
      
      private var _container:MovieClip;
      
      private var _json:Object;
      
      private var _loader:Loader;
      
      private var _connector:ConnectorDataBase;
      
      private var _finish:Object;
      
      private var _flag:Boolean;
      
      private const ALERT:String = "キャンペーンのゲームがみつかりません。";
      
      public function CampaignGame(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
      }
      
      private function helpHandler(param1:CustomEvent) : void
      {
         var _loc2_:String = String(param1.data);
         PokemonBridge.callHelp(_loc2_);
      }
      
      private function judgeHandler(param1:Event = null) : void
      {
         switch(param1.type)
         {
            case ConnectorDataBase.DB_PROGRESS:
               break;
            case ConnectorDataBase.DB_ERROR:
               ExternalInterface.call("setCampaign",false);
               PokemonBridge.alertWindow(this._connector.error,PokemonBridge.WITH_FADEOUT);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.disconnect();
               this._connector = null;
               PokemonBridge.ClearConnect();
               CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
               break;
            case ConnectorDataBase.DB_SUCCESS:
               PokemonBridge.ClearConnect();
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.disconnect();
               this._connector = null;
               this.finish();
         }
      }
      
      private function loginHandler(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         switch(param1.type)
         {
            case ConnectorDataBase.DB_ERROR:
            case ConnectorDataBase.DB_PROGRESS:
               break;
            case ConnectorDataBase.DB_SUCCESS:
               _loc2_ = this._connector.json;
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.loginHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.loginHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.loginHandler);
               this._connector.disconnect();
               this._connector = null;
               Logger.log("// --------------------------------------------------------------------------------");
               Logger.log("// ユーザ情報の再解析　--------");
               for(_loc3_ in _loc2_.member)
               {
                  Logger.log("// " + _loc3_ + " : " + PokemonBridge[_loc3_]);
                  PokemonBridge[_loc3_] = _loc2_.member[_loc3_];
               }
               Logger.log("// --------------------------------------------------------------------------------");
               PokemonBridge.ClearConnect();
               this.start();
         }
      }
      
      private function start() : void
      {
         var _loc1_:String = "";
         _loc1_ = PokemonBridge.PATH + "../../../campaign/assets/game/" + this._json.campaign_id + "_" + this._json.object.object_id + PokemonBridge.lang + ".swf";
         PokemonBridge.percent = 0;
         PokemonBridge.DataConnect();
         if(this._loader)
         {
            if(this._container.numChildren == 1)
            {
               this._container.removeChild(this._loader);
            }
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loaderHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loaderHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
            this._loader.unloadAndStop();
            this._loader = null;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         var _loc3_:LoaderContext = new LoaderContext();
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loaderHandler);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loaderHandler);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderHandler);
         this._loader.load(_loc2_,_loc3_);
      }
      
      public function open(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:URLVariables = null;
         this.init();
         ExternalInterface.call("setCampaign",true);
         this._json = param1;
         Logger.log("// ---------------------------------------------");
         Logger.log("// DETAIL GAME");
         Logger.log("// ---------------------------------------------");
         for(_loc2_ in this._json)
         {
            Logger.log(_loc2_ + " / " + this._json[_loc2_]);
            if(_loc2_ == "object")
            {
               for(_loc3_ in this._json[_loc2_])
               {
                  Logger.log("// " + _loc3_ + " / " + this._json[_loc2_][_loc3_]);
               }
            }
         }
         if(Number(this._json.refresh_flag) == 1)
         {
            if(this._connector)
            {
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.loginHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.loginHandler);
               this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.loginHandler);
               this._connector.disconnect();
               this._connector = null;
            }
            Logger.log("// ユーザ情報の再読込");
            PokemonBridge.ApiConnect();
            _loc4_ = new URLVariables();
            _loc4_.ping = 1;
            this._connector = new ConnectorDataBase();
            this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.loginHandler);
            this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.loginHandler);
            this._connector.addEventListener(ConnectorDataBase.DB_PROGRESS,this.loginHandler);
            this._connector.connect(ConnectorPATH.DB_LOGIN_INIT,_loc4_,false,"POST");
         }
         else
         {
            this.start();
         }
      }
      
      private function finish() : void
      {
         if(this._flag)
         {
            ExternalInterface.call("setCampaign",false);
            PokemonBridge.fadeIn();
            CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
         }
         else
         {
            this._flag = true;
         }
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._flag = false;
      }
      
      private function loaderHandler(param1:Event) : void
      {
         var _loc2_:ProgressEvent = null;
         var _loc3_:Number = NaN;
         switch(param1.type)
         {
            case ProgressEvent.PROGRESS:
               _loc2_ = ProgressEvent(param1);
               _loc3_ = _loc2_.bytesLoaded / _loc2_.bytesTotal;
               PokemonBridge.percent = _loc3_;
               break;
            case IOErrorEvent.IO_ERROR:
               ExternalInterface.call("setCampaign",false);
               PokemonBridge.ClearConnect();
               this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loaderHandler);
               this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loaderHandler);
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
               this._loader = null;
               PokemonBridge.alertWindow(FontManager.getIdText("c_bl_1"),PokemonBridge.WITH_FADEOUT);
               CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
               break;
            case Event.COMPLETE:
               PokemonBridge.fadeOut();
               PokemonBridge.ClearConnect();
               this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loaderHandler);
               this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loaderHandler);
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
               this._container.addChild(this._loader);
               CampaignBridge.addEventListener(CampaignBridge.CALL_HELP,this.helpHandler);
               PokemonBridge.addEventListener(PokemonBridge.MINI_GAME_PAUSE,this.communicateHandler);
               PokemonBridge.addEventListener(PokemonBridge.MINI_GAME_PLAY,this.communicateHandler);
               CampaignBridge.addEventListener(CampaignBridge.CAMPAIGN_FINISH,this.communicateHandler);
               CampaignBridge.addEventListener(CampaignBridge.CAMPAIGN_GET,this.communicateHandler);
               CampaignBridge.dispatchEvent(new Event(CampaignBridge.CAMPAIGN_PLAY));
         }
      }
      
      private function communicateHandler(param1:Event) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:String = null;
         switch(param1.type)
         {
            case CampaignBridge.CAMPAIGN_FINISH:
               this.finish();
               break;
            case CampaignBridge.CAMPAIGN_GET:
               _loc2_ = new URLVariables();
               _loc2_.campaign_id = this._json.campaign_id;
               if(this._json.serial_key)
               {
                  _loc2_.serial_key = this._json.serial_key;
               }
               _loc3_ = "1" + this._json.otoken + this._json.campaign_id;
               _loc3_ = MD5.hash(_loc3_);
               _loc2_.result = _loc3_;
               PokemonBridge.ApiConnect();
               this._connector = new ConnectorDataBase();
               this._connector.addEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
               this._connector.addEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
               this._connector.addEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
               this._connector.connect(ConnectorPATH.DB_CAMPAIGN_CLEAR,_loc2_,false,"POST");
               break;
            case PokemonBridge.MINI_GAME_PLAY:
               CampaignBridge.dispatchEvent(new Event(CampaignBridge.CAMPAIGN_PLAY));
               break;
            case PokemonBridge.MINI_GAME_PAUSE:
               CampaignBridge.dispatchEvent(new Event(CampaignBridge.CAMPAIGN_STOP));
         }
      }
      
      public function close() : void
      {
         if(this._connector)
         {
            this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.judgeHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.judgeHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.judgeHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_ERROR,this.loginHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,this.loginHandler);
            this._connector.removeEventListener(ConnectorDataBase.DB_PROGRESS,this.loginHandler);
            this._connector.disconnect();
            this._connector = null;
         }
         if(this._loader)
         {
            if(this._container.numChildren == 1)
            {
               this._container.removeChild(this._loader);
            }
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loaderHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loaderHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loaderHandler);
            this._loader.unloadAndStop();
            this._loader = null;
         }
         CampaignBridge.removeEventListener(CampaignBridge.CAMPAIGN_FINISH,this.communicateHandler);
         CampaignBridge.removeEventListener(CampaignBridge.CAMPAIGN_GET,this.communicateHandler);
         this._container.visible = false;
      }
   }
}


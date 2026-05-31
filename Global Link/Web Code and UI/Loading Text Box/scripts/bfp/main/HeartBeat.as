package bfp.main
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   
   public class HeartBeat
   {
      
      private static var _urlloader:URLLoader;
      
      private static var _date:Date;
      
      private static var _cnt:Number;
      
      private static var _timer:Timer;
      
      private static var _connector:ConnectorDataBase;
      
      public function HeartBeat()
      {
         super();
      }
      
      private static function connectHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case ProgressEvent.PROGRESS:
               break;
            case ConnectorDataBase.DB_ERROR:
               _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectHandler);
               _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectHandler);
               _connector.disconnect();
               _connector = null;
               PokemonBridge.alertWindow(FontManager.getIdText("pg_amf_1"),PokemonBridge.WITH_RELOAD);
               break;
            case ConnectorDataBase.DB_SUCCESS:
               _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectHandler);
               _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectHandler);
               _connector.disconnect();
               _connector = null;
               _date = new Date();
               _timer.reset();
               _timer.start();
         }
      }
      
      public static function init() : void
      {
         _date = new Date();
         _timer = new Timer(60000,0);
         _timer.addEventListener(TimerEvent.TIMER,timerHandler);
         _timer.start();
         PokemonBridge.addEventListener(PokemonBridge.CAMPAIGN_FLAG,beatConnection);
      }
      
      private static function beatConnection(param1:Event = null) : void
      {
         _timer.stop();
         var _loc2_:Date = new Date();
         Logger.log("// HEART BEAT ------------------------ ");
         Logger.log("// TIME : " + String(_loc2_.getHours()) + ":" + String(_loc2_.getMinutes()) + ":" + String(_loc2_.getSeconds()));
         var _loc3_:String = _loc2_.getHours() + "-" + _loc2_.getMinutes() + "-" + _loc2_.getSeconds();
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.timestamp = _loc3_;
         _connector = new ConnectorDataBase();
         _connector.addEventListener(ConnectorDataBase.DB_SUCCESS,connectHandler);
         _connector.addEventListener(ConnectorDataBase.DB_ERROR,connectHandler);
         _connector.connect(ConnectorPATH.DB_HEARTBEAT,_loc4_,false,"GET");
      }
      
      private static function timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:Date = new Date();
         var _loc3_:Number = (_loc2_.time - _date.time) / 60000;
         if(_loc3_ > 20)
         {
            beatConnection();
         }
      }
   }
}


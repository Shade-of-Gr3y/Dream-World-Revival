package bfp.main.alert
{
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.properties.DisplayShortcuts;
   import caurina.transitions.properties.FilterShortcuts;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   
   public class AlertScene
   {
      
      private var _container:MovieClip;
      
      private var _alertWelcome:AlertWelcome;
      
      private var _alertBoard:AlertBoard;
      
      private var _alertDownload:AlertDownload;
      
      private var _alertPage:String = "";
      
      private var _alertCantsleep:AlertCantSleepless;
      
      private var _alertGamedata:AlertGamedata;
      
      private var _alertOneDay:AlertOneDay;
      
      private var _alertPlaydata:AlertPlaydata;
      
      private var _alertSleepless:AlertSleepless;
      
      private var _alertWakeup:AlertWakeup;
      
      private var _alertBusy:AlertBusy;
      
      public function AlertScene(container:MovieClip)
      {
         super();
         this._container = container;
         this._container.visible = false;
         this._alertOneDay = new AlertOneDay(this._container.alertOneDay);
         this._alertBusy = new AlertBusy(this._container.alertBusy);
         this._alertWelcome = new AlertWelcome(this._container.alertWelcome);
         this._alertDownload = new AlertDownload(this._container.alertDownload);
         this._alertSleepless = new AlertSleepless(this._container.alertSleepless);
         this._alertBoard = new AlertBoard(this._container.alertBoard);
         this._alertPlaydata = new AlertPlaydata(this._container.alertPlaydata);
         this._alertWakeup = new AlertWakeup(this._container.alertWakeup);
         this._alertCantsleep = new AlertCantSleepless(this._container.alertCantsleep);
         this._alertGamedata = new AlertGamedata(this._container.alertGamedata);
         ColorShortcuts.init();
         FilterShortcuts.init();
         DisplayShortcuts.init();
      }
      
      public function clear() : void
      {
         PDWEnterBridge.removeEventListener(PDWEnterBridge.ENTER_ALERT,this.alertHandler);
      }
      
      private function alertHandler(e:Event) : void
      {
         this.init();
         switch(this._alertPage)
         {
            case PDWEnterBridge.HOUR_24_TIMER_ALERT:
               this._alertOneDay.close();
               break;
            case PDWEnterBridge.BUSY_PDW_ALERT:
               this._alertBusy.close();
               break;
            case PDWEnterBridge.ENABLE_ACCESS_TO_PDW:
               this._alertWelcome.close();
               break;
            case PDWEnterBridge.DOWNLOAD_PDW_ALERT:
               this._alertDownload.close();
               break;
            case PDWEnterBridge.SLEEPING_PDW_ALERT:
               this._alertSleepless.close();
               break;
            case PDWEnterBridge.DELAY_BOARD:
               this._alertBoard.close();
               break;
            case PDWEnterBridge.DELAY_PLAYDATA:
               this._alertPlaydata.close();
               break;
            case PDWEnterBridge.ALERT_DONT_WAKEUP:
               this._alertWakeup.close();
               break;
            case PDWEnterBridge.ALERT_DONT_SLEEP:
               this._alertCantsleep.close();
               break;
            case PDWEnterBridge.DELAY_GAMEDATA:
               this._alertGamedata.close();
         }
         switch(PDWEnterBridge.alertPage)
         {
            case PDWEnterBridge.HOUR_24_TIMER_ALERT:
               this._alertOneDay.open();
               break;
            case PDWEnterBridge.BUSY_PDW_ALERT:
               this._alertBusy.open();
               break;
            case PDWEnterBridge.ENABLE_ACCESS_TO_PDW:
               this._alertWelcome.open();
               break;
            case PDWEnterBridge.DOWNLOAD_PDW_ALERT:
               this._alertDownload.open();
               break;
            case PDWEnterBridge.SLEEPING_PDW_ALERT:
               this._alertSleepless.open();
               break;
            case PDWEnterBridge.DELAY_BOARD:
               this._alertBoard.open();
               break;
            case PDWEnterBridge.DELAY_PLAYDATA:
               this._alertPlaydata.open();
               break;
            case PDWEnterBridge.ALERT_DONT_WAKEUP:
               this._alertWakeup.open();
               break;
            case PDWEnterBridge.ALERT_DONT_SLEEP:
               this._alertCantsleep.open();
               break;
            case PDWEnterBridge.DELAY_GAMEDATA:
               this._alertGamedata.open();
               break;
            case PDWEnterBridge.ENTER_ALERT_CLOSE:
               this.close();
               break;
            case PDWEnterBridge.REMOVED_SITE_PDW:
               this.complete();
         }
         this._alertPage = PDWEnterBridge.alertPage;
      }
      
      private function init() : void
      {
         this._container.visible = true;
         this._container.alpha = 1;
      }
      
      public function open() : void
      {
         PDWEnterBridge.addEventListener(PDWEnterBridge.ENTER_ALERT,this.alertHandler);
         PDWEnterCheck.check();
      }
      
      private function complete() : void
      {
         ExternalInterface.call("setpdw",false);
         PokemonBridge.href("../");
      }
      
      public function close() : void
      {
         Tweener.addTween(this._container,{
            "alpha":0,
            "time":0.3,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "visible":false,
            "time":0,
            "delay":0.3,
            "transition":"linear"
         });
      }
   }
}


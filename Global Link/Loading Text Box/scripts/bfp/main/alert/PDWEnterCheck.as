package bfp.main.alert
{
   import bfp.common.ConnectorDataBase;
   import bfp.common.ConnectorPATH;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.Logger2;
   import bfp.common.PokemonBridge;
   import com.adobe.serialization.json.JSON;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class PDWEnterCheck
   {
      
      private static var _connector:ConnectorDataBase;
      
      private static var _ticketTimer:Timer;
      
      private static var _lifeTimer:Timer;
      
      private static var _jsonLoader:URLLoader;
      
      private static var _lastlogindate:Date = null;
      
      private static var _dreamlandFlag:Boolean = false;
      
      private static var _ticketFlag:Boolean = false;
      
      private static var _returnFlag:Boolean = false;
      
      private static var _oneMinTimer:Timer = new Timer(60000,5);
      
      private static var _life:int = 0;
      
      private static var _lifeFlag:Boolean = false;
      
      public function PDWEnterCheck()
      {
         super();
      }
      
      private static function oneMinTimerHandler(param1:TimerEvent) : void
      {
         Logger.log("1分たった!!");
         if(_oneMinTimer.currentCount < 5)
         {
            if(PokemonBridge.now == PokemonBridge.SITE_PDW)
            {
               if(!PokemonBridge.pdwAlertFlag)
               {
                  PokemonBridge.dispatchEvent(new Event(PokemonBridge.MINI_GAME_PAUSE));
               }
               PDWEnterBridge.dispatchEvent(new Event(PDWEnterBridge.PDW_PRESSURE_ALERT_SLEEP));
            }
         }
      }
      
      public static function get lastlogindate() : Date
      {
         return _lastlogindate;
      }
      
      private static function connectLoginSuccessHandler(param1:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
         checkAPI();
      }
      
      private static function oneMinTimerCompleteHandler(param1:TimerEvent) : void
      {
         Logger.log("1時間5分たった!!");
         _oneMinTimer.stop();
         _oneMinTimer.removeEventListener(TimerEvent.TIMER,oneMinTimerHandler);
         _oneMinTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,oneMinTimerCompleteHandler);
         if(PokemonBridge.now == PokemonBridge.SITE_PDW)
         {
            if(!PokemonBridge.pdwAlertFlag)
            {
               PokemonBridge.dispatchEvent(new Event(PokemonBridge.MINI_GAME_PAUSE));
            }
            PDWEnterBridge.dispatchEvent(new Event(PDWEnterBridge.PDW_EXIT_ALERT_SLEEP));
         }
      }
      
      public static function check() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Date = null;
         var _loc11_:Number = NaN;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Array = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Date = null;
         var _loc22_:Number = NaN;
         Logger.log("--------------------");
         Logger.log("進入チェック - version 3");
         if(PokemonBridge.is_initializing == 0)
         {
            Logger.log("PDW上に member_savedata が存在していて");
            if(PokemonBridge.rom_id == 0)
            {
               Logger.log("体験版で");
               if(_ticketFlag)
               {
                  Logger.log("前回PDW　に　アクセスした時間から 01時間以内 で");
                  if(_returnFlag)
                  {
                     Logger.log("PDW終了していない　- ログイン引き継ぎAPIへ");
                     _returnFlag = false;
                     PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                     checkLoginApi();
                  }
                  else
                  {
                     Logger.log("PDW終了した　- 混雑状況確認へ");
                     PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                     checkJson();
                  }
               }
               else
               {
                  Logger.log("前回PDW　に　アクセスした時間から 01時間以上 で");
                  if(_lifeFlag)
                  {
                     Logger.log("まだ24時間経過していない　- 進入不可");
                     PDWEnterBridge.enterAlert(PDWEnterBridge.HOUR_24_TIMER_ALERT);
                  }
                  else
                  {
                     Logger.log("24時間経過した　- 混雑状況確認へ");
                     PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                     checkJson();
                  }
               }
            }
            else
            {
               Logger.log("製品版で");
               if(PokemonBridge.pdw_copied_at)
               {
                  Logger.log("一度はゲームシンクし、PDW上にデータが反映されていて");
                  _loc1_ = PokemonBridge.pdw_copied_at.split(" ");
                  _loc2_ = _loc1_[0].split("-");
                  _loc3_ = Number(_loc2_[0]);
                  _loc4_ = Number(_loc2_[1].slice(0,_loc2_[1].length));
                  _loc5_ = Number(_loc2_[2].slice(0,_loc2_[2].length));
                  _loc6_ = _loc1_[1].split(":");
                  _loc7_ = Number(_loc6_[0]);
                  _loc8_ = Number(_loc6_[1].slice(0,_loc6_[1].length));
                  _loc9_ = Number(_loc6_[2].slice(0,_loc6_[2].length));
                  _loc10_ = new Date(_loc3_,_loc4_,_loc5_,_loc7_,_loc8_,_loc9_);
                  _loc11_ = Number(_loc10_.getTime());
                  _loc12_ = PokemonBridge.last_up_time_strict.split(" ");
                  _loc13_ = _loc12_[0].split("-");
                  _loc14_ = Number(_loc13_[0]);
                  _loc15_ = Number(_loc13_[1].slice(0,_loc13_[1].length));
                  _loc16_ = Number(_loc13_[2].slice(0,_loc13_[2].length));
                  _loc17_ = _loc12_[1].split(":");
                  _loc18_ = Number(_loc17_[0]);
                  _loc19_ = Number(_loc17_[1].slice(0,_loc17_[1].length));
                  _loc20_ = Number(_loc17_[2].slice(0,_loc17_[2].length));
                  _loc21_ = new Date(_loc14_,_loc15_,_loc16_,_loc18_,_loc19_,_loc20_);
                  _loc22_ = Number(_loc21_.getTime());
                  Logger.log("PDW_COPIED_AT : " + _loc11_);
                  Logger.log("LAST_UP_TIME_STRICT : " + _loc22_);
                  if(_loc22_ < _loc11_ + 10 * 1000)
                  {
                     Logger.log("遅延がなくて");
                     if(PokemonBridge.sleeping_flag)
                     {
                        Logger.log("寝ていてて");
                        if(_ticketFlag)
                        {
                           Logger.log("前回PDW　に　アクセスした時間から 01時間以内 で");
                           if(_returnFlag)
                           {
                              Logger.log("PDW終了していない　- ログイン引き継ぎAPIへ");
                              _returnFlag = false;
                              PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                              checkLoginApi();
                           }
                           else
                           {
                              Logger.log("PDW終了した　- 混雑状況確認へ");
                              PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                              checkJson();
                           }
                        }
                        else
                        {
                           Logger.log("前回PDW　に　アクセスした時間から 01時間以上 で");
                           if(_lifeFlag)
                           {
                              Logger.log("まだ24時間経過していない　- 進入不可");
                              PDWEnterBridge.enterAlert(PDWEnterBridge.HOUR_24_TIMER_ALERT);
                           }
                           else
                           {
                              Logger.log("24時間経過した　- 混雑状況確認へ");
                              PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
                              checkJson();
                           }
                        }
                     }
                     else
                     {
                        Logger.log("寝ていなくて");
                        if(PokemonBridge.is_downloaded)
                        {
                           Logger.log("寝かせていない　- 進入不可");
                           PDWEnterBridge.enterAlert(PDWEnterBridge.ALERT_DONT_SLEEP);
                        }
                        else
                        {
                           Logger.log("おこしていない　- 進入不可");
                           PDWEnterBridge.enterAlert(PDWEnterBridge.ALERT_DONT_WAKEUP);
                        }
                     }
                  }
                  else
                  {
                     Logger.log("DSデータの遅延がある　- 進入不可");
                     PDWEnterBridge.enterAlert(PDWEnterBridge.DELAY_GAMEDATA);
                  }
               }
               else
               {
                  Logger.log("ゲームシンクして、PDW上にデータが反映されていない");
                  if(PokemonBridge.sleeping_flag)
                  {
                     Logger.log("寝ていてて");
                     Logger.log("DSデータの遅延がある　- 進入不可");
                     PDWEnterBridge.enterAlert(PDWEnterBridge.DELAY_GAMEDATA);
                  }
                  else
                  {
                     Logger.log("寝ていなくて");
                     Logger.log("寝かせていないorおこしていないの両方の可能性あり");
                     Logger.log("※新環境移行にともなって一度はDSでゲームシンクする必要がある");
                     PDWEnterBridge.enterAlert(PDWEnterBridge.ALERT_DONT_SLEEP);
                  }
               }
            }
         }
         else
         {
            Logger.log("PDW上にデータが反映されていない");
            PDWEnterBridge.enterAlert(PDWEnterBridge.DELAY_PLAYDATA);
         }
         Logger.log("--------------------");
      }
      
      private static function setLifeTimer(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!_lifeFlag)
         {
            _life = param1;
            _lifeFlag = true;
            _lifeTimer = new Timer(1000,0);
            _lifeTimer.addEventListener(TimerEvent.TIMER,enterTimerHandler);
            _lifeTimer.reset();
            _lifeTimer.start();
            _loc2_ = _life / 60 / 60;
            _loc3_ = _life / 60 % 60;
            _loc4_ = _life % 60;
            Logger.log("// NEXT ACCESS TIME (HH:MM:SS) --- " + _loc2_ + ":" + _loc3_ + ":" + _loc4_);
         }
      }
      
      private static function enterTimerHandler(param1:TimerEvent) : void
      {
         --_life;
         Logger2.log(_life.toString());
         PDWEnterBridge.lifeCountDown(_life);
         if(_life == 0)
         {
            _lastlogindate = null;
            _lifeTimer.stop();
            _lifeTimer.removeEventListener(TimerEvent.TIMER,enterTimerHandler);
            _lifeTimer = null;
            _lifeFlag = false;
         }
      }
      
      private static function startHandler(param1:Event) : void
      {
         Logger.log("PDW開始");
         setLastLogin(PokemonBridge.last_started_at);
         setHourTimer(3600);
         setLifeTimer(24 * 60 * 60);
         PDWEnterBridge.entrySharedObject(_life);
      }
      
      public static function init() : void
      {
         Logger.log("// *****************************************************************");
         setLastLogin(PokemonBridge.last_started_at);
         if(PokemonBridge.nextstart_remaintime)
         {
            if(PokemonBridge.nextstart_remaintime > 0)
            {
               PDWEnterBridge.lifeCountDown(PokemonBridge.nextstart_remaintime);
               setLifeTimer(PokemonBridge.nextstart_remaintime);
               if(_life > 23 * 60 * 60)
               {
                  setHourTimer(_life - 23 * 60 * 60);
               }
            }
            else
            {
               _returnFlag = true;
               PDWEnterBridge.lifeCountDown(0);
            }
         }
         else
         {
            _returnFlag = true;
            PDWEnterBridge.lifeCountDown(0);
         }
         Logger.log("// *****************************************************************");
         PDWEnterBridge.addEventListener(PDWEnterBridge.GET_TIME_STAMP,startHandler);
         PDWEnterBridge.addEventListener(PDWEnterBridge.PDW_FINISH,finishHandler);
         PDWEnterBridge.addEventListener(PDWEnterBridge.PDW_ENTRY_CHECK,PDWEntryCheckHandler);
         PDWEnterBridge.addEventListener(PDWEnterBridge.RETURN_TO_PGL_2,specialErrorHandler);
      }
      
      private static function connectSuccessHandler(param1:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         var _loc2_:Object = _connector.json;
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
         if(_returnFlag)
         {
            PDWEnterBridge.enterAlert(PDWEnterBridge.ENABLE_ACCESS_TO_PDW);
         }
         else
         {
            PokemonBridge.siteChange(PokemonBridge.SITE_PDW);
         }
      }
      
      public static function specialErrorHandler(param1:Event) : void
      {
         PDWEnterBridge.removeEventListener(PDWEnterBridge.RETURN_TO_PGL_2,specialErrorHandler);
         oneMinTimerCompleteHandler(null);
      }
      
      private static function checkJson() : void
      {
         if(_jsonLoader)
         {
            _jsonLoader.removeEventListener(Event.COMPLETE,jsonLoaderCompleteHandler);
            _jsonLoader = null;
         }
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CONNECTING);
         var _loc1_:Date = new Date();
         var _loc2_:String = "/traffic/";
         var _loc3_:Number = 12345 * Number(PokemonBridge.world_id) - 6789;
         if(PokemonBridge.rom_id == 0)
         {
            _loc2_ += "trial_" + _loc3_ + "/status.json";
         }
         else
         {
            _loc2_ += "product_" + _loc3_ + "/status.json";
         }
         _loc2_ += "?time=" + _loc1_.getTime();
         var _loc4_:URLRequest = new URLRequest();
         _loc4_.url = _loc2_;
         _jsonLoader = new URLLoader();
         _jsonLoader.dataFormat = URLLoaderDataFormat.TEXT;
         _jsonLoader.addEventListener(Event.COMPLETE,jsonLoaderCompleteHandler);
         _jsonLoader.load(_loc4_);
      }
      
      private static function jsonLoaderCompleteHandler(param1:Event) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(_jsonLoader.data.toString());
         if(_loc3_.is_over_capacity == 1)
         {
            _loc2_ = false;
         }
         _jsonLoader.removeEventListener(Event.COMPLETE,jsonLoaderCompleteHandler);
         _jsonLoader = null;
         if(_loc2_)
         {
            checkLoginApi();
         }
         else
         {
            PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
            PDWEnterBridge.enterAlert(PDWEnterBridge.BUSY_PDW_ALERT);
         }
      }
      
      private static function checkLoginApi() : void
      {
         if(_connector)
         {
            _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
            _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
            _connector.disconnect();
            _connector = null;
         }
         _connector = new ConnectorDataBase();
         _connector.addEventListener(ConnectorDataBase.DB_SUCCESS,connectLoginSuccessHandler);
         _connector.addEventListener(ConnectorDataBase.DB_ERROR,connectLoginErrorHandler);
         _connector.connect(ConnectorPATH.DB_CONITUE_LOGIN,null,false,"POST");
      }
      
      public static function PDWEntryCheckHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         PDWEnterBridge.removeEventListener(PDWEnterBridge.PDW_ENTRY_CHECK,PDWEntryCheckHandler);
         if(_life > 23 * 60 * 60)
         {
            _loc2_ = _life / 60 / 60;
            _loc3_ = _life / 60 % 60;
            _loc4_ = "あと[MM]分あそべます。\n混んでいたら遊べないのをご了承ください。\n次回のアクセスは、[HH]時間後から受付いたします。";
            _loc4_ = _loc4_.replace(/\[MM\]/g,_loc3_);
            _loc4_ = _loc4_.replace(/\[HH\]/g,_loc2_);
            PokemonBridge.alertWindow(_loc4_,PokemonBridge.WITH_FADEOUT);
         }
      }
      
      private static function connectLoginErrorHandler(param1:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         PokemonBridge.sleeping_flag = _connector.sleepingflag;
         var _loc2_:Boolean = true;
         PokemonBridge.alertWindow(String(_connector.error),PokemonBridge.WITH_RELOAD);
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
      }
      
      private static function connectErrorHandler(param1:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         PokemonBridge.sleeping_flag = _connector.sleepingflag;
         var _loc2_:Boolean = true;
         if(_connector.timecheck)
         {
            _loc2_ = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.HOUR_24_TIMER_ALERT);
         }
         if(_connector.roomcheck)
         {
            _loc2_ = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.BUSY_PDW_ALERT);
         }
         if(_connector.downloadcheck)
         {
            _loc2_ = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.DOWNLOAD_PDW_ALERT);
         }
         if(_connector.sleepingcheck)
         {
            _loc2_ = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.SLEEPING_PDW_ALERT);
         }
         if(_loc2_)
         {
            PokemonBridge.alertWindow(FontManager.getIdText("pg_ame_1"),PokemonBridge.WITH_FADEOUT);
         }
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
      }
      
      private static function setLastLogin(param1:Number) : void
      {
         _lastlogindate = new Date(1970,0,1,0,0,param1);
         Logger.log("// LAST LOGIN --- " + lastlogindate.toString());
      }
      
      private static function checkAPI() : void
      {
         if(_connector)
         {
            _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
            _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
            _connector.disconnect();
            _connector = null;
         }
         _connector = new ConnectorDataBase();
         _connector.addEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.addEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.connect(ConnectorPATH.DB_CHECK_PDW,null,false,"POST");
      }
      
      private static function ticketTimerHandler(param1:TimerEvent) : void
      {
         Logger.log("１時間たった!!");
         _ticketFlag = false;
         if(_ticketTimer)
         {
            _ticketTimer.stop();
            _ticketTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,ticketTimerHandler);
            _ticketTimer = null;
         }
         _oneMinTimer.addEventListener(TimerEvent.TIMER,oneMinTimerHandler);
         _oneMinTimer.addEventListener(TimerEvent.TIMER_COMPLETE,oneMinTimerCompleteHandler);
         _oneMinTimer.reset();
         _oneMinTimer.start();
         if(PokemonBridge.now == PokemonBridge.SITE_PDW)
         {
            if(!PokemonBridge.pdwAlertFlag)
            {
               PokemonBridge.dispatchEvent(new Event(PokemonBridge.MINI_GAME_PAUSE));
            }
            PDWEnterBridge.dispatchEvent(new Event(PDWEnterBridge.PDW_ONE_HOUR_ALERT_SLEEP));
         }
      }
      
      public static function get life() : Number
      {
         return _life;
      }
      
      private static function finishHandler(param1:Event) : void
      {
         Logger.log("PDW終了");
         PDWEnterBridge.removeSharedObject();
         ExternalInterface.call("setpdw",false);
         PokemonBridge.href("/");
      }
      
      private static function setHourTimer(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_ticketFlag)
         {
            _ticketFlag = true;
            _ticketTimer = new Timer(param1 * 1000,1);
            _ticketTimer.addEventListener(TimerEvent.TIMER_COMPLETE,ticketTimerHandler);
            _ticketTimer.reset();
            _ticketTimer.start();
            _loc2_ = param1 / 60 % 60;
            _loc3_ = param1 % 60;
            Logger.log("// REMINE PDW TIME (HH:MM:SS) --- " + "00:" + _loc2_ + ":" + _loc3_);
            if(PDWEnterBridge.checkSharedObject())
            {
               _returnFlag = true;
            }
            else
            {
               _returnFlag = false;
            }
         }
      }
   }
}


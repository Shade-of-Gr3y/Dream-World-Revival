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
      
      private static function oneMinTimerHandler(e:TimerEvent) : void
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
      
      private static function connectLoginSuccessHandler(e:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
         checkAPI();
      }
      
      private static function oneMinTimerCompleteHandler(e:TimerEvent) : void
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
         var divtime:Array = null;
         var dateArr:Array = null;
         var yearNum:Number = NaN;
         var monthNum:Number = NaN;
         var dateNum:Number = NaN;
         var timeArr:Array = null;
         var hourNum:Number = NaN;
         var minNum:Number = NaN;
         var secNum:Number = NaN;
         var date:Date = null;
         var sec:Number = NaN;
         var divtime2:Array = null;
         var dateArr2:Array = null;
         var yearNum2:Number = NaN;
         var monthNum2:Number = NaN;
         var dateNum2:Number = NaN;
         var timeArr2:Array = null;
         var hourNum2:Number = NaN;
         var minNum2:Number = NaN;
         var secNum2:Number = NaN;
         var date2:Date = null;
         var sec2:Number = NaN;
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
                  divtime = PokemonBridge.pdw_copied_at.split(" ");
                  dateArr = divtime[0].split("-");
                  yearNum = Number(dateArr[0]);
                  monthNum = Number(dateArr[1].slice(0,dateArr[1].length));
                  dateNum = Number(dateArr[2].slice(0,dateArr[2].length));
                  timeArr = divtime[1].split(":");
                  hourNum = Number(timeArr[0]);
                  minNum = Number(timeArr[1].slice(0,timeArr[1].length));
                  secNum = Number(timeArr[2].slice(0,timeArr[2].length));
                  date = new Date(yearNum,monthNum,dateNum,hourNum,minNum,secNum);
                  sec = date.getTime();
                  divtime2 = PokemonBridge.last_up_time_strict.split(" ");
                  dateArr2 = divtime2[0].split("-");
                  yearNum2 = Number(dateArr2[0]);
                  monthNum2 = Number(dateArr2[1].slice(0,dateArr2[1].length));
                  dateNum2 = Number(dateArr2[2].slice(0,dateArr2[2].length));
                  timeArr2 = divtime2[1].split(":");
                  hourNum2 = Number(timeArr2[0]);
                  minNum2 = Number(timeArr2[1].slice(0,timeArr2[1].length));
                  secNum2 = Number(timeArr2[2].slice(0,timeArr2[2].length));
                  date2 = new Date(yearNum2,monthNum2,dateNum2,hourNum2,minNum2,secNum2);
                  sec2 = date2.getTime();
                  Logger.log("PDW_COPIED_AT : " + sec);
                  Logger.log("LAST_UP_TIME_STRICT : " + sec2);
                  if(sec2 < sec + 10 * 1000)
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
      
      private static function setLifeTimer(sec:Number) : void
      {
         var r_hour:int = 0;
         var r_min:int = 0;
         var r_sec:int = 0;
         if(!_lifeFlag)
         {
            _life = sec;
            _lifeFlag = true;
            _lifeTimer = new Timer(1000,0);
            _lifeTimer.addEventListener(TimerEvent.TIMER,enterTimerHandler);
            _lifeTimer.reset();
            _lifeTimer.start();
            r_hour = _life / 60 / 60;
            r_min = _life / 60 % 60;
            r_sec = _life % 60;
            Logger.log("// NEXT ACCESS TIME (HH:MM:SS) --- " + r_hour + ":" + r_min + ":" + r_sec);
         }
      }
      
      private static function enterTimerHandler(e:TimerEvent) : void
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
      
      private static function startHandler(e:Event) : void
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
      
      private static function connectSuccessHandler(e:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         var json:Object = _connector.json;
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
      
      public static function specialErrorHandler(e:Event) : void
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
         var date:Date = new Date();
         var str:String = "/traffic/";
         var world:Number = 12345 * Number(PokemonBridge.world_id) - 6789;
         if(PokemonBridge.rom_id == 0)
         {
            str += "trial_" + world + "/status.json";
         }
         else
         {
            str += "product_" + world + "/status.json";
         }
         str += "?time=" + date.getTime();
         var jsonPath:URLRequest = new URLRequest();
         jsonPath.url = str;
         _jsonLoader = new URLLoader();
         _jsonLoader.dataFormat = URLLoaderDataFormat.TEXT;
         _jsonLoader.addEventListener(Event.COMPLETE,jsonLoaderCompleteHandler);
         _jsonLoader.load(jsonPath);
      }
      
      private static function jsonLoaderCompleteHandler(e:Event) : void
      {
         var _flag:Boolean = true;
         var _json:Object = com.adobe.serialization.json.JSON.decode(_jsonLoader.data.toString());
         if(_json.is_over_capacity == 1)
         {
            _flag = false;
         }
         _jsonLoader.removeEventListener(Event.COMPLETE,jsonLoaderCompleteHandler);
         _jsonLoader = null;
         if(_flag)
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
      
      public static function PDWEntryCheckHandler(e:Event) : void
      {
         var hour:int = 0;
         var min:int = 0;
         var str:String = null;
         PDWEnterBridge.removeEventListener(PDWEnterBridge.PDW_ENTRY_CHECK,PDWEntryCheckHandler);
         if(_life > 23 * 60 * 60)
         {
            hour = _life / 60 / 60;
            min = _life / 60 % 60;
            str = "あと[MM]分あそべます。\n混んでいたら遊べないのをご了承ください。\n次回のアクセスは、[HH]時間後から受付いたします。";
            str = str.replace(/\[MM\]/g,min);
            str = str.replace(/\[HH\]/g,hour);
            PokemonBridge.alertWindow(str,PokemonBridge.WITH_FADEOUT);
         }
      }
      
      private static function connectLoginErrorHandler(e:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         PokemonBridge.sleeping_flag = _connector.sleepingflag;
         var flag:Boolean = true;
         PokemonBridge.alertWindow(String(_connector.error),PokemonBridge.WITH_RELOAD);
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
      }
      
      private static function connectErrorHandler(e:Event) : void
      {
         PokemonBridge.alertDialog(PokemonBridge.ALERT_CLEAR);
         PokemonBridge.sleeping_flag = _connector.sleepingflag;
         var flag:Boolean = true;
         if(_connector.timecheck)
         {
            flag = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.HOUR_24_TIMER_ALERT);
         }
         if(_connector.roomcheck)
         {
            flag = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.BUSY_PDW_ALERT);
         }
         if(_connector.downloadcheck)
         {
            flag = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.DOWNLOAD_PDW_ALERT);
         }
         if(_connector.sleepingcheck)
         {
            flag = false;
            PDWEnterBridge.enterAlert(PDWEnterBridge.SLEEPING_PDW_ALERT);
         }
         if(flag)
         {
            PokemonBridge.alertWindow(FontManager.getIdText("pg_ame_1"),PokemonBridge.WITH_FADEOUT);
         }
         _connector.removeEventListener(ConnectorDataBase.DB_SUCCESS,connectSuccessHandler);
         _connector.removeEventListener(ConnectorDataBase.DB_ERROR,connectErrorHandler);
         _connector.disconnect();
         _connector = null;
      }
      
      private static function setLastLogin(sec:Number) : void
      {
         _lastlogindate = new Date(1970,0,1,0,0,sec);
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
      
      private static function ticketTimerHandler(e:TimerEvent) : void
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
      
      private static function finishHandler(e:Event) : void
      {
         Logger.log("PDW終了");
         PDWEnterBridge.removeSharedObject();
         ExternalInterface.call("setpdw",false);
         PokemonBridge.href("/");
      }
      
      private static function setHourTimer(sec:Number) : void
      {
         var r_min:int = 0;
         var r_sec:int = 0;
         if(!_ticketFlag)
         {
            _ticketFlag = true;
            _ticketTimer = new Timer(sec * 1000,1);
            _ticketTimer.addEventListener(TimerEvent.TIMER_COMPLETE,ticketTimerHandler);
            _ticketTimer.reset();
            _ticketTimer.start();
            r_min = sec / 60 % 60;
            r_sec = sec % 60;
            Logger.log("// REMINE PDW TIME (HH:MM:SS) --- " + "00:" + r_min + ":" + r_sec);
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


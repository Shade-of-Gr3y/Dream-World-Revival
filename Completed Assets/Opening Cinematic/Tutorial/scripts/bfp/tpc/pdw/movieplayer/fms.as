package bfp.tpc.pdw.movieplayer
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   public class fms extends EventDispatcher
   {
       
      
      internal var nc:*;
      
      internal var ncn:*;
      
      internal var nct:*;
      
      public var ns:*;
      
      internal var target_url:*;
      
      internal var sname:*;
      
      internal var ov:*;
      
      public var du:*;
      
      public var metadata:*;
      
      internal var snum:*;
      
      internal var mytime:*;
      
      internal var starttime:*;
      
      internal var comp_flag:*;
      
      internal var bw_flag:* = false;
      
      internal var timer_id:*;
      
      internal var tm_ob:*;
      
      internal var vb_ob:*;
      
      internal var failed_check:*;
      
      internal var playing_flag:*;
      
      public var last_info:*;
      
      public function fms()
      {
         super();
         this.tm_ob = new Timer(2000,1);
      }
      
      public function init(param1:*) : *
      {
         this.nc = undefined;
         this.ncn = undefined;
         this.nct = undefined;
         this.ncn = new NetConnection();
         this.ncn.objectEncoding = ObjectEncoding.AMF0;
         this.nct = new NetConnection();
         this.nct.objectEncoding = ObjectEncoding.AMF0;
         this.ncn.addEventListener(NetStatusEvent.NET_STATUS,this.ncn_onStatus);
         this.nct.addEventListener(NetStatusEvent.NET_STATUS,this.nct_onStatus);
         var _loc2_:Object = new Object();
         _loc2_.onBWDone = this.onBWDone;
         this.ncn.client = _loc2_;
         var _loc3_:Object = new Object();
         _loc3_.onBWDone = this.onBWDone;
         _loc3_.onBWCheck = this.onBWCheck;
         this.nct.client = _loc3_;
         this.ov = param1;
         this.vb_ob = this.ov.myvideo;
         this.vb_ob.clear();
         if(this.vb_ob.hasEventListener("Event.REMOVED") == false)
         {
            this.vb_ob.addEventListener(Event.REMOVED,this.removed_fms);
         }
      }
      
      internal function removed_fms(param1:*) : *
      {
         this.close();
      }
      
      public function start(param1:*, param2:*, ... rest) : *
      {
         trace("start " + param1 + " " + param2);
         this.failed_check = [false,false];
         this.target_url = param1;
         if(this.nc == undefined)
         {
            this.ncn.connect(param1);
            this.tm_ob.addEventListener(TimerEvent.TIMER,this.connect_rtmpt);
            this.tm_ob.start();
         }
         else
         {
            this.connect_netStream();
         }
         this.sname = param2;
         var _loc4_:* = this;
         this.du = undefined;
         this.comp_flag = undefined;
         this.starttime = 0;
         this.snum = 0;
         if(rest.length > 0)
         {
            this.snum = rest[0];
         }
      }
      
      internal function connect_rtmpt(param1:TimerEvent) : *
      {
         var _loc2_:* = "rtmpt" + this.target_url.substr(4);
         if(this.nct != undefined && this.nct != null)
         {
            this.nct.connect(_loc2_);
         }
      }
      
      internal function ncn_onStatus(param1:NetStatusEvent) : *
      {
         if(param1.info.code == "NetConnection.Connect.Success")
         {
            if(this.nct != undefined)
            {
               this.nct.close();
               this.nct = undefined;
               this.tm_ob.stop();
            }
            this.nc = this.ncn;
            this.connect_netStream();
            this.nc.call("checkBandwidth",null);
         }
         if(param1.info.code == "NetConnection.Connect.Failed")
         {
            this.check_failed(0);
         }
      }
      
      internal function nct_onStatus(param1:NetStatusEvent) : *
      {
         if(param1.info.code == "NetConnection.Connect.Success")
         {
            this.ncn.close();
            this.ncn = undefined;
            this.nc = this.nct;
            this.tm_ob.stop();
            this.connect_netStream();
         }
         if(param1.info.code == "NetConnection.Connect.Failed")
         {
            this.check_failed(1);
         }
      }
      
      public function onBWCheck(... rest) : Number
      {
         return 0;
      }
      
      public function onBWDone(... rest) : void
      {
         var _loc2_:Number = NaN;
         if(rest.length > 0)
         {
            _loc2_ = Number(rest[0]);
         }
      }
      
      internal function check_failed(param1:*) : *
      {
         this.failed_check[param1] = true;
         if(Boolean(this.failed_check[0]) && Boolean(this.failed_check[1]))
         {
            dispatchEvent(new Event("onFailed"));
         }
      }
      
      internal function connect_netStream() : *
      {
         var _loc1_:Object = new Object();
         _loc1_.onMetaData = this.ns_onMetaData;
         _loc1_.onPlayStatus = this.ns_onPlayStatus;
         if(this.ns == undefined)
         {
            this.ns = new NetStream(this.nc);
            this.ns.addEventListener(NetStatusEvent.NET_STATUS,this.ns_onStatus);
            this.ns.bufferTime = 3;
            this.ns.client = _loc1_;
         }
         this.vb_ob.attachNetStream(this.ns);
         if(this.nc != undefined && this.ns != undefined)
         {
            this.stream_play(undefined);
         }
      }
      
      internal function stream_play(param1:*) : *
      {
         var _loc2_:* = undefined;
         this.comp_flag = undefined;
         if(typeof this.sname == "object")
         {
            _loc2_ = this.sname[this.snum];
         }
         else
         {
            _loc2_ = this.sname;
         }
         trace("stream_play sn=" + _loc2_);
         if(_loc2_.substr(-4) == ".flv")
         {
            _loc2_ = _loc2_.substr(0,_loc2_.length - 4);
         }
         if(_loc2_.substr(-4) == ".mp4")
         {
            _loc2_ = "mp4:" + _loc2_.substr(0,_loc2_.length - 4);
         }
         if(param1 != undefined)
         {
            this.ns.play(_loc2_,param1,-1,true);
            this.starttime = param1;
         }
         else
         {
            this.ns.play(_loc2_,0);
         }
         this.playing_flag = true;
      }
      
      internal function ns_onMetaData(param1:Object) : *
      {
         if(param1.duration != undefined)
         {
            this.du = param1.duration;
         }
         this.metadata = param1;
         var _loc2_:* = new Event("onMetaData");
         dispatchEvent(_loc2_);
      }
      
      internal function ns_onPlayStatus(param1:Object) : *
      {
         var _loc2_:* = undefined;
         if(param1.code == "NetStream.Play.Complete")
         {
            this.comp_flag = true;
            _loc2_ = new Event("onComplete");
            dispatchEvent(_loc2_);
         }
      }
      
      internal function ns_onStatus(param1:*) : *
      {
         var _loc2_:* = undefined;
         trace("ns_onStatus " + param1.info.code);
         this.last_info = param1.info.code;
         if(param1.info.code == "NetStream.Buffer.Full")
         {
         }
         if(param1.info.code == "NetStream.Play.Start")
         {
            trace("NetStream.Play.Start");
            this.ov.sizeflag = false;
            this.ov.addEventListener(Event.ENTER_FRAME,this.video_enterframe);
            _loc2_ = new Event("onStart");
            dispatchEvent(_loc2_);
         }
         if(param1.info.code == "NetStream.Play.InsufficientBW" && this.bw_flag)
         {
            if(this.snum < this.sname.length - 1)
            {
               ++this.snum;
               this.stream_play(this.starttime + this.ns.time);
            }
         }
         dispatchEvent(new Event("onStatus"));
      }
      
      internal function video_enterframe(param1:*) : *
      {
         if(this.ns != undefined)
         {
            this.mytime = this.ns.time + this.starttime;
         }
         else
         {
            this.mytime = 0;
         }
         if(this.playing_flag == true && this.mytime > 0 && this.vb_ob.visible == false)
         {
         }
      }
      
      public function duration() : *
      {
         return this.du;
      }
      
      public function bytesLoaded() : *
      {
         if(this.ns != undefined)
         {
            return this.ns.bytesLoaded;
         }
         return 0;
      }
      
      public function bytesTotal() : *
      {
         if(this.ns != undefined)
         {
            return this.ns.bytesTotal;
         }
         return 0;
      }
      
      public function bufferTime() : *
      {
         if(this.ns != undefined)
         {
            return this.ns.bufferTime;
         }
         return 0;
      }
      
      public function bufferLength() : *
      {
         if(this.ns != undefined)
         {
            return this.ns.bufferLength;
         }
         return 0;
      }
      
      public function time() : *
      {
         var _loc1_:* = 0;
         if(this.ns != undefined)
         {
            if(this.ns.time != undefined)
            {
               _loc1_ = this.ns.time + this.starttime;
            }
         }
         return _loc1_;
      }
      
      public function close() : *
      {
         if(this.ov != undefined)
         {
            this.ov.removeEventListener(Event.ENTER_FRAME,this.video_enterframe);
         }
         var _loc1_:* = false;
         if(this.nc != undefined)
         {
            if(this.nc.connected)
            {
               if(this.ns != undefined)
               {
                  this.ns.close();
               }
               this.nc.close();
               _loc1_ = true;
            }
            this.nc = undefined;
            this.ns = undefined;
         }
         if(this.ncn != undefined)
         {
            if(this.ns != undefined)
            {
               this.ns.close();
            }
            this.ncn.close();
            _loc1_ = true;
            this.ncn = undefined;
            this.ns = undefined;
         }
         if(this.nct != undefined)
         {
            if(this.ns != undefined)
            {
               this.ns.close();
            }
            this.nct.close();
            _loc1_ = true;
            this.nct = undefined;
            this.ns = undefined;
         }
         this.du = undefined;
         this.playing_flag = false;
         return _loc1_;
      }
      
      public function pause() : *
      {
         if(this.ns != undefined)
         {
            this.ns.pause();
         }
         this.playing_flag = false;
      }
      
      public function stop() : *
      {
         if(this.ov != undefined)
         {
            this.ov.removeEventListener(Event.ENTER_FRAME,this.video_enterframe);
         }
         this.mytime = 0;
         this.close();
      }
      
      public function seek(param1:*) : *
      {
         if(param1 < this.starttime)
         {
            this.stream_play(param1);
         }
         else if(this.ns != undefined)
         {
            this.ns.seek(param1 - this.starttime);
         }
      }
      
      internal function seek_next() : *
      {
         var _loc1_:* = this.ns.time + 0.5;
         this.ns.seek(_loc1_);
      }
      
      internal function seek_prev() : *
      {
         var _loc1_:* = this.ns.time - 1;
         this.ns.seek(_loc1_);
      }
      
      public function restart() : *
      {
         if(this.nc == undefined || this.ns == undefined)
         {
            this.init(this.ov);
            this.start(this.target_url,this.sname,this.snum);
         }
         else if(this.comp_flag == true)
         {
            this.stream_play(undefined);
         }
         else
         {
            this.playing_flag = true;
            this.ns.resume();
         }
      }
      
      public function get_percent() : *
      {
         var _loc1_:* = undefined;
         if(this.du != undefined && this.vb_ob.visible == true)
         {
            if(this.du > 0)
            {
               _loc1_ = this.mytime / this.du;
               if(_loc1_ > 1)
               {
                  _loc1_ = 1;
               }
               if(_loc1_ < 0 || _loc1_ == undefined || isNaN(_loc1_))
               {
                  _loc1_ = 0;
               }
               return _loc1_;
            }
            return 0;
         }
         return 0;
      }
      
      internal function get_loaded_percent() : *
      {
         var _loc1_:* = undefined;
         if(this.ns != undefined)
         {
            if(this.du != undefined)
            {
               if(this.du > 0)
               {
                  _loc1_ = (this.ns.time + this.ns.bufferLength) / this.du;
                  if(_loc1_ > 1)
                  {
                     _loc1_ = 1;
                  }
                  return _loc1_;
               }
               return 0;
            }
            return 0;
         }
         return 0;
      }
      
      public function changeFlv(param1:*) : *
      {
         if(this.ov != undefined && this.ns != undefined)
         {
            if(0 <= param1 && param1 < this.sname.length && param1 != this.snum)
            {
               this.snum = param1;
               this.stream_play(this.starttime + this.ns.time);
            }
         }
      }
      
      public function clear() : *
      {
         if(this.ov != undefined)
         {
            this.vb_ob.attachNetStream(null);
         }
      }
   }
}

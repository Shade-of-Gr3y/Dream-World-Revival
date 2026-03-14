package com.google.analytics.core
{
   import com.google.analytics.data.UTMA;
   import com.google.analytics.data.UTMB;
   import com.google.analytics.data.UTMC;
   import com.google.analytics.data.UTMK;
   import com.google.analytics.data.UTMV;
   import com.google.analytics.data.UTMZ;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.VisualDebugMode;
   import com.google.analytics.v4.Configuration;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public dynamic class Buffer
   {
      
      private var _SO:SharedObject;
      
      private var _OBJ:Object;
      
      private var _utma:UTMA;
      
      private var _utmb:UTMB;
      
      private var _utmc:UTMC;
      
      private var _debug:DebugConfiguration;
      
      private var _utmk:UTMK;
      
      private var _config:Configuration;
      
      private var _utmv:UTMV;
      
      private var _utmz:UTMZ;
      
      private var _volatile:Boolean;
      
      public function Buffer(param1:Configuration, param2:DebugConfiguration, param3:Boolean = false, param4:Object = null)
      {
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         super();
         _config = param1;
         _debug = param2;
         UTMB.defaultTimespan = _config.sessionTimeout;
         UTMZ.defaultTimespan = _config.conversionTimeout;
         if(!param3)
         {
            _SO = SharedObject.getLocal(_config.cookieName,_config.cookiePath);
            _loc5_ = false;
            if(_SO.data.utma)
            {
               if(!hasUTMA())
               {
                  _createUMTA();
               }
               _utma.fromSharedObject(_SO.data.utma);
               if(_debug.verbose)
               {
                  _debug.info("found: " + _utma.toString(true),VisualDebugMode.geek);
               }
               if(_utma.isExpired())
               {
                  if(_debug.verbose)
                  {
                     _debug.warning("UTMA has expired",VisualDebugMode.advanced);
                  }
                  _clearUTMA();
                  _loc5_ = true;
               }
            }
            if(_SO.data.utmb)
            {
               if(!hasUTMB())
               {
                  _createUMTB();
               }
               _utmb.fromSharedObject(_SO.data.utmb);
               if(_debug.verbose)
               {
                  _debug.info("found: " + _utmb.toString(true),VisualDebugMode.geek);
               }
               if(_utmb.isExpired())
               {
                  if(_debug.verbose)
                  {
                     _debug.warning("UTMB has expired",VisualDebugMode.advanced);
                  }
                  _clearUTMB();
                  _loc5_ = true;
               }
            }
            if(_SO.data.utmc)
            {
               delete _SO.data.utmc;
               _loc5_ = true;
            }
            if(_SO.data.utmk)
            {
               if(!hasUTMK())
               {
                  _createUMTK();
               }
               _utmk.fromSharedObject(_SO.data.utmk);
               if(_debug.verbose)
               {
                  _debug.info("found: " + _utmk.toString(),VisualDebugMode.geek);
               }
            }
            if(_SO.data.utmv)
            {
               if(!hasUTMV())
               {
                  _createUMTV();
               }
               _utmv.fromSharedObject(_SO.data.utmv);
               if(_debug.verbose)
               {
                  _debug.info("found: " + _utmv.toString(true),VisualDebugMode.geek);
               }
               if(_utmv.isExpired())
               {
                  if(_debug.verbose)
                  {
                     _debug.warning("UTMV has expired",VisualDebugMode.advanced);
                  }
                  _clearUTMV();
                  _loc5_ = true;
               }
            }
            if(_SO.data.utmz)
            {
               if(!hasUTMZ())
               {
                  _createUMTZ();
               }
               _utmz.fromSharedObject(_SO.data.utmz);
               if(_debug.verbose)
               {
                  _debug.info("found: " + _utmz.toString(true),VisualDebugMode.geek);
               }
               if(_utmz.isExpired())
               {
                  if(_debug.verbose)
                  {
                     _debug.warning("UTMZ has expired",VisualDebugMode.advanced);
                  }
                  _clearUTMZ();
                  _loc5_ = true;
               }
            }
            if(_loc5_)
            {
               save();
            }
         }
         else
         {
            _OBJ = new Object();
            if(param4)
            {
               for(_loc6_ in param4)
               {
                  _OBJ[_loc6_] = param4[_loc6_];
               }
            }
         }
         _volatile = param3;
      }
      
      public function save() : void
      {
         var flushStatus:String = null;
         if(!isVolatile())
         {
            flushStatus = null;
            try
            {
               flushStatus = _SO.flush();
            }
            catch(e:Error)
            {
               _debug.warning("Error...Could not write SharedObject to disk");
            }
            switch(flushStatus)
            {
               case SharedObjectFlushStatus.PENDING:
                  _debug.info("Requesting permission to save object...");
                  _SO.addEventListener(NetStatusEvent.NET_STATUS,_onFlushStatus);
                  break;
               case SharedObjectFlushStatus.FLUSHED:
                  _debug.info("Value flushed to disk.");
            }
         }
      }
      
      public function get utmv() : UTMV
      {
         if(!hasUTMV())
         {
            _createUMTV();
         }
         return _utmv;
      }
      
      public function clearCookies() : void
      {
         utma.reset();
         utmb.reset();
         utmc.reset();
         utmz.reset();
         utmv.reset();
         utmk.reset();
      }
      
      public function get utmz() : UTMZ
      {
         if(!hasUTMZ())
         {
            _createUMTZ();
         }
         return _utmz;
      }
      
      public function hasUTMA() : Boolean
      {
         if(_utma)
         {
            return true;
         }
         return false;
      }
      
      public function hasUTMB() : Boolean
      {
         if(_utmb)
         {
            return true;
         }
         return false;
      }
      
      public function isGenuine() : Boolean
      {
         if(!hasUTMK())
         {
            return true;
         }
         return utmk.hash == generateCookiesHash();
      }
      
      public function resetCurrentSession() : void
      {
         _clearUTMB();
         _clearUTMC();
         save();
      }
      
      public function hasUTMC() : Boolean
      {
         if(_utmc)
         {
            return true;
         }
         return false;
      }
      
      public function hasUTMK() : Boolean
      {
         if(_utmk)
         {
            return true;
         }
         return false;
      }
      
      public function generateCookiesHash() : Number
      {
         var _loc1_:String = null;
         _loc1_ = "";
         _loc1_ += utma.valueOf();
         _loc1_ += utmb.valueOf();
         _loc1_ += utmc.valueOf();
         _loc1_ += utmz.valueOf();
         _loc1_ += utmv.valueOf();
         return Utils.generateHash(_loc1_);
      }
      
      private function _createUMTA() : void
      {
         _utma = new UTMA();
         _utma.proxy = this;
      }
      
      private function _createUMTB() : void
      {
         _utmb = new UTMB();
         _utmb.proxy = this;
      }
      
      private function _createUMTC() : void
      {
         _utmc = new UTMC();
      }
      
      public function hasUTMV() : Boolean
      {
         if(_utmv)
         {
            return true;
         }
         return false;
      }
      
      private function _createUMTK() : void
      {
         _utmk = new UTMK();
         _utmk.proxy = this;
      }
      
      public function hasUTMZ() : Boolean
      {
         if(_utmz)
         {
            return true;
         }
         return false;
      }
      
      private function _createUMTV() : void
      {
         _utmv = new UTMV();
         _utmv.proxy = this;
      }
      
      private function _createUMTZ() : void
      {
         _utmz = new UTMZ();
         _utmz.proxy = this;
      }
      
      public function updateUTMA(param1:Number) : void
      {
         if(_debug.verbose)
         {
            _debug.info("updateUTMA( " + param1 + " )",VisualDebugMode.advanced);
         }
         if(!utma.isEmpty())
         {
            if(isNaN(utma.sessionCount))
            {
               utma.sessionCount = 1;
            }
            else
            {
               utma.sessionCount += 1;
            }
            utma.lastTime = utma.currentTime;
            utma.currentTime = param1;
         }
      }
      
      private function _onFlushStatus(param1:NetStatusEvent) : void
      {
         _debug.info("User closed permission dialog...");
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               _debug.info("User granted permission -- value saved.");
               break;
            case "SharedObject.Flush.Failed":
               _debug.info("User denied permission -- value not saved.");
         }
         _SO.removeEventListener(NetStatusEvent.NET_STATUS,_onFlushStatus);
      }
      
      private function _clearUTMA() : void
      {
         _utma = null;
         if(!isVolatile())
         {
            _SO.data.utma = null;
            delete _SO.data.utma;
         }
      }
      
      private function _clearUTMC() : void
      {
         _utmc = null;
      }
      
      private function _clearUTMB() : void
      {
         _utmb = null;
         if(!isVolatile())
         {
            _SO.data.utmb = null;
            delete _SO.data.utmb;
         }
      }
      
      public function update(param1:String, param2:*) : void
      {
         if(isVolatile())
         {
            _OBJ[param1] = param2;
         }
         else
         {
            _SO.data[param1] = param2;
         }
      }
      
      private function _clearUTMZ() : void
      {
         _utmz = null;
         if(!isVolatile())
         {
            _SO.data.utmz = null;
            delete _SO.data.utmz;
         }
      }
      
      private function _clearUTMV() : void
      {
         _utmv = null;
         if(!isVolatile())
         {
            _SO.data.utmv = null;
            delete _SO.data.utmv;
         }
      }
      
      public function isVolatile() : Boolean
      {
         return _volatile;
      }
      
      public function get utma() : UTMA
      {
         if(!hasUTMA())
         {
            _createUMTA();
         }
         return _utma;
      }
      
      public function get utmb() : UTMB
      {
         if(!hasUTMB())
         {
            _createUMTB();
         }
         return _utmb;
      }
      
      public function get utmc() : UTMC
      {
         if(!hasUTMC())
         {
            _createUMTC();
         }
         return _utmc;
      }
      
      public function get utmk() : UTMK
      {
         if(!hasUTMK())
         {
            _createUMTK();
         }
         return _utmk;
      }
   }
}


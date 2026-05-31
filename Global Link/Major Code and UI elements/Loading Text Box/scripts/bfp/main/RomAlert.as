package bfp.main
{
   import bfp.common.Logger;
   import caurina.transitions.properties.ColorShortcuts;
   import flash.display.MovieClip;
   
   public class RomAlert
   {
      
      public static const NOT_SYNC:String = "NOT_SYNC";
      
      public static const NO_ID:String = "NO_ID";
      
      private var _container:MovieClip;
      
      private var _noid:RomAlertNoid;
      
      private var _notsync:RomAlertNotSync;
      
      public function RomAlert(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._notsync = new RomAlertNotSync(this._container.notsync);
         this._noid = new RomAlertNoid(this._container.noid);
         ColorShortcuts.init();
      }
      
      public function open(param1:String) : void
      {
         this._container.visible = true;
         switch(param1)
         {
            case RomAlert.NOT_SYNC:
               this._notsync.open();
               break;
            case RomAlert.NO_ID:
               Logger.log("NO_ID");
               this._noid.open();
         }
      }
   }
}


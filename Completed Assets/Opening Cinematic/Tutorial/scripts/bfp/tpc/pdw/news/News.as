package bfp.tpc.pdw.news
{
   import bfp.PDWBridge;
   import bfp.common.Connection;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.tpc.pdw.PDWURL;
   import caurina.transitions.Tweener;
   import com.adobe.serialization.json.JSON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.text.Font;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import jp.feb19.display.CircleSlicePreloader;
   import jp.feb19.utils.ButtonUtilities;
   import jp.feb19.utils.ColorUtilities;
   
   public class News extends Sprite
   {
       
      
      public var newlabelmc:MovieClip;
      
      public var nodatamc:MovieClip;
      
      public var closemc:MovieClip;
      
      public var close_btn:MovieClip;
      
      private var _urlLoader:URLLoader;
      
      private var _preloader:CircleSlicePreloader;
      
      private var _newsRecords:Object;
      
      private var _newsRecordAssets:Array;
      
      private var _pageNation:PageNationForNews;
      
      private var _connection:Connection;
      
      private const NUM:uint = 8;
      
      public function News()
      {
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         var _loc4_:Font = null;
         super();
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            if((_loc4_ = Font.enumerateFonts()[_loc2_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
               break;
            }
         }
         _loc3_ = new TextFormat();
         _loc3_.font = "PokemonFontShingoM";
         _loc3_.size = 16;
         _loc3_.color = 16777215;
         _loc3_.align = TextFormatAlign.CENTER;
         this.nodatamc.tf.defaultTextFormat = _loc3_;
         this.nodatamc.tf.antiAliasType = "advanced";
         this.nodatamc.tf.gridFitType = "subpixel";
         this.nodatamc.tf.sharpness = -200;
         this.nodatamc.tf.thickness = 100;
         this.nodatamc.tf.embedFonts = _loc1_;
         this.nodatamc.tf.multiline = false;
         this.nodatamc.tf.wordWrap = false;
         this.nodatamc.tf.y = 139;
         FontManager.setTextID(this.nodatamc.tf,"new_home_3");
         this.tabEnabled = false;
         this.tabChildren = false;
         this.nodatamc.visible = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         this.x = 166;
         this.y = -463;
         this._newsRecordAssets = [];
         this.nodatamc.visible = false;
         this.closemc.hitArea = this.close_btn;
      }
      
      private function changeHandler(param1:Event) : void
      {
         this.loadPage(this._pageNation.select - 1);
      }
      
      public function release() : void
      {
         if(this._pageNation)
         {
            this._pageNation.release();
            this._pageNation.removeEventListener(Event.CHANGE,this.changeHandler);
            this._pageNation = null;
         }
      }
      
      public function visit() : void
      {
         ButtonUtilities.setBtn(this.closemc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         Tweener.addTween(this,{
            "time":0.6,
            "y":0,
            "transition":"easeOutExpo"
         });
         if(this._pageNation)
         {
            this._pageNation.select = 1;
         }
         this.loadPage(0);
      }
      
      public function away() : void
      {
         ButtonUtilities.unsetBtn(this.closemc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         dispatchEvent(new Event("willNewsClose"));
         Tweener.addTween(this,{
            "time":0.3,
            "y":-463,
            "transition":"easeInQuad",
            "onComplete":function():*
            {
               dispatchEvent(new Event(Event.CLOSE));
            }
         });
      }
      
      public function loadPage(param1:uint = 0) : void
      {
         this.clearPage();
         this._preloader = new CircleSlicePreloader();
         addChild(this._preloader);
         this._preloader.x = 352;
         this._preloader.y = 270;
         this._connection = new Connection();
         this._connection.request["token"] = PokemonBridge.token;
         this._connection.request["offset"] = param1 * this.NUM;
         this._connection.request["rowcount"] = this.NUM;
         this._connection.request["weekly_flag"] = 0;
         this._connection.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._connection.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._connection.open(PDWURL.PDW_INFO,"GET");
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         if(this._preloader)
         {
            this._preloader.destroy();
            removeChild(this._preloader);
            this._preloader = null;
         }
         this.nodatamc.visible = true;
         this._connection.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._connection.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         var _loc2_:String = FontManager.getIdText("dialog_1");
         var _loc3_:String = FontManager.getIdText("dialog_2");
         if(this._connection.statusCode == 0)
         {
            PDWBridge.dialogError(_loc2_,PDWBridge.DIALOG_ERROR_NONE);
         }
         else
         {
            PDWBridge.dialogError(_loc3_,PDWBridge.DIALOG_ERROR_NONE);
         }
         this._connection = null;
      }
      
      public function clearPage() : void
      {
         if(this._preloader)
         {
            this._preloader.destroy();
            removeChild(this._preloader);
            this._preloader = null;
         }
         if(this._connection)
         {
            this._connection.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this._connection.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            this._connection.close();
         }
         var _loc1_:Array = this._newsRecordAssets;
         var _loc2_:uint = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            removeChild(_loc1_[_loc3_]);
            _loc3_++;
         }
         this._newsRecordAssets = [];
      }
      
      private function loadCompleteHandler(param1:Event) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:NewsRecord = null;
         if(this._preloader)
         {
            this._preloader.destroy();
            removeChild(this._preloader);
            this._preloader = null;
         }
         this._connection.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._connection.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         if(!PDWBridge.isLocal && this._connection.statusCode == 0)
         {
            _loc6_ = FontManager.getIdText("dialog_1");
            PDWBridge.dialogError(_loc6_,PDWBridge.DIALOG_ERROR_NONE);
            this.nodatamc.visible = true;
            return;
         }
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(this._connection.data.toString());
         this._newsRecords = _loc2_;
         var _loc3_:uint = uint(_loc2_.list.length);
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = _loc2_.list[_loc5_];
            _loc8_ = addChild(new NewsRecord(_loc7_.news_date,_loc7_.news_type,_loc7_.message,false)) as NewsRecord;
            _loc4_.push(_loc8_);
            _loc8_.x = 35;
            _loc8_.y = 130 + _loc5_ * 34;
            _loc5_++;
         }
         this._newsRecordAssets = _loc4_;
         if(!this._pageNation && _loc2_.total_count != 0)
         {
            this._pageNation = new PageNationForNews(Math.ceil(_loc2_.total_count / this.NUM),6,new Rectangle(186,418,311,0));
            addChild(this._pageNation);
            this._pageNation.addEventListener(Event.CHANGE,this.changeHandler);
         }
         if(_loc2_.total_count == 0 || _loc3_ == 0)
         {
            this.nodatamc.visible = true;
         }
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.paint(this.newlabelmc,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.reset(this.newlabelmc);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.reset(this.newlabelmc);
               this.away();
         }
      }
   }
}

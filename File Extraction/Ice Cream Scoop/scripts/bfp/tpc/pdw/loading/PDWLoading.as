package bfp.tpc.pdw.loading
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PDWLoading extends PDWAlert
   {
      
      private var _percentage:int;
      
      public var indicatormc:MovieClip;
      
      public var loadMesMc:MovieClip;
      
      public var tf:TextField;
      
      public function PDWLoading()
      {
         this.percentage = 0;
         super();
      }
      
      override public function visit() : void
      {
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         super.visit();
      }
      
      override public function away() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         super.away();
      }
      
      override public function init() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:TextFormat = null;
         var _loc4_:Font = null;
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            _loc4_ = Font.enumerateFonts()[_loc2_];
            if(_loc4_.fontName == "PokemonFontKozM")
            {
               _loc1_ = true;
               break;
            }
         }
         _loc3_ = new TextFormat();
         _loc3_.font = "PokemonFontKozM";
         _loc3_.size = 15;
         _loc3_.color = 6963756;
         _loc3_.align = TextFormatAlign.RIGHT;
         this.tf.antiAliasType = AntiAliasType.ADVANCED;
         this.tf.gridFitType = GridFitType.SUBPIXEL;
         this.tf.sharpness = -200;
         this.tf.thickness = 100;
         this.tf.defaultTextFormat = _loc3_;
         this.tf.embedFonts = _loc1_;
         this.tf.selectable = false;
         this.tf.text = "0";
         this.tf.y = 102;
         super.init();
      }
      
      public function set percentage(param1:int) : void
      {
         this._percentage = param1;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         this.tf.text = this.percentage.toString();
      }
      
      public function get percentage() : int
      {
         return this._percentage;
      }
   }
}


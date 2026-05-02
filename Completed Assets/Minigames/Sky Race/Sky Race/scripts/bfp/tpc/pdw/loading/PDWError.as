package bfp.tpc.pdw.loading
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PDWError extends PDWAlert
   {
       
      
      public var tf:TextField;
      
      public var closemc:MovieClip;
      
      private const color:uint = 14910251;
      
      public function PDWError()
      {
         super();
      }
      
      public function setText(param1:String = "") : void
      {
         var _loc3_:* = undefined;
         var _loc4_:TextFormat = null;
         var _loc5_:Font = null;
         var _loc2_:Boolean = false;
         for(_loc3_ in Font.enumerateFonts())
         {
            _loc5_ = Font.enumerateFonts()[_loc3_];
            if(_loc5_.fontName == "PokemonFontShingoM")
            {
               _loc2_ = true;
               break;
            }
         }
         _loc4_ = new TextFormat();
         _loc4_.font = "PokemonFontShingoM";
         _loc4_.size = 13;
         _loc4_.color = 3355443;
         _loc4_.align = TextFormatAlign.CENTER;
         this.tf.antiAliasType = AntiAliasType.ADVANCED;
         this.tf.gridFitType = GridFitType.SUBPIXEL;
         this.tf.sharpness = -200;
         this.tf.thickness = 100;
         this.tf.selectable = false;
         this.tf.defaultTextFormat = _loc4_;
         this.tf.embedFonts = _loc2_;
         this.tf.text = param1;
         this.tf.width = 300;
         this.tf.multiline = true;
         this.tf.wordWrap = true;
         this.tf.x = int((375 - this.tf.width) / 2);
      }
      
      override public function visit() : void
      {
         this.closemc.buttonMode = true;
         this.closemc.mouseChildren = false;
         this.closemc.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.closemc.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.closemc.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      override public function away() : void
      {
         this.closemc.buttonMode = false;
         this.closemc.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.closemc.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.closemc.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         super.away();
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               _loc3_ = _loc2_.bgmc.transform.colorTransform;
               _loc3_.redMultiplier = 0;
               _loc3_.greenMultiplier = 0;
               _loc3_.blueMultiplier = 0;
               _loc3_.redOffset = this.color >> 16 & 255;
               _loc3_.greenOffset = this.color >> 8 & 255;
               _loc3_.blueOffset = this.color & 255;
               _loc2_.bgmc.transform.colorTransform = _loc3_;
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               _loc3_ = _loc2_.bgmc.transform.colorTransform;
               _loc3_.redMultiplier = 1;
               _loc3_.greenMultiplier = 1;
               _loc3_.blueMultiplier = 1;
               _loc3_.redOffset = 0;
               _loc3_.greenOffset = 0;
               _loc3_.blueOffset = 0;
               _loc2_.bgmc.transform.colorTransform = _loc3_;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               _loc3_ = _loc2_.bgmc.transform.colorTransform;
               _loc3_.redMultiplier = 1;
               _loc3_.greenMultiplier = 1;
               _loc3_.blueMultiplier = 1;
               _loc3_.redOffset = 0;
               _loc3_.greenOffset = 0;
               _loc3_.blueOffset = 0;
               _loc2_.bgmc.transform.colorTransform = _loc3_;
               this.away();
         }
      }
   }
}

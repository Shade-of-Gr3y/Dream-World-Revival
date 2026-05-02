package bfp.tpc.pdw.common
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class PDWUtils
   {
      
      public function PDWUtils()
      {
         super();
      }
      
      public static function setUnavailableColor(displayObject:DisplayObject) : void
      {
         var cl:ColorTransform = displayObject.transform.colorTransform;
         cl.redMultiplier = 0.5;
         cl.greenMultiplier = 0.5;
         cl.blueMultiplier = 0.5;
         cl.redOffset = 111;
         cl.greenOffset = 111;
         cl.blueOffset = 111;
         displayObject.transform.colorTransform = cl;
      }
      
      public static function markupMultilingualText(text:String) : String
      {
         return text.replace(/([가-힝]+)|([^가-힝]+)/g,function(match:String, hangeul:String, other:String, index:int, all:String):String
         {
            var fontName:* = undefined;
            if(hangeul)
            {
               fontName = "InterparkGothicOTFM";
            }
            else
            {
               fontName = "PokemonFontShingoM";
            }
            return (<FONT FACE={fontName}>{match}</FONT>).toXMLString();
         });
      }
   }
}


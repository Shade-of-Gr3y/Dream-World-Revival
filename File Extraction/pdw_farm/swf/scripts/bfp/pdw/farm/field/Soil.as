package bfp.pdw.farm.field
{
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import caurina.transitions.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class Soil extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var typeSafe:MovieClip;
      
      private var typeCaution:MovieClip;
      
      private var typeDanger:MovieClip;
      
      private var defaultSoil:MovieClip;
      
      private var data:FarmData;
      
      public function Soil(param1:MovieClip, param2:*)
      {
         super();
         this.targetMC = param1;
         param1.mouseChildren = false;
         param1.mouseEnabled = false;
         this.defaultSoil = param2;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.defaultSoil.mouseEnabled = false;
         this.defaultSoil.mouseChildren = false;
         this.typeSafe = this.targetMC.typeSafe;
         this.typeCaution = this.targetMC.typeCaution;
         this.typeDanger = this.targetMC.typeDanger;
         this.reset();
      }
      
      public function reset() : *
      {
         this.typeSafe.visible = false;
         this.typeSafe.alpha = 0;
         this.typeCaution.visible = false;
         this.typeCaution.alpha = 0;
         this.typeDanger.visible = false;
         this.typeDanger.alpha = 0;
         this.defaultSoil.visible = true;
         this.defaultSoil.alpha = 1;
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this.typeSafe);
         Tweener.removeTweens(this.typeCaution);
         Tweener.removeTweens(this.typeDanger);
         Tweener.removeTweens(this.defaultSoil);
      }
      
      public function run() : *
      {
      }
      
      public function change(param1:*) : *
      {
         switch(param1)
         {
            case this.data.SOIL_STATUS_SAFE:
               Tweener.removeTweens(this.typeSafe);
               Tweener.removeTweens(this.typeCaution);
               Tweener.removeTweens(this.typeDanger);
               Tweener.removeTweens(this.defaultSoil);
               Tweener.addTween(this.typeSafe,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":1
               });
               Tweener.addTween(this.typeCaution,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeDanger,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.defaultSoil,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               break;
            case this.data.SOIL_STATUS_CAUTION:
               Tweener.removeTweens(this.typeSafe);
               Tweener.removeTweens(this.typeCaution);
               Tweener.removeTweens(this.typeDanger);
               Tweener.removeTweens(this.defaultSoil);
               Tweener.addTween(this.typeSafe,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeCaution,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":1
               });
               Tweener.addTween(this.typeDanger,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.defaultSoil,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               break;
            case this.data.SOIL_STATUS_DANGER:
               Tweener.removeTweens(this.typeSafe);
               Tweener.removeTweens(this.typeCaution);
               Tweener.removeTweens(this.typeDanger);
               Tweener.removeTweens(this.defaultSoil);
               Tweener.addTween(this.typeSafe,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeCaution,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeDanger,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":1
               });
               Tweener.addTween(this.defaultSoil,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               break;
            default:
               Tweener.removeTweens(this.typeSafe);
               Tweener.removeTweens(this.typeCaution);
               Tweener.removeTweens(this.typeDanger);
               Tweener.removeTweens(this.defaultSoil);
               Tweener.addTween(this.typeSafe,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeCaution,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.typeDanger,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":0
               });
               Tweener.addTween(this.defaultSoil,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_autoAlpha":1
               });
         }
      }
   }
}


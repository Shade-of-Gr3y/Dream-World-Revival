package game3_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol310")]
   public dynamic class help_inside_mc_170 extends MovieClip
   {
      
      public var btn_next:MovieClip;
      
      public var btn_previous:MovieClip;
      
      public var help_1:MovieClip;
      
      public var help_2:MovieClip;
      
      public function help_inside_mc_170()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["help_1"]);
         MovieClip(root).moveLangFrame(this["help_2"]);
      }
   }
}


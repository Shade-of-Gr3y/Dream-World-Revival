package bfp.common
{
   import adobe.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.ui.*;
   
   public class pokemonLoader extends MovieClip
   {
      
      private var basepath:*;
      
      private var position_width:*;
      
      private var position_height:*;
      
      private var mypoke:*;
      
      public function pokemonLoader(param1:String = "", param2:Number = 0, param3:Number = 0)
      {
         super();
         this.basepath = param1;
         this.position_width = param2;
         this.position_height = param3;
      }
      
      public function loadSwf(param1:*, param2:Number = 0) : *
      {
         var pid:* = param1;
         var fid:Number = param2;
         this.mypoke = PokemonBridge.createRenderer();
         if(this.mypoke)
         {
            try
            {
               this.mypoke.loadToArea(pid,fid,this.position_width,this.position_height);
            }
            catch(e:ArgumentError)
            {
               dispatchEvent(new Event(Event.COMPLETE));
            }
            this.addEventListener(Event.ENTER_FRAME,this.pokeEnterFrameHandler);
            this.mypoke.shadowOpacity = 0;
            this.addChild(this.mypoke.display);
         }
      }
      
      private function pokeEnterFrameHandler(param1:Event) : void
      {
         if(this.mypoke.display.width > 5)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.pokeEnterFrameHandler);
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function unloadSwf() : void
      {
         if(this.mypoke)
         {
            this.removeChild(this.mypoke.display);
         }
      }
      
      public function get renderPokemon() : *
      {
         return this.mypoke;
      }
   }
}


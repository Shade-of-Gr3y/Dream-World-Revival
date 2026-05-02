package bfp.tpc.pdw.common
{
   import adobe.utils.*;
   import bfp.common.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.ui.*;
   
   public class pokemonLoader2 extends MovieClip
   {
      
      private var position_width:*;
      
      private var position_height:*;
      
      private var position_x:*;
      
      private var position_y:*;
      
      private var mypoke:*;
      
      private var pokeid:*;
      
      public var num:*;
      
      public function pokemonLoader2(x:*, y:*, w:Number = 0, h:Number = 0)
      {
         super();
         this.position_x = x;
         this.position_y = y;
         this.position_width = w;
         this.position_height = h;
      }
      
      public function loadSwf(pid:*, fid:Number = 0) : *
      {
         this.mypoke = PokemonBridge.createRenderer2();
         if(this.mypoke)
         {
            try
            {
               this.mypoke.loadToArea(pid,fid,this.position_width,this.position_height);
            }
            catch(e:ArgumentError)
            {
               trace(">>>pokemonLoader Error " + e);
               dispatchEvent(new Event(Event.COMPLETE));
            }
            this.addEventListener(Event.ENTER_FRAME,this.pokeEnterFrameHandler);
            this.addChild(this.mypoke.display);
         }
         this.pokeid = pid;
      }
      
      public function get pokemonId() : *
      {
         return this.pokeid;
      }
      
      private function pokeEnterFrameHandler(e:Event) : void
      {
         if(this.mypoke.display.width > 5)
         {
            this.mypoke.display.x = this.position_x;
            this.mypoke.display.y = this.position_y;
            this.removeEventListener(Event.ENTER_FRAME,this.pokeEnterFrameHandler);
            this.setEvent();
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function setEvent() : void
      {
         this.mypoke.display.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.mypoke.display.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.mypoke.display.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      private function mouseOverHandler(e:Event) : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
      }
      
      private function mouseOutHandler(e:Event) : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
      }
      
      private function clickHandler(e:Event) : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function unloadSwf() : void
      {
         if(this.mypoke)
         {
            if(this.contains(this.mypoke.display))
            {
               this.removeChild(this.mypoke.display);
            }
            this.mypoke.display.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
            this.mypoke.display.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
            this.mypoke.display.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         }
      }
      
      public function get renderPokemon() : *
      {
         return this.mypoke;
      }
   }
}


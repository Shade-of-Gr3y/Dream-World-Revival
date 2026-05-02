package bfp
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PDWPokemonStatusDisplayObject extends Sprite implements IPDWPokemonStatus
   {
      
      public function PDWPokemonStatusDisplayObject()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         graphics.clear();
         graphics.beginFill(16711680);
         graphics.drawRect(0,0,100,100);
         graphics.endFill();
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      private function removedFromStageHandler(event:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      public function get nickname() : String
      {
         return null;
      }
      
      public function set nickname(value:String) : void
      {
      }
      
      public function get pglNickname() : String
      {
         return null;
      }
      
      public function set pglNickname(value:String) : void
      {
      }
      
      public function get pokemonName() : String
      {
         return null;
      }
      
      public function set pokemonName(value:String) : void
      {
      }
      
      public function get parentName() : String
      {
         return null;
      }
      
      public function set parentName(value:String) : void
      {
      }
      
      public function get level() : int
      {
         return 0;
      }
      
      public function set level(value:int) : void
      {
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function set type(value:String) : void
      {
      }
      
      public function get gender() : int
      {
         return 0;
      }
      
      public function set gender(value:int) : void
      {
      }
      
      public function get personality() : String
      {
         return null;
      }
      
      public function set personality(value:String) : void
      {
      }
      
      public function get monsterball() : String
      {
         return null;
      }
      
      public function set monsterball(value:String) : void
      {
      }
   }
}


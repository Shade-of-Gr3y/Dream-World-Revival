package bfp
{
   import flash.events.IEventDispatcher;
   
   public interface IPDWPokemonStatus extends IEventDispatcher
   {
       
      
      function get nickname() : String;
      
      function set nickname(param1:String) : void;
      
      function get pglNickname() : String;
      
      function set pglNickname(param1:String) : void;
      
      function get pokemonName() : String;
      
      function set pokemonName(param1:String) : void;
      
      function get parentName() : String;
      
      function set parentName(param1:String) : void;
      
      function get level() : int;
      
      function set level(param1:int) : void;
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get gender() : int;
      
      function set gender(param1:int) : void;
      
      function get personality() : String;
      
      function set personality(param1:String) : void;
      
      function get monsterball() : String;
      
      function set monsterball(param1:String) : void;
   }
}

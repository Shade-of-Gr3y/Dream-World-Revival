package bfp.main
{
   import bfp.common.PokemonBridge;
   
   public class CheckUserInformation
   {
      
      public function CheckUserInformation()
      {
         super();
      }
      
      public static function get isName() : Boolean
      {
         var _loc1_:Boolean = false;
         if(PokemonBridge.pgl_name)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public static function get isRom() : Boolean
      {
         var _loc1_:Boolean = false;
         if(PokemonBridge.rom_id)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public static function get isLogin() : Boolean
      {
         var _loc1_:Boolean = false;
         if(PokemonBridge.member_id)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}


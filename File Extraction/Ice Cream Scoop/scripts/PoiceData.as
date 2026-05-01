package
{
   public class PoiceData
   {
      
      private var m_no:int;
      
      private var m_textureFile:String;
      
      private var m_mag:Number;
      
      private var m_type:int;
      
      private var m_fric_top:Number;
      
      private var m_fric_side:Number;
      
      public function PoiceData(param1:int, param2:String)
      {
         super();
         this.m_no = param1;
         this.m_textureFile = param2;
         this.m_type = 0;
         this.m_fric_top = 0.0003;
         this.m_fric_side = 0.0001;
         this.m_mag = 1;
      }
      
      public function set fric_side(param1:Number) : void
      {
         this.m_fric_side = param1;
      }
      
      public function get no() : int
      {
         return this.m_no;
      }
      
      public function set mag(param1:Number) : void
      {
         this.m_mag = param1;
      }
      
      public function get type() : int
      {
         return this.m_type;
      }
      
      public function get fric_side() : Number
      {
         return this.m_fric_side;
      }
      
      public function get mag() : Number
      {
         return this.m_mag;
      }
      
      public function set type(param1:int) : void
      {
         this.m_type = param1;
      }
      
      public function LoadTexture() : LoadSwfMovieClip
      {
         comDefine.DebugPrint("PoiceData loadTex" + comDefine.g_Dir + "poice_tex/" + this.m_textureFile);
         var _loc1_:LoadSwfMovieClip = new LoadSwfMovieClip();
         _loc1_.LoadSwf(comDefine.g_Dir + "poice_tex/" + this.m_textureFile);
         return _loc1_;
      }
      
      public function set fric_top(param1:Number) : void
      {
         this.m_fric_top = param1;
      }
      
      public function get fric_top() : Number
      {
         return this.m_fric_top;
      }
   }
}


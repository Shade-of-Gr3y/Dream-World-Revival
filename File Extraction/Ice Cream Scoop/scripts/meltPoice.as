package
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   
   public class meltPoice extends MovieClip
   {
      
      public var shape:Shape;
      
      public var bSolid:Boolean;
      
      private var m_leng:Number;
      
      private var m_size:Number;
      
      private var m_countMax:Number;
      
      public var pos:Vec2;
      
      private var m_add:Number;
      
      private var m_max:Number;
      
      public var start:Vec2;
      
      private var m_count:Number;
      
      public function meltPoice()
      {
         super();
         this.shape = new Shape();
         this.pos = new Vec2();
         this.pos.x = 0;
         this.pos.y = 0;
         this.bSolid = true;
         addChild(this.shape);
      }
      
      public function move() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         x = Interpolate.GetF(0,this.m_countMax,this.start.x,this.pos.x,0,this.m_count);
         y = Interpolate.GetF(0,this.m_countMax,this.start.y,this.pos.y,0,this.m_count);
         ++this.m_count;
      }
      
      public function create(param1:Number, param2:Number) : void
      {
         this.m_size = param1;
         this.m_max = Math.random() * this.m_size * 0.25;
         this.m_add = this.m_size / 2 + Math.random() * this.m_size / 3;
         this.m_count = 0;
         this.m_countMax = 48 + Math.random() * 64;
         this.m_leng = param2 + this.m_max;
         this.pos.Normalize();
         this.pos.Scale(this.m_leng);
         this.start = new Vec2();
         this.start.Set(this.pos.x,this.pos.y - this.m_add);
         this.start.Normalize();
         this.start.Scale(param2 - this.m_size);
         this.pos.y -= this.pos.x - this.start.x;
         this.pos.x = this.start.x;
         this.shape.graphics.clear();
         this.shape.graphics.beginFill(0);
         this.shape.graphics.drawCircle(0,0,this.m_size);
         this.shape.graphics.endFill();
      }
   }
}


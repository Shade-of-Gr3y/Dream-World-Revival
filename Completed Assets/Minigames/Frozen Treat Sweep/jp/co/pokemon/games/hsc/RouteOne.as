package jp.co.pokemon.games.hsc
{

    public class RouteOne extends Object
    {
        public var ppos:Pos2;
        public var dir4:int;

        public function RouteOne(param1:Pos2, param2:int)
        {
            this.ppos = param1.clone();
            this.dir4 = param2;
            return;
        }// end function

        public function clone() : RouteOne
        {
            return new RouteOne(this.ppos.clone(), this.dir4);
        }// end function

    }
}

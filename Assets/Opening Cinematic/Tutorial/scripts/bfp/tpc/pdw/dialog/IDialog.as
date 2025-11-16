package bfp.tpc.pdw.dialog
{
   public interface IDialog
   {
       
      
      function init() : void;
      
      function release() : void;
      
      function visit() : void;
      
      function away() : void;
   }
}

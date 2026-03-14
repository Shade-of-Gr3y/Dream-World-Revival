package org.libspark.thread
{
   public class ThreadState
   {
      
      public static const NEW:uint = 0;
      
      public static const RUNNABLE:uint = 1;
      
      public static const WAITING:uint = 2;
      
      public static const TIMED_WAITING:uint = 3;
      
      public static const TERMINATING:uint = 4;
      
      public static const TERMINATED:uint = 5;
      
      public function ThreadState()
      {
         super();
      }
   }
}


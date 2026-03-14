package com.google.analytics
{
   import com.google.analytics.utils.Version;
   
   public class API
   {
      
      public static var version:Version = new Version();
      
      version.major = 1;
      version.minor = 0;
      version.build = 1;
      version.revision = "$Rev: 234 $ ".split(" ")[1];
      
      public function API()
      {
         super();
      }
   }
}


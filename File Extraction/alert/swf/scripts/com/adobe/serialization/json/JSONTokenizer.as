package com.adobe.serialization.json
{
   public class JSONTokenizer
   {
      
      private var loc:int;
      
      private var ch:String;
      
      private var obj:Object;
      
      private var jsonString:String;
      
      public function JSONTokenizer(s:String)
      {
         super();
         this.jsonString = s;
         this.loc = 0;
         this.nextChar();
      }
      
      private function skipComments() : void
      {
         if(this.ch == "/")
         {
            this.nextChar();
            switch(this.ch)
            {
               case "/":
                  do
                  {
                     this.nextChar();
                  }
                  while(this.ch != "\n" && this.ch != "");
                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true)
                  {
                     if(this.ch == "*")
                     {
                        this.nextChar();
                        if(this.ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        this.nextChar();
                     }
                     if(this.ch == "")
                     {
                        this.parseError("Multi-line comment not closed");
                     }
                  }
                  this.nextChar();
                  break;
               default:
                  this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private function isDigit(ch:String) : Boolean
      {
         return ch >= "0" && ch <= "9";
      }
      
      private function readString() : JSONToken
      {
         var hexValue:String = null;
         var i:int = 0;
         var token:JSONToken = new JSONToken();
         token.type = JSONTokenType.STRING;
         var string:String = "";
         this.nextChar();
         for(; this.ch != "\"" && this.ch != ""; this.nextChar())
         {
            if(this.ch != "\\")
            {
               string += this.ch;
               continue;
            }
            this.nextChar();
            switch(this.ch)
            {
               case "\"":
                  string += "\"";
                  break;
               case "/":
                  string += "/";
                  break;
               case "\\":
                  string += "\\";
                  break;
               case "b":
                  string += "\b";
                  break;
               case "f":
                  string += "\f";
                  break;
               case "n":
                  string += "\n";
                  break;
               case "r":
                  string += "\r";
                  break;
               case "t":
                  string += "\t";
                  break;
               case "u":
                  hexValue = "";
                  for(i = 0; i < 4; i++)
                  {
                     if(!this.isHexDigit(this.nextChar()))
                     {
                        this.parseError(" Excepted a hex digit, but found: " + this.ch);
                     }
                     hexValue += this.ch;
                  }
                  string += String.fromCharCode(parseInt(hexValue,16));
                  break;
               default:
                  string += "\\" + this.ch;
            }
         }
         if(this.ch == "")
         {
            this.parseError("Unterminated string literal");
         }
         this.nextChar();
         token.value = string;
         return token;
      }
      
      private function nextChar() : String
      {
         return this.ch = this.jsonString.charAt(this.loc++);
      }
      
      public function getNextToken() : JSONToken
      {
         var possibleTrue:String = null;
         var possibleFalse:String = null;
         var possibleNull:String = null;
         var token:JSONToken = new JSONToken();
         this.skipIgnored();
         switch(this.ch)
         {
            case "{":
               token.type = JSONTokenType.LEFT_BRACE;
               token.value = "{";
               this.nextChar();
               break;
            case "}":
               token.type = JSONTokenType.RIGHT_BRACE;
               token.value = "}";
               this.nextChar();
               break;
            case "[":
               token.type = JSONTokenType.LEFT_BRACKET;
               token.value = "[";
               this.nextChar();
               break;
            case "]":
               token.type = JSONTokenType.RIGHT_BRACKET;
               token.value = "]";
               this.nextChar();
               break;
            case ",":
               token.type = JSONTokenType.COMMA;
               token.value = ",";
               this.nextChar();
               break;
            case ":":
               token.type = JSONTokenType.COLON;
               token.value = ":";
               this.nextChar();
               break;
            case "t":
               possibleTrue = "t" + this.nextChar() + this.nextChar() + this.nextChar();
               if(possibleTrue == "true")
               {
                  token.type = JSONTokenType.TRUE;
                  token.value = true;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'true\' but found " + possibleTrue);
               }
               break;
            case "f":
               possibleFalse = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
               if(possibleFalse == "false")
               {
                  token.type = JSONTokenType.FALSE;
                  token.value = false;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'false\' but found " + possibleFalse);
               }
               break;
            case "n":
               possibleNull = "n" + this.nextChar() + this.nextChar() + this.nextChar();
               if(possibleNull == "null")
               {
                  token.type = JSONTokenType.NULL;
                  token.value = null;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'null\' but found " + possibleNull);
               }
               break;
            case "\"":
               token = this.readString();
               break;
            default:
               if(this.isDigit(this.ch) || this.ch == "-")
               {
                  token = this.readNumber();
                  break;
               }
               if(this.ch == "")
               {
                  return null;
               }
               this.parseError("Unexpected " + this.ch + " encountered");
         }
         return token;
      }
      
      private function skipWhite() : void
      {
         while(this.isWhiteSpace(this.ch))
         {
            this.nextChar();
         }
      }
      
      public function parseError(message:String) : void
      {
         throw new JSONParseError(message,this.loc,this.jsonString);
      }
      
      private function isWhiteSpace(ch:String) : Boolean
      {
         return ch == " " || ch == "\t" || ch == "\n" || ch == "\r";
      }
      
      private function skipIgnored() : void
      {
         var originalLoc:int = 0;
         do
         {
            originalLoc = this.loc;
            this.skipWhite();
            this.skipComments();
         }
         while(originalLoc != this.loc);
      }
      
      private function isHexDigit(ch:String) : Boolean
      {
         var uc:String = ch.toUpperCase();
         return this.isDigit(ch) || uc >= "A" && uc <= "F";
      }
      
      private function readNumber() : JSONToken
      {
         var token:JSONToken = new JSONToken();
         token.type = JSONTokenType.NUMBER;
         var input:String = "";
         if(this.ch == "-")
         {
            input += "-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch))
         {
            this.parseError("Expecting a digit");
         }
         if(this.ch == "0")
         {
            input += this.ch;
            this.nextChar();
            if(this.isDigit(this.ch))
            {
               this.parseError("A digit cannot immediately follow 0");
            }
         }
         else
         {
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         if(this.ch == ".")
         {
            input += ".";
            this.nextChar();
            if(!this.isDigit(this.ch))
            {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         if(this.ch == "e" || this.ch == "E")
         {
            input += "e";
            this.nextChar();
            if(this.ch == "+" || this.ch == "-")
            {
               input += this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch))
            {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch))
            {
               input += this.ch;
               this.nextChar();
            }
         }
         var num:Number = Number(input);
         if(isFinite(num) && !isNaN(num))
         {
            token.value = num;
            return token;
         }
         this.parseError("Number " + num + " is not valid!");
         return null;
      }
   }
}


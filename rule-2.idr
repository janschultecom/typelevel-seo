module Main

import Data.List
import Data.HVect
import Helper

allowedChars : List Char
allowedChars = ['a'..'z'] ++ ['0'..'9'] ++ ['-']

data ValidLiteral : List Char -> Type where
  One : { auto prf : Elem value Main.allowedChars } -> ValidLiteral [value]
  Multi : { auto prf : Elem value Main.allowedChars } -> ValidLiteral xs -> ValidLiteral (value :: xs) 

data LiteralRoute : String -> Type where
  Literal : (lit:String) ->
            -- RULE 1  
            { auto prf : ValidLiteral (unpack lit) } -> 
            LiteralRoute lit

-----------------------------------
                    
maxLevel : Nat
maxLevel = 3 

data Base = MkBase    

-- shortRoute : Test Route
-- shortRoute = Check (Root / Literal "two" / Literal "three") -- must compile

-- longRoute : Test Route
-- longRoute = Check (Root / Literal "two" / Literal "three" / Literal "four") -- does not compile


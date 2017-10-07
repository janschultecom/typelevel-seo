module Main

import Data.List
import Data.HVect
import WordsProvider
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
                    
data Base = MkBase    

maxLevel : Nat
maxLevel = 3 

data Route :  List Type -> Type where
  Root : Route [Base]
  (/) : Route parent -> 
        child ->
        -- RULE 2
        { auto prf : LTE (length (child :: parent) ) Main.maxLevel } ->  
        Route (child :: parent)

shortRoute : Test Route
shortRoute = Check (Root / Literal "one" / Literal "two") -- must compile

-- longRoute : Test Route
-- longRoute = Check (Root / Literal "one" / Literal "two" / Literal "three") -- does not compile


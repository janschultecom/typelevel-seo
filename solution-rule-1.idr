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

validLiteral : Test LiteralRoute
validLiteral = Check ( Literal "lambda-world" ) -- must compile

-- emptyLiteral : Test LiteralRoute
-- emptyLiteral = Check ( Literal "") -- does not compile

-- invalidLiteral : Test LiteralRoute
-- invalidLiteral = Check ( Literal "aab-4d-{}" ) -- does not compile

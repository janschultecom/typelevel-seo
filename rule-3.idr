module Main

import Data.List
import Data.HVect
import WordsProvider
import Helper 

%language TypeProviders
%provide (seoWords : List String) with readWords "seo-words.txt"

numberInfixes : String -> Nat
numberInfixes word = length $ filter (\w => isInfixOf w word) seoWords

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

-- seoRoute : Test LiteralRoute
-- seoRoute = Check (Literal "has-category-inside") -- must compile

-- noSeoRoute : Test LiteralRoute
-- noSeoRoute = Check (Literal "no-seo-relevant-word") -- must not compile


-----------------------------------
                    
data Base = MkBase    

maxLevel : Nat
maxLevel = 3 

infixl 9 /
data Route :  List Type -> Type where
  Root : Route [Base]
  (/) : Route parent -> 
        child ->
        -- RULE 2
        { auto prf : LTE (length (child :: parent) ) Main.maxLevel } ->  
        Route (child :: parent)

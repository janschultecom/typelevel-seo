module Main

import Helper 

allowedChars : List Char
allowedChars = ['a'..'z'] ++ ['0'..'9'] ++ ['-']

--data Elem : a -> List a -> Type where
--  Here : Elem x (x :: xs)
--  There : (later : Elem x xs) -> Elem x (y :: xs) 


--validLiteral : Test LiteralRoute
--validLiteral = Check ( Literal "seo-friendly" ) -- must compile

--emptyLiteral : Test LiteralRoute
--emptyLiteral = Check ( Literal "" ) -- must not compile

--invalidLiteral : Test LiteralRoute
--invalidLiteral = Check ( Literal "not-$sEo-{fRi3ndLy}" ) -- must not compile

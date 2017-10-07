module Main

import Data.List
import Data.HVect
import Helper 

allowedChars : List Char
allowedChars = ['a'..'z'] ++ ['0'..'9'] ++ ['-']



-- validLiteral = Check ( Literal "lambda-world" ) -- must compile

-- emptyLiteral : Test LiteralRoute
-- emptyLiteral = Check ( Literal "") -- must not compile

-- invalidLiteral : Test LiteralRoute
-- invalidLiteral = Check ( Literal "aab-4d-{}" ) -- must not compile

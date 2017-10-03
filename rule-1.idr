import Data.List

allowedChars : List Char
allowedChars = ['a'..'z'] ++ ['0'..'9'] ++ ['-','%']

{-data Elem : t -> List t -> Type where
  Here : Elem x (x :: xs)
  There : Elem x xs -> Elem x (y :: xs) -}


cIsAllowed : Elem '%' Main.allowedChars
cIsAllowed = ?cIsAllowed_rhs


data ValidLiteral : List Char -> Type where
  One : { auto prf: Elem c Main.allowedChars } -> ValidLiteral [c]
  Multi : { auto prf: Elem c Main.allowedChars } -> ValidLiteral cs -> ValidLiteral ( c :: cs)

emptyNotAllowed : ValidLiteral ['c','a','$']
emptyNotAllowed = Multi (Multi One) 



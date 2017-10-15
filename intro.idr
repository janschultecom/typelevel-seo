import Data.Vect

--data Option t = Some t | None 
data Option : (t:Type) -> Type where 
  Some : (value:t) -> Option t 
  None : Option t 

add : Int -> Int -> Int
add x y = x + y

StringOrNat : Nat -> Type
StringOrNat Z = String
StringOrNat (S K) = Nat

divide : (x:Nat) -> (y:Nat) -> StringOrNat y
divide x Z = "Divisor was 0" 
divide x y @ (S k) = div x y


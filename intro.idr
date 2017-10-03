import Data.Vect

StringOrNat : Nat -> Type
StringOrNat Z = String
StringOrNat (S K) = Nat

divide : (x:Nat) -> (y:Nat) -> StringOrNat y
divide x Z = "Divisor was 0" 
divide x y @ (S k) = div x y


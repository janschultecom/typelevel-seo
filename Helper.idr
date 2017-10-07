module Test

public export
data Test : (f : a -> Type) -> Type where
  Check : { F : x -> Type } -> { t : x } -> ( value : F t) -> Test F

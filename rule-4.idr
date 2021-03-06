module Main

import Data.List
import Data.HVect
import WordsProvider
import Helper 

%language TypeProviders
%provide (seoWords : List String) with readWords "seo-words.txt"

numberInfixes : String -> Nat

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

infixl 9 /
data Route :  List Type -> Type where
  Root : Route [Base]
  (/) : Route parent -> 
        child ->
        -- RULE 2
        { auto prf : LTE (length (child :: parent) ) Main.maxLevel } ->  
        Route (child :: parent)

--------------------------------------

data HttpMethod = HttpGet | HttpPost

HttpHandler : Type 
HttpHandler = String -> String 

RouteHandler : (route:List Type) -> Type
RouteHandler r = (HttpMethod, Route r, HttpHandler)

GET : Route r -> HttpHandler -> RouteHandler r 
GET route handler = (HttpGet, route, handler) 

handler : HttpHandler
handler = id

sampleRoute : Test RouteHandler 
sampleRoute = Check $ GET (Root / Literal "category") handler

---------------------------------------

infixl 8 &
data RoutesConfiguration : List (List Type) -> Type where
  Routes : (root: RouteHandler [Base]) -> RoutesConfiguration [[Base]]
  (&) : RoutesConfiguration routes -> 
        RouteHandler (child :: parent)  ->
        -- RULE 3
        { auto prf : Elem parent routes } ->  
        RoutesConfiguration ( (child :: parent) :: routes) 

validConfiguration : Test RoutesConfiguration
validConfiguration = Check $ Routes 
           ( GET  Root handler ) &      
            ( GET (Root / Literal "category") handler) & 
            ( GET (Root / Literal "category" / Literal "sports-bar") handler ) -- must compile
          
invalidConfiguration : Test RoutesConfiguration
--invalidConfiguration = Check $ Routes 
--            ( GET  Root handler ) &      
--            ( GET (Root / Literal "category" / Literal "sports-bar") handler ) -- does not compile


module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--parte 1
--1
data Persona = Persona{
    edad::Number,
    items::[String],
    xp::Number
}deriving Show

data Criatura = Criatura{
    peligrosidad::Number,
    deshacer::Persona->Bool
}deriving Show

siempredetras = Criatura 0 (\x->False)
gnomos cant = Criatura (2**cant) (elem ("soplador de hojas") . items)
fantasma categoria asunto = Criatura (20*categoria) asunto

pepe = Persona 25 ["soplador de hojas","faca"] 10

--2
enfrentarCriatura criatura persona
    |(deshacer criatura) persona = persona{xp=xp persona + peligrosidad criatura}
    |otherwise = persona{xp=xp persona + 1}

--3
--a
enfrentarCriaturas criaturas persona = foldr (enfrentarCriatura) persona criaturas

--b
{-?????????????-}

--parte 2
--1
zipWithIf _ _ _ [] =[]
zipWithIf _ _ [] _ =[]
zipWithIf f condicion (m:ms) (l:ls)
    |(not.condicion) l = l:(zipWithIf f condicion (m:ms) ls)
    |otherwise = (f m l) : (zipWithIf f condicion ms ls)


--2
--a
abecedarioDesde letra =init ([letra..'z']++['a'..letra])

--b
desencriptarLetra clave letra = ['a'..'z'] !! (length  (takeWhile (/=letra) (abecedarioDesde clave)))

--c
cesar clave texto = zipWithIf (desencriptarLetra) (flip elem ['a'..'z']) (repeat clave) texto

--d
todaPosibleDesencript texto = map (flip cesar texto) ['a'..'z']

--3

vigenere claves texto = zipWithIf (desencriptarLetra) (flip elem ['a'..'z']) clavesFinal texto
    where clavesFinal = (foldl1 (++) (replicate (div (length texto) (length claves))  claves))


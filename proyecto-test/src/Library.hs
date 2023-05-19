module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

funcionLoca = (/=0).length

mayor x y
    | x > y = x
    | otherwise = y
    
bisiesto anio = esMultiploDe 400 anio || (not (esMultiploDe 100 anio) && esMultiploDe 4 anio)

esMultiploDe x y = mod y x == 0
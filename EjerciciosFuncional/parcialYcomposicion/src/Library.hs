module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Aplicacion Parcial
--Ejercicio 1
siguiente = (1 + )

--Ejercicio 2
mitad x = x/2

--Ejercicio 3
inversa = (/) 1

--Ejercicio 4
triple = (3 *)

--Ejercicio 5
esNumeroPositivo = (0 <)

--Composición
--Ejercicio 6
esMultiploDe x y = ((==0). mod x) y

--Ejercicio 7
esBisiesto anio = esMultiploDe anio 400|| ((not.esMultiploDe anio) 100 && esMultiploDe anio 4)

--Ejercicio 8
inversaRaizQuadrada = (inversa.sqrt)

--Ejercicio 9
incrementMCuadradoN n m = ((+ m).( ^2)) n

--Ejercicio 10
esResultadoPar n m = (even.( ^m)) n
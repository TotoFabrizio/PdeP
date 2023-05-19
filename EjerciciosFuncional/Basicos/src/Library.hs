module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Ejercicio 1

esMultiploDeTres = (==0).(`mod`3)

--Ejercicio 2

esMultiploDe x y = (mod x y) == 0

--Ejercicio 3

cubo x = x^3

--Ejercicio 4

area x y = x*y

--Ejercicio 5

esBisiesto anio = esMultiploDe anio 400|| (not (esMultiploDe anio 100) && esMultiploDe anio 4)

--Ejercicio 6

celsiusToFahr c = 32 + 9/5 * c

--Ejercicio 7

fahrToCelsius f = (f-32)*5/9

--Ejercicio 8

haceFrioF f = (fahrToCelsius f )< 8 

--Ejercicio 9

mcm a b = (a*b)/ gcd a b

--Ejercicio 10

dispersion a b c = max (max a b) c - min (min a b) c

diasParejos a b c = dispersion a b c < 30

diasLocos a b c = (dispersion a b c )> 100

diasNormales a b c = not( diasLocos a b c ) && not (diasParejos a b c)

--Ejercicio 11

pesoPino h = (min 300 h) *3 + (max 0 (h-300))*2

esPesoUtil p = (400 < p) && (p < 1000)

sirvePino h = esPesoUtil (pesoPino h)

--Ejercicio 12
cuadradoPerfecto x y
    | x == (y^2) = True
    | x > (y^2) = cuadradoPerfecto x (y+1)
    |otherwise = False

esCuadradoPerfecto  = (`cuadradoPerfecto` 0)
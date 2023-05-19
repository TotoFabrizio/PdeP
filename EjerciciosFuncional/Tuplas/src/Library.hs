module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

triple numero = numero*3

--Tuplas
--Ejercicio 1

fst3 (a,_,_) = a
snd3 (_,a,_) = a
trd3 (_,_,a) = a

--Ejercicio 2

aplicar (x,y) z = (x z, y z)

--Ejercicio 3

cuentaBizarra (x,y)
    | x>y = x+y
    | x<y && y-x>10 = y-x
    | otherwise = x*y 

--Ejercicio 4

esNotaBochazo = (>) 6

aprobo (x,y) = (not.esNotaBochazo) x && (not.esNotaBochazo) y

promocion (x,y) = (x+y) >= 15 && x>=7 && y>=7

aproboPrimerParcial (x,y) = (not.esNotaBochazo) x

--Ejercicio 5


notasFinales nota = (max ((fst.fst) nota) ((fst.snd) nota),max ((snd.fst) nota) ((snd.snd) nota))

recursa = not.aprobo.notasFinales

recuperoPrimer = aproboPrimerParcial.snd

recuperoAlgunParcial nota = (fst.snd) nota /= -1 || (snd.snd) nota /= -1

recuperoDeGusto nota = (promocion.fst) nota && recuperoAlgunParcial nota

--Ejercicio 6

esMayorDeEdad  = (>21).snd  

--Ejercicio 7

calcular numeros
    | (even.fst) numeros && (odd.snd) numeros = (((*2).fst) numeros,((+1).snd) numeros)
    | (even.fst) numeros && (not.odd.snd) numeros = (((*2).fst) numeros,snd numeros)
    | (not.even.fst) numeros && (odd.snd) numeros = (fst numeros,((+1).snd) numeros)
    | (not.even.fst) numeros && (not.odd.snd) numeros = (fst numeros,snd numeros)

module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Listas
--Ejercicio 1
suma [] = 0
suma (x:xs) =  x + suma(xs)

--Ejercicio 2
frecuenciaCardiaca = [80, 100, 120, 128, 130, 123, 125] 

promedioFrecuenciaCardiaca = suma frecuenciaCardiaca / length frecuenciaCardiaca

frecuenciaCardiacaMinuto m = frecuenciaCardiaca !! (m/10)

frecuenciaHastaMomento m = take (m/10+1) frecuenciaCardiaca

--Ejercicio 3
esCapicua lista = concat lista == (reverse.concat) lista

--Ejercicio 4
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))

cuandoHabloMasMinutos
    |(suma.snd.fst) duracionLlamadas > (suma.snd.snd) duracionLlamadas = (fst.fst) duracionLlamadas
    |otherwise = (fst.snd) duracionLlamadas

cuandoHizoMasLlamadas
    |(length.snd.fst) duracionLlamadas > (length.snd.snd) duracionLlamadas = (fst.fst) duracionLlamadas
    |otherwise = (fst.snd) duracionLlamadas


--Orden Superior
--Ejercicio 1
existsAny f (x,y,z) = f x || f y || f z

--Ejercicio 2
mejor f g x = max (f x) (g x)

--Ejercicio 3
aplicarPar f (x,y) = (f x, f y)

--Ejercicio 4
parDeFns f g x = (f x, g x)

--Orden superior + Listas
--Ejercicio 1

esMultiploDeAlguno n = any ((==0).mod n)

--Ejercicio 2
promedios [] = []
promedios (x:xs) = sum(x)/length x : promedios(xs)

--Ejercicio 3
promediosSinAplazos x = filter (4<) (promedios x)

--Ejercicio 4
mejoresNotas [] =[]
mejoresNotas (x:xs) = maximum x : mejoresNotas xs

--Ejercicio 5
aprobo = all (6<=)

--Ejercicio 6
aprobaron = filter aprobo

--Ejercicio 7
divisores n = filter ((==0).mod n) [1..n]

--Ejercicio 8
exists _ []=False
exists f (x:xs) = f x || exists f xs

--Ejercicio 9
hayAlgunNegativo l = any (0>) l

--Ejercicio 10
aplicarFunciones::[t->a]->t->[a]
aplicarFunciones [] _ = []
aplicarFunciones l n = head l n : (aplicarFunciones (tail l) n)

--Ejercicio 11
sumaF l n = foldr (+) 0 (aplicarFunciones l n)

--Ejercicio 12
subirHabilidad _ [] = []
subirHabilidad n (x:xs)
    |n + x >= 12 = 12 : subirHabilidad n xs
    |otherwise = (n+x) : subirHabilidad n xs

--Ejercicio 13
flimitada f n
    |f n >= 12 =12
    |f n <= 0 = 0
    |otherwise = f n

--a
cambiarHabilidad _ [] = []
cambiarHabilidad f (x:xs) = flimitada f x : cambiarHabilidad f xs

--b cambiarHabilidad (+4) (cambiarHabilidad (+(-4)) [2,4,5,3,8]) 

--Ejercicio 14 takeWhile :: (a -> Bool) -> [a] -> [a] se queda todos los valores de la lista hasta que la funcion da false

--Ejercicio 15
primerosPares = takeWhile even
primerosDivisores n = takeWhile ((==0).mod n)
primerosNoDivisores n = takeWhile ((/=0).mod n)

--Ejercicio 16
huboMesMejorDe [] [] _ = False
huboMesMejorDe (i:is) (e:es) n = i-e >n || huboMesMejorDe is es n

--Ejercicio 17
--a
crecimienetoAnual edad
    |elem edad [1..10] = 24- (edad*2)
    |elem edad [11..15] = 4
    |elem edad [16,17] = 2
    |elem edad [18,19] = 1
    |otherwise = 0

--b
crecimientoEntreEdades edad1 edad2 = (sum.map (crecimienetoAnual))   [edad1..(edad2-1)]

--c
alturasEnUnAnio edad = map (+ crecimienetoAnual edad)

--d
alturaEnEdades altura edad lista = map ((+ altura).crecimientoEntreEdades edad) lista

--Ejercicio 18
lluviasEnero = [0,2,5,1,34,2,0,21,0,0,0,0,0,5,9,18,4,0]
rachasLluvia [] = []
rachasLluvia lluvias = filter (not.null) ((fst.rachasAux) lluvias : (rachasLluvia.snd.splitAt ((snd.rachasAux) lluvias)) lluvias)
rachasAux l = (takeWhile (/=0) (dropWhile (==0) l),length l - (length (dropWhile (/=0) (dropWhile (==0) l))))
--[[2,5,1,34,2],[21],[5,9,18,4]]
mayorRachaDeLluvias lluvias = (maximum.map length) (rachasLluvia lluvias)

--Ejercicio 19
sumaL = foldl (+) 0

--Ejercicio 20
productoria = foldl (*) 1

--Ejercicio 21
dispersion lista = foldr1 (max) lista - foldr1 (min) lista 
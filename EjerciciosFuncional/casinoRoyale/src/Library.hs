module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

palos = ["Corazones", "Picas", "Tréboles", "Diamantes"]
type Carta = (Number,String)

data Jugador = Jugador{
    nombre::String,
    mano::[Carta],
    bebida::String
}deriving Show

pokerDeAses    = [(1,"Corazones"), (1,"Picas"), (1,"Tréboles"), (1,"Diamantes"), (10,"Diamantes")]
fullDeJokers   = [(11,"Corazones"), (11,"Picas"), (11,"Tréboles"), (10,"Diamantes"), (10,"Picas")]
piernaDeNueves = [(9,"Corazones"), (9,"Picas"), (9,"Tréboles"), (10,"Diamantes"), (4,"Copas")]

jamesBond = Jugador "Bond... James Bond" pokerDeAses "Martini... shaken, not stirred"
leChiffre = Jugador "Le Chiffre" fullDeJokers "Gin"
felixLeiter = Jugador "Felix Leiter" piernaDeNueves "Whisky"

mesaQueMasAplauda = [jamesBond, leChiffre, felixLeiter]

ocurrenciasDe x = length . filter (== x)
concatenar = foldl (++) []


--1
--a
mayorSegun f x y
    |f x > f y = x
    |otherwise = y

--b
maximoSegun f = foldl1 (mayorSegun f) 

--c
sinRepetidos [] = []
sinRepetidos (x:xs) = x : (sinRepetidos.filter (/=x) $ xs)

--2
--a
esoNoSeVale (num, palo) = not (elem num [1..13] && elem palo palos)

--b
manoNegra jugador = ((/=5).length.mano $ jugador) || any esoNoSeVale (mano jugador)

--3

aparece n mano = any ((==n).flip ocurrenciasDe (map fst mano)) [1..13]

--a
par = aparece 2
--b
pierna = aparece 3
--c
color::[Carta]->Bool
color mano = any ((==5).flip ocurrenciasDe (map snd mano)) palos
--d
fullHouse mano = par mano && pierna mano
--e
poker = aparece 4
--f
otro _ = True

--4
alguienSeCarteo mesa = cartas /= sinRepetidos cartas
    where cartas = concat.map mano $ mesa

--5
--a
valores = [(par,1), (pierna,2), (color,3), (fullHouse,4), (poker,5), (otro, 0)]

valor mano = snd.maximoSegun snd . filter (($ mano).fst) $ valores

--b
bebidaWinner = bebida.maximoSegun (valor.mano) . filter (not.manoNegra)

--6
--a >nombre.maximoSegun (length.bebida) $ mesaQueMasAplauda
--b >nombre.maximoSegun (length .filter esoNoSeVale . mano) $ mesaQueMasAplauda
--c >nombre.maximoSegun ((*(-1)). length . nombre) $ mesaQueMasAplauda
--d >nombre.maximoSegun (valor.mano) $ mesaQueMasAplauda

--7
--a
ordenar _ [] = []
ordenar criterio (x:xs) = ordenar criterio adelante ++ [x] ++ ordenar criterio atras
    where adelante = filter (not.criterio x) xs
          atras = filter (criterio x) xs

--b
--i
escalera mano = ordenadas == [head ordenadas ... head ordenadas+4]
    where ordenadas = ordenar (<) . map fst $ mano

--ii
escaleraDeColor mano = escalera mano && (color mano)
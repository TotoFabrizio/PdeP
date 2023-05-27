module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--data Ubicacion = Intersección calle1 calle2 | Altura calle número
data Ubicacion = Interseccion String String | Altura String Number deriving (Show, Eq)

data Persona = Persona {
    edad :: Number,
    tiempoLibre :: Number,
    dineroEncima :: Number
} deriving Show
huberto = Persona 42 10 10.2
leto = Persona 32 20 20

--colectivos = [(línea, paradas)]
colectivos :: [(Number, [Ubicacion])]
colectivos = [(14,[Interseccion "Salguero" "Lavalle", Interseccion "Salguero" "Potosi",
    Interseccion "Bulnes" "Potosi", Altura "Bulnes" 1200]), 
    (168,[Altura "Corrientes" 100, Altura "Corrientes" 300, Altura "Corrientes" 500, 
    Altura "Corrientes" 700])]

data Huber = Huber {
    origen :: Ubicacion,
    destino :: Ubicacion,
    importe :: Number
} deriving Show

hubers :: [Huber]
hubers = [Huber (Interseccion "Salguero" "Lavalle") (Interseccion "Bulnes" "Potosi") 5,
         Huber (Altura "Av Corrientes" 700) (Interseccion "Sarmiento" "Gallo") 10,
        Huber (Interseccion "Salguero" "Potosi") (Altura "Ecuador" 600) 20,
        Huber (Altura "Corrientes" 300) (Altura "Corrientes" 700) 5,
        Huber (Interseccion "Salguero" "Lavalle") (Altura "Bulnes" 1200) 5]

ubicaciones :: [Ubicacion]
ubicaciones = [ubicacion1, Interseccion "Salguero" "Potosi",
    ubicacion2, Interseccion "Sarmiento" "Gallo",
    Altura "Ecuador" 600, Altura "Corrientes" 100, Altura "Corrientes" 300, 
    Altura "Corrientes" 500, Altura "Corrientes" 700,ubicacion3]

ubicacion1 = Interseccion "Salguero" "Lavalle" 
ubicacion2 = Interseccion "Bulnes" "Potosi"
ubicacion3 = Altura "Bulnes" 1200

estanOrdenadas u1 u2 lista = indexOf u1 lista < indexOf u2 lista

indexOf e lista = recIndexOf 1 e lista 

recIndexOf _ _ [] = 0 -- es feo :)
recIndexOf index e (x:xs)
    | e==x = index
    | otherwise = recIndexOf (index+1) e xs

--1
importeEnHuber ub1 ub2
    |any (viajaA) hubers = importe . head $ filter (viajaA) hubers
    |otherwise = 0
    where viajaA huber = ub1 == origen huber && ub2 == destino huber
    
--2
sePuedeIrEnBondi ub1 ub2 = any (realizaViajeBondi ub1 ub2) colectivos

realizaViajeBondi ub1 ub2 = estanOrdenadas ub1 ub2 . snd
--3
masBaratasQueHuber ub1 ub2= map fst . filter condicion $ colectivos
    where condicion colectivo = realizaViajeBondi ub1 ub2 colectivo && importeEnColectivo ub1 ub2 colectivo < limite
          limite = importeEnHuber ub1 ub2

importeEnColectivo ub1 ub2 colectivo = (2*) . cantParadasEntre ub1 ub2 . snd $ colectivo

cantParadasEntre ub1 ub2 ubicaciones = length . tail . dropWhileEnd (/=ub2) . dropWhile (/=ub1) $ ubicaciones

dropWhileEnd condicion = reverse . dropWhile condicion . reverse
--4a

distanciaEntre ub1 ub2 ubicaciones = cantParadasEntre ub1 ub2 ubicaciones * 4

--5
puedeIrCaminando persona ub1 ub2 = (edad persona < 35 && tiempoLibre persona > 30) || distanciaEntre ub1 ub2 ubicaciones < 20

--6a

maximoSegun condicion = foldl1 (mayorSegun condicion)

mayorSegun f a b  
    | f a > f b = a
    | otherwise = b

--b i maximoSegun (((-1)*).importe) hubers

--7
encuentroPosible (p1,u1) (p2,u2) = sePuedeIrEnBondi u1 u2 || sePuedeIrEnBondi u2 u1 || puedeIrCaminando p1 u1 u2 || puedeIrCaminando p2 u2 u1 
    || (importeEnHuber u1 u2 >0 && importeEnHuber u1 u2 <= dineroEncima p1) ||(importeEnHuber u2 u1 >0 && importeEnHuber u2 u1 <= dineroEncima p2)

--8 funcionLoca a f m b = (m <) . head $ [uncurry b t | t <- zip a f]
{- funcionLoca :: Ord m => a -> f -> m -> ((a,f) -> [m] -> bool)-}
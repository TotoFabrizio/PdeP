module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Auto = Auto {
    color::String,
    velocidad::Number,
    distancia::Number
}deriving (Show,Eq)

type Carrera = [Auto]

{-instance Eq Auto where
    (==) a1 a2 = color a1 == color a2
-}
auto1 = Auto "Rojo" 120 45
auto2 = Auto "Negro" 100 35
auto3 = Auto "Verde" 150 40
auto4 = Auto "Rosa" 200 20

--1
--a
estaCerca auto1 auto2 = color auto1 /= color auto2 && abs (distancia auto1 - distancia auto2)  < 10

--b
mayorSegun f a b
    |f a > f b = a
    |otherwise = b

maximoSegun f = foldl1 (mayorSegun f)

vaTranquilo::Carrera->Auto->Bool
vaTranquilo carrera auto = not (any (estaCerca auto) carrera) && (maximoSegun distancia carrera) == auto

--c
puesto carrera auto = length $ filter (not.vaGanando auto) carrera

vaGanando auto1 auto2 = distancia auto1 > distancia auto2

--2
--a
corra auto tiempo = auto{distancia= (+distancia auto).(*tiempo).velocidad $ auto}

--b
--i
alterarVelocidad auto modificador = auto{velocidad = modificador (velocidad auto)}

--ii
bajarVelocidad cant auto = alterarVelocidad auto reduccion
    where reduccion velocidad = max 0 (velocidad-cant)

--3
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

--a
terremoto auto carrera = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad 50) carrera

--b
miguelitos cant auto carrera = afectarALosQueCumplen (vaGanando auto) (bajarVelocidad cant) carrera

--c
jetPack tiempo auto carrera = afectarALosQueCumplen (==auto) jet carrera
    where jet auto = alterarVelocidad (corra (alterarVelocidad auto (2*)) tiempo) (/2)

--4
type Eventos = [Carrera->Carrera]

--a
simularCarrera carrera eventos = zip (map (puesto luegoEventos) luegoEventos) (map color luegoEventos)
    where luegoEventos = foldl1 (.) eventos carrera

simularCarrera' carrera eventos = foldr1 (.) eventos carrera

--b
--i
correnTodos tiempo carrera = map (flip corra tiempo) carrera

--ii

usaPowerUp colorA powerUp carrera = powerUp autoSegunColor carrera
    where autoSegunColor = head (filter ((==colorA).color) carrera)

--c

auto5 = Auto "Rojo" 120 0
auto6 = Auto "Blanco" 120 0
auto7 = Auto "Azul" 120 0
auto8 = Auto "Negro" 120 0

eventos = [correnTodos 30,usaPowerUp "Azul" (jetPack 3), usaPowerUp "Blanco" terremoto, correnTodos 40, usaPowerUp "Blanco" (miguelitos 20),usaPowerUp "Negro" (jetPack 6),correnTodos 10 ]

carrera = [auto5,auto6,auto7,auto8]
module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--1
data Guantelete = Guantelete {
    material::String,
    gemas::[Gema]
}

data Personaje = Personaje {
    edad::Number,
    energia::Number,
    habilidades::[String],
    nombre::String,
    planeta::String
}deriving (Show,Eq)

type Universo = [Personaje]
ironMan = Personaje 30 100 ["Volar", "Millonario"] "Tony Stark" "Tierra"
drStrange = Personaje 58 41 ["Volar","Controlar el tiempo"] "Steven Strange" "Tierra"

universo1 = [ironMan,drStrange]

chasquido guantelete universo
    |((=="uru").material) guantelete  && ((6==).length.gemas) guantelete= take (div (length universo) 2) universo
    |otherwise = universo
--2

aptoPendex = any ((<45).edad) 

energiaTotal = sum.map energia .filter((1<).length.habilidades)

--3
type Gema = Personaje->Personaje

mente = quitarEnergia 

quitarEnergia valor personaje = personaje{energia = energia personaje - valor}

alma habilidad = quitarHabilidad habilidad . quitarEnergia 10

quitarHabilidad habilidad personaje = personaje{habilidades = filter (/=habilidad) (habilidades personaje)}

espacio planetaTp personaje= quitarEnergia 20 personaje {planeta = planetaTp}

poder personaje = atacarHabilidades personaje {energia = 0}

atacarHabilidades personaje
    |(<=2).length.habilidades $ personaje = personaje{habilidades = []}
    |otherwise = personaje

tiempo personaje = quitarEnergia 50 personaje {edad = max 18 (div (edad personaje) 2)}

gemaLoca gema = gema.gema

--4
guanteleteGoma = Guantelete "Goma" [tiempo,alma "usar Mjolnir", gemaLoca (alma "programación en Haskell")]

--5
utilizar gemas = foldl1 (.) gemas

--6
gemaMasPoderosa personaje guantelete = gemaMasPoderosaDe (gemas guantelete) personaje

gemaMasPoderosaDe [gema] _ = "Pepe"
gemaMasPoderosaDe (g:f:gs) personaje
    |(energia.g) personaje < (energia.f) personaje = gemaMasPoderosaDe (g:gs) personaje
    |otherwise = gemaMasPoderosaDe (f:gs) personaje

--7

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas tiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

{-
gemaMasPoderosa punisher guanteleteDeLocos
esta funcion se puede ejecutar, pero su ejecución no terminaria ya que, como la lista de gemas es infinita nunca podra llegar a la condición de finalzación
de la funcion gemaMasPoderosaDe
-}

{-
usoLasTresPrimerasGemas guanteleteDeLocos punisher
esta funcion se puede ejecutar y su ejecución termina ya que de la lista infinitas de gemas solo toma las tres primeras por lazy evaluation
-}
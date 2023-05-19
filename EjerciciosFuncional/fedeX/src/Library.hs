module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Envio = Envio {
    origen:: Locacion,
    destino:: Locacion,
    peso:: Number,
    precioBase:: Number,
    categorias:: [Categoria],
    impuestos:: [Impuesto]
} deriving (Show, Eq)

data Locacion = Locacion{
    ciudad:: String,
    pais:: String
} deriving (Show, Eq)

type Categoria = String

type Cargo = Envio -> Number

type Impuesto = Envio -> Number


agregarCargo condicion monto envio
    |condicion envio = monto
    |otherwise = 0

--categorias
cargoCategoria categoria porcentaje envio = agregarCargo (elem categoria .categorias) (precioBase envio*porcentaje/100) envio
cargoTecnologia = cargoCategoria "tecnología" 18

cargoSobrepeso pesoLimite envio = agregarCargo ((<) pesoLimite .peso) ((peso envio - pesoLimite) * 80) envio

cargoArbitrario envio = agregarCargo (\x->True) 50 envio
--impuestos
iva envio = agregarCargo (\x -> True) (precioBase envio * 20/100) envio

multicategoria envio = agregarCargo ((3<).length.categorias) (precioBase envio * 1/100) 

aduanero envio = agregarCargo ((=="internacional").localOInter) (precioBase envio * 3/100) envio

impuestoExtranio envio = agregarCargo (even.precioBase) (precioBase envio * 10/100) envio

--Envios de ejemplo
envio1 = Envio (Locacion "Pilar" "Argentina") (Locacion "varela" "Argentina") 10 500 ["tecnología"] [iva]

envioBS = Envio (Locacion "Buenos Aires" "Argentina") (Locacion "Utrecht" "Países Bajos") 2 220 ["música","tecnología"] []
envioCal = Envio (Locacion "California" "Estados Unidos") (Locacion "Miami" "Estados Unidos") 5 1500 ["libros"] [iva,impuestoExtranio]

--3.a
cuestaMas n = (n<).precioBase
--3.b
esBarato = not.cuestaMas 1300

--4
--a
seDirigeA paisDestino = ((==)paisDestino).pais.destino

--b
localOInter envio
    |(pais.origen $ envio) == (pais.destino $ envio) = "local"
    |otherwise = "internacional"

--5
categorisar::[Envio]->[Categoria]->[Envio]
categorisar _ [] = []
categorisar [] _ = []
categorisar (e:es) listaCat 
    |all (flip elem (categorias e)) listaCat = e : categorisar es listaCat
    |otherwise = categorisar es listaCat

--categorisar' envios listaCat = flip all listaCat (flip elem (categorias envios))
--6

precioTotal envio cargos =  envio{precioBase = precioBase envio + cargo + sum(map ($ envio{precioBase = precioBase envio + cargo}) (impuestos envio))}
    where cargo = sum (map ($ envio) cargos)

--7
{-
maximo f g envio
    |(precioBase.f) envio > (precioBase.g) envio = f
    |otherwise = g
maximoSegun envio (f:g:fs) = maximo (maximo f g envio) (head fs)
-}
--otra opcion
--maximoS envio cargos = maximum ( map (precioBase) (map (($ envio)) cargos))

maximoS envio cargos = (zip cargos (map ($ envio) cargos))
module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero


--1
--a
type Recurso = String

data Pais = Pais{
    ingresoPerCapita::Number,
    activosPubicos::Number,
    acrivosPrivados::Number,
    recursos::[Recurso],
    deudaFmi::Number
} deriving Show

--b
namibia = Pais 4140 400000 650000 ["mineria", "ecoturismo"] 50

--2

type Estrategia = Pais -> Pais

prestarMillones n pais = pais{deudaFmi = deudaFmi pais + n * 1.5}

reducirPerCapita n pais = pais{ingresoPerCapita = ingresoPerCapita pais * n}

reducirSectorPublico n pais 
    |n>100 = reducirPerCapita 0.8 pais{activosPubicos = activosPubicos pais - n}
    |otherwise = reducirPerCapita 0.5 pais{activosPubicos = activosPubicos pais - n}

explotacionRecurso recurso  pais= pais{recursos = filter (/= recurso) $ recursos pais , deudaFmi = deudaFmi pais - 2 }

blindaje pais =  (reducirSectorPublico 500 . prestarMillones (pbi pais/2)) pais

pbi pais = ingresoPerCapita pais * (acrivosPrivados pais + activosPubicos pais)

--3
--a
type Receta = [Estrategia]

receta = [prestarMillones 200,explotacionRecurso "mineria"]

--b
aplicarReceta receta  = foldl1 (.) receta
-- ?> aplicarReceta receta namibia

--4
--a
venezuela = Pais 100 500000 800000 ["Petróleo","Turismo"] 500

puedenZafar = filter (elem "Petróleo" . recursos)

--b
totalDeuda paises = sum $ map deudaFmi paises

--5
recetasOrdenadas recetas pais = estanOrdenados pbiPaisModificado
     where pbiPaisModificado = (map pbi . map (flip aplicarReceta pais)) recetas

estanOrdenados [] = True
estanOrdenados (l:ls)
    |l == minimum (l:ls) = estanOrdenados ls
    |otherwise = False
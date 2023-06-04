module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Turista = Turista{
    cansancio::Number,
    stress::Number,
    solo::Bool,
    idiomas::[String]
} deriving Show

irPlaya turista
    |solo turista = turista{cansancio= max 0 (cansancio turista - 5)}
    |otherwise = turista{stress= max 0 (stress turista - 1)}

apreciarPaisaje elemento turista = turista{stress = max 0 (stress turista - length elemento)}

salirHablarIdioma idioma turista
    |elem idioma $ idiomas turista = turista{solo=False}
    |otherwise = turista{idiomas = idioma: idiomas turista,solo=False}

caminar minutos turista = turista{cansancio = cansancio turista + intensidad,stress = stress turista - intensidad}
    where intensidad = div minutos 4

paseoBarco marea turista
    |marea == "fuerte" = turista{cansancio = cansancio turista + 10,stress = stress turista + 6}
    |marea == "moderada" = turista
    |marea == "tranquila" = salirHablarIdioma "aleman" . apreciarPaisaje "mar" . caminar 10 $ turista

ana = Turista 0 21 False ["español"]
beto = Turista 15 15 True ["aleman"]
cathi = Turista 15 15 True ["aleman","catalán"]

--2
--a
hacerExcursion excursion turista = (postStress){stress = stress (postStress) - round( stress (postStress)*0.1)}
    where postStress = excursion turista

--b
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun indice turista excursion = deltaSegun indice (hacerExcursion excursion turista) turista

--c
esEducativa turista = (>= 1).deltaExcursionSegun (length.idiomas) turista 

esDesestresante turista = (<=(-3)).deltaExcursionSegun stress turista
sonDesestresantes turista = map (esDesestresante turista)

--3

completo = [salirHablarIdioma "melmacquiano",irPlaya,caminar 40,apreciarPaisaje "cascada",caminar 20]
ladoB excursion = [caminar 120,excursion,paseoBarco "tranquila"]
islaVecina marea
    |marea == "fuerte" = [paseoBarco marea,apreciarPaisaje "algo",paseoBarco marea]
    |otherwise = [paseoBarco marea,irPlaya,paseoBarco marea]

probarTour = [apreciarPaisaje "olas"]

--a
hacerTour tour turista = foldl1 (.) tour $ turista{stress = stress turista + length tour}

--b
esConvincente turista excursion = esDesestresante turista excursion && (not.solo.excursion) turista

tourConvincente turista tour = any (esConvincente turista) tour

algunoConvincente turista tours = any (tourConvincente turista) tours

--c
espiritualidad tour turista = deltaSegun stress (hacerTour tour turista) turista + deltaSegun cansancio (hacerTour tour turista) turista
efectividad tour turistas = sum . map (espiritualidad tour) . filter (flip tourConvincente tour)
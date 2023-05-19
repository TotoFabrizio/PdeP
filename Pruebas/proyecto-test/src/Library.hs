module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Persona = Persona {
    nombre::String,
    nivelResistencia::Number,
    habilidades::[String],
    amigos::[Persona]
} deriving Show

data Amenaza = Amenaza{
    objetivo::String,
    nivelPoder::Number,
    debilidades::[String]
}deriving Show

type Ciudad = (String, Number)

bombon = Persona "Bombon" 55 ["escuchar canciones de Luciano Pereyra", "Dar golpes fuertes"] ["señor cerdo", "Silicio"]
mojoJojo = Amenaza "Destruir a las chicas superpoderosas" 70 ["velocidad","super fuerza"]

danioPotencial amenaza = nivelPoder amenaza - ((3*).length.debilidades) amenaza

puedeAtacarCiudad ciudad amenaza = ((2*).snd) ciudad < danioPotencial amenaza

puedeVencerAmenaza amenaza chica
    |(even.length.objetivo) amenaza = nivelResistencia chica > ((/2).danioPotencial) amenaza
    |otherwise = nivelResistencia chica > danioPotencial amenaza

esNivelAlto amenaza = (even.length.debilidades) amenaza && (not.elem "kryptonita")  (debilidades amenaza) && ((>50).nivelPoder) amenaza

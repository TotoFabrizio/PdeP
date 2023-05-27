module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--1a
type Id = String
data Cuenta = Cuenta {
    idC::Id,
    saldo::Number
}deriving (Show, Eq)

type Bloque = [(Id,Transaccion)]
type Transaccion = Cuenta -> Cuenta 
type Blockchains = [Bloque]

cuenta1 = Cuenta "Perro" 250
cuenta2 = Cuenta "Mama" 0
cuenta3 = Cuenta "lolaso" (-2)

bloque1 =[("Perro",mineria),("Perro",mineria),("Mama",cobranza 25)]
bloque2 =[("lolaso",mineria),("Perro",pago 100),("Mama",pago 10)] 

--b
modificarSaldo num cuenta  = cuenta{saldo = saldo cuenta + num}

pago pago = modificarSaldo (-pago)
cobranza = modificarSaldo
mineria = modificarSaldo 25

--2a
esIdCuenta identificador = (identificador ==).idC 

--2b
priemraQueCumple condicion = head.filter condicion

--2c
sinPrimeraQCumple condicion cuentas = filter (/=priemraQueCumple condicion cuentas) cuentas

--3
modificarCuenta identificador cuentas trx = trx (priemraQueCumple (esIdCuenta identificador) cuentas) : (sinPrimeraQCumple (esIdCuenta identificador) cuentas)

--4
afectar cuentas bloque = foldl aplicarTrx cuentas bloque
    where aplicarTrx cs (identificador, trx) = modificarCuenta identificador cs trx

--5
esEstable cuenta = saldo cuenta >= 0
sonEstables = all (esEstable)
--6
afectarBlockchain [] cuentas = []
afectarBlockchain (b:bs) cuentas = afectar cuentas b : afectarBlockchain bs (afectar cuentas b)

chequeoBlockchain blockchains cuentas = map (sonEstables) $ afectarBlockchain blockchains cuentas
--7
{-
funcionSinPudor x y 
  | (length . filter even . map (fst y) $ head x) > 10 = id
  | otherwise                                          = snd y

funcionSinPudor:: [[c]] ->((c->num),(a->a))->(a->a)

-}
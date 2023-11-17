/** First Wollok example */
import packs.*

class Linea {
	const numero
	const property consumos
	const packs
	var property deuda = 0
	var property tipo = comun
		
	method costoPromedioEntre(fechaIn,fechaFin){
		return consumos.filter{consumo => consumo.fechaRealizacion().between(fechaIn,fechaFin)}.sum{consumo => consumo.costo()} / consumos.size()
	}
	
	method costoDelMes(){
		const hoy = new Date()
		return consumos.filter{consumo => consumo.fechaRealizacion().between(hoy.minusDays(30),hoy)}.sum{consumo => consumo.costo()}
	}
	
	method agragarPack(pack) = packs.add(pack)
	
	method puedeRealizarConsumo(consumo) = packs.any{pack => pack.satisfaceConsumo(consumo)}
	
	method realizarConsumo(consumo){
		if(self.puedeRealizarConsumo(consumo)){
			self.consumir(consumo)
			consumos.add(consumo)
		}else
		{
			tipo.faltaPack(self,consumo)
		}
			
	}
	method consumir(consumo){
		packs.reverse().find{pack=>pack.satisfaceConsumo(consumo)}.realizarConsumo(consumo)
	}
	
	method limpiezaPackks() {
		packs.removeAllSuchThat{pack => pack.esInutil()}
	}
	method agregarConsumo(consumo) = consumos.add(consumo)
	method agregarDeuda(cant){
		deuda += cant
	}
}

object comun{
	method faltaPack(linea,consumo){
		throw new NoHayPack(message = "No hay pack q satisface el consumo")
	}
}

object black{
	
	method faltaPack(linea,consumo){
		linea.agregarDeuda(consumo.costo())
		linea.agregarConsumo(consumo)
	}
}

object platinum{
	method faltaPack(linea,consumo){
		linea.agregarConsumo(consumo)
	}
}


class Consumo{
	method costo()
	method megas() = 0
	method duracion() = 0
}

class Llamada inherits Consumo{
	const duracion
	const fechaRealizacion
	
	override method costo(){
		return llamada.costoFijo() + 0.max(duracion - llamada.tiempoDeCobroExtra() ) * llamada.costoSegundo()
	}
	override method duracion() = duracion
}
object llamada{
	var property costoFijo = 1
	var property costoSegundo = 0.1
	var property tiempoDeCobroExtra = 30
}

class Internet inherits Consumo{
	const megas
	const fechaRealizacion
	
	override method costo(){
		return megas * internet.costoPorMega()
	}
	override method megas() = megas
}
object internet{
	var property costoPorMega = 0.1
}

class NoHayPack inherits Exception{}
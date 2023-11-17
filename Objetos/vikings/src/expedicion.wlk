class Expedicion {
	const vikingos
	const invasiones
	
	method subirA(vikingo){
		vikingos.add(vikingo)
	}
	method valeLaPena(){
		return invasiones.all{invasion => invasion.valeLaPena(self)}
	}
	method cantidadVikingos() = vikingos.length()
	
	method monedasMinimasCapital() = vikingos.length() * 3
	
	method realizarExpedicion(){
		var botin
		if(self.valeLaPena()){
			invasiones.forEach{invasion => botin += invasion.botin(self)}
		}
	}
	method aumentarVidasCobradas(){
		vikingos.forEach{vikingo => vikingo.aumentarVidasCobradas()}
	}
}


class Capital{
	const factorDeRiqueza
	
	method valeLaPena(expedicion) = expedicion.cantidadVikingos() * factorDeRiqueza >= expedicion.monedasMinimasCapital()
	
	method realizarExpedicion(expedicion) {
			expedicion.aumentarVidasCobradas()
			return expedicion.cantidadVikingos() * factorDeRiqueza
		}
}

class Aldea{
	var cantidadCrucifijos
	
	method valeLaPena(expedicion) = cantidadCrucifijos >= 15
	
	method realizarExpedicion(expedicion) {
			var botin = cantidadCrucifijos
			cantidadCrucifijos = 0
			return botin
		}
}

class AldeaAmurallada inherits Aldea{
	const cantidadMinimaParaAtaque
	
	override method valeLaPena(expedicion) = super(expedicion) && expedicion.cantidadVikingos() > cantidadMinimaParaAtaque
}
/** First Wollok example */
import expedicion.*

class Vikingo {
	var property casta
	const property ocupacion
	var property vidasCobradas
	var property armas = 0
	var property hijos
	var property hectareas
	var property oro
	
	method esProductivo(){
		return ocupacion.esProductivo(self) && casta.esProductivo(self)
	}
	
	method tieneArmas() = armas >0
	method vidasCobradasSuficientes() = vidasCobradas > 20
	method ratioHijosHectareasOk() = hijos <= hectareas*2
	
	method subirseA(expedicion){
		if(self.esProductivo()){
			expedicion.subirA(self)
		}else{
			throw new noProductivo(message = "No es productivo")
		}
	}
	
	method aumentarVidasCobradas(){
		vidasCobradas += 1
	}
	
	method subirCasta(){
		casta.subirOcupacion(self)
	}
	
	method aumentarArmas(cant){
		armas += cant
	}
	method aumentarHijos(cant){
		hijos += cant
	}
	method aumentarHectareas(cant){
		hectareas += cant
	}
}

object soldado{
	method esProductivo(vikingo){
		return vikingo.vidasCobradasSuficientes() && vikingo.tieneArmas()
	}
	method subirCasta(vikingo){
		vikingo.aumentarArmas(10)
	}
}

object granjero{
	method esProductivo(vikingo){
		return vikingo.ratioHijosHectareasOk()
	}
	method subirCasta(vikingo){
		vikingo.aumentarHijos(2)
		vikingo.aumentarHectareas(2)
	}
}

object jarl{
	method esProductivo(vikingo) = not vikingo.tieneArmas()
	
	method subirCasta(vikingo){
		vikingo.ocupacion().subirCasta(vikingo)
		vikingo.casta(karl)
	}
}

object karl{
	method esProductivo(vikingo) = true
	method subirCasta(vikingo){
		vikingo.casta(thrall)
	}
}

object thrall{
	method esProductivo(vikingo) = true
	method subirCasta(vikingo){
	}
}

class noProductivo inherits Exception{
}
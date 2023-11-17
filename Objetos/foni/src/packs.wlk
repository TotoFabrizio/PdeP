class Pack{
	var property credito
	var property megas
	const fechaVencimiento
	
	method satisfaceConsumo(consumo)
	method realizarConsumo(consumo)
	method esInutil() = self.vencido() || self.acabado()
	method vencido() = false
	method acabado() = false
}

class Credito inherits Pack{

	override method satisfaceConsumo(consumo){
		return  (not self.esInutil()) && consumo.costo() <= credito
	}
	
	override method realizarConsumo(consumo){
		credito -= consumo.costo()
	}
	
	override method acabado() = credito <= 0
}

class MegasLibres inherits Pack{
	override method satisfaceConsumo(consumo){
		return (not self.esInutil()) && consumo.megas() != 0 && consumo.megas() <= megas
	}
	override method realizarConsumo(consumo){
		megas -= consumo.megas()
	}
	
	override method acabado() = megas <= 0
}

class LlamadasGratis inherits Pack{
	override method satisfaceConsumo(consumo){
		return (not self.esInutil()) && consumo.duracion() != 0
	}
	
	override method vencido() = fechaVencimiento < new Date()
}

class InternetIliLosFindes inherits Pack{
	override method satisfaceConsumo(consumo) {
		return (not self.esInutil()) && consumo.fechaRealizacion().isWeekendDay() && consumo.megas() != 0
	}
	
	override method vencido() = fechaVencimiento < new Date()
}

class MegasLibresPlus inherits MegasLibres{
	override method satisfaceConsumo(consumo) = super(consumo) || consumo.megas() < 0.1
}





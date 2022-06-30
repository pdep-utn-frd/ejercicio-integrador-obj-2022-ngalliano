class Arma{
	var property nombre
	var property potencia
}

class Villano {
	const minions = []
	var property ciudad
	
	method nuevoMinion(){
		const minion = new Minion(bananas = 5)
		const rayoCongelante = new Arma(nombre = "Rayo Congelante", potencia =10)
		minion.otorgarArma(rayoCongelante)
		minions.add(minion)
	}
	
	method agregarMinion(minion){
		minions.add(minion)
	}
		
	method planificar(maldad){
		maldad.asignarMinions(minions.filter({minion => maldad.esApto(minion)}))
	}
	
	method realizar(maldad){
		maldad.realizarEn(ciudad)
	}
	
	method minionMasUtil(){
		return minions.max({minion => minion.maldades()})
	}
	
	method minionsMasInutiles(){
		return minions.filter({minion => minion.maldades() < 1})
	}
}


class Minion{
	var property bananas
	var property color = amarillo
	var property armas = []
	var property maldades = 0
	method perderArmas(){
		armas.clear()
	}
	method nivelConcentracion(){
		return color.nivelConcentracion(self)	
	}
	method otorgarArma(arma){
		armas.add(arma)
	}
	method alimentar(cantidad){
		bananas += cantidad
	}
	method comerBanana(){
		bananas -= 1
		bananas = bananas.max(0)
	}
	method esPeligroso(){
		return (armas.size() >= 2 || color == violeta)
	}
	method consumirSueroMutante(){
		color.consumirSueroMutante(self)
		self.comerBanana()
	}
}

object amarillo{
	method nivelConcentracion(minion){
		return (minion.bananas() + minion.armas().max({arma => arma.potencia()}).potencia())
	}
	method consumirSueroMutante(minion){
		minion.color(violeta) 
		minion.armas([])
	}
}

object violeta{
	method nivelConcentracion(minion){
		return (minion.bananas())
	}
	method consumirSueroMutante(minion){
		minion.color(amarillo) 
	}
}

class Maldad{
	const property minionsAsignados = []
	
	method asignarMinions(minions){
		minionsAsignados.addAll(minions)
	}
	
	method realizarEn(ciudad){
		if (minionsAsignados.isEmpty())
			throw new Exception(message = "Sin Minions Asignados")
		self.realizar(ciudad)
	}
	
	method realizar(ciudad)	
}

class Congelar inherits Maldad{
	const nivelMinimo = 500
	
	method esApto(minion){
		return minion.armas().any({arma => arma.nombre() == "Rayo Congelante"}) && minion.nivelConcentracion() > nivelMinimo
	}
	
	override method realizar(ciudad){
		ciudad.reducirTemperatura(30)
		minionsAsignados.forEach({minion => minion.alimentar(10)})
		minionsAsignados.forEach({minion => minion.maldades(minion.maldades()+1)})
	}
}

class Robar inherits Maldad{
	var property objetivoRobo
	
	method esApto(minion){
		return minion.esPeligroso() && objetivoRobo.esApto(minion)
	}
	
	override method realizar(ciudad){
		ciudad.eliminarObjeto(objetivoRobo)
		objetivoRobo.realizarCon(minionsAsignados)
		minionsAsignados.forEach({minion => minion.maldades(minion.maldades()+1)})
	}	
}

class Piramides{
	var property altura
	method esApto(minion){
		return minion.nivelConcentracion() > altura/2
	}
	method realizarCon(minions){
		minions.forEach({minion => minion.alimentar(10)})
	}
}

object sueroMutante{
	method esApto(minion){
		return minion.nivelConcentracion() > 23 && minion.bananas()>100
	}
	method realizarCon(minions){
		minions.forEach({minion => minion.consumirSueroMutante()})
	}
}

object luna{
	method esApto(minion){
		return minion.armas().any({arma => arma.nombre() == "Rayo Encogedor"})
	}
	method realizarCon(minions){
		minions.forEach({minion => minion.otorgarArma( new Arma(nombre = "Rayo Congelante", potencia =10))})
	}
}

class Ciudad{
	const objetosCiudad =[]
	var property temperatura
	method reducirTemperatura(grados){
		temperatura -= grados
	}
	method eliminarObjeto(objeto){
		objetosCiudad.remove(objeto)
	}
}


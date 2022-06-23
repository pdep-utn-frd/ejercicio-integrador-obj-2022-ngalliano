class Arma{
	const nombre
	const potencia
}

class Maldad{
	const property minionsAsignados = []
		
}

class Villano {
	var minions = []
	method nuevoMinion(){
		minions.add(new Minion())
	}
	method otorgarArma(minion,arma){
		minion.otorgarArma(arma)
	}
	method alimentar(minion,cantidad){
		minion.alimentar(cantidad)
	}
	method nivelConcentracion(minion){
		minion.nivelConcentracion()
	}
	method esPeligroso(minion){
		minion.esPeligroso()
	}
	method planificar(){
		minions.filter({minion => minion})
	}
}

object amarillo{
	method nivelConcentracion(minion){
		return (minion.bananas() + minion.armas().max({arma => arma.potencia()}))
	}
	method consumirSueroMutante(minion){
		minion.color(violeta) 
		minion.armas([])
		minion.bananas(minion.bananas()-1)
	}
}

object violeta{
	method nivelConcentracion(minion){
		return (minion.bananas())
	}
	method consumirSueroMutante(minion){
		minion.color(amarillo) 
		minion.bananas(minion.bananas()-1)
	}
}

class Minion{
	var property bananas = 5
	var property color = amarillo
	var property armas = [rayoCongelante]
	method nivelConcetracion(){
		color.nivelConcetracion(self)	
	}
	method otorgarArma(arma){
		armas.add(arma)
	}
	method alimentar(cantidad){
		bananas += cantidad
	}
	method comerBanana(){
		bananas -= 1
	}
	method esPeligroso(){
		return (armas.size() >= 2 || color == violeta)
	}
	method consumirSueroMutante(){
		color.consumirSueroMutante(self)
	}
}




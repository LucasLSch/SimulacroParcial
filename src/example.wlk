class Mafioso {
	var nivelLealtead
	var rango
	const armas = []
	var property herido = false
	var morido = false
}

object revolver{
	var tambor = 6
	
	method dispararA(unMafioso){
		if(tambor > 0){
			unMafioso.morir()
			tambor -= 1
		}
	}
	
	method recargar(){
		tambor = 6
	}
}

object escopeta{
	method dispararA(unMafioso){
		if(unMafioso.herido()){
			unMafioso.morir()
		} else {
			unMafioso.sufrirDanio()
		}
	}
}

class CuerdaDePiano{
	var buenaCalidad = false
	
	method dispararA(unMafioso){
		if(buenaCalidad){
			unMafioso.morir()
		}
	}
}
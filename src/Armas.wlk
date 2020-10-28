import Mafioso.*

class Revolver{
	var tambor
	
	method dispararA(unMafioso){
		if(tambor > 0){
			unMafioso.morir()
			tambor -= 1
		}
	}
	
	method recargar(){
		tambor = 6
	}
	
	method esSutil(){
		return self.tieneUnaBala()
	}
	
	method tieneUnaBala(){
		return tambor == 1
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
	
	method esSutil(){
		return false
	}
}

class CuerdaDePiano{
	var buenaCalidad
	
	method dispararA(unMafioso){
		if(buenaCalidad){
			unMafioso.morir()
		}
	}
	
	method esStuil() {
		return true
	}
}
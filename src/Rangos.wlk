import Armas.*
import Mafioso.*

object don {
	method obtenerBeneficios(unMafioso){
		//Vacio
	}
	
	method aniadirSubordinados(unDon, unMafioso){
		unDon.agregaSubordinado(unMafioso)
	}
	
	method comoTrabaja(unDon, unaVictima){
		unDon.mandarAUnSubordinadoATrabajar(unaVictima)
	}
	
	method elegancia(unDon){
		return true
	}
}

object subjefe {
	method obtenerBeneficios(unMafioso){
		//Vacio
	}
	
	method aniadirSubordinados(unSubjefe, unMafioso){
		unSubjefe.agregaSubordinado(unMafioso)
	}
	
	method comoTrabaja(unSubjefe, unaVictima){
		unSubjefe.atacarConArmasDistintas(unaVictima)
	}
	
	method elegancia(unSubjefe){
		return unSubjefe.algunSubordinadoTieneArmaSutil()
	}
}

object soldado {
	method obtenerBeneficios(unMafioso){
		unMafioso.obtenerArma(escopeta)
	}
	
	method comoTrabaja(unSoldado, unaVictima){
		unSoldado.usarArmaMasAMano(unaVictima)
	}
	
	method elegancia(unSoldado){
		unSoldado.tieneArmaSutil()
	}
}

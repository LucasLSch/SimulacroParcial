class Mafioso {
	var nivelLealtead
	var rango
	const armas = []
	const subordinados = #{}
	var property herido = false
	var morido = false
	
	method morir(){
		morido = true
	}
	
	method sufrirDanio(){
		herido = true
	}
	
	method usarArmaCon(unArma, unMafioso){
		unArma.dispararA(unMafioso)
	}
	
	method recargar(unRevolver){
		unRevolver.recargar()
	}
	
	method agregarSubordinado(unMafioso){
		if(self.noEsSoldado()){
			subordinados.add(unMafioso)
		}
	}
	
	method noEsSoldado(){
		return rango != soldado
	}
	
	method asignarRango(unRango){
		rango = unRango
		unRango.obtenerBeneficios()
	}
	
	method hacerSuTrabajo(unaVictima){
		rango.comoTrabaja(self, unaVictima)
	}
	
	method mandarUnSubordinadoATrabajar(unaVictima){
		subordinados.any().hacerSuTrabajo(unaVictima)
	}
	
	method atacarConArmasDistintas(unaVictima){
		self.usarArmaMasAMano(unaVictima)
		self.dejarArmaParaDespues()
	}
	
	method usarArmaMasAMano(unaVictima){
		self.usarArmaCon(armas.head(), unaVictima)
	}
	
	method dejarArmaParaDespues(){
		const armaUsada = armas.head()
		armas.remove(armaUsada)
		armas.add(armaUsada)
	}
	
	
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
	var buenaCalidad
	
	method dispararA(unMafioso){
		if(buenaCalidad){
			unMafioso.morir()
		}
	}
}

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
}

object soldado {
	method obtenerBeneficios(unMafioso){
		unMafioso.obtenerArma(escopeta)
	}
	
	method comoTrabaja(unSoldado, unaVictima){
		unSoldado.usarArmaMasAMano(unaVictima)
	}
}
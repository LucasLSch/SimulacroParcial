class Mafioso {
	var property nivelLealtad
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
		unRango.obtenerBeneficios(self)
	}
	
	method hacerSuTrabajo(unaVictima){
		rango.comoTrabaja(self, unaVictima)
	}
	
	method mandarUnSubordinadoATrabajar(unaVictima){
		subordinados.anyOne().hacerSuTrabajo(unaVictima)
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
		self.agregarArma(armaUsada)
	}
	
	method dormisConLosPeces(){
		return morido
	}
	
	method cantArmas(){
		return armas.size()
	}
	
	method agregarArma(unArma){
		armas.add(unArma)
	}
	
	method despachaElegantemente(){
		return rango.elegancia(self)
	}
	
	method algunSubordinadoTieneArmaSutil(){
		return subordinados.any{ unMafioso => unMafioso.tieneArmaSutil() }
	}
	
	method tieneArmaSutil(){
		return armas.any{ unArma => unArma.esSutil() }
	}
	
	method multiplicarLealtad(unNumero){
		nivelLealtad *= unNumero
	}
	
	method atacarVictimas(unasVictimas){
		unasVictimas.forEach{ unaVictima => self.hacerSuTrabajo(unaVictima) }
	}
}

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

class Familia{
	const integrantes = #{}
	const traiciones = #{}
	
	method peligroso(){
		return integrantes.max{ unMafioso => unMafioso.cantArmas() }
	}
	
	method elQueQuieraEstarArmadoQueAndeArmado(){
		integrantes.forEach{ unMafioso => unMafioso.agregarArma(new Revolver(tambor = 6)) }
	}
	
	method ataqueSorpresa(unaFamilia){
		integrantes.removeAllSuchThat{ unMafioso => unMafioso.dormisConLosPeces() }
		integrantes.forEach{ unMafioso => unMafioso.hacerSuTrabajo(unaFamilia.peligroso()) }
	}
	
	method luto(){
		self.ascenderASoldados()
		self.designarNuevoDon()
		self.multiplicarLealtad(1.1)
	}
	
	method ascenderASoldados(){
		self.soldadosConMasDeNArmas(5).forEach{ unSoldado => unSoldado.asignarRango(subjefe) }
	}
	
	method soldadosConMasDeNArmas(unNumero){
		return self.soldados().filter{ unSoldado => unSoldado.cantArmas() > unNumero }
	}
	
	method soldados(){
		return integrantes.filter{ unMafioso => !unMafioso.noEsSoldado() }
	}
	
	method designarNuevoDon(){
		self.integranteConMayorLealtad().asignarRango(don)
	}
	
	method integranteConMayorLealtad(){
		return integrantes.max{ unMafioso => unMafioso.nivelLealtad() }
	}
	
	method multiplicarLealtad(unNumero){
		integrantes.forEach{ unMafioso => unMafioso.multiplicarLealtad(unNumero) }
	}
	
	method recordarTraicion(unaTraicion){
		traiciones.add(unaTraicion)
	}
	
	method confiaEn(unIntegrante){
		return self.lealtadPromedio() < 2 * unIntegrante.nivelLealtad()
	}
	
	method lealtadPromedio(){
		return integrantes.sum{ unMafioso => unMafioso.nivelLealtad() } / integrantes.size()
	}
	
	method agregarIntegrante(unIntegrante){
		integrantes.add(unIntegrante)
	}
	
	method ajusticiar(unMafioso){
		unMafioso.morir()
	}
}

class Traicion{
	const familiaTraicionada
	const familiaDeseada
	const victimas = #{}
	var fecha
	const traidor
	
	method planearTraicion(unaVictima, unaFecha){
		victimas.add(unaVictima)
		fecha = unaFecha
	}
	
	method seComplica(unaVictima, cantDias){
		victimas.add(unaVictima)
		fecha.minusDays(cantDias)
	}
	
	method ejecutarTraicion(){
		if(familiaTraicionada.confiaEn(traidor)){
			traidor.atacarVictimas(victimas)
			familiaDeseada.agregarIntegrante(traidor)
		} else {
			familiaTraicionada.ajusticiar(traidor)
		}
		familiaTraicionada.recordarTraicion(self)
	}
}
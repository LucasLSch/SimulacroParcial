import Rangos.*
import Armas.*

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
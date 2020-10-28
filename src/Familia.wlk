import Armas.*
import Rangos.*
import Traicion.*

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
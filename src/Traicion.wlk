import Familia.*
import Mafioso.*

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
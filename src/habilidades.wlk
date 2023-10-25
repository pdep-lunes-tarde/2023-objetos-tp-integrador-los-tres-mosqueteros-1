import wollok.game.*
import direcciones.*
import tp.*

class Trampa {
	var property esTrampa = true
	var property esPersonaje = false
	var property position = game.origin()
	var property danio = 7
	var property esEnemigo = false
	var property tiempoActiva = 10
	
	method lanzar (pj) {
			const trampaLanzada = new Trampa ()
			trampaLanzada.position(pj.direction().siguientePosicion(pj))
			game.addVisual(trampaLanzada)
			game.schedule(1000*tiempoActiva,{=> trampaLanzada.removerTrampa()})
		
	}

	method image () = "trampachico.png"
	
	method activar (entidad) {
		if (entidad.esEnemigo()){
			entidad.recibirDanio(self)
			entidad.stun(5)
			game.removeVisual(self)
		}
			
	}
	
	method removerTrampa () {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
	method mejorar (pj) {
		danio += 2
		tiempoActiva += 2
		pj.cooldownHabilidad(pj.cooldownHabilidad()-3)
	}
	 
}


class Granada {
	var property esTrampa = false
	var property esEnemigo = false
	var property position = game.origin()
	var property direccion = sur
	var property danio = 8
	var rango = 10
	
	method lanzar (pj) {
		const granadaLanzada = new Granada()
		granadaLanzada.direccion(pj.direction())
		granadaLanzada.position(pj.direction().siguientePosicion(pj))
		game.addVisual(granadaLanzada)
		tpIntegrador.agregarUtilidad(granadaLanzada)
	}
	
	method viajar (pj) {
		if (rango>0){
			position = direccion.siguientePosicion(self)
			game.onCollideDo(self,{enemigo => if (enemigo.esEnemigo()){self.explota() rango = 0}})
			rango --
		}
		else {self.explota()}
	}	
	
	method explota () {
		if (game.hasVisual(self)){
			const colliders = game.colliders(self)
			colliders.forEach({x => x.recibirDanio(self)})
			tpIntegrador.sacarUtilidad(self)
			game.removeVisual(self)
		}
	}
	
	method mejorar (pj) {
		danio += 5
		rango += 2
		pj.cooldownHabilidad(pj.cooldownHabilidad()-1)
	}
	
	method image () = "granadaChiquito.png"
	
}

class DisparoCertero  {
	var property esTrampa = false
	var property esEnemigo = false
	var property esPersonaje = false
	var property position = game.origin()
	var property direccion = sur
	var property danio = 20
	var rango = 15
	
	method lanzar (pj) {
		const disparo = new DisparoCertero()
		disparo.direccion(pj.direction())
		disparo.position(pj.direction().siguientePosicion(pj))
		game.addVisual(disparo)
		tpIntegrador.agregarUtilidad(disparo)
	}
	
	method viajar (pj) {
		if (rango>0){
			position = direccion.siguientePosicion(self)
			game.onCollideDo(self,{enemigo => if (enemigo.esEnemigo()){enemigo.recibirDanio(self) enemigo.stun(5) rango = 0}})
			rango --
		}
		else {self.eliminarse()}
	}
	
	method eliminarse () {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
	method mejorar (pj) {
		danio += 10
		rango += 2
		pj.cooldownHabilidad(pj.cooldownHabilidad()-2)
	}
	
	method image () = "bala.png"
	
}

import wollok.game.*

class Trampa {

	var property position = game.origin()
	
	method lanzar (pj) {
			const trampaLanzada = new Trampa ()
			trampaLanzada.position(pj.direction().siguientePosicion(pj))
			game.addVisual(trampaLanzada)
			game.schedule(10000,{=> trampaLanzada.removerTrampa()})
		
	}

	method image () = "trampachico.png"
	
	method activar (entidad) {
		if (entidad.esEnemigo()){
			entidad.hacerDanio()
			entidad.stun()
			game.removeVisual(self)
		}
			
	}
	
	method removerTrampa () {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	 
}
//class Granada {
//	const distancia = 7
//	
//	method lanzar (pj) {
//		
//	}
//}

object red {
	
}

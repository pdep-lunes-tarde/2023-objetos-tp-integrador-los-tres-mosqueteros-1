import wollok.game.*

class Trampa {
	var property espera = 0
	const cooldown
	var property position = game.origin()
	
	method lanzar (pj) {
		if (self.puedeLanzarse()) {
			position = pj.direction().siguientePosicion(pj)
			game.addVisual(self)
			game.schedule(10000,{=> self.removerTrampa()})
			espera = cooldown
			game.onTick(1000,"bajar cooldown",{espera-1})
			game.schedule(1000*cooldown+1,{game.removeTickEvent("bajar cooldown")})
		}
	}
	
	method puedeLanzarse () = espera <= 0

	method image () = "manzana.png"
	
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

object granada {
	
}

object red {
	
}

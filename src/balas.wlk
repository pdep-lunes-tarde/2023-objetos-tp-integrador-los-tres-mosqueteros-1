import wollok.game.*

object cartucho {
	
	var property direccion
	var property position
	const property rango = 5
	
	method spawn (pj) {
		direccion = pj.direction()
		position = direccion.siguientePosicion(pj)
		game.addVisual(self)
		self.viajar(pj)
	}
	
	method viajar (pj) {
		//terminar de implementar el rango como un contador para ahorrar onticks
		game.onTick(100,"viajeBala",{position = direccion.siguientePosicion(self)})
		if(game.hasVisual(self)){game.onTick(600,"removerBala",{self.borrarBala()})}
	}
	
	method borrarBala () {
		game.removeTickEvent("viajeBala")
		game.removeTickEvent("removerBala")
		game.removeVisual(self)
	}
	
	method image () = "bala.png"
	
}


object viajeBala {
	
	method apply () {
		
	}
	
}



//object calibreFranco {
	
	//method image () {}
	
//}

//object calibreComun {
	
//	method image () {}
//	
//}
//
//object calibreSubfu {
//	
//	method image () {}
//	
//}
//
//object calibreAk {
//	
//	method image () {}
//	
//}
//
//object calibreLigero {
//	
//	method image () {
//		
//	}
//	
//}
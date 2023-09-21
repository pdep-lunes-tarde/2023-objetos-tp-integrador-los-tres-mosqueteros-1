import wollok.game.*

object cartucho {
	
	var property position
	
	method viajar (pj) {
		game.addVisual(self)
		position = pj.posicion()
		position = position.right(5)
	}
	
	method image () = "bala.png"
	
}

object calibreFranco {
	
	method image () {}
	
}

object calibreComun {
	
	method image () {}
	
}

object calibreSubfu {
	
	method image () {}
	
}

object calibreAk {
	
	method image () {}
	
}

object calibreLigero {
	
	method image () {
		
	}
	
}
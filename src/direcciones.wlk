import obstaculos.*
import wollok.game.*

class Posicion {
	var property x = 0
	var property y = 0
	
	method right(n) {
		x += 1
		return self
	}
	
	method left(n) {
		x -= 1
		return self
	}
	
	method up(n) {
		y += 1
		return self
	}
	
	method down(n) {
		y -= 1
		return self
	}
	
	method allElements() = game.getObjectsIn(self)
	
}

class Direccion {
	var property position = new Posicion (x=0,y=0)
	var property siguientePos = new Posicion (x=0,y=0)
		
	method siguientePosicion (objeto) 
	

}



object sur inherits Direccion {
	
	override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().down(1)
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty() or siguientePos.allElements().any({elemento => elemento.esEnemigo()})){
			return position
		}
		
		return siguientePos
		
		}	
}

object norte inherits Direccion {
	
	 override method siguientePosicion (objeto) {
		position = objeto.position()
		
		siguientePos = game.at(objeto.position().up(1).x(),objeto.position().up(1).y())
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}

object este inherits Direccion {
	
		override method siguientePosicion (objeto) {
			position = objeto.position()
		siguientePos = objeto.position().right(1)
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}
}

object oeste inherits Direccion {

	    override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().left(1)
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}
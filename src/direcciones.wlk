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
	
	method upRelativo() = new Posicion (x=x,y=y+1)
	method downRelativo() = new Posicion (x=x,y=y-1)
	method leftRelativo() = new Posicion (x=x-1,y=y)
	method rightRelativo() = new Posicion (x=x+1,y=y)
	
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
		siguientePos = new Posicion (x=objeto.position().x(),y=objeto.position().downRelativo().y())
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}

object norte inherits Direccion {
	
	 override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = new Posicion (x=objeto.position().x(),y=objeto.position().upRelativo().y())
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}

object este inherits Direccion {
	
	override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = new Posicion (x=objeto.position().rightRelativo().x(),y=objeto.position().y())
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}
}

object oeste inherits Direccion {

	    override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = new Posicion (x=objeto.position().leftRelativo().x(),y=objeto.position().y())
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}
import obstaculos.*
import wollok.game.*

class Direccion {
	var property position = game.origin()
	var property siguientePos = game.origin()
		
	method siguientePosicion (objeto) 
}



object sur inherits Direccion {
	
	override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().down(1)
		
		if(not siguientePos.allElements().filter{elemento => obstaculos.contains(elemento)}.isEmpty()){
			return position
		}
		
		return siguientePos
		
		}	
}

object norte inherits Direccion {
	
	 override method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().up(1)
		
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
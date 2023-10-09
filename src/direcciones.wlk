import obstaculos.*

object sur {
	var property position
	var property siguientePos 
	
	method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().down(1)
		
		if(siguientePos.allElements().isEmpty()){
			return position.down(1)	
		}
		
		return position
		
		}	
}

object norte {
	var property position
	var property siguientePos 
	
	method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().up(1)
		
		if(siguientePos.allElements().isEmpty()){
			return position.up(1)	
		}
		
		return position
		
		}	
}
object este {
	var property position
	var property siguientePos 
	
	method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().right(1)
		
		if(siguientePos.allElements().isEmpty()){
			return position.right(1)	
		}
		
		return position
		
		}	
}
object oeste {
	var property position
	var property siguientePos 
	
	method siguientePosicion (objeto) {
		position = objeto.position()
		siguientePos = objeto.position().left(1)
		
		if(siguientePos.allElements().isEmpty()){
			return position.left(1)	
		}
		
		return position
		
		}	
}
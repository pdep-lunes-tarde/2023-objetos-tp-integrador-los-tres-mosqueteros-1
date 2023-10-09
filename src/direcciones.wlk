object sur {
	var property position
	method siguientePosicion (objeto) {
		position = objeto.position()
		return position.down(1)
		}	
}

object norte {
	
	var property position
	
	method siguientePosicion (objeto) {
		
		position = objeto.position()
		return position.up(1)
		
		}
}
object este {
	
	var property position
	
	method siguientePosicion (objeto) {
		
		position = objeto.position()
		return position.right(1)
		
		}
}
object oeste {
	
	var property position
	
	method siguientePosicion (objeto) {
		
		position = objeto.position()
		return position.left(1)
		
		}
}
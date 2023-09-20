import wollok.game.*

object player {
	var vida
	var arma
	var objeto
	var pasivas = new List()
	var revivir = false
	
	var property position = game.origin()	
	
	method empezarCentrado(){
		position = game.center()
	}
	
	method image() = "mario.png"
	
	method atacar () {}
	
	method cambiarVida () {}
		
	method caminar () {}
	
	method habilidad () {}
	
	method cambiarObjeto () {}
	
	method agregarPasiva () {}
		
	method cumplirDesafio () {}
	
	method morir () {}
	
}

object obstaculo{ //mover a otro archivo llamado "obstaculos", en el momento no pude hacerlo
	var property position = game.center()
	method image()= "arbusto.png"
	
	method colision(){position = position.up(1)} //colision (anda mal)
	
}
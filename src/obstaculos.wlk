import wollok.game.*

object obstaculo{ //mover a otro archivo llamado "obstaculos", en el momento no pude hacerlo
	var property position = game.center()
	method image()= "arbusto.png"
	
	method colision(){position = position.up(1)} //colision (anda mal)
	
}
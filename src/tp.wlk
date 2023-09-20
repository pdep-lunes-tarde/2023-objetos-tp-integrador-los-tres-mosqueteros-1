import wollok.game.*
import personaje.*

object tpIntegrador {
	
	method inicializarPantalla(){
		game.width(20)
		game.height(20)
		game.cellSize(30)
	}
	
	method jugar() {
		self.inicializarPantalla()
		game.addVisualCharacter(player) // Para que el personajes se mueva con las flechitas
		game.addVisual(obstaculo)
		game.whenCollideDo(player, {objeto => objeto.colision()}) //Cuando el jugador esta en la misma posiion que el objeto, ocurre algo(en este caso el arbusto se desplaza, cosa que no queremos) 
		game.start()
	}
}

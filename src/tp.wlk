import wollok.game.*
import personaje.*
import obstaculos.*

object tpIntegrador {
	
	method inicializarPantalla(){
		game.width(20)
		game.height(20)
		game.cellSize(30)
	}
	
	method jugar() {
		self.inicializarPantalla()
		game.addVisualCharacter(escopetero) // Para que el personajes se mueva con las flechitas
		game.addVisual(obstaculo)
		game.whenCollideDo(escopetero, {objeto => objeto.colision()}) //Cuando el jugador esta en la misma posiion que el objeto, ocurre algo(en este caso el arbusto se desplaza, cosa que no queremos)
		
		keyboard.d().onPressDo{escopetero.disparar()}
		 
		game.start()
	}
}

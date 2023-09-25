import wollok.game.*
import personaje.*
import obstaculos.*
import armas.*
import balas.*
import direcciones.*

object tpIntegrador {
	
	method inicializarPantalla(){
		game.width(20)
		game.height(20)
		game.cellSize(30)
	}
	
	method menu() {
		self.inicializarPantalla()
		//añadir visuales de los personajes
		//crear objeto manito que elege para visualizar cual estoy eligiendo
		//mover con las flechtias la eleccion
		//enter tiene que elegir ese personaje borrando el menu e inicializando el method jugar
		
	}
	
	method jugar() {
		self.inicializarPantalla()
		game.addVisualCharacter(escopetero) // Para que el personajes se mueva con las flechitas
		game.addVisual(obstaculo)
		//game.whenCollideDo(escopetero, {objeto => objeto.colision()}) //Cuando el jugador esta en la misma posiion que el objeto, ocurre algo(en este caso el arbusto se desplaza, cosa que no queremos)
		
		keyboard.d().onPressDo{escopetero.disparar()}
//		if (game.hasVisual(escopetero.arma().tipoMunicion())){game.onTick(1000,"viajeBala",{escopetero.arma().tipoMunicion().viajar()})}
		 
		keyboard.up().onPressDo{escopetero.direction(norte)}
		keyboard.down().onPressDo{escopetero.direction(sur)}
		keyboard.right().onPressDo{escopetero.direction(este)}
		keyboard.left().onPressDo{escopetero.direction(oeste)}
		 
		game.start()
	}
}

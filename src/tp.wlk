import wollok.game.*
import personaje.*
import obstaculos.*
import armas.*
import balas.*
import direcciones.*
import menu.*

object tpIntegrador {
	
	const  property balasEnPantalla = new List()
	var personajeElegido
	
	method agregarBala (bala) {
		if (balasEnPantalla.size()<4){
		balasEnPantalla.add(bala)
		}
		else {game.say(personajeElegido,"aun no")}
	}
	
	method sacarBala (bala) {
		balasEnPantalla.remove(bala)
	}
	
	method inicializarPantalla(){
		game.width(20)
		game.height(20)
		game.cellSize(30)
	}
	
	method menu() {
		self.inicializarPantalla()
		game.addVisual(escopetero)
		game.addVisualIn(franco,game.at(8,8))
		game.addVisualIn(ingeniero,game.at(12,12))

		var seleccion = 0
		keyboard.right().onPressDo{seleccion = 2.min(seleccion+1)}
		keyboard.left().onPressDo{seleccion = 0.max(seleccion-1)}
		
		
		keyboard.enter().onPressDo{personajeElegido = eleccion.seleccion(seleccion)}
		keyboard.enter().onPressDo{self.jugar()}
		
		game.start()
	}
	
	method jugar() {

		game.clear()
		game.addVisualCharacter(personajeElegido) 
		game.addVisual(obstaculo)
		
		keyboard.d().onPressDo{personajeElegido.disparar()}
		keyboard.up().onPressDo{personajeElegido.direction(norte)}
		keyboard.down().onPressDo{personajeElegido.direction(sur)}
		keyboard.right().onPressDo{personajeElegido.direction(este)}
		keyboard.left().onPressDo{personajeElegido.direction(oeste)}
		 
		game.onTick(100,"dispararBala",{balasEnPantalla.forEach{x => x.viajar(personajeElegido)}})
	}
}

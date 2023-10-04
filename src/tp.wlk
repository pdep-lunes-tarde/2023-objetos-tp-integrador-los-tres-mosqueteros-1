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
		balasEnPantalla.add(bala)
	}
	
	method sacarBala (bala) {
		balasEnPantalla.remove(bala)
	}
	
	method inicializarPantalla(){
		game.width(30)
		game.height(18)
		game.cellSize(40)
	}
	
	method menu() {
		self.inicializarPantalla()
		game.boardGround("fondoachicado.png")
		game.addVisualIn(escopetero,game.at(2,10))
		game.addVisualIn(franco,game.at(12,10))
		game.addVisualIn(ingeniero,game.at(22,10))

		var seleccion = 0
		keyboard.right().onPressDo{seleccion = 2.min(seleccion+1)}
		
		keyboard.left().onPressDo{seleccion = 0.max(seleccion-1)}
		
		
		keyboard.enter().onPressDo{personajeElegido = eleccion.seleccion(seleccion) personajeElegido.imagen(personajeElegido.imagenDerecha()) self.jugar()}
		
	}
	
	method jugar() {

		game.clear()
		game.addVisualCharacter(personajeElegido) 
		game.addVisual(obstaculo)
		
		keyboard.z().onPressDo{personajeElegido.disparar()}
		keyboard.up().onPressDo{personajeElegido.direction(norte)}
		keyboard.down().onPressDo{personajeElegido.direction(sur)}
		keyboard.right().onPressDo{personajeElegido.direction(este) personajeElegido.imagen(personajeElegido.imagenDerecha())}
		keyboard.left().onPressDo{personajeElegido.direction(oeste) personajeElegido.imagen(personajeElegido.imagenIzquierda())}
		keyboard.x().onPressDo{personajeElegido.lanzarHabilidad()}
		 
		game.onTick(100,"dispararBala",{balasEnPantalla.forEach{x => x.viajar(personajeElegido)}})
	}
}

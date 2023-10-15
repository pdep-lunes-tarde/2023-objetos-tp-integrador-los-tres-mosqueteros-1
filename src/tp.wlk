import wollok.game.*
import personaje.*
import obstaculos.*
import armas.*
import balas.*
import direcciones.*
import menu.*
import enemigos.*

object tpIntegrador {
	var property enemigosEnPantalla = []
	var selector = 0
	const oleadas = [oleadaUno,oleadaDos,oleadaTres]
	const  property utilidadesEnPantalla = new List()
	var personajeElegido
	
	method agregarUtilidad (bala) {
		utilidadesEnPantalla.add(bala)
	}
	
	method sacarUtilidad (bala) {
		utilidadesEnPantalla.remove(bala)
	}
	
	method inicializarPantalla(){
		game.width(30)
		game.height(18)
		game.cellSize(40)
	}
	
	method menu() {
		self.inicializarPantalla()
		game.boardGround("calle.png")
		game.addVisualIn(escopetero,game.at(2,10))
		game.addVisualIn(franco,game.at(12,10))
		game.addVisualIn(ingeniero,game.at(22,10))

		var seleccion = 0
		keyboard.right().onPressDo{seleccion = 2.min(seleccion+1)}
		
		keyboard.left().onPressDo{seleccion = 0.max(seleccion-1)}
		
		
		keyboard.enter().onPressDo{personajeElegido = eleccion.seleccion(seleccion) personajeElegido.imagen(personajeElegido.imagenDerecha()) self.jugar()}
		
	}
	
	method jugar() {

		var enemigos = self.elegirOleada()


		game.clear()
		game.addVisual(personajeElegido) 
		obstaculos.forEach({obstaculo => game.addVisual(obstaculo)})
		game.onTick(2000,"spawn enemigo",{
			if (not enemigos.isEmpty()){
			enemigos.first().spawn()  enemigosEnPantalla.add(enemigos.first()) enemigos.remove(enemigos.first())
			}
		})
		game.onTick(500,"enemigo persigue",{
			if (not enemigosEnPantalla.isEmpty()){
				enemigosEnPantalla.forEach({x => x.perseguir(personajeElegido)})
		}})
		game.onTick(2000,"pasar de ronda",{
			if (enemigosEnPantalla.isEmpty() && enemigos.isEmpty()){
				selector += 1
				if (selector < 3){
					enemigos = self.elegirOleada()
				}
				else {game.say(personajeElegido,"Ganeeeee")}
			}
		})		
		
		keyboard.up().onPressDo{personajeElegido.correr(norte)}
		keyboard.down().onPressDo{personajeElegido.correr(sur)}
		keyboard.right().onPressDo{personajeElegido.correr(este)}
		keyboard.left().onPressDo{personajeElegido.correr(oeste)}
				
		keyboard.z().onPressDo{personajeElegido.disparar()}
		keyboard.up().onPressDo{personajeElegido.direction(norte)}
		keyboard.down().onPressDo{personajeElegido.direction(sur)}
		keyboard.right().onPressDo{personajeElegido.direction(este) personajeElegido.imagen(personajeElegido.imagenDerecha())}
		keyboard.left().onPressDo{personajeElegido.direction(oeste) personajeElegido.imagen(personajeElegido.imagenIzquierda())}
		keyboard.x().onPressDo{personajeElegido.lanzarHabilidad()}
		
		game.onTick(200,"viajeUtilidades",{utilidadesEnPantalla.forEach{x => x.viajar(personajeElegido)}})
	}
	
	method elegirOleada () {
		return oleadas.get(selector).enemigos()
	}
	
}

object oleadaUno {
	var property enemigos = [zombieUno]
}

object oleadaDos {
	var property enemigos = [zombieUno,zombieDos]
}

object oleadaTres {
	var property enemigos = [zombieUno,zombieDos,zombieTres]
}
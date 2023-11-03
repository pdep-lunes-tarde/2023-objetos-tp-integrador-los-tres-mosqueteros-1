import personaje.*
import wollok.game.*

//object eleccionPersonaje {
//	const personajes = [escopetero,franco,ingeniero]
//	var property personajeElegido = 0
//	
//	method seleccion (numero) {
//		personajeElegido = personajes.get(numero)
//		return personajeElegido
//	}
//}

class Eleccion {
	const opciones 
	var property opcionElegida = 0
	
	method seleccion (numero) {
		opcionElegida = opciones.get(numero)
		return opcionElegida
	}
}

const eleccionPersonaje = new Eleccion (opciones=[escopetero,franco,ingeniero])
const eleccionMenu = new Eleccion (opciones=[jugar,instrucciones,salir])


class Texto {
	var property image
}

object manito {
	var property image = "manitoChiquito.png"
	
	method posicionarse (numero) {
		if (numero == 0) {game.removeVisual(self) game.addVisualIn(self,game.at(11,9))}
		if (numero == 1) {game.removeVisual(self) game.addVisualIn(self,game.at(8,7))}
		if (numero == 2) {game.removeVisual(self) game.addVisualIn(self,game.at(11,5))}
		if (numero == 3) {game.removeVisual(self) game.addVisualIn(self,game.at(1,12))}
		if (numero == 4) {game.removeVisual(self) game.addVisualIn(self,game.at(11,12))}
		if (numero == 5) {game.removeVisual(self) game.addVisualIn(self,game.at(21,12))}
	}
}

const jugar = new Texto (image="jugar.png")
const instrucciones = new Texto (image="instrucciones.png")
const salir = new Texto (image="salir.png")

const sonidoMenu = game.sound("sonidoMenu.mp3")
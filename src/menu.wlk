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

object menuPj {
	method danio () = new Texto (image="dañoC.png")
	method vida () = new Texto (image="vidaC.png")
	method escalado () = new Texto (image="escaladoC.png")
	method barrita () = new Texto (image="barraC.png")
	method barrasEscopetero () {
		game.addVisualIn(self.barrita(),game.at(4,6))
		game.addVisualIn(self.barrita(),game.at(5,6))
		game.addVisualIn(self.barrita(),game.at(6,6))
		game.addVisualIn(self.barrita(),game.at(7,6))
		game.addVisualIn(self.barrita(),game.at(8,6))
		
		game.addVisualIn(self.barrita(),game.at(4,8))
		game.addVisualIn(self.barrita(),game.at(5,8))
		game.addVisualIn(self.barrita(),game.at(6,8))
		
		game.addVisualIn(self.barrita(),game.at(4,4))
		game.addVisualIn(self.barrita(),game.at(5,4))
	}
	method barrasFranco() {
		game.addVisualIn(self.barrita(),game.at(14,6))
		game.addVisualIn(self.barrita(),game.at(15,6))
		
		game.addVisualIn(self.barrita(),game.at(14,8))
		game.addVisualIn(self.barrita(),game.at(15,8))
		game.addVisualIn(self.barrita(),game.at(16,8))
		game.addVisualIn(self.barrita(),game.at(17,8))
		game.addVisualIn(self.barrita(),game.at(18,8))
		
		game.addVisualIn(self.barrita(),game.at(14,4))
		game.addVisualIn(self.barrita(),game.at(15,4))
	}
	method barrasIng () {
		game.addVisualIn(self.barrita(),game.at(24,6))
		game.addVisualIn(self.barrita(),game.at(25,6))
		game.addVisualIn(self.barrita(),game.at(26,6))
		
		game.addVisualIn(self.barrita(),game.at(24,8))
		
		game.addVisualIn(self.barrita(),game.at(24,4))
		game.addVisualIn(self.barrita(),game.at(25,4))
		game.addVisualIn(self.barrita(),game.at(26,4))
		game.addVisualIn(self.barrita(),game.at(27,4))
		game.addVisualIn(self.barrita(),game.at(28,4))
	}
}

const jugar = new Texto (image="jugar.png")
const instrucciones = new Texto (image="instrucciones.png")
const salir = new Texto (image="salir.png")
const disparar = new Texto (image="disparar.png")
const habilidad = new Texto (image="habilidad.png")
const menu = new Texto (image="menu.png")
const movimiento = new Texto (image="movimiento.png")

const flechitas = new Texto (image="flechas.png")
const z = new Texto (image="zGr.png")
const x = new Texto (image="xGr.png")
const q = new Texto (image="qGr.png")


const sonidoMenu = game.sound("sonidoMenu.mp3")
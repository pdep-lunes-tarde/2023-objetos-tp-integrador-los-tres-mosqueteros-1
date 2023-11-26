import personaje.*
import wollok.game.*

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
	method danino () = new Texto (image="dañoC.png")
	method vida () = new Texto (image="vidaC.png")
	method escalado () = new Texto (image="escaladoC.png")
	method barrita () = new Texto (image="barraC.png")
	
	method generarBarras(posiciones) {
    posiciones.forEach({ posicion => game.addVisualIn(self.barrita(), posicion)})
	}

	
	method barrasEscopetero () {
		const posiciones = [
			game.at(4, 6), game.at(5, 6), game.at(6, 6), game.at(7, 6), game.at(8, 6),
    	    game.at(4, 8), game.at(5, 8), game.at(6, 8),game.at(4, 4), game.at(5, 4)
    	    ]
		
		self.generarBarras(posiciones)
	}

	method barrasFranco() {
    	const posiciones = [
        	game.at(14, 6), game.at(15, 6),game.at(14, 8), game.at(15, 8), game.at(16, 8), 
        	game.at(17, 8), game.at(18, 8), game.at(14, 4), game.at(15, 4)
    		]
    self.generarBarras(posiciones)
}

	method barrasIng() {
    	const posiciones = [
        	game.at(24, 6), game.at(25, 6), game.at(26, 6), game.at(24, 8),
        	game.at(24, 4), game.at(25, 4), game.at(26, 4), game.at(27, 4), game.at(28, 4)
    		]
    self.generarBarras(posiciones)
}

}

object corazonesInterfaz {
	const vidas = new List()

	method inicializarVidas() {
		vidas.add(vidaUno)
		vidas.add(vidaDos)
		vidas.add(vidaTres)
		vidas.add(vidaCuatro)
		vidas.add(vidaCinco)
		}

	method sacarVida(numero) {
		vidas.elementAt(numero).sacarCorazon()
	}

	method ponerVida(numero) {
		vidas.elementAt(numero).ponerCorazon()
	}
}

class Corazon {
	const posicion 
	var property image = "corazonChiquito.png"
	method ponerCorazon () {
		game.addVisualIn(self,posicion)
		return 1
	}
	method sacarCorazon() {
		game.removeVisual(self)
		return 1
	}
}

const vidaUno = new Corazon (posicion = game.at(0,17))
const vidaDos = new Corazon (posicion = game.at(1,17))
const vidaTres = new Corazon (posicion = game.at(2,17))
const vidaCuatro = new Corazon (posicion = game.at(3,17))
const vidaCinco  = new Corazon (posicion = game.at(4,17))

const vidaUnoJ2 = new Corazon (posicion = game.at(27,17))
const vidaDosJ2 = new Corazon (posicion = game.at(28,17))
const vidaTresJ2 = new Corazon (posicion = game.at(29,17))

const jugar = new Texto (image="jugar.png")
const instrucciones = new Texto (image="instrucciones.png")
const salir = new Texto (image="salir.png")
const disparo = new Texto (image="disparar.png")
const habilidad = new Texto (image="habilidad.png")
const menu = new Texto (image="menu.png")
const movimiento = new Texto (image="movimiento.png")

const flechitas = new Texto (image="flechas.png")
const z = new Texto (image="zGr.png")
const equis = new Texto (image="xGr.png")
const q = new Texto (image="qGr.png")


const sonidoMenu = game.sound("sonidoMenu.mp3")
import wollok.game.*
import personaje.*
import obstaculos.*
import armas.*
import balas.*
import direcciones.*
import menu.*
import enemigos.*

const musicaJuego = game.sound("MusicaJuego.mp3")
const musicaMenu = game.sound("MusicaMenu.mp3")

object tpIntegrador {
	var property enemigosEnPantalla = []
	var enemigos
	var selector = 0
	const oleadas = [oleadaUno,oleadaDos,oleadaTres,oleadaCuatro,oleadaCinco,oleadaSeis,oleadaSiete,oleadaOcho,oleadaNueve,oleadaDiez]
	var property utilidadesEnPantalla = new List()
	var personajeElegido
	
	method resetearValores () {
		personajeElegido.resetearValores()
		oleadas.forEach({x => x.resetearValores()})
		selector = 0
		enemigosEnPantalla = []
		utilidadesEnPantalla = []
		musicaJuego.stop()
		self.menuPrincipal()
	}
	
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
	
	method elegirMenu (numero) {
		if (numero == 10) {self.menuPrincipal()}
		if (numero == 0) {self.menuPersonajes()}
		if (numero == 1) {self.menuInstrucciones()}
		if (numero == 2) {game.stop()}
	}
	
	method menuPrincipal() {
		game.clear()
		self.inicializarPantalla()
		game.boardGround("calle.png")
		game.addVisualIn(escopetero,game.at(2,10))
		game.addVisualIn(franco,game.at(12,10))
		game.addVisualIn(ingeniero,game.at(22,10))
		game.addVisualIn(jugar,game.at(3,7))
		game.addVisualIn(manito,game.at(11,9))
		game.addVisualIn(instrucciones,game.at(3,5))
		game.addVisualIn(salir,game.at(3,3))
		musicaMenu.shouldLoop(true)
		musicaMenu.volume(0.3)
		sonidoMenu.volume(0.1)
		game.onTick(1,"poner musica",{musicaMenu.play() game.removeTickEvent("poner musica")})

		var seleccion = 0

		keyboard.down().onPressDo{seleccion = 2.min(seleccion+1) manito.posicionarse(seleccion)}
		keyboard.up().onPressDo{seleccion = 0.max(seleccion-1) manito.posicionarse(seleccion)}
			
		keyboard.enter().onPressDo{self.elegirMenu(seleccion)}		
	}
	
	method menuPersonajes() {
		game.clear()
		var seleccion = 0
		game.addVisualIn(escopetero,game.at(2,10))
		game.addVisualIn(franco,game.at(12,10))
		game.addVisualIn(ingeniero,game.at(22,10))
		game.addVisualIn(manito,game.at(1,12))
		
		keyboard.right().onPressDo{seleccion = 2.min(seleccion+1) manito.posicionarse(seleccion+3)}
		keyboard.left().onPressDo{seleccion = 0.max(seleccion-1) manito.posicionarse(seleccion+3)}
		
		keyboard.enter().onPressDo{personajeElegido = eleccionPersonaje.seleccion(seleccion) personajeElegido.imagen(personajeElegido.imagenDerecha()) self.jugar()}
	}
	
	method menuInstrucciones() {
		
	}
	
	method jugar() {

		enemigos = self.elegirOleada()
		var rondasHastaMejorar = 3


		game.clear()
		musicaMenu.stop()
		musicaJuego.shouldLoop(true)
		musicaJuego.volume(0.3)
		game.onTick(1,"poner musica juego",{musicaJuego.play() game.removeTickEvent("poner musica juego")})
		game.addVisual(personajeElegido) 
		obstaculos.forEach({obstaculo => game.addVisual(obstaculo)})
		game.onTick(2000,"spawn enemigo",{
			if (not enemigos.isEmpty()){
			enemigos.first().spawn()  enemigosEnPantalla.add(enemigos.first()) enemigos.remove(enemigos.first())
			}
		})
		game.onTick(350,"enemigo persigue",{
			if (not enemigosEnPantalla.isEmpty()){
				enemigosEnPantalla.forEach({x => x.perseguir(personajeElegido)})
		}})
		game.onTick(2000,"pasar de ronda",{
			if (enemigosEnPantalla.isEmpty() && enemigos.isEmpty()){
				selector += 1
				rondasHastaMejorar --
				if (selector < 10){
					enemigos = self.elegirOleada()
				}
				
				else {game.say(personajeElegido,"Ganeeeee") game.schedule(2000,{self.resetearValores()})}
				
				if (rondasHastaMejorar == 0) {
					personajeElegido.mejorar()
					rondasHastaMejorar = 3
				}
				

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

class Oleada {
	var property enemigos
	const property enemigosIniciales = enemigos.copy()
	method resetearValores () {
		self.enemigos().forEach({x => x.resetearValores()})
		self.enemigos(self.enemigosIniciales())
	}
}

//tres zombies
const oleadaUno = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1)
])

//4 zombies 3 curtidos
const oleadaDos = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										  new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1)
])

//2 fuertes 3 curtidos
const oleadaTres = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 50,imagen = "zombieDosChiquito.png", danio = 5,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 50,imagen = "zombieDosChiquito.png", danio = 5,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1)
])

//1 tanque 3 zombies
const oleadaCuatro = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieTresChiquito.png", danio = 10,velocidadDeMovimiento = 2),
											 new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
											 new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
											 new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1)
											 
])

//dos fantasmas 3 curtidos
const oleadaCinco = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1)
])

//3 flashes 3 fantasmas
const oleadaSeis = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7)
])

//1 elite 2 casi elites
const oleadaSiete = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 60,imagen = "zombieChiquito.png", danio = 6,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 60,imagen = "zombieChiquito.png", danio = 6,velocidadDeMovimiento = 1)
])

//2 de cada
const oleadaOcho = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 50,imagen = "zombieDosChiquito.png", danio = 5,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 50,imagen = "zombieDosChiquito.png", danio = 5,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 60,imagen = "zombieChiquito.png", danio = 6,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 60,imagen = "zombieChiquito.png", danio = 6,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1)
])

//1 ultra tanque 1 tanque 3 elites 5 random
const oleadaNueve = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 200,imagen = "zombieChiquito.png", danio = 20,velocidadDeMovimiento = 2.5),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieTresChiquito.png", danio = 10,velocidadDeMovimiento = 2),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1),
											new Enemigo (position = new Posicion(x=30,y=10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 1)
])

//el boss dos ultra tanques 5 elites 2 fantasmas
const oleadaDiez = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 1000,imagen = "zombieChiquito.png", danio = 100,velocidadDeMovimiento = 3),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 200,imagen = "zombieChiquito.png", danio = 20,velocidadDeMovimiento = 2.5),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 200,imagen = "zombieChiquito.png", danio = 20,velocidadDeMovimiento = 2.5),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 1),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7),
										   new Enemigo (position = new Posicion(x=30,y=10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.7)
])
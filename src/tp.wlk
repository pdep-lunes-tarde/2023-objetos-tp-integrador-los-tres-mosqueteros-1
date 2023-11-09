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
		jugadorUno.resetearValores()
		jugadorDos.resetearValores()
		oleadas.forEach({x => x.resetearValores()})
		selector = 0
		enemigosEnPantalla = []
		utilidadesEnPantalla = new List ()
		musicaJuego.pause()
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
		game.onTick(1,"poner musica",{if (not musicaMenu.played()) {musicaMenu.play()game.removeTickEvent("poner musica")} if(musicaMenu.paused()){musicaMenu.resume()}})

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
		
		game.addVisualIn(menuPj.danio(),game.at(1,7))
		game.addVisualIn(menuPj.vida(),game.at(1,5))
		game.addVisualIn(menuPj.escalado(),game.at(1,4))
		menuPj.barrasEscopetero()
		
		game.addVisualIn(menuPj.danio(),game.at(11,7))
		game.addVisualIn(menuPj.vida(),game.at(11,5))
		game.addVisualIn(menuPj.escalado(),game.at(11,4))
		menuPj.barrasFranco()
		
		game.addVisualIn(menuPj.danio(),game.at(21,7))
		game.addVisualIn(menuPj.vida(),game.at(21,5))
		game.addVisualIn(menuPj.escalado(),game.at(21,4))
		menuPj.barrasIng()
		
		keyboard.right().onPressDo{seleccion = 2.min(seleccion+1) manito.posicionarse(seleccion+3)}
		keyboard.left().onPressDo{seleccion = 0.max(seleccion-1) manito.posicionarse(seleccion+3)}
		keyboard.q().onPressDo{self.menuPrincipal()}
		
		keyboard.enter().onPressDo{personajeElegido = eleccionPersonaje.seleccion(seleccion) personajeElegido.imagen(personajeElegido.imagenDerecha()) self.jugarDos()}
	}
	
	method menuInstrucciones() {
		game.clear()
		game.addVisualIn(z,game.at(6,10))
		game.addVisualIn(x,game.at(6,7))
		game.addVisualIn(flechitas,game.at(5,13))
		game.addVisualIn(q,game.at(6,4))
		game.addVisualIn(disparar,game.at(1,9))
		game.addVisualIn(habilidad,game.at(4,6))
		game.addVisualIn(movimiento,game.at(4,12))
		game.addVisualIn(menu,game.at(0,3))
		
		keyboard.q().onPressDo{self.menuPrincipal()}
	}
	
	method jugarUno() {

		enemigos = self.elegirOleada()
		var rondasHastaMejorar = 3


		game.clear()
		musicaMenu.pause()
		musicaJuego.shouldLoop(true)
		musicaJuego.volume(0.3)
		game.onTick(1,"poner musica juego",{if (not musicaJuego.played()) {musicaJuego.play() game.removeTickEvent("poner musica juego")} if(musicaJuego.paused()){musicaJuego.resume()}})
		game.addVisual(personajeElegido) 
		personajeElegido.inicializarCorazones()
		obstaculos.forEach({obstaculo => game.addVisual(obstaculo)})
		game.onTick(2000,"spawn enemigo",{
			if (not enemigos.isEmpty()){
			enemigos.first().spawn()  enemigosEnPantalla.add(enemigos.first()) enemigos.remove(enemigos.first())
			}
		})
		game.onTick(200,"enemigo persigue",{
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
		keyboard.q().onPressDo{self.menuPrincipal() self.resetearValores()}
		
		game.onTick(100,"viajeUtilidades",{utilidadesEnPantalla.forEach{x => x.viajar(personajeElegido)}})
	}
	
	method jugarDos () {
		game.clear()
		musicaMenu.pause()
		musicaJuego.shouldLoop(true)
		musicaJuego.volume(0.3)
		game.onTick(1,"poner musica juego",{if (not musicaJuego.played()) {musicaJuego.play() game.removeTickEvent("poner musica juego")} if(musicaJuego.paused()){musicaJuego.resume()}})
		jugadorUno.imagen(jugadorUno.imagenDerecha())
		jugadorDos.imagen(jugadorDos.imagenIzquierda())
		game.addVisual(jugadorUno)
		game.addVisual(jugadorDos)
		jugadorUno.inicializarCorazones()
		jugadorDos.inicializarCorazones()
		jugadorUno.esEnemigo(true)
		jugadorDos.esEnemigo(true)
		obstaculos.forEach({obstaculo => game.addVisual(obstaculo)})
		
		keyboard.up().onPressDo{jugadorDos.correr(norte)}
		keyboard.down().onPressDo{jugadorDos.correr(sur)}
		keyboard.right().onPressDo{jugadorDos.correr(este)}
		keyboard.left().onPressDo{jugadorDos.correr(oeste)}
				
		keyboard.o().onPressDo{jugadorDos.disparar()}
		keyboard.up().onPressDo{jugadorDos.direction(norte)}
		keyboard.down().onPressDo{jugadorDos.direction(sur)}
		keyboard.right().onPressDo{jugadorDos.direction(este) jugadorDos.imagen(jugadorDos.imagenDerecha())}
		keyboard.left().onPressDo{jugadorDos.direction(oeste) jugadorDos.imagen(jugadorDos.imagenIzquierda())}
		keyboard.p().onPressDo{jugadorDos.lanzarHabilidad()}
		
		keyboard.w().onPressDo{jugadorUno.correr(norte)}
		keyboard.s().onPressDo{jugadorUno.correr(sur)}
		keyboard.d().onPressDo{jugadorUno.correr(este)}
		keyboard.a().onPressDo{jugadorUno.correr(oeste)}
				
		keyboard.v().onPressDo{jugadorUno.disparar()}
		keyboard.w().onPressDo{jugadorUno.direction(norte)}
		keyboard.s().onPressDo{jugadorUno.direction(sur)}
		keyboard.d().onPressDo{jugadorUno.direction(este) jugadorUno.imagen(jugadorUno.imagenDerecha())}
		keyboard.a().onPressDo{jugadorUno.direction(oeste) jugadorUno.imagen(jugadorUno.imagenIzquierda())}
		keyboard.b().onPressDo{jugadorUno.lanzarHabilidad()}
		
		game.onTick(70,"viajeUtilidades",{utilidadesEnPantalla.forEach{x => x.viajar(personajeElegido)}})
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
const oleadaUno = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 30,imagen = "zombieChiquito.png", danio = 1,velocidadDeMovimiento = 1)
//										  new Enemigo (position = new Posicion(x=30,y=10),vida = 30,imagen = "zombieChiquito.png", danio = 1,velocidadDeMovimiento = 1),
//										  new Enemigo (position = new Posicion(x=30,y=10),vida = 30,imagen = "zombieChiquito.png", danio = 1,velocidadDeMovimiento = 1)
])

//4 zombies 3 curtidos
const oleadaDos = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 30,imagen = "zombieChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
//										  new Enemigo (position = new Posicion(x=30,y=10),vida = 30,imagen = "zombieChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
])

//2 fuertes 3 curtidos
const oleadaTres = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)])

//1 tanque 3 zombies
const oleadaCuatro = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
//											 new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5),
//											 new Enemigo (position = new Posicion(x=30,y=10),vida = 100,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
])

//dos fantasmas 3 curtidos
const oleadaCinco = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 200,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 1)])

//3 flashes 3 fantasmas
const oleadaSeis = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 300,imagen = "zombieDosChiquito.png", danio = 2,velocidadDeMovimiento = 1)])

//1 elite 2 casi elites
const oleadaSiete = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 300,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)])

//2 de cada
const oleadaOcho = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 300,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
//										   new Enemigo (position = new Posicion(x=30,y=10),vida = 300,imagen = "zombieDosChiquito.png", danio = 1,velocidadDeMovimiento = 0.5)
])

//1 ultra tanque 1 tanque 3 elites 5 random
const oleadaNueve = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 500,imagen = "zombieDosChiquito.png", danio = 2,velocidadDeMovimiento = 0.3)])

//el boss dos ultra tanques 5 elites 2 fantasmas
const oleadaDiez = new Oleada (enemigos = [new Enemigo (position = new Posicion(x=30,y=10),vida = 1000,imagen = "zombieDosChiquito.png", danio = 3,velocidadDeMovimiento = 0.4)])
import direcciones.*
import personaje.*
import wollok.game.*
import tp.*

class Enemigo inherits Direccion {
	const imagen 
	var vida
	const vidaInicial = vida
	const posInicial = position
	var property danio
	var property esEnemigo = true
	var property esTrampa = false
	var property esPersonaje = false
	var property estaStuneado = false
	var property velocidadDeMovimiento
	
	method recibirDanio (objetoDanino) {
//		game.say(self,"auchis")
		vida -= objetoDanino.danio()
		if (vida <= 0) {
			self.borrar()
			self.resetearValores()
		}
	}
	
	method debilitar () {
		danio -= 2
	}
	
	method stun (tiempo) {
		self.estaStuneado(true)
		game.schedule(1000*tiempo,{self.estaStuneado(false)})
	}
	
	method spawn () {
		game.addVisual(self)
	}
		
	method image () = imagen
	
	method perseguir (pj) {
		if(not self.estaStuneado()) {
			game.onCollideDo(self,{algo => if (algo.esTrampa()) {algo.activar(self)} if(algo.esPersonaje()){algo.recibirDanio(danio)} if(algo.esEnemigo()){}})
			if (pj.position().x()>self.position().x()){
			position = este.siguientePosicion(self)
			self.stun(velocidadDeMovimiento)
		}
			if (pj.position().x()<self.position().x()) {
			position = oeste.siguientePosicion(self)
			self.stun(velocidadDeMovimiento)
		}
			if (pj.position().y()>self.position().y()){
			position = norte.siguientePosicion(self)
			self.stun(velocidadDeMovimiento)
		}
			if (pj.position().y()<self.position().y()){
			position = sur.siguientePosicion(self)
			self.stun(velocidadDeMovimiento)
		}
		
		}
	}
	
	method borrar () {
		if (game.hasVisual(self)){
			game.removeVisual(self)
			tpIntegrador.enemigosEnPantalla().remove(self)
		}
	}
	
	override method siguientePosicion (objeto) {
		
	}
	
	method resetearValores() {
		vida = vidaInicial
		position = posInicial
	}
	
}


const zombie = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png", danio = 3,velocidadDeMovimiento = 0.8)
const zombieFuerte = new Enemigo (position = game.at(30,10),vida = 50,imagen = "zombieDosChiquito.png", danio = 5,velocidadDeMovimiento = 0.8)
const zombieTanque = new Enemigo (position = game.at(30,10),vida = 100,imagen = "zombieTresChiquito.png", danio = 10,velocidadDeMovimiento = 1.5)
const zombieFlash = new Enemigo (position = game.at(30,10),vida = 1,imagen = "zombieChiquito.png", danio = 2,velocidadDeMovimiento = 0.1)
const zombieCurtido = new Enemigo (position = game.at(30,10),vida = 15,imagen = "zombieChiquito.png", danio = 4,velocidadDeMovimiento = 0.8)
const zombieFantasma = new Enemigo (position = game.at(30,10),vida = 5,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.5)
const zombieCasiElite = new Enemigo (position = game.at(30,10),vida = 60,imagen = "zombieChiquito.png", danio = 6,velocidadDeMovimiento = 0.8)
const zombieElite = new Enemigo (position = game.at(30,10),vida = 70,imagen = "zombieChiquito.png", danio = 7,velocidadDeMovimiento = 0.8)
const zombieUltraTanque = new Enemigo (position = game.at(30,10),vida = 200,imagen = "zombieChiquito.png", danio = 20,velocidadDeMovimiento = 2)
const Boss = new Enemigo (position = game.at(30,10),vida = 2000,imagen = "zombieChiquito.png", danio = 100,velocidadDeMovimiento = 3)
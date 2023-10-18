import direcciones.*
import personaje.*
import wollok.game.*
import tp.*

class Enemigo inherits Direccion {
	const imagen 
	var vida
	var property ultimaDireccion = norte
	const vidaInicial = vida
	const posInicial = position
	var property danio
	var property esEnemigo = true
	var property estaStuneado = false
	
	method recibirDanio (objetoDanino) {
		game.say(self,"auchis")
		vida -= objetoDanino.danio()
		if (vida <= 0) {
			self.borrar()
			self.resetearValores()
		}
	}
	
	method stun (objeto) {
		self.estaStuneado(true)
		game.schedule(3000,{self.estaStuneado(false)})
	}
	
	method spawn () {
		game.addVisual(self)
	}
		
	method image () = imagen
	
	method perseguir (pj) {
		if(not self.estaStuneado()) {
			game.onCollideDo(self,{algo => if (algo.esTrampa()) {algo.activar(self)} if(algo.esPersonaje()){algo.recibirDanio(danio)}})
			if (pj.position().x()>self.position().x()){
			position = este.siguientePosicion(self)
			ultimaDireccion = este
		}
			if (pj.position().x()<self.position().x()) {
			position = oeste.siguientePosicion(self)
			ultimaDireccion = oeste
		}
			if (pj.position().y()>self.position().y()){
			position = norte.siguientePosicion(self)
			ultimaDireccion = norte
		}
			if (pj.position().y()<self.position().y()){
			position = sur.siguientePosicion(self)
			ultimaDireccion = sur
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


const zombieUno = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png", danio = 5)
const zombieDos = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieDosChiquito.png", danio = 5)
const zombieTres = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieTresChiquito.png", danio = 5)
const zombieCuatro = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png", danio = 5)
const zombieCinco = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png", danio = 5)
const zombieSeis = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png", danio = 5)
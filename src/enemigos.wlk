import direcciones.*
import personaje.*
import wollok.game.*
import tp.*

class Enemigo inherits Direccion {
	const imagen 
	var vida
	const vidaInicial = vida
	const posInicial = position
	
	method recibirDanio (objetoDanino) {
		game.say(self,"auchis")
		vida -= objetoDanino.danio()
		if (vida <= 0) {
			self.borrar()
			vida = vidaInicial
			position = posInicial
		}
	}
	
	method spawn () {
		game.addVisual(self)
	}
	
	method image () = imagen
	
	method perseguir (pj) {
		if (pj.position().x()>self.position().x()){
			position = este.siguientePosicion(self)
		}
		if (pj.position().x()<self.position().x()) {
			position = oeste.siguientePosicion(self)
		}
		if (pj.position().y()>self.position().y()){
			position = norte.siguientePosicion(self)
		}
		if (pj.position().y()<self.position().y()){
			position = sur.siguientePosicion(self)
		}
		if (pj.position() == self.position()) {
			game.say(self,"Te atrape")
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
	
}


const zombieUno = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png")
const zombieDos = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieDosChiquito.png")
const zombieTres = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieTresChiquito.png")
const zombieCuatro = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png")
const zombieCinco = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png")
const zombieSeis = new Enemigo (position = game.at(30,10),vida = 10,imagen = "zombieChiquito.png")
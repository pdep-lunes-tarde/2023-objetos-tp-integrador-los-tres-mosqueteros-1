import direcciones.*
import personaje.*
import wollok.game.*
import tp.*

class Enemigo {
	var property position
	var property direction = norte
	var vida
	
	method recibirDanio (cantidad) {
		vida -= cantidad
	}
	
	method spawn () {
		game.addVisual(self)
	}
	
	method image () = "zombieChiquito.png"
	
	method perseguir (pj) {
		if (pj.position().x()>self.position().x()){
			position = self.position().right(1)
		}
		if (pj.position().x()<self.position().x()) {
			position = self.position().left(1)
		}
		if (pj.position().y()>self.position().y()){
			position = self.position().up(1)
		}
		if (pj.position().y()<self.position().y()){
			position = self.position().down(1)
		}
		if (pj.position() == self.position()) {
			game.say(self,"Te atrape")
		}
	}
	
	method borrar () {
		game.removeVisual(self)
	}
	
}


const zombieUno = new Enemigo (position = game.at(20,10),vida = 10)
const zombieDos = new Enemigo (position = game.at(20,10),vida = 10)
const zombieTres = new Enemigo (position = game.at(20,10),vida = 10)
const zombieCuatro = new Enemigo (position = game.at(20,10),vida = 10)
const zombieCinco = new Enemigo (position = game.at(20,10),vida = 10)
const zombieSeis = new Enemigo (position = game.at(20,10),vida = 10)
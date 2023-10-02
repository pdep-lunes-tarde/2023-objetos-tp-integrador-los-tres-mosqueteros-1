import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import pasivas.*
import direcciones.*
import tp.*

class Personaje {
	var property vida
	const vidaInicial = vida
	var property arma
	const armaInicial = arma
	var property laHabilidad
	const habilidadInicial = laHabilidad
	var imagen 
	var pasiva
	
	var property direction = sur
	var property position = game.origin()	
	
	method posicion () = position

	method image() = imagen
	
	method disparar () {
		arma.disparar(self)
	}
	
	method recibirDanio (cantidad) {
		if (vida==1){
			self.morir()
		}
		else {
			self.cambiarVida(-cantidad)
		}
	} 
	
	method morir () {
		self.resetearValores()
		game.clear()
		tpIntegrador.menu()
	}
	
	method resetearValores () {
		arma = armaInicial
		laHabilidad = habilidadInicial
		vida = vidaInicial
	}
	
	method cambiarVida (valor) {
		vida += valor
	}
	
	method lanzarHabilidad () {
		laHabilidad.lanzar(self)
	}
	
}

// Sacar el new trampa cuando creas el personaje y crear la trampa al lanzar la habilidad y despues en el tp hacer una lista de trampas y que vaya preguntando hace cuanto esta
const escopetero = new Personaje (vida = 20,arma = escopeta,laHabilidad = new Trampa(cooldown=10),pasiva = roboDeVida,imagen="mario.png")
const franco = new Personaje (vida = 15,arma = francotirador,laHabilidad = new Trampa(cooldown=10),pasiva = roboDeVida,imagen="pibe.png")
const ingeniero = new Personaje (vida = 10,arma = pistola,laHabilidad = new Trampa(cooldown=10),pasiva = roboDeVida,imagen="pibito.png")

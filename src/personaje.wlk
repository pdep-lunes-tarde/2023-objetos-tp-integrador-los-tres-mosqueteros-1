import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import pasivas.*
import direcciones.*

class Personaje {
	var vida
	var property arma
	var laHabilidad
	var imagen 
	var pasiva
	
	var property direction = sur
	var property position = game.origin()	
	
	method posicion () = position
	
	method empezarCentrado(){
		position = game.center()
	}
	
	method caminar () {}
	
	method image() = imagen
	
	method disparar () {
		arma.disparar(self)
	}
	
	method cambiarVida (valor) {
		vida += valor
	}
	
	method habilidad () {
		laHabilidad.lanzar()
	}
	
}

const escopetero = new Personaje (vida = 20,arma = escopeta,laHabilidad = trampa,pasiva = roboDeVida,imagen="mario.png")
const franco = new Personaje (vida = 15,arma = francotirador,laHabilidad = trampa,pasiva = roboDeVida,imagen="ejemploDos.png")
const ingeniero = new Personaje (vida = 10,arma = pistola,laHabilidad = trampa,pasiva = roboDeVida,imagen="ejemploUno.png")

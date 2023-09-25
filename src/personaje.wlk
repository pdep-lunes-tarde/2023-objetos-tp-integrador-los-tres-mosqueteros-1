import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import pasivas.*
import direcciones.*
// quite por ahora las idead de objetos y revivir, 
// estaba pensando muchas cosas y pense dejarlo mas para el final de ultima

class Personaje {
	var vida
	var property arma
	var laHabilidad
	var pasiva
	
	var property direction = sur
	var property position = game.origin()	
	
	method posicion () = position
	
	method empezarCentrado(){
		position = game.center()
	}
	
	method caminar () {}
	
	method image() = "mario.png"
	
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

const escopetero = new Personaje (vida = 20,arma = escopeta,laHabilidad = trampa,pasiva = roboDeVida)
//const franco = new Personaje (vida = 15,arma = francotirador,habilidad = red,pasiva = multiplicadorDeDanio)
//const ingeniero = new Personaje (vida = 10,arma = pistola,habilidad = granada,pasiva = mejoraDeArma)

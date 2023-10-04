import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import pasivas.*
import direcciones.*
import tp.*

class Personaje {
	var property vida
	var property arma
	var property habilidad
	var pasiva
	
	var property habilidadEnCd = false
	var cooldownHabilidad
	
	const vidaInicial = vida
	const armaInicial = arma
	const habilidadInicial = habilidad	
	
	var property imagenDerecha
	var property imagenIzquierda
	var property imagenMenu 
	var property imagen = imagenMenu
	
	var property direction = sur
	var property position = game.origin()	

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
		habilidad = habilidadInicial
		vida = vidaInicial
	}
	
	method cambiarVida (valor) {
		vida += valor
	}
	
	method lanzarHabilidad () {
		if(not habilidadEnCd){
			habilidad.lanzar(self)
			self.habilidadEnCd(true)
			game.schedule(1000*cooldownHabilidad,{self.habilidadEnCd(false)})
		}
		else{
			game.say(self,"aun no")
		}
		
	}
	
}

const escopetero = new Personaje (vida = 20,arma = escopeta,habilidad = new Trampa(),cooldownHabilidad = 10,pasiva = roboDeVida,imagenDerecha="escopetero derecha.png",imagenIzquierda="escopetero izquierda.png",imagenMenu="escopetero menu1.png")
const franco = new Personaje (vida = 15,arma = francotirador,habilidad = new Trampa(),cooldownHabilidad = 10,pasiva = roboDeVida,imagenDerecha="sniper chiquito.png",imagenIzquierda="sniper izquierda.png",imagenMenu="sniper.png")
const ingeniero = new Personaje (vida = 10,arma = pistola,habilidad = new Trampa(),cooldownHabilidad = 10,pasiva = roboDeVida,imagenDerecha="ing.png",imagenIzquierda="ingiz.png",imagenMenu="ing menu1.png")

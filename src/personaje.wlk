import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import direcciones.*
import tp.*
import obstaculos.*
import enemigos.*

class Personaje  {
	var property esTrampa = false
	var property esEnemigo = false
	var property esPersonaje = true
	
	var property recibioDanioHacePoco = false
	var property vida
	var property arma
	var property habilidad
	
	var property habilidadEnCd = false
	var property cooldownHabilidad
	
	var property armaEnCd = false
	var property cooldownArma
	
	const vidaInicial = vida
	const armaInicial = arma
	const habilidadInicial = habilidad	
	
	var property imagenDerecha
	var property imagenIzquierda
	var property imagenMenu 
	var property imagen = imagenMenu
	
	var property direction = sur
	var property position = new Posicion (x=0,y=0)	

	method image() = imagen
	
	method siguientePosicion(){ 
		return direction.siguientePosicion(self)	
	}
	
	
	method correr(dir){
		direction = dir
		position = self.siguientePosicion()
	}
	
	method disparar () {
		if (not armaEnCd) {
			arma.disparar(self)
			armaEnCd = true
			game.schedule(250*cooldownArma,{armaEnCd = false})
		}
	}
	
	method recibirDanio (cantidad) {
		if (not recibioDanioHacePoco) {
			vida -= cantidad
			if (vida <= 0){
			self.morir()
			}
			self.recibioDanioHacePoco(true)
			game.schedule(500,{self.recibioDanioHacePoco(false)})
		}
	} 
	
	method curar (cantidad) {
		vida += cantidad
	}
	
	method morir () {
		tpIntegrador.resetearValores()		
	}
	
	method resetearValores () {
		arma = armaInicial
		habilidad = habilidadInicial
		vida = vidaInicial
		imagen = imagenMenu
		position = new Posicion (x=0,y=0)
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
	
	method mejorar () {
		habilidad.mejorar(self)
		vida += 5
		game.say(self,"Me siento mas fuerte!")
	}
	
}

class Ingeniero inherits Personaje {
	const listaArmas = [subfusil,ak,ligera]
	var selector = 0
	
	override method mejorar () {
		super()
		self.arma(listaArmas.get(selector))
		selector = 2.max(selector+1)
		cooldownArma -= 0.4
	}
}

const escopetero = new Personaje (vida = 5,arma = escopeta,cooldownArma = 3,habilidad = new Trampa(),cooldownHabilidad = 10,imagenDerecha="escopetero derecha.png",imagenIzquierda="escopetero izquierda.png",imagenMenu="escopetero menu1.png")
const franco = new Personaje (vida = 4,arma = francotirador,cooldownArma = 5,habilidad = new DisparoCertero(),cooldownHabilidad = 15,imagenDerecha="sniper chiquito.png",imagenIzquierda="sniper izquierda.png",imagenMenu="sniper.png")
const ingeniero = new Personaje (vida = 3,arma = pistola,cooldownArma = 2,habilidad = new Granada(),cooldownHabilidad = 9,imagenDerecha="ing.png",imagenIzquierda="ingiz.png",imagenMenu="ing menu1.png")

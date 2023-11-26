import wollok.game.*
import armas.*
import balas.*
import habilidades.*
import direcciones.*
import tp.*
import obstaculos.*
import enemigos.*
import menu.*

class Personaje  {
	var property esTrampa = false
	var property esEnemigo = false
	var property esPersonaje = true
	
	var property recibioDanioHacePoco = false
	var property vida
	var property corazones 
	var property arma
	var property ventaja
	
	var property habilidadEnCd = false
	var property cooldownHabilidad
	
	var property armaEnCd = false
	var property cooldownArma
	
	const vidaInicial = vida
	const armaInicial = arma
	const habilidadInicial = ventaja	
	
	var property imagenDerecha
	var property imagenIzquierda
	var property imagenMenu 
	var property imagen = imagenMenu
	
	var property direction = sur
	var property position
	var property posicionInicial = position

	method image() = imagen
	
	method personajePosX(){
		return position.x()
	}
	
	method personajePosY(){
		return position.y()
	}
	
	method siguientePosicion(){ 
		return direction.siguientePosicion(self)	
	}
	
	method inicializarCorazones(){
		corazones.forEach({x => x.ponerCorazon()})
	}
	
	method correr(dir){
		direction = dir
		position = self.siguientePosicion()
	}
	
	method disparar() {
		if (not armaEnCd) {
			arma.disparar(self)
			armaEnCd = true
			game.schedule(250*cooldownArma,{armaEnCd = false})
		}
	}
	
	method recibirDanio (objeto) {
		if (not recibioDanioHacePoco) {
			corazonesInterfaz.sacarVida(vida)
			vida -= objeto.danio()
			if (vida <= 0){
			self.morir()
			}
			self.recibioDanioHacePoco(true)
			game.schedule(700,{self.recibioDanioHacePoco(false)})
		}
	} 
	
	method curar (cantidad) {
		vida += cantidad
		corazonesInterfaz.ponerVida(vida)
	}
	
	method morir () {
		tpIntegrador.resetearValores()		
	}
	
	method resetearValores () {
//		arma = armaInicial
//		habilidad = habilidadInicial
		vida = vidaInicial
		imagen = imagenMenu
		position = posicionInicial
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
		self.curar(1)
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

class JugadorDos inherits Personaje {
	override method recibirDanio (objeto) {
		if (not recibioDanioHacePoco) {
			corazonesInterfaz.sacarVida(vida+7)
			vida -= objeto.danio()
			if (vida <= 0){
			self.morir()
			}
			self.recibioDanioHacePoco(true)
			game.schedule(700,{self.recibioDanioHacePoco(false)})
			}
	} 
	
	override method curar (cantidad) {
		vida += cantidad
		corazonesInterfaz.ponerVida(vida+7)
	}
}

const escopetero = new Personaje (position=new Posicion (x=0,y=10),vida = 5,corazones=[vidaUno,vidaDos,vidaTres,vidaCuatro,vidaCinco],arma = escopeta,cooldownArma = 3,ventaja = new Trampa(),cooldownHabilidad = 10,imagenDerecha="escopetero derecha.png",imagenIzquierda="escopetero izquierda.png",imagenMenu="escopetero menu1.png")
const franco = new Personaje (position=new Posicion (x=0,y=10),vida = 2,corazones=[vidaUno,vidaDos],arma = francotirador,cooldownArma = 5,ventaja = new DisparoCertero(),cooldownHabilidad = 15,imagenDerecha="sniper chiquito.png",imagenIzquierda="sniper izquierda.png",imagenMenu="sniper.png")
const ingeniero = new Personaje (position=new Posicion (x=0,y=10),vida = 3,corazones=[vidaUno,vidaDos,vidaTres],arma = pistola,cooldownArma = 2,ventaja = new Granada(),cooldownHabilidad = 9,imagenDerecha="ing.png",imagenIzquierda="ingiz.png",imagenMenu="ing menu1.png")
const jugadorUno = new Personaje (position=new Posicion (x=0,y=10),vida=3,corazones=[vidaUno,vidaDos,vidaTres],arma = multi,cooldownArma=1,ventaja=new Granada(),cooldownHabilidad = 9,imagenDerecha="ing.png",imagenIzquierda="ingiz.png",imagenMenu="ing menu1.png")
const jugadorDos = new JugadorDos (position=new Posicion (x=20,y=10),vida=3,corazones=[vidaUnoJ2,vidaDosJ2,vidaTresJ2],arma = multi,cooldownArma=1,ventaja=new Granada(),cooldownHabilidad = 9,imagenDerecha="ing.png",imagenIzquierda="ingiz.png",imagenMenu="ing menu1.png")
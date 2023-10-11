import wollok.game.*
import direcciones.*
import personaje.*
import tp.*

class Bala {
	
	var property direccion = sur
	var property position = game.origin()
	var property danio
	var property rango 
	var property imagen
	
	method spawn (pj) {
		direccion = pj.direction()
		position = direccion.siguientePosicion(pj)
		self.agregarImagen()
		tpIntegrador.agregarBala(self)
	}
	
	method agregarImagen (){
		if(direccion==sur){
			imagen = "balaabajo.png"
			game.addVisual(self)
		}
		if(direccion==norte){
			imagen = "balaarriba.png"
			game.addVisual(self)
		}
		if(direccion==oeste){
			imagen = "balaizquierda.png"
			game.addVisual(self)
		}
		if(direccion==este){
			imagen = "bala.png"
			game.addVisual(self)	
		}
	}
	
	method viajar (pj) {
		if (rango>0){
			position = direccion.siguientePosicion(self)
			game.onCollideDo(self,{enemigo => enemigo.recibirDanio(self) self.borrarBala() rango=0})
			rango --
		}
		else {self.borrarBala()}
	}
	
	method borrarBala () {
		if (game.hasVisual(self)) {
			tpIntegrador.sacarBala(self)
			game.removeVisual(self)
		}
	}
	
	method recibirDanio (algo) {
		
	}
	
	method image () = imagen
	
}

const cartucho = new Bala (rango=5,imagen="bala.png",danio=3)
const calibreFranco = new Bala (rango=100,imagen="manzana.png",danio=1)
const calibreComun = new Bala (rango=7,imagen="bala.png",danio=1)
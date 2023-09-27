import wollok.game.*
import direcciones.*
import personaje.*
import tp.*

class Bala {
	
	var property direccion = sur
	var property position = game.origin()
	var property rango 
	const property imagen
	
	method spawn (pj) {
		direccion = pj.direction()
		position = direccion.siguientePosicion(pj)
		game.addVisual(self)
//		self.viajar(pj)
		tpIntegrador.agregarBala(self)
	}
	
	method viajar (pj) {
//		game.onTick(100,"viajeBala",{position = direccion.siguientePosicion(self)})
//		if(game.hasVisual(self)){game.schedule(100*rango+1,{self.borrarBala()})}
		if (rango>0){
			position = direccion.siguientePosicion(self)
			rango --
		}
		else {self.borrarBala()}
	}
	
	method borrarBala () {
//		game.removeTickEvent("viajeBala")
		tpIntegrador.sacarBala(self)
		game.removeVisual(self)
	}
	
	method image () = imagen
	
}

const cartucho = new Bala (rango=5,imagen="bala.png")
const calibreFranco = new Bala (rango=100,imagen="manzana.png")
const calibreComun = new Bala (rango=7,imagen="bala.png")
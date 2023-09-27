import wollok.game.*
import direcciones.*
import personaje.*

class Bala {
	
	var property direccion = sur
	var property position = game.origin()
	const property rango 
	const imagen
	
	method spawn (pj) {
		direccion = pj.direction()
		position = direccion.siguientePosicion(pj)
		game.addVisual(self)
		self.viajar(pj)
	}
	
	method viajar (pj) {
		game.onTick(100,"viajeBala",{position = direccion.siguientePosicion(self)})
		if(game.hasVisual(self)){game.schedule(100*rango+1,{self.borrarBala()})}
	}
	
	method borrarBala () {
		game.removeTickEvent("viajeBala")
		game.removeVisual(self)
	}
	
	method image () = imagen
	
}

const cartucho = new Bala (rango=5,imagen="bala.png")
const calibreFranco = new Bala (rango=100,imagen="manzana.png")
const calibreComun = new Bala (rango=7,imagen="bala.png")
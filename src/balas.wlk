import wollok.game.*
import direcciones.*
import personaje.*
import tp.*

class Bala {
	var property esEnemigo = false
	var property esTrampa = false
	var property esPersonaje = false
	var property direccion = sur
	var property position = new Posicion (x=0,y=0)
	var property danio
	var property rango 
	var property imagen
	
	method creaBala (pj) = new Bala (danio = 1 , imagen = "bala.png" , rango = 7)
	
	method spawn (pj) {
		direccion = pj.direction()
		position = direccion.siguientePosicion(pj)
		self.agregarImagen()
		tpIntegrador.agregarUtilidad(self)
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
			game.onCollideDo(self,{enemigo => if(enemigo.esEnemigo()){enemigo.recibirDanio(self) self.borrarBala() rango=0}})
			rango --
		}
		else {self.borrarBala()}
	}
	
	method borrarBala () {
		if (game.hasVisual(self)) {
			tpIntegrador.sacarUtilidad(self)
			game.removeVisual(self)
		}
	}
	
	
	method image () = imagen
	
}

class CalibreFranco inherits Bala {
	var distanciaViajada = 0
	
	override method creaBala (pj) = new CalibreFranco (danio = 1 , imagen = "bala.png" , rango = 15)
	
	override method viajar (pj) {
		if (rango>0){
			position = direccion.siguientePosicion(self)
			distanciaViajada ++
			danio += distanciaViajada/2
			game.onCollideDo(self,{enemigo => if(enemigo.esEnemigo()){enemigo.recibirDanio(self) self.borrarBala() rango=0}})
			rango --
		}
		else {self.borrarBala()}
	}
}

class Cartucho inherits Bala {
	
	override method creaBala (pj) = new Cartucho (danio = 7 , imagen = "bala.png" , rango = 5)
	
	override method viajar (pj) {
		if (rango>0){
			position = direccion.siguientePosicion(self)
			game.onCollideDo(self,{enemigo => if(enemigo.esEnemigo()){enemigo.recibirDanio(self) self.borrarBala() rango=0 pj.curar(1)}})
			rango --
		}
		else {self.borrarBala()}
	}
}

class CalibreSubfu inherits Bala {
	override method creaBala (pj) = new Bala (rango = 6,imagen = "bala.png",danio = 2)
}

class CalibreAk inherits Bala {
	override method creaBala (pj) = new Bala (rango = 10,imagen = "bala.png",danio = 4)
}

class CalibreLigero inherits Bala {
	override method creaBala (pj) = new Bala (rango = 14,imagen = "bala.png",danio = 6)
}

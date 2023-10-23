import balas.*

class Arma {
	const property tipoMunicion
	
	method disparar (pj) {
		const balaDisparada = tipoMunicion.creaBala(pj)
		balaDisparada.spawn(pj)
	}
	
}

const escopeta = new Arma (tipoMunicion = new Cartucho (danio = 3,imagen = "bala.png",rango = 5))
const francotirador = new Arma (tipoMunicion = new CalibreFranco (danio = 1,imagen = "bala.png",rango = 15))

const pistola = new Arma (tipoMunicion = calibreComun)
//const subfusil = new Arma (tipoMunicion = calibreSubfu)
//const ak = new Arma (tipoMunicion = calibreAk)
//const ligera = new Arma (tipoMunicion = calibreLigero)
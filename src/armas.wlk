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

const pistola = new Arma (tipoMunicion =  new Bala (rango=7,imagen="bala.png",danio=1))
const subfusil = new Arma (tipoMunicion = new CalibreSubfu (danio = 2,imagen = "bala.png",rango = 6))
const ak = new Arma (tipoMunicion = new CalibreAk (rango = 10,imagen = "bala.png",danio = 4))
const ligera = new Arma (tipoMunicion = new CalibreLigero (rango = 14,imagen = "bala.png",danio = 6))
const multi = new Arma (tipoMunicion = new Multi (rango = 12,imagen="bala.png",danio=1))
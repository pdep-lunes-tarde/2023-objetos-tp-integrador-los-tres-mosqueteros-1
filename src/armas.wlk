import balas.*

class Arma {
	const property tipoMunicion
	
	method disparar (pj) {
		const balaDisparada = new Bala (imagen=tipoMunicion.imagen(),rango=tipoMunicion.rango())
		balaDisparada.spawn(pj)
	}
	
}

const escopeta = new Arma (tipoMunicion = cartucho)
const francotirador = new Arma (tipoMunicion = calibreFranco)

const pistola = new Arma (tipoMunicion = calibreComun)
//const subfusil = new Arma (tipoMunicion = calibreSubfu)
//const ak = new Arma (tipoMunicion = calibreAk)
//const ligera = new Arma (tipoMunicion = calibreLigero)
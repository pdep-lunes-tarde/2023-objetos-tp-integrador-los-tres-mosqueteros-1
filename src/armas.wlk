import balas.*

class Arma {
	var property tipoMunicion
	
	method disparar (pj) {
		tipoMunicion.spawn(pj)
	}
	
}

const escopeta = new Arma (tipoMunicion = cartucho)
//const francotirador = new Arma (tipoMunicion = calibreFranco)
//
//const pistola = new Arma (tipoMunicion = calibreComun)
//const subfusil = new Arma (tipoMunicion = calibreSubfu)
//const ak = new Arma (tipoMunicion = calibreAk)
//const ligera = new Arma (tipoMunicion = calibreLigero)
import wollok.game.*

class Obstaculo{ 
	var property position = self.posInicial()
	var property esTrampa = false
	var property esEnemigo = false
	var property esPersonaje = false
	method image()= "auto_destruido.png"
	
	method posInicial() {
    	const x = 0.randomUpTo(game.width()).truncate(0)
    	const y = 0.randomUpTo(game.height()).truncate(0) 
    	position = game.at(x,y) 
    	return position
  }
  
}

const obs1 = new Obstaculo()
const obs2 = new Obstaculo()
const obs3 = new Obstaculo()
const obs4 = new Obstaculo()
const obs5 = new Obstaculo()
const obs6 = new Obstaculo()
const obs7 = new Obstaculo()
const obs8 = new Obstaculo()
const obs9 = new Obstaculo()
const obs10 = new Obstaculo()

const obstaculos = [obs1, obs2, obs3, obs4, obs5, obs6, obs7, obs8, obs9, obs10]
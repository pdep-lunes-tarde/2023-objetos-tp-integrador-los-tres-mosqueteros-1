import personaje.*

object eleccion {
	const personajes = [escopetero,franco,ingeniero]
	var property personajeElegido
	
	method seleccion (numero) {
		personajeElegido = personajes.get(numero)
		return personajeElegido
	}
	
}

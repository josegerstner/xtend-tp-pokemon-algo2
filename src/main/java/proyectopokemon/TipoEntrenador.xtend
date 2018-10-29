package proyectopokemon

//clase utilizada para setear el tipo de entrenador
abstract class TipoEntrenador {
	// método abstracto que debe tener cada clase hija
	def boolean esExperto(Entrenador ash){false}
	def void SumarEXPadicional(Entrenador ash){}
	def void SumarEXPcaptura(Entrenador ash, Pokemon nuevoPokemon){}
	def void SumarEXPevolucion(Entrenador ash){}
}

class Luchador extends TipoEntrenador {
	override esExperto(Entrenador ash) {
		ash.getNivel() > 18 || ash.getCombatesGanados() > 30
	}

	override SumarEXPadicional(Entrenador ash) {
		ash.experiencia = ash.experiencia + 200
	}
}

class Coleccionista extends TipoEntrenador {
	override esExperto(Entrenador ash) {
		ash.getNivel() > 13 || (ash.cantidadEspeciesAtrapadas() > 20 && ash.coleccionBalanceada())
	}
	override SumarEXPcaptura(Entrenador ash, Pokemon nuevoPokemon) {
		if (!(ash.tengoPokemon(nuevoPokemon) )) {
			ash.ganaExperiencia(500)
		}
	}
}

class Criador extends TipoEntrenador {
	override esExperto(Entrenador ash) {
		ash.pokemonEvolucionados() > 15 && ash.pokemonDeGranNivel() > 5
	}
	override SumarEXPevolucion(Entrenador ash) {
		ash.ganaExperiencia(200+ash.pokemonAcombate.experiencia)
	}
}
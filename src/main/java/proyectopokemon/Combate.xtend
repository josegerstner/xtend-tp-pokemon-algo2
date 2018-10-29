/**********************************************************
 * Materia: Algoritmos 2
 * 		Año 2017
 * Gurpo 6:
 * 			Julián Haeberli
 * 			Marcos Parisi
 * 			José Gerstner
 * Entrega 0 : Pokémon AL GO II
 *********************************************************/
package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Combate {

	var Entrenador peleador1
	var Entrenador peleador2
	var double random = Math.random

//peleador 2 siempre es el jugador. Peleador1 es el NPC
	new(Entrenador NPC, Entrenador Jugador) {
		peleador1 = NPC
		peleador2 = Jugador
		
	}

	// Antes de iniciar un combate verificamos la distancia entre los dos
	def Pelear() {
		DistanciaParaPelear()
		Ganador()

	}

	def DistanciaParaPelear() {
		if (Math.max(0, peleador1.dondeEstoy.distance(peleador2.dondeEstoy)) > 5) {
			throw new BussinesException("Muy lejos para pelear")
		}
	}

	def Ganador() {
		if (this.dameRandom() <= (CalculoChances(peleador2, peleador1) /
			(CalculoChances(peleador2, peleador1) + CalculoChances(peleador1, peleador2)))) {
			peleador2.ganarCombate()
			GanarPelearDinero()
			GanarPeleaSumaExperiencia()
			PokemonRecibeDano()
			PokemonSumaExperiencia()
		} else {
			PerderPeleaDinero()
			PerderPeleaPokemonKO()
		}
	}

	def porcentajePorFuerte(Pokemon poke1, Pokemon poke2) {
		if (poke2.especie.miTipo.exists[tipo|poke1.soyFuerte(tipo)]) {
			poke1.puntosAtaque * 0.25
		}
	}

	def porcentajePorResistente(Pokemon poke1, Pokemon poke2) {
		if (poke2.especie.miTipo.exists[tipo|poke1.soyResistente(tipo)]) {
			poke1.puntosSaludMaxima * 0.15
		}
	}

	def porcentajeEntrenadorExperto(Entrenador _entrenador) {
		if (_entrenador.tipo.esExperto(_entrenador)) {
			_entrenador.pokemonAcombate.puntosAtaque * 0.25
		} else {
			0
		}
	}

//Calculo de de chances. yo es el que hace ChancesPropias.
	def double CalculoChances(Entrenador yo, Entrenador EL) {
		yo.pokemonAcombate.puntosAtaque + porcentajePorFuerte(yo.pokemonAcombate, yo.pokemonAcombate) +
			porcentajePorResistente(yo.pokemonAcombate, yo.pokemonAcombate) + porcentajeEntrenadorExperto(yo)
	}

	def PokemonRecibeDano() {
		peleador2.pokemonAcombate.salud =  (peleador2.pokemonAcombate.puntosSaludMaxima *
			( (peleador2.pokemonAcombate.puntosAtaque) * 1.00 /
				(peleador2.pokemonAcombate.puntosAtaque + peleador1.pokemonAcombate.puntosAtaque))).intValue
		}

		// Aca empiezan los suscesos que ocurren si GANA la pelea
		def void GanarPelearDinero() {
			peleador2.dinero = peleador2.dinero + peleador2.dineroApostado
		}

		def void GanarPeleaSumaExperiencia() {
			peleador2.experiencia = peleador2.experiencia + 300
			if (peleador2.getNivel - peleador1.getNivel > 0) {
				peleador1.tipo.SumarEXPadicional(peleador1)
			}
		}

		def void PokemonSumaExperiencia() {
			peleador2.pokemonAcombate.experiencia = peleador2.pokemonAcombate.experiencia +
				(peleador1.pokemonAcombate.experiencia * 0.1).intValue
			peleador2.evolucionarPokemon()
		}

		// ACA empiezan los sucesos que ocurren si PIERDE la pelea
		def void PerderPeleaDinero() {
			// peleador2.dinero = Math.max(peleador2.dinero - peleador2.dineroApostado, 0)
			peleador2.dinero = peleador2.dinero - peleador2.dineroApostado
		}

		def void PerderPeleaPokemonKO() {
			peleador2.pokemonAcombate.salud = 0
		}

		def double dameRandom() {
			Math.random
		}

	}
	
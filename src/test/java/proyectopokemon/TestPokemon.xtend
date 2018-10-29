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

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.uqbar.geodds.Point

class TestPokemon {
	var pikachu = new Especie(100, 200)
	var metapod = new Especie(10, 20)
	var poka = new Pokemon(pikachu, "Macho", new Tipo("Electrico"))
	var capullo = new Pokemon(metapod, "Hembra", new Tipo("Bicho"))
	var buterfree = new Especie(20, 40)
	val punto = new Point(1, 2)

	@Before
	def initialize() {
		poka.experiencia = 50
		metapod.evolucion = buterfree
		metapod.nivelEvolucion = 10
		poka.dondeEsta = new Point(2, 4)
	}

	@Test
	def ConExperiencia50elNivelEs1() {
		Assert.assertEquals(poka.getNivel, 1, 0.01)
	}

	@Test
	def PuntosDeAtaqueConExperiencia2Es54() {
		Assert.assertEquals(poka.puntosAtaque(), 100, 1)
	}

	@Test
	def PuntosDeSaludConExperiencia2Es108() {
		Assert.assertEquals(poka.puntosSaludMaxima(), 200, 1)
	}

	@Test
	def SetearDondeEstaPokemonX2Y4SetearPuntoX1Y2AssertNotEquals() {
		Assert.assertNotEquals(poka.distanciaHasta(punto), 0, 1)
	}

	@Test
	def MedirDistanciaEntreDosPuntos() {
		capullo.dondeEsta = new Point(-34.578511, -58.526840)
		var Point punto = new Point(-34.541876, -58.444556)
		Assert.assertEquals(capullo.distanciaHasta(punto), 8.59, 0.1)
	}

	@Test
	def MetapodEvolucionaAButerfree() {
		capullo.experiencia=5000
		capullo.evolucionar()
		Assert.assertEquals(capullo.especie, buterfree)
	}
}

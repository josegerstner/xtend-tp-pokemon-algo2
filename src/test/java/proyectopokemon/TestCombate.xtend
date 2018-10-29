/**********************************************************
 * Materia: Algoritmos 2
 * 		Año 2017
 * Gurpo 6:
 * 			Julián Haeberli
 * 			Marcos Parisi
 * 			José Gerstner
 * Entrega : Pokémon AL GO II
 *********************************************************/
package proyectopokemon

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.uqbar.geodds.Point
import static org.mockito.Mockito.*

class TestCombate {
	var ash = new Entrenador(new Coleccionista())
	var garyLejos = new Entrenador(new Coleccionista())
	var garyCerca = new Entrenador(new Coleccionista())
	var pichachu = new Especie(100, 200)
	var metapod = new Especie(10, 20)
	var poka = new Pokemon(pichachu, "Macho", new Tipo("Electrico"))
	var meta = new Pokemon(metapod, "Hembra", new Tipo("Bicho"))
	var ArenaLejos = new Combate(garyLejos, ash)
	var ArenaCercaPerdedora = new Combate(garyCerca, ash)
	var ArenaCercaGanador = new Combate(garyCerca, ash)

	@Before
	def void initialize() {

		ash.movete(new Point(0, 0))
		garyLejos.movete(new Point(11, 11))
		garyCerca.movete(new Point(0, 0))
		ash.pokemonAcombate = poka
		garyCerca.pokemonAcombate = meta
		ArenaCercaPerdedora = mockearArenaPerdedora()
		ArenaCercaGanador = mockearArenaGanador()

	}

	@Test(expected=RuntimeException)
	def void DosEntrenadoresEstanMuyLejosParaPelear() {
		ArenaLejos.Pelear()
	}

	@Test
	def DosEntrenadoresPeleanYUnoPierdeDinero() {
		ash.dineroApostado = 50
		ArenaCercaPerdedora.Pelear()
		Assert.assertEquals(ash.dinero, 450, 1)
		verify(ArenaCercaPerdedora, times(1)).PerderPeleaDinero
	}

	@Test
	def DosEntrenadoresPeleanUnoPierdeYPokemonMuere() {
		ArenaCercaPerdedora.Pelear()
		Assert.assertEquals(ash.pokemonAcombate.salud, 0)
		verify(ArenaCercaPerdedora, times(1)).PerderPeleaPokemonKO
	}

	@Test
	def DosEntrenadoresPeleanYUnoGanaDinero() {
		poka.experiencia = 50000
		meta.experiencia = 50000
		ash.dineroApostado = 90
		ArenaCercaGanador.Pelear()
		Assert.assertEquals(ash.dinero, 590, 1)
		verify(ArenaCercaGanador, never).PerderPeleaPokemonKO
	}

	@Test
	def DosEntrenadoresPeleanYSeReduceLaSaludDelPokemon() {
		ash.dineroApostado = 100
		ArenaCercaGanador.Pelear()
		Assert.assertEquals(ash.pokemonAcombate.salud, 181)
		verify(ArenaCercaGanador, times(1)).GanarPeleaSumaExperiencia
	}

	@Test
	def DosEntrenadoresPeleanDosVecesYGanaExpDosveces() {
		ash.dineroApostado = 100
		ArenaCercaGanador.Pelear()
		ArenaCercaGanador.Pelear()
		Assert.assertEquals(ash.pokemonAcombate.salud, 181)
		verify(ArenaCercaGanador, times(2)).GanarPeleaSumaExperiencia
	}

	def mockearArenaPerdedora() {
		var Combate ArenaCercaPerder = spy(ArenaCercaPerdedora)
		when(ArenaCercaPerder.dameRandom).thenReturn(1d)
		ArenaCercaPerder
	}

	def mockearArenaGanador() {
		var ArenaCercaGana = spy(ArenaCercaGanador)
		when(ArenaCercaGana.dameRandom).thenReturn(0d)
		ArenaCercaGana
	}
}

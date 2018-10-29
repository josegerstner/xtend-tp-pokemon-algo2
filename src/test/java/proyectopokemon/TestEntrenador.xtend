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

import static org.mockito.Mockito.*
import org.junit.Test
import org.junit.Before
import org.junit.Assert
import org.uqbar.geodds.Point

class TestEntrenador {
	val ash = new Entrenador(new Luchador)
	val gary = new Entrenador(new Coleccionista())
	var brook = new Entrenador(new Criador)

	val pichachu = new Especie(100, 200)
	val raichu = new Especie(200, 400)
	val metapod = new Especie(10, 20)

	val poka = new Pokemon(pichachu, "Macho", new Tipo("Electrico"))
	val meta = new Pokemon(metapod, "Hembra", new Tipo("Bicho"))
	val Arena = new Combate(gary, ash)
	var MailSender sender
	var NotificarEnviarMailSuperado Superao
	var NotificarEnviarMailLVLMax MaxLVL
	
	@Before
	def void initialize() {
		pichachu.evolucion = raichu
		pichachu.nivelEvolucion = 11
		poka.especie = pichachu
		meta.especie = metapod
		poka.experiencia = 5000
		meta.experiencia = 50000
		sender = MockearMailSender()
		Superao = new NotificarEnviarMailSuperado(ash, sender)
		MaxLVL = new NotificarEnviarMailLVLMax(ash, sender)
	}

	@Test
	def verSiTengoPokemon() {
		ash.pokemonAtrapados.add(poka)
		Assert.assertTrue(ash.pokemonAtrapados.contains(poka))
	}

	@Test
	def queEvolucioneUnPokemon() {
		ash.movete(new Point(0, 0))
		gary.movete(new Point(0, 0))
		ash.pokemonAcombate = poka
		gary.pokemonAcombate = meta
		Arena.random = 0d
		ash.dineroApostado = 90
		Arena.Pelear()
		Assert.assertEquals(ash.pokemonAcombate.especie, raichu)
	}

	@Test
	def void nivelEntrenadorEs1() {
		Assert.assertEquals(1, ash.getNivel)
	}

	@Test
	def void nivelEntrenadorEs20() {
		ash.setExperiencia(220000)
		Assert.assertEquals(20, ash.getNivel)
	}

	@Test
	def void entrenadorEsExperto() {
		ash.setExperiencia(210000)
		ash.setCombatesGanados(31)
		Assert.assertTrue(ash.tipo.esExperto(ash))
	}

	
	
	@Test
	def void SubirAnivelMax() {
		ash.amigos.add(gary)
		brook.experiencia=14000
		ash.amigos.add(brook)
		ash.agregarAccion(MaxLVL)
		ash.experiencia = 100
		ash.ganaExperiencia(500000)
		Assert.assertEquals(brook.notificaciones.size,1)
	}
	
	def MockearMailSender() {
		val temporal = mock(typeof(MailSender))
		temporal
	}

}

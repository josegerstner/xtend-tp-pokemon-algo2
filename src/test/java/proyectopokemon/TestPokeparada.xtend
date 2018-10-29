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
import org.uqbar.geodds.Point
import org.junit.Assert

class TestPokeparada {
	var Entrenador entrenador = new Entrenador(new Luchador)
	var Entrenador otroEntrenador =  new Entrenador(new Luchador)
	val pokeparadaLejos = new Pokeparada(new Point(-24.578511, 0.526840), "Pokeparada Larguirucho")
	val pokeparadaCerca = new Pokeparada(new Point(-34.578511, -58.526840), "Pokeparada Magikarp")
	var pokeparadaCercaConStock = new Pokeparada(new Point(-34.578511, -58.526840), "Pokeparada FreeBalls")
	val pokebola = new Item("pokebola",50d,10)
	var pikachu = new Especie(100, 200)
	var metapod = new Especie(10, 20)
	var poka = new Pokemon(pikachu, "Macho", new Tipo("Electrico"))
	var capullo = new Pokemon(metapod, "Hembra", new Tipo("Bicho"))
	var Item hierro = new ItemDecoratorSimple(new Item("HIERRO",20,50d),5,10)
	
	@Before
	def void initialize(){
		pokeparadaCercaConStock.agregarItem(pokebola)
		pokeparadaCercaConStock.agregarItem(hierro)
		entrenador.setDondeEstoy(new Point(-34.578511, -58.526840))
		otroEntrenador.setDondeEstoy(new Point(-34.578511, -58.526840))
	}
	
	@Test(expected=BussinesException)
	def void comproPokebolaEnPokeparadaLejosDaExpecion(){
		entrenador.comprarItem(pokebola, pokeparadaLejos)
	}
	
	@Test(expected=BussinesException)
	def void comproPokebolaEnPokeparadaCercaQueNoTienePokebola(){
		entrenador.comprarItem(pokebola, pokeparadaCerca)
	}
	
	@Test(expected=BussinesException)
	def void comproPokebolaEnPokeparadaCercaSinStock(){
		entrenador.comprarItem(pokebola, pokeparadaCerca)
	}
	
	@Test
	def void testDeIntercambioInvalido(){
		entrenador.sumoPokemon(poka)
		otroEntrenador.sumoPokemon(capullo)
		Assert.assertFalse(pokeparadaLejos.intercambioValido(entrenador, poka, otroEntrenador, capullo))
	}
	
	@Test
	def void testDeIntercambioValido(){
		entrenador.sumoPokemon(poka)
		otroEntrenador.sumoPokemon(capullo)
		Assert.assertTrue(pokeparadaCerca.intercambioValido(entrenador, poka, otroEntrenador, capullo))
	}
	
	@Test
	def void comproPocionDecoradaEstaAgregadaAlListado(){
		Assert.assertTrue(pokeparadaCercaConStock.productos.contains(hierro))
	}
}
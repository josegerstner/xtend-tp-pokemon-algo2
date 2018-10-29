package proyectopokemon

import org.junit.Test
import org.junit.Before
import org.junit.Assert
import java.util.List

class TestItemDecorador {
	var electrico = new Tipo("Electrico")
	var planta = new Tipo("Planta")
	var pocion = new Item("POCION", 20, 50d)
	var Item hierro = new ItemDecoratorSimple(pocion, 5, 10)
	var Item zinc = new ItemDecoratorPorcentaje(pocion, 25, 10)
	var Item cobre = new ItemDecoratorPorcentaje(pocion, 20, 10, electrico, 50)
	
	var Item compuesto = new ItemDecoratorPorcentaje(zinc, 25, 10)

	var pikachu = new Especie(100, 200)
	var List<Tipo> listaElectrico = newArrayList
	var List<Tipo> listaPlanta = newArrayList

	@Before
	def void initialize() {
		pikachu.setearTipo(electrico)
		listaElectrico.add(electrico)
		listaPlanta.add(planta)
	}

	@Test
	def void precioHierro() {
		Assert.assertEquals(hierro.precio, 60, 0.1d)
	}

	@Test
	def void cantidadDeSaludQueCuraZink() {
		Assert.assertEquals(zinc.cantidadDeSaludCurable(listaPlanta), 25, 0.1d)
	}

	@Test
	def void cantidadDeSaludQueCuraCobreAunPokemonTipoPlanta() {
		Assert.assertEquals(cobre.cantidadDeSaludCurable(listaPlanta), 24, 0.1d)
	}

	@Test
	def void cantidadDeSaludQueCuraCobreAunPokemonElectrico() {
		Assert.assertEquals(cobre.cantidadDeSaludCurable(listaElectrico), 30, 0.1d)
	}
	
	@Test
	def void precioCompuesto() {
		Assert.assertEquals(compuesto.precio, 70, 0.1d)
	}
	
	@Test
	def void cantidadDeSaludQueCuraCompuesto() {
		Assert.assertEquals(compuesto.cantidadDeSaludCurable(listaPlanta), 31, 0.1d)
	}
}

package proyectopokemon
import static org.mockito.Mockito.*
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import org.junit.Before

class TestRepositorioPokeparada {
	var RepositorioPokeparada repositorio
	var Pokeparada pokeparadaValida1
	var Pokeparada pokeparadaValida2
	var Pokeparada pokeparadaValida3
	var Pokeparada pokeparadaInvalida
	var ActualizacionMasivaRepositorioPokeparada actualizacionMasiva
	var String actualizar = "[{\"x\": -8.0,\"y\": 9.44,\"nombre\": \"Pokeparada obelisco\",\"itemsDisponibles\": [\"pokebola\",\"superball\",\"poción\"]},{\"x\": 33,\"y\": 12,\"nombre\": \"UNSAM\",\"itemsDisponibles\": [\"pokebola\",\"ultraball\",\"superpoción\"]}]"
	var ServicioExternoActualizacion SEA
	@Before
	def void initialize() {
		SEA = MockearSEAnueva(actualizar)
		repositorio = RepositorioPokeparada.getinstance()
		repositorio.cleanLista()
		pokeparadaValida1 = new Pokeparada(new Point(-8.0, 9.44), "Pokeparada Chorizard")
		pokeparadaValida2 = new Pokeparada(new Point(33, 12), "Pokepizza")
		pokeparadaValida3 = new Pokeparada(new Point(20.5413, 20.3111), "Pokeparada Meowthcree")
		pokeparadaInvalida = new Pokeparada(new Point(35.5313, 20.3123), null)
	}

	@Test
	def insertoDosPokeparadasAlRepositorio() {
		repositorio.create(pokeparadaValida1)
		repositorio.create(pokeparadaValida2)
		Assert.assertEquals(repositorio.lista.size, 2)
	}

	@Test(expected=BussinesException)
	def void insertarPokeparadaInvalidaDaExcepcion() {
		repositorio.create(pokeparadaValida1)
		repositorio.create(pokeparadaInvalida)
	}

	@Test
	def void insertarDosPokeparadasEliminarLaPrimera() {
		repositorio.create(pokeparadaValida1)
		repositorio.create(pokeparadaValida2)
		repositorio.delete(pokeparadaValida1)
		Assert.assertEquals(repositorio.lista.size, 1)
	}

	@Test
	def void insertarTresPokeparadasYBuscar2ConSearch() {
		repositorio.create(pokeparadaValida1)
		repositorio.create(pokeparadaValida2)
		repositorio.create(pokeparadaValida3)
		Assert.assertEquals(repositorio.search("Pokeparada").size, 2)
	}

	@Test
	def void insertarUnaPokeparadaUpdateYcomoNoExisteQueLaAgregue() {
		repositorio.create(pokeparadaValida1)
		repositorio.update(pokeparadaValida2)
		Assert.assertEquals(repositorio.lista.size, 2)
	}

	@Test
	def void ActualizarMasivamenteLaParada1() {
		repositorio.cleanLista()
		repositorio.create(pokeparadaValida1)
		repositorio.create(pokeparadaValida2)
		repositorio.create(pokeparadaValida3)
		actualizacionMasiva = new ActualizacionMasivaRepositorioPokeparada(SEA)
		actualizacionMasiva.servicioExterno()
		Assert.assertEquals(repositorio.searchById(pokeparadaValida1.ID).nombre, "Pokeparada obelisco")
	}
	
	def MockearSEAnueva(String pokeparada){
		val temporal = mock(typeof(ServicioExternoActualizacion))
		when(temporal.Pokeparadas).thenReturn(pokeparada)
		temporal
	}
}

package proyectopokemon
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestRepositorioEspecie {
	
	var RepositorioEspecie repositorio
	var Especie picachu
	var Especie charmander
	var Especie bulbasaur
	var Especie squirtel
	var ActualizacionMasivaRepositorioEspecie actualizacionMasiva
	var String nueva = "[{\"numero\": 1,\"nombre\": \"Bulbasaur\",\"puntosAtaqueBase\": 10,\"puntosSaludBase\": 15,\"descripcion\": \"A Bulbasaur es fácil verle echándose una siesta al sol.\",\"tipos\": [\"hierba\",\"veneno\"],\"velocidad\": 7,\"evolucion\": 2,\"nivelEvolucion\": 16},{\"numero\": 2,\"nombre\": \"Ivysaur\",\"puntosAtaqueBase\": 15,\"puntosSaludBase\": 20,\"descripcion\": \"Este Pokémon lleva un bulbo en el lomo.\",\"tipos\": [\"hierba\",\"veneno\"],\"velocidad\": 8,\"evolucion\": 3,\"nivelEvolucion\": 32}]"
	var String actualizarSquirtel = "[{\"numero\": 4,\"nombre\": \"Squirtel\",\"puntosAtaqueBase\": 12,\"puntosSaludBase\": 17,\"descripcion\": \"A Bulbasaur es fácil verle echándose una siesta al sol.\",\"tipos\": [\"hierba\",\"veneno\"],\"velocidad\": 7,\"evolucion\": 2,\"nivelEvolucion\": 16},{\"numero\": 2,\"nombre\": \"Ivysaur\",\"puntosAtaqueBase\": 15,\"puntosSaludBase\": 20,\"descripcion\": \"Este Pokémon lleva un bulbo en el lomo.\",\"tipos\": [\"hierba\",\"veneno\"],\"velocidad\": 8,\"evolucion\": 3,\"nivelEvolucion\": 32}]"
	var ServicioExternoActualizacion SEA
	var ServicioExternoActualizacion SEASquirtle  
	var Administrador admin
	var EjecutorTareas delegado
	@Before
	def void initialize() {
		repositorio = RepositorioEspecie.getinstance()
		SEA = MockearSEAnueva(nueva)
		SEASquirtle =  MockearSEAnueva(actualizarSquirtel) 
		// repositorio.cleanLista() para limpiar la lista y que no fallen los test
		repositorio.cleanLista()
		picachu = new Especie(10, 20)
		picachu.nombre = "Picachu"
		picachu.numero = 15
		picachu.descripcion = "Raton electrico"
		picachu.setearTipo(new Tipo("Electrico"))
		picachu.velocidad = 16
		charmander = new Especie(12, 23)
		charmander.nombre = "Charmander"
		charmander.numero = 7
		charmander.descripcion = "Lagartija de fuego"
		charmander.setearTipo(new Tipo("Fuego"))
		charmander.velocidad = 20
		squirtel = new Especie(11, 24)
		squirtel.numero = 4
		squirtel.nombre = "Squirtel"
		squirtel.descripcion = "Tortuga de agua"
		squirtel.setearTipo(new Tipo("agua"))
		squirtel.velocidad = 10
		bulbasaur = new Especie(8, 18)
		delegado = new EjecutorTareas
		admin = new Administrador(delegado)
	}

	@Test
	def void InsertarDosEspeciesAlrepositorio() {
		repositorio.create(picachu)
		repositorio.create(charmander)
		Assert.assertEquals(repositorio.lista.size, 2)
	}

	@Test(expected=BussinesException)
	def void InsertarDosEspeciePeroQueUnaNoSeInsertePorMalaValidacion() {
		repositorio.create(picachu)
		repositorio.create(bulbasaur)
		Assert.assertEquals(repositorio.lista.size, 1)
	}

	@Test
	def void InsertarDosEspecieEliminarLaPrimera() {
		repositorio.create(picachu)
		repositorio.create(charmander)
		repositorio.delete(picachu)
		Assert.assertEquals(repositorio.lista.size, 1)
	}

	@Test
	def void InsertarTresEspeciesYBuscar2ConSearch() {
		repositorio.create(picachu)
		repositorio.create(charmander)
		repositorio.create(squirtel)
		Assert.assertEquals(repositorio.search("u").size, 2)
	}

	@Test
	def void InsertarUnaEspecieUpdateYcomoNoExisteQueLaAgregue() {
		repositorio.create(picachu)
		repositorio.update(charmander)
		Assert.assertEquals(repositorio.lista.size, 2)
	}

	@Test
	def void InsertarDosEspecieUpdateUnaYBuscarlaPorId() {
		repositorio.create(picachu)
		picachu.numero = 22
		repositorio.update(picachu)
		Assert.assertEquals(repositorio.searchById(picachu.ID).numero, 22)
	}

	@Test
	def void ActualizarMasivamenteElRepositorio() {
		repositorio.create(picachu)
		repositorio.create(charmander)
		repositorio.create(squirtel)
		actualizacionMasiva = new ActualizacionMasivaRepositorioEspecie(SEA)
		actualizacionMasiva.servicioExterno()
		Assert.assertEquals(repositorio.search("Bulba").size, 1)
	}

	@Test
	def void ActualizarMasivamenteElRepositorioProbarElCambio() {
		repositorio.create(picachu)
		repositorio.create(charmander)
		repositorio.create(squirtel)
		actualizacionMasiva = new ActualizacionMasivaRepositorioEspecie(SEASquirtle)
		actualizacionMasiva.servicioExterno()
		Assert.assertEquals(repositorio.searchById(squirtel.ID).ataqueBase,11)
	}
	
	@Test
	def void ProbarActualizarEspeciesDelAdministrador(){
		repositorio.create(picachu)
		repositorio.create(charmander)
		repositorio.create(squirtel)
		actualizacionMasiva = new ActualizacionMasivaRepositorioEspecie(SEASquirtle)
		admin.tarea= new ActualizacionEspecies(actualizacionMasiva)
		admin.iniciarTarea()
		Assert.assertEquals(repositorio.searchById(squirtel.ID).ataqueBase,11)
	}
	
	def MockearSEAnueva(String esta){
		val temporal = mock(typeof(ServicioExternoActualizacion))
		when(temporal.Especie).thenReturn(esta)
		temporal
	}
	
}

package proyectopokemon

import org.junit.Test
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.uqbar.geodds.Point

class TestPoblarArea {
	var Especie kakuna
	var Especie pikachu
	var Especie metapod
	var List<Especie> nuevaListaEspecie
	var Pokemon poka
	var Poblar poblar
	var EjecutorTareas exe
	var Administrador admin
	var Point desde
	var Point hasta
	val int nivelMaximo = 30
	val int nivelMinimo = 2
	val int densidadXkm2 = 3

	@Before
	def void initialize() {
		
		desde = new Point(5, 4)
		hasta = new Point(6, 7)
		
		kakuna = new Especie(20, 100)
		pikachu = new Especie(100, 200)
		metapod = new Especie(10, 20)
		
		poblar = new Poblar
		kakuna.setearTipo(new Tipo("Bicho"))
		pikachu.setearTipo(new Tipo("Electrico"))
		metapod.setearTipo(new Tipo("Bicho"))
		
		nuevaListaEspecie = newArrayList(pikachu, metapod, kakuna)
		
		poka = new Pokemon(pikachu, "Macho", new Tipo("Electrico"))
		
		exe = new EjecutorTareas
		admin = new Administrador(exe)
		poblar.setListaEspecie(nuevaListaEspecie)
	}

	@Test
	def calcularArea() {
		poblar.poblarArea(desde, hasta, nuevaListaEspecie, nivelMaximo, nivelMinimo, densidadXkm2)
		Assert.assertEquals(poblar.calcularAreaRectangulo(), 3, 1)
	}
	
	@Test
	def seteoNivelDePikachu(){
		poblar.poblarArea(desde, hasta, nuevaListaEspecie, nivelMaximo, nivelMinimo, densidadXkm2)
		poblar.setearNivel(poka)
		Assert.assertEquals(poka.getNivel>=nivelMinimo, poka.getNivel<=nivelMaximo)
	}
	
	@Test
	def void pido3PokemonYMeTrae3PokemonXKm2DeArea() {
		poblar.poblarArea(desde, hasta, nuevaListaEspecie, nivelMaximo, nivelMinimo, densidadXkm2)
		admin.setTarea(poblar)
		admin.iniciarTarea
		Assert.assertEquals(poblar.getListaEspecie.size, 3)
	}

	@Test
	def pidoLaUltimaEspecieDeLaLista() {
		Assert.assertEquals(poblar.listaEspecie.get(2), kakuna)
	}

	@Test
	def nivelDePokemonCreadoEsMenosAlMaximoYMayorAlMinimoPasado() {
		poblar.poblarArea(desde, hasta, nuevaListaEspecie, nivelMaximo, nivelMinimo, densidadXkm2)
		admin.setTarea(poblar)
		admin.iniciarTarea
		var Pokemon poke = poblar.getListaPokemon.get(nuevaListaEspecie.size - 1)
		Assert.assertEquals(poke.nivel >= nivelMinimo, poke.nivel <= nivelMaximo)
	}
}

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

import org.junit.Test
import org.junit.Assert

class TestEspecie {
	var unaEspecie = new Especie(1,2)

	@Test
	def ConsultarAtaque() {
		Assert.assertEquals(unaEspecie.getAtaqueBase, 1)
	}
	
	@Test
	def ConsultarSalud() {
		Assert.assertEquals(unaEspecie.getSaludBase, 2)
	}
}
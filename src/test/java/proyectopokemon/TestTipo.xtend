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

class TestTipo {

	var unTipo = new Tipo("Un tipo")
	var tipoSuperFuerte = new Tipo("SuperFuerte")
	var tipoSuperResistente = new Tipo("SuperResistente")
	var tipoUltraFuerte = new Tipo("UltraFuerte")	
	var tipoUltraResistente = new Tipo("UltraResistente")
	
	@Test
	def ConsultarNombreDeTipo() {
		Assert.assertEquals(unTipo.descripcion, "Un tipo")
	}
			
	@Test
	def SetearFuerzaListaVaciaAgregaTipo() {
		unTipo.setFuerte = tipoSuperFuerte		
		Assert.assertEquals(unTipo.getFuerte.get(0).getDescripcion, "SuperFuerte")
	}
	
	@Test
	def SetearResistenciaListaVaciaAgregaTipo() {
		unTipo.setResistente = tipoSuperResistente
		Assert.assertEquals(unTipo.getResistente.get(0).getDescripcion, "SuperResistente")
	}
			
	@Test
	def SetearFuerzaListaConTipoDistintoLoAgrega() {
		unTipo.setFuerte = tipoSuperFuerte
		unTipo.setFuerte = tipoUltraFuerte
		Assert.assertEquals(unTipo.getFuerte.get(1).getDescripcion, "UltraFuerte")
	}
	
	@Test
	def SetearResistenciaListaConTipoDistintoLoAgrega() {
		unTipo.setResistente = tipoSuperResistente
		unTipo.setResistente = tipoUltraResistente		
		Assert.assertEquals(unTipo.getResistente.get(1).getDescripcion, "UltraResistente")
	}
					
	@Test(expected=BussinesException)
	def SetearFuerzaListaConTipoRepetidoNoLoAgrega() {
		unTipo.setFuerte = tipoSuperFuerte
		unTipo.setFuerte = tipoSuperFuerte
		Assert.assertEquals(unTipo.getFuerte.size(), 1)
	}
	
	@Test(expected=BussinesException)
	def SetearResistenciaListaConTipoRepetidoNoLoAgrega() {
		unTipo.setResistente = tipoSuperResistente
		unTipo.setResistente = tipoSuperResistente
		Assert.assertEquals(unTipo.getResistente.size(), 1)
	}
}


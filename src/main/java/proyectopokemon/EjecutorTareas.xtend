package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class EjecutorTareas {
	
	def void ejecutar(ComandosAdministrador comando){
		comando.ejecutar()
	}	
}
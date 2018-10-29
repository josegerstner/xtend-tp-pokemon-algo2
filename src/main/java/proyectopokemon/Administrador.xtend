package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Administrador {

	var EjecutorTareas esclavo
	var ComandosAdministrador tarea
	new(EjecutorTareas _esclavo) {
		esclavo = _esclavo
	}
	
	def void iniciarTarea(){
		esclavo.ejecutar(tarea)
	}
	

}

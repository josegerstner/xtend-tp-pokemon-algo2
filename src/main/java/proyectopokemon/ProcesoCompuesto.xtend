package proyectopokemon

import java.util.List

class ProcesoCompuesto extends Proceso{
	List<Proceso> procesos
	def void agregarProceso(Proceso proceso){
		procesos.add(proceso)
	}
	
}
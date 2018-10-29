package proyectopokemon

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

//Ya que vamos a crear tantos tipos distintos me parecio mas facil crear una nueva clase
@Accessors
class Tipo {
	val String descripcion
	var List<Tipo> Fuerte = newArrayList
	var List<Tipo> Resistente  = newArrayList
	

	new(String nombre) {
		descripcion = nombre
	}

		
	def setFuerte(Tipo _tipo) {
		if (!Fuerte.contains(_tipo)) {
			Fuerte.add(_tipo)
		}else{
			throw new BussinesException("No se puede ingresar el mismo tipo")
		}
	}

	def setResistente(Tipo _tipo) {
		if (!Resistente.contains(_tipo)) {
			Resistente.add(_tipo)
		}else{
			throw new BussinesException("No se puede ingresar el mismo tipo")
		}
	}
	
}

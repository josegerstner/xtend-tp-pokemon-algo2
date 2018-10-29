/**********************************************************
 * Materia: Algoritmos 2
 * 		Año 2017
 * Gurpo 6:
 * 			Julián Haeberli
 * 			Marcos Parisi
 * 			José Gerstner
 * Entrega 0 : Pokémon AL GO II
 *********************************************************/
package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Especie implements Entidad {
	var int ataqueBase
	var int saludBase
	var int velocidad = 0
	var List<Tipo> miTipo = newArrayList
	// Si no esta seteado entonces la evolucion no va a producir ningun cambio ya que el pokemon va a seguir siendo de la misma especie
	var Especie evolucion = this
	var int NivelEvolucion = 0
	var int numero = 0
	var String descripcion
	var String nombre
	var int ID

	new(int ataque, int salud) {
		ataqueBase = ataque
		saludBase = salud
	}

	def boolean evolucionar(Pokemon pokemon) {
		if (pokemon.getNivel() >= NivelEvolucion && this.evolucion != pokemon.especie) {
			pokemon.miPreEvolucion.add(pokemon.especie)
			pokemon.especie = evolucion
			true
		} else {
			false
		}
	}

	def setearTipo(Tipo _tipo) {
		if (! miTipo.contains(_tipo)) {
			miTipo.add(_tipo)
		}
	}

	override validar() {
		validarNombre()
		validarNumero()
		validarDescripcion()
		validarTipos()
		validarVelocidad()
	}

	def validarNombre() {
		if (this.nombre == null || this.nombre.length() == 0) {
			throw new BussinesException("Error: Nombre no puede ser vacio.")
		}
	}

	def validarNumero() {
		if (this.numero == 0) {
			throw new BussinesException("Error: Numero no puede ser cero.")
		}
	}

	def validarDescripcion() {
		if (this.descripcion == null || this.descripcion.length() == 0) {
			throw new BussinesException("Error: Descripcion no puede ser vacio.")
		}
	}

	def validarTipos() {
		if (this.miTipo.size == 0) {
			throw new BussinesException("Error: Tiene que tener al menos un tipo.")
		}
	}

	def validarVelocidad() {
		if (this.velocidad == 0) {
			throw new BussinesException("Error: Velocidad no puede ser cero.")
		}
	}
	def soyFuerte(Tipo _tipo){
		miTipo.exists(tipo|tipo.fuerte.contains(_tipo))
	}
	def soyResistente(Tipo _tipo){
		miTipo.exists(tipo|tipo.resistente.contains(_tipo))		
	}
}

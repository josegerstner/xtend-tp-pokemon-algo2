package proyectopokemon

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ItemDecoratorPorcentaje extends Item {

	var Item decorado
	var int curacion
	var int monedas
	var Tipo tipo
	var int porcentajeTipo
	var double porc = 0

	new(Item _decorado, int _curacion, int _monedas) {
		decorado = _decorado
		curacion = _curacion 
		monedas = _monedas
	}

	new(Item _decorado, int _curacion, int _monedas, Tipo _tipo, int _porcentajeTipo) {
		decorado = _decorado
		curacion = _curacion 
		monedas = _monedas
		tipo = _tipo
		porcentajeTipo = _porcentajeTipo
	}

	override int cantidadDeSaludCurable(List<Tipo> tipos) {
		// Problemas en tipo de datos entnces agregamos esto
		porc = this.dameCuracion(tipos)
		porc = (porc / 100) + 1
		(decorado.cantidadDeSaludCurable(tipos) * porc ).intValue
	}

	def int dameCuracion(List<Tipo> tipos) {
		if (validarTipo(tipos)) {
			porcentajeTipo
		} else {
			curacion
		}
	}

	def boolean validarTipo(List<Tipo> tipos) {
		tipos.exists[t|t == tipo]
	}

	override double getPrecio() {
		decorado.precio + monedas
	}

}

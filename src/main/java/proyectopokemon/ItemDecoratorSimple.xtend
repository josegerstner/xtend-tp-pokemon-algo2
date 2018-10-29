package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class ItemDecoratorSimple extends Item {
	var Item decorado
	var int curacion
	var int monedas

	new(Item _decorado, int _curacion, int _monedas) {
		decorado = _decorado
		curacion = _curacion
		monedas = _monedas
	}

	override int cantidadDeSaludCurable(List<Tipo> tipos) {
		decorado.cantidadDeSaludCurable(tipos) + curacion
	}

	override double getPrecio() {
		decorado.precio + monedas
	}

}

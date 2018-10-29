package proyectopokemon

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Pokeparada implements Entidad{
	var Point dondeEsta
	var String nombre
	var List<Item> productos = newArrayList
	var int ID = 0
	
	new(Point ubicacion, String nombre) {
		dondeEsta = ubicacion
		this.nombre = nombre
	}

	def void venderItem(Entrenador ash, Item item) {
		validarQueTengaItem(item)
		ash.sumarAMochila(item)
	}

	def cambiarPokemon(Entrenador yo, Pokemon mio, Entrenador otro, Pokemon suyo) {
		if (intercambioValido(yo, mio, otro, suyo)) {
			yo.dejoPokemon(mio)
			otro.dejoPokemon(suyo)
			yo.sumoPokemon(suyo)
			otro.sumoPokemon(mio)
		}
	}

	def intercambioValido(Entrenador yo, Pokemon mio, Entrenador otro, Pokemon suyo) {
		yo.estoyCercaDePokeparada(this) && otro.estoyCercaDePokeparada(this) && yo.tengoPokemon(mio) &&
			otro.tengoPokemon(suyo)
	}

	def void agregarItem(Item _item) {
		if (! productos.contains(_item)) {
			productos.add(_item)
		}
	}
	
	override validar(){
		this.validarNombre()
		this.validarUbicacion()
	}
	
	def validarNombre(){
		if (this.nombre == null || this.nombre.length==0 ){
			throw new BussinesException("Error: Tiene que tener nombre.")
		}
	}
	
	def validarUbicacion(){
		if (this.dondeEsta == null){
			throw new BussinesException("Error: Tiene que estar en un lugar.")
		}
	}
	
	def validarQueTengaItem(Item _item){
		if (!productos.contains(_item)){
			throw new BussinesException("Error: No vende ese item.")
		}
	}
	
}

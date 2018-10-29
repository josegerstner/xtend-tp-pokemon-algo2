package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class RepositorioPokeparada extends Repositorio<Pokeparada>{
	var int iterPokeparada = 0
	static var RepositorioPokeparada instance

	// Singleton
	private new() {
	}

	static def getinstance() {
		if (instance == null) {
			instance = new RepositorioPokeparada
		}
		instance
	}

	override void create(Pokeparada pokeparada) {
		pokeparada.validar()
		iterPokeparada = iterPokeparada + 1
		pokeparada.ID = iterPokeparada
		lista.add(pokeparada)
		
	}

	override void update(Pokeparada pokeparadaNueva) {
		pokeparadaNueva.validar()
		validarUpdate(pokeparadaNueva)

		var pokeparada = searchById(pokeparadaNueva.ID)
		pokeparada.nombre = pokeparadaNueva.nombre
		pokeparada.dondeEsta = pokeparadaNueva.dondeEsta
	}

	override Pokeparada searchById(int id) {
		lista.findFirst[poke|poke.ID == id]
	}
	
	override Iterable<Pokeparada> search(String buscar) {
		lista.filter [ poke |
			poke.productos == poke.productos.filter[item | item.nombre() == buscar] ||
			poke.nombre.contains(buscar)
		]
	}

	def Pokeparada searchByPoint(Point ubicacion) {
		lista.filter [poke|
			Double.compare(poke.dondeEsta.x, ubicacion.x) == 0 &&
			Double.compare(poke.dondeEsta.y, ubicacion.y) == 0
		].get(0)
	}

	override validarUpdate(Pokeparada pokeparada) {
		if (!lista.exists(poke|
			Double.compare(poke.dondeEsta.x, pokeparada.dondeEsta.x) == 0 &&
			Double.compare(poke.dondeEsta.y, pokeparada.dondeEsta.y) == 0
		)) {
			this.create(pokeparada)
		} else {
			pokeparada.ID = this.searchByPoint(pokeparada.dondeEsta).ID
		}
	}

	override void updateExterno(Pokeparada pokeparadaNueva) {
		pokeparadaNueva.validar()
		validarUpdate(pokeparadaNueva)
		var pokeparada = searchByPoint(pokeparadaNueva.dondeEsta)
		pokeparada.nombre = pokeparadaNueva.nombre
		pokeparada.dondeEsta = pokeparadaNueva.dondeEsta
	}
}

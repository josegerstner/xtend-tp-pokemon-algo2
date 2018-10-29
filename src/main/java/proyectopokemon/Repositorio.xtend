package proyectopokemon

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class  Repositorio<T> {
	public var List<T> lista = newArrayList
	
	def abstract void create(T generic)

	def void delete(T generic) {
		lista.remove(generic)
	}

	def abstract void update(T newGeneric)

	def abstract T searchById(int id)

	def abstract Iterable<T> search(String buscar)

	def cleanLista() {
		lista = newArrayList
	}

	def abstract void validarUpdate(T generic)

	def abstract void updateExterno(T newGeneric)
	
}
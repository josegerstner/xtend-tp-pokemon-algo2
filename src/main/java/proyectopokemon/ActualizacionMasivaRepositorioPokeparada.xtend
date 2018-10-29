package proyectopokemon

import org.json.JSONObject
import org.json.JSONArray
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ActualizacionMasivaRepositorioPokeparada {

	var RepositorioPokeparada repositorio
	var JSONObject jsonObj
	var ServicioExternoActualizacion SEA   
	
	new ( ServicioExternoActualizacion _SEA ){
		SEA = _SEA
	}
	
	def servicioExterno() {
		var String entero = SEA.Pokeparadas
		repositorio = RepositorioPokeparada.getinstance()
		var JSONArray arreglo = new JSONArray(entero)

		for (var i = 0; i < arreglo.length; i++) {
			jsonObj = arreglo.getJSONObject(i)
			actualizarObjeto(jsonObj)
		}
	}

	def actualizarObjeto(JSONObject poke) {
		var Pokeparada pokeparada = new Pokeparada(new Point(poke.getDouble("x"), poke.getDouble("y")),
			poke.getString("nombre"))
		var JSONArray jsonPokeparadas = poke.getJSONArray("itemsDisponibles")
		for (var i = 0; i < jsonPokeparadas.length(); i++) {
			pokeparada.agregarItem(new Item(jsonPokeparadas.getString(i),1d,1))
		}
		repositorio.update(pokeparada)
	}
}

package proyectopokemon

import org.json.JSONObject
import org.json.JSONArray

class ActualizacionMasivaRepositorioEspecie {
	var RepositorioEspecie repositorio
	var JSONObject jsonObj
	var ServicioExternoActualizacion SEA
	
	new ( ServicioExternoActualizacion _SEA ){
		SEA = _SEA
	}

	def servicioExterno() {
		var String entero = SEA.Especie
		repositorio = RepositorioEspecie.getinstance()
		var JSONArray arreglo = new JSONArray(entero)

		for (var i = 0; i < arreglo.length; i++) {
			jsonObj = arreglo.getJSONObject(i)
			actualizarObjeto(jsonObj)
		}
	}

	def actualizarObjeto(JSONObject esp) {
		var Especie especie = new Especie(esp.getInt("puntosAtaqueBase"), esp.getInt("puntosSaludBase"))
		especie.numero = esp.getInt("numero")
		especie.nombre = esp.getString("nombre")
		especie.descripcion = esp.getString("descripcion")
		var JSONArray jsonTipos = esp.getJSONArray("tipos")
		for (var i = 0; i < jsonTipos.length(); i++) {
			especie.setearTipo(new Tipo(jsonTipos.getString(i)))
		}
		especie.velocidad = esp.getInt("velocidad")
		//especie.evolucion = repositorio.search(esp.getInt("numero").toString).get(0)
		especie.nivelEvolucion = esp.getInt("nivelEvolucion")
		repositorio.update(especie)

	}

}

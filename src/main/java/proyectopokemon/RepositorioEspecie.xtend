package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioEspecie extends Repositorio<Especie>{
	static var RepositorioEspecie instance

	private new() {
	}

	static def getinstance() {
		if (instance == null) {
			instance = new RepositorioEspecie
		}
		instance
	}

	var int iterEspecie = 0

	override void create(Especie especie) {
		especie.validar()
		iterEspecie = iterEspecie + 1
		especie.ID = iterEspecie
		lista.add(especie)

	}

	override void update(Especie especieNueva) {
		especieNueva.validar()
		this.validarUpdate(especieNueva)
		var especie = this.searchById(especieNueva.ID)
		especie.numero = especieNueva.numero
		especie.descripcion  = especieNueva.descripcion
		especie.ataqueBase  = especieNueva.ataqueBase 
		especie.saludBase  = especieNueva.saludBase
		especie.evolucion  = especieNueva.evolucion
		especie.miTipo  = especieNueva.miTipo
		especie.nivelEvolucion  = especieNueva.nivelEvolucion
		especie.nombre  = especieNueva.nombre
		especie.saludBase  = especieNueva.saludBase
		especie.velocidad  = especieNueva.velocidad
		
		
	}

	override searchById(int _id) {
		lista.findFirst[esp | esp.ID == _id]
	}

	override Iterable<Especie> search(String buscar) {
		lista.filter[esp |( esp.numero==buscar || esp.nombre.contains(buscar))]
	}
	override validarUpdate(Especie especie){
		if (!lista.exists(esp|esp==especie)){
			this.create(especie)
		}
	}
	
	
	override void updateExterno(Especie especieNueva) {
		especieNueva.validar()
		this.validarUpdate(especieNueva)
		var especie = this.search(especieNueva.numero.toString).get(0)
		especie.numero = especieNueva.numero
		especie.descripcion  = especieNueva.descripcion
		especie.ataqueBase  = especieNueva.ataqueBase 
		especie.saludBase  = especieNueva.saludBase
		especie.evolucion  = especieNueva.evolucion
		especie.miTipo  = especieNueva.miTipo
		especie.nivelEvolucion  = especieNueva.nivelEvolucion
		especie.nombre  = especieNueva.nombre
		especie.saludBase  = especieNueva.saludBase
		especie.velocidad  = especieNueva.velocidad
	}
}



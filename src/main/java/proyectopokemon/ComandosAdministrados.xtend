package proyectopokemon

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

interface ComandosAdministrador {
	def void ejecutar()

	def void ejecutarCompuestos()
	
	def boolean validarCompuesto()
}

@Accessors
class ActualizacionEspecies implements ComandosAdministrador {
	var List<ComandosAdministrador> compuesto
	var ActualizacionMasivaRepositorioEspecie actualizacion

	new(ActualizacionMasivaRepositorioEspecie act) {
		actualizacion = act
	}

	override ejecutar() {
		this.ejecutarCompuestos
		actualizacion.servicioExterno()
	}

	override ejecutarCompuestos() {
		if(validarCompuesto)
			this.compuesto.forEach[task|task.ejecutar]
	}
	
	override validarCompuesto() {
		compuesto!=null
	}

}

@Accessors
class ActualizacionPokeparada implements ComandosAdministrador {
	var List<ComandosAdministrador> compuesto
	var ActualizacionMasivaRepositorioPokeparada actualizacion

	new(ActualizacionMasivaRepositorioPokeparada act) {
		actualizacion = act
	}

	override ejecutar() {
		this.ejecutarCompuestos
		actualizacion.servicioExterno()
	}

	override ejecutarCompuestos() {
		if (validarCompuesto)
			this.compuesto.forEach[task|task.ejecutar]
	}
	
	override validarCompuesto() {
		compuesto!=null
	}

}

@Accessors
class Poblar implements ComandosAdministrador {
	var List<Pokemon> listaPokemon = newArrayList
	var List<ComandosAdministrador> compuesto = newArrayList
	var Point desde
	var Point hasta
	var List<Especie> listaEspecie = newArrayList
	var int nivelMaximo
	var int nivelMinimo
	var int densidadXkm2
	val List<String> genero = newArrayList("Hembra", "Macho")

	override ejecutar() {
		this.ejecutarCompuestos
		this.poblarArea(desde, hasta, listaEspecie, nivelMaximo, nivelMinimo, densidadXkm2)
	}

	override ejecutarCompuestos() {
		if(validarCompuesto)
			this.compuesto.forEach[task|task.ejecutar]
	}
	
	override validarCompuesto() {
		compuesto!=null
	}

	// POBLAR AREA
	def void poblarArea(Point desde, Point hasta, List<Especie> nuevaListaEspecie, 
		int nivelMaximo, int nivelMinimo, int densidadXkm2) {
		
		//seteo parámetros
		this.desde=desde
		this.hasta=hasta
		this.listaEspecie=nuevaListaEspecie
		this.nivelMaximo=nivelMaximo
		this.nivelMinimo=nivelMinimo
		this.densidadXkm2=densidadXkm2
		val area = this.calcularAreaRectangulo()
		val int cantidad = calculoCantidad(area)
		var int i
		var int j = 0
		
		//creo pokemon en lugares random dentro del área
		for (i = 0; i < cantidad; i++) {
			listaPokemon.add(new Pokemon(nuevaListaEspecie.get(j), genero.get(1), 
				nuevaListaEspecie.get(j).getMiTipo.get(0)
			))
			listaPokemon.get(i).setDondeEsta(this.puntoRandom())
			this.setearNivel(listaPokemon.get(i))
			j++
			if(j == nuevaListaEspecie.size) j = 0
		}
	}
	
	def setearNivel(Pokemon poke){
		poke.setExperiencia = Math.ceil(((Math.pow(this.calcularNivelRandom() * 100, 2).intValue 
			- 50) / 100 - 25) / 2).intValue
	}
	
	def generoRandom(){
		Math.round(Math.random() * genero.size).intValue
	}
	
	def calcularNivelRandom(){
		Math.ceil(Math.random() * Math.abs(nivelMaximo - nivelMinimo)).intValue + nivelMinimo
	}

	def Point puntoRandom() {
		var semillaX = (Math.random() * (hasta.getX - desde.getX)).intValue + desde.getX
		var semillaY = (Math.random() * (hasta.getY - desde.getY)).intValue + desde.getY
		new Point(semillaX, semillaY)
	}

	def int calculoCantidad(double area) {
		Math.ceil(densidadXkm2 * area).intValue
	}

	def double calcularAreaRectangulo() {
		val base = Math.abs(hasta.getX - desde.getX)
		val altura = Math.abs(hasta.getY - desde.getY)
		base * altura
	}
}

@Accessors
class AgregarAcciones implements ComandosAdministrador {
	var List<ComandosAdministrador> compuesto
	var List<AccionLVLUP> acciones
	var List<Entrenador> entrenadores

	override ejecutar() {
		this.ejecutarCompuestos
		acciones.forEach[accion|entrenadores.forEach[entrenador|entrenador.agregarAccion(accion)]]
	}

	override ejecutarCompuestos() {
		if(validarCompuesto)
			this.compuesto.forEach[task|task.ejecutar]
	}
	
	override validarCompuesto() {
		compuesto!=null
	}

}

@Accessors
class RemoverAcciones implements ComandosAdministrador {
	var List<ComandosAdministrador> compuesto
	var List<AccionLVLUP> acciones
	var List<Entrenador> entrenadores

	override ejecutar() {
		this.ejecutarCompuestos
		acciones.forEach[accion|entrenadores.forEach[entrenador|entrenador.eliminarAccion(accion)]]
	}

	override ejecutarCompuestos() {
		if(validarCompuesto)
			this.compuesto.forEach[task|task.ejecutar]
	}
	
	override validarCompuesto() {
		compuesto!=null
	}

}

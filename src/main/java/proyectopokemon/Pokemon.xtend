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
import org.uqbar.geodds.Point
import java.util.List

@Accessors
class Pokemon {
	// Como el nivel es calculado segun la experiencia no se agrego como variable. Evitamos que se pueda setear
	// Pasa lo mismo con puntos de ataque y salud
	var int experiencia = 0
	var Especie especie
	var Tipo tipo
	val String genero
	var Point dondeEsta
	var int salud
	var List<Especie> miPreEvolucion = newArrayList

	new(Especie _especie, String genero, Tipo tipo) {
		experiencia=50
		especie = _especie
		this.genero = genero
		this.tipo = tipo
		salud = puntosSaludMaxima()
	}

	def getNivel() {
		(Math.sqrt(100 * (2 * this.experiencia + 25) + 50) / 100).intValue
	}

	def puntosAtaque() {
		this.especie.ataqueBase * this.getNivel
	}

	def puntosSaludMaxima() {
		this.especie.saludBase * this.getNivel
	}

	def distanciaHasta(Point punto) {
		this.dondeEsta.distance(punto)
	}

	// retorna si el pokemon ha evolucionado
	def evolucionado() {
		miPreEvolucion.size>0
	}

	def chancesEscapar() {
		nivel * (1 + especie.velocidad / 10)
	}

	def boolean soyFuerte(Tipo _tipo) {
		this.especie.soyFuerte(_tipo)
	}

	def boolean soyResistente(Tipo _tipo) {
		this.especie.miTipo.exists(tipo|tipo.resistente.contains(_tipo))
	}
	def recuperaSalud(int puntosSalud){
		salud += puntosSalud
	}
	def boolean evolucionar(){
	 	this.especie.evolucionar(this)
	}
	def void recibirPocion(Item pocion){
		this.recuperaSalud(pocion.cantidadDeSaludCurable(this.especie.miTipo))
	}
}

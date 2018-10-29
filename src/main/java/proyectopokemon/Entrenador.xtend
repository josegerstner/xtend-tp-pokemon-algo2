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

import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Entrenador {
	var int experiencia = 0
	var int combatesGanados = 0
	var List<Pokemon> pokemonAtrapados = newArrayList
	var List<Pokemon> pokemonGuardados = newArrayList
	var List<Item> mochila = newArrayList
	val Map<Integer, Integer> niveles = newHashMap
	var double dinero
	val TipoEntrenador tipo
	var Point dondeEstoy
	var Pokemon pokemonAcombate
	var int dineroApostado
	var List<Entrenador> amigos = newArrayList
	var List<Entrenador> solicitudes = newArrayList
	var List<AccionLVLUP> nivelObserver = newArrayList
	var List<Notificacion> notificaciones = newArrayList

	new(TipoEntrenador tipo) {
		this.tipo = tipo
		dinero = 500
		niveles.put(0, 1)
		niveles.put(1000, 2)
		niveles.put(3000, 3)
		niveles.put(6000, 4)
		niveles.put(10000, 5)
		niveles.put(15000, 6)
		niveles.put(21000, 7)
		niveles.put(28000, 8)
		niveles.put(36000, 9)
		niveles.put(45000, 10)
		niveles.put(55000, 11)
		niveles.put(65000, 12)
		niveles.put(75000, 13)
		niveles.put(85000, 14)
		niveles.put(100000, 15)
		niveles.put(120000, 16)
		niveles.put(140000, 17)
		niveles.put(160000, 18)
		niveles.put(185000, 19)
		niveles.put(210000, 20)
	}
var int hola
var int chau
	// suma la cantidad de experiencia pasada por parámetro
	def ganaExperiencia(int experienciaGanada) {
		experiencia += experienciaGanada
		
		if (this.getNivel !=
			(niveles.get(niveles.keySet.findFirst[nivel|(this.getExperiencia - experiencia) <= nivel])).intValue) {
				this.nivelObserver.forEach[o|o.notificar()]
		}
	}

	// getter de la variable nivel
	def int getNivel() {
		if (getExperiencia < 210000)
			niveles.get(niveles.keySet.findFirst[nivel|this.getExperiencia <= nivel])
		else
			20
	}

	

	// suma un combate ganado
	def ganarCombate() {
		combatesGanados++
	}

	// devuelve cantidad de especies atrapadas
	def cantidadEspeciesAtrapadas() {
		this.especiesAtrapadas.size
	}

	// devuelve un listado con las especies atrapadas
	def especiesAtrapadas() {
		pokemonAtrapados.map[getEspecie()] // habría que modificar el método para que las especies sean distintas
	}

	// devuelve un booleano true si la colección está balanceada, sino false
	def coleccionBalanceada() {
		cantidadPokemonMacho() < 55 && cantidadPokemonMacho() > 45
	}

	// devuelve la cantidad de pokemon macho
	def cantidadPokemonMacho() {
		pokemonAtrapados.filter[getGenero() == "Macho"].size
	}

	// agrega pokemon al listado pokemonAtrapados
	def atraparPokemon(Pokemon nuevoPokemon, Item pokebolaParaAtraparlo) {
		// Agregue las validaciones. Falta que pasa si lo atrapa
		if (this.validaCaptura(nuevoPokemon)) {
			this.lanzaPokebola(pokebolaParaAtraparlo)
			this.tipo.SumarEXPcaptura(this, nuevoPokemon)
			this.sumoPokemon(nuevoPokemon)
			this.ganaExperiencia(100)
		} else
			throw new BussinesException("No puedo capturar pokemon")
	}

	def sumoPokemon(Pokemon nuevoPokemon) {
		if (pokemonAtrapados.size < 6) {
			pokemonAtrapados.add(nuevoPokemon)
		} else {
			pokemonGuardados.add(nuevoPokemon)
		}
	}

	def dejoPokemon(Pokemon pokemonActual) {
		if (tengoPokemon(pokemonActual)) {
			if (pokemonEncima(pokemonActual)) {
				pokemonAtrapados.remove(pokemonActual)
			} else {
				pokemonGuardados.remove(pokemonActual)
			}
		}
	}

	def pokemonGuardado(Pokemon poke) {
		pokemonGuardados.contains(poke)
	}

	def pokemonEncima(Pokemon poke) {
		pokemonAtrapados.contains(poke)
	}

	def validaCaptura(Pokemon nuevoPokemon) {
		this.estoyEnRango(nuevoPokemon) && this.loAtrapa(nuevoPokemon) && this.tengoPokebolas()
	}

	def boolean tengoPokebolas() {
		mochila.exists [ item |
			item.getNombre() == "pokebola" || item.getNombre() == "superball" || item.getNombre() == "ultraball"
		]
	}

	// devuelve cantidad de pokemon evolucionados
	def pokemonEvolucionados() {
		pokemonAtrapados.map[evolucionado()].size + pokemonGuardados.map[evolucionado()].size
	}

	// devuelve cantidad de pokemon con nivel mayor a 20
	def pokemonDeGranNivel() {
		pokemonAtrapados.filter[getNivel() > 20].size
	}

	// ver si existe un pokemon en la colección
	def tengoPokemon(Pokemon poke) {
//		pokemonAtrapados.exists[Pokemon|this.especiesAtrapadas().iterator == poke] || pokemonGuardados.exists[Pokemon|this.especiesAtrapadas().iterator == poke]
		this.pokemonEncima(poke) || this.pokemonGuardado(poke)
	}

	def loAtrapa(Pokemon poke) {
		Math.random() <= this.getNivel / (this.getNivel + poke.chancesEscapar)
	}

	def lanzaPokebola(Item item) {
		if (this.tengoItem(item))
			mochila.remove(item)
		else
			throw new BussinesException("No tengo más pokebolas")
	}

	def movete(Point aDonde) {
		dondeEstoy = aDonde
	}

	// True si estoy a menos de 10 metros, false si no
	def boolean estoyEnRango(Pokemon nuevoPokemon) {
		this.dondeEstoy.distance(nuevoPokemon.dondeEsta) <= 10
	}

	def boolean estoyCercaDePokeparada(Pokeparada poke) {
		this.dondeEstoy.distance(poke.getDondeEsta) < 10
	}

	def comprarItem(Item item, Pokeparada poke) {
		if (this.validoCompraItem(item, poke)) {
			this.setDinero(this.getDinero - this.dineroAGastar(item))
			poke.venderItem(this, item)
		} else
			throw new BussinesException("No puedo comprar")
	}

	def sumarAMochila(Item item) {
		mochila.add(item)
	}

	def validoCompraItem(Item item, Pokeparada poke) {
		this.tengoDinero(this.dineroAGastar(item)) && this.estoyCercaDePokeparada(poke)
	}

	def dineroAGastar(Item item) {
		item.getPrecio
	}

	def boolean tengoDinero(double precio) {
		dinero >= precio
	}

	def curarPokemon(Pokeparada poke) {
		if (this.estoyCercaDePokeparada(poke)) {
			this.pokemonAtrapados.forEach[setSalud(puntosSaludMaxima)]
		}
	}

	def darPocion(Pokemon poke, Item item) {
		if (this.tengoItem(item)) {
			// poke.recuperaSalud(item.cantidadDeSaludCurable())
			poke.recibirPocion(item)
		}
	}

	def boolean tengoItem(Item item) {
		mochila.contains(item)
	}

	// Uso siempre la variable pokemonAcombate por que es la unica forma en que un pokemon puede ganar experiencia(en combate)
	def evolucionarPokemon() {
		if (pokemonAcombate.evolucionar()) {
			this.ganaExperiencia(200)
			this.tipo.SumarEXPevolucion(this)
		}
	}

	def void enviarSolicitud(Entrenador solicito) {
		solicito.solicitudes.add(this)
	}

	def void rechazarSolicitud(Entrenador enemigo) {
		solicitudes.remove(enemigo)
	}

	def void aceptarSolicitud(Entrenador amigo) {
		amigo.amigos.add(this)
		this.amigos.add(amigo)
	}

	def eliminarAmigo(Entrenador enemigo) {
		amigos.remove(enemigo)
		enemigo.amigos.remove(this)
	}

	def void recibirNotificacion(Notificacion mensaje) {
		notificaciones.add(mensaje)
	}

	
	def boolean estoyEnMaxLVL() {
		this.nivel == 20
	}

	def void agregarAccion(AccionLVLUP accion) {
		nivelObserver.add(accion)
	}

	def void eliminarAccion(AccionLVLUP accion) {
		nivelObserver.remove(accion)
	}
}

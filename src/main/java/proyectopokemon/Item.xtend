package proyectopokemon

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Item {
	var String nombre
	var double precio
	var int probabilidadDeCaptura = 0
	int cantidadDeSaludCurable = 0
	
	new(){}
	//sobrecarga de contructores
	//tipos de pokebolas
	new(String nombre, double precio, int probabilidadDeCaptura) {
		this.nombre = nombre
		this.precio = precio
		this.probabilidadDeCaptura = probabilidadDeCaptura
	}
	//tipos de pociones
	new(String nombre, int cantidadDeSaludCurable, double precio){
		this.nombre=nombre
		this.precio=precio
		this.cantidadDeSaludCurable=cantidadDeSaludCurable
	}
	
	
	
	def int probabilidadExtraDeCaptura(){probabilidadDeCaptura}

	def int cantidadDeSaludCurable(List<Tipo> tipos){cantidadDeSaludCurable}

	def double getPrecio(){precio}

	def String nombre(){nombre}
}
//
//@Accessors
//class Pokebola extends Item {
//	var String nombre
//	var double precio
//	var int probabilidadDeCaptura = 0
//
//	new(String _nombre, double _precio) {
//		nombre = _nombre
//		precio = _precio
//	}
//	
//	new(String nombre){
//		this.nombre = nombre
//		if(nombre=="pokebola"){
//			precio = 80
//		}else if(nombre=="superball"){
//			precio = 150
//			probabilidadDeCaptura=10
//		}else{
//			precio = 200
//			probabilidadDeCaptura = 25
//		}
//	}
//	
//	
//	override nombre() { nombre }
//
//	override getPrecio() { precio }
//	
//	override probabilidadExtraDeCaptura() { probabilidadDeCaptura }
//}
//
//@Accessors
//class Pocion extends Item {
//	String nombre
//	double precio
//	int cantidadDeSaludCurable
//	
//	new(String nombre, double precio, int cantidadDeSaludCurable){
//		this.nombre=nombre
//		this.precio=precio
//		this.cantidadDeSaludCurable=cantidadDeSaludCurable
//	}
//	
//	new(String nombre){
//		this.nombre = nombre
//		if(nombre=="pokebola"){
//			precio = 50
//			cantidadDeSaludCurable = 20
//		}else{
//			precio = 100
//			cantidadDeSaludCurable = 50
//		}
//	}
//	
//	override nombre() { nombre }
//
//	override getPrecio() { precio }
//
//	override cantidadDeSaludCurable() { cantidadDeSaludCurable }
//}
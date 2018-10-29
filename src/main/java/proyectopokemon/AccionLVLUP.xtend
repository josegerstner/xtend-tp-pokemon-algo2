package proyectopokemon

import java.util.Map
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

interface AccionLVLUP {
	def void notificar()
}

class NotificarLVL5 implements AccionLVLUP {
	var Entrenador entrenador

	new(Entrenador entreno) {
		entrenador = entreno

	}

	override notificar() {
		if (entrenador.nivel % 5 == 0) {
			entrenador.amigos.forEach[a|a.recibirNotificacion(new Notificacion("NIVEL5"))]
		}
	}

}

class NotificarEnviarMailSuperado implements AccionLVLUP {
	var Entrenador entrenador
	var MailSender sender
	var Mail mail = new Mail
	//var int nivel = 0

	new(Entrenador entreno, MailSender _sender) {
		entrenador = entreno
		sender = _sender

	}

	override notificar() {
		
		entrenador.amigos.forEach [ a |
			if ((a.getNivel()+1).equals(entrenador.getNivel()) ) {
				a.recibirNotificacion(new Notificacion("SUPERADO"))
				mail.para = a
				mail.de = entrenador
				mail.asunto = "Te pase GIL!!"
				sender.enviarMail(mail)
			}
		]
	}
	
}

class NotificarEnviarMailLVLMax implements AccionLVLUP {
	var Entrenador entrenador
	var MailSender sender
	var Mail mail = new Mail

	new(Entrenador entreno, MailSender _sender) {
		entrenador = entreno
		sender = _sender
	}

	override notificar() {
		if (entrenador.estoyEnMaxLVL) {
			entrenador.recibirNotificacion(new Notificacion("LEVELMAX"))
			mail.para = entrenador
			mail.de = entrenador
			mail.asunto = "Llegue al maximo nivel!!"
			sender.enviarMail(mail)
			enviarMail(entrenador)
			entrenador.amigos.forEach [ a |
				a.recibirNotificacion(new Notificacion("LEVELMAX"))
				mail.para = a
				mail.de = entrenador
				mail.asunto = "Llegue al maximo nivel!!"
				sender.enviarMail(mail)
			]

		}
	}

	def void enviarMail(Entrenador superado) {
	}
}

class DarPremioPorNivel implements AccionLVLUP {
	var Entrenador entrenador
	var Recompensa planoRecompensa

	new(Entrenador entreno) {
		entrenador = entreno

	}

	def void setearRecompensa(Recompensa reco) {
		planoRecompensa = reco
	}

	override notificar() {
		entrenador.dinero = entrenador.dinero + planoRecompensa.getMonedas(entrenador.nivel)
		planoRecompensa.getItems(entrenador.nivel).forEach[i|entrenador.mochila.add(i)]
	}

}

class Recompensa {
	var Map<Integer, Integer> recompensaMonedas = newHashMap
	var Map<Integer, List<Item>> recompensaItem = newHashMap

	def void setNivelMonedas(int nivel, int monedas) {
		recompensaMonedas.put(nivel, monedas)
	}

	def void setNivelItems(int nivel, Item item) {
		var List<Item> aux = recompensaItem.get(nivel)
		aux.add(item)
		recompensaItem.put(nivel, aux)
	}

	def int getMonedas(int nivel) {
		recompensaMonedas.get(nivel)
	}

	def List<Item> getItems(int nivel) {
		recompensaItem.get(nivel)
	}

}

//INTERFAZ SALIENTE -------ENVIO DE MAIL
@Accessors
class Mail {
	var Entrenador de
	var Entrenador para
	var String asunto
	var String cuerpo
	var MailSender sender

}

interface MailSender {
	def void enviarMail(Mail mail)
}

class Notificacion {
	var String mensaje

	new(String _mensaje) {
		mensaje = _mensaje
	}
}

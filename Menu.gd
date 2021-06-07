extends CanvasLayer

#las señales se emiten cuando se presionan los botones correspondientes
signal iniciar_juego
signal cargar_juego


# Called when the node enters the scene tree for the first time.
func _ready():
	$Atras.hide()
	pass


func _on_Iniciar_pressed():
	$Iniciar.hide()
	#aunque lo ideal sería que redirija a los slots de memoria, y que elija alguno para nueva partida
	$Cargar.hide()
	$Titulo.hide()
	emit_signal("iniciar_juego")

#faltaría un método cuando se presiona el botón de carga

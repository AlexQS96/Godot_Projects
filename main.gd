extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$apu_body.visible=false
	$background.visible=false
	$Obstaculos.visible=false
	$Piso.visible=false

func nuevo_juego():
	$background.show()
	$Obstaculos.show()
	$Piso.show()
	$apu_body.show()

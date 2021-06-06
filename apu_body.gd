extends KinematicBody2D
export (float) var GRAVEDAD # gravedad que se aplica en cada instante
export (float) var DESPLAZAMIENTO #lo mismo que el de abajo pero para el movimiento
export (float) var VEL_SALTO #velocidad de salto esto editalo en el inspector de apu body en scripts
var saltando = false #saltando en NO
var velocidad = Vector2() # velocidad en lo que se mueve en el momento actual
enum estados {quieto , caminando} #almaceno los estados y lo apunto en el codigo 
var estado_actual = estados # asigno a estados a estado_actual (la verdad creo que no sirve pero bueno lo dejo ahi)
var screen_size #para la pantalla pero no logro hacerlo funcionar para que en ventana me lo muestre como en pantalla completa
signal hit #Cada vez que el apu tenga contacto con algún enemigo se emite la señal de que fue golpeado
signal bonus #


func _ready():
	#bueno todo esto ni idea lo copie del codigo de github pero inicializo el estado de apu
	#en quieto al iniciar el juego
	#lo otro 
	screen_size=get_viewport_rect().size
	estado_actual = estados.quieto


func _physics_process(delta):
	velocidad.y += GRAVEDAD * delta # formula para aplicar gravedad 
	
	#boton ESC para salir del juego
	if(Input.is_action_just_released("ui_cancel")):
		  get_tree().quit()
	
	# lo que explico aca va para lo demas 
	# asigno la tecla que quiero usar
	#cambio el estado de quieto a caminando para avisarle al movimiento que mueva a apu
	#cambio la direccion del sprite segun la tecla por defecto lo diseñe hacia la derecha en png
	#si no se encuentra saltando entonces cambio a la animacion caminando
	#si estoy saltando no voy a poder caminar en el aire por que me dio paja hacer el sprite
	#si vago
	
	if(Input.is_action_just_pressed("tecla_D")):
		estado_actual = estados.caminando
		get_node("apuSprite").flip_h = false
		if(!saltando):
			get_node("animaciones").play("caminando")
		
	if(Input.is_action_just_pressed("tecla_A")):
		estado_actual = estados.caminando
		get_node("apuSprite").flip_h = true
		if(!saltando):
			get_node("animaciones").play("caminando")
	
	if(Input.is_action_just_released("tecla_D")):
		estado_actual = estados.quieto
		if(!saltando):
			get_node("animaciones").play("quieto")
	
	if(Input.is_action_just_released("tecla_A")):
		estado_actual = estados.quieto
		if(!saltando):
			get_node("animaciones").play("quieto")
	
	if(Input.is_action_pressed("tecla_espacio")):
		if(!saltando):
			get_node("animaciones").play("salto")
			saltando = true
			velocidad.y = -VEL_SALTO
		
	# Sirve para detectar el suelo si esta en el suelo y no esta saltando se queda en animacion
	# quieto
	# si esta moviendose pasa a la animacion caminando
	var collisionCounter = get_slide_count() - 1
	if collisionCounter > -1:
		var obj_colisionado = get_slide_collision(collisionCounter).collider
		if(obj_colisionado.is_in_group("suelo") && saltando):
			get_node("animaciones").play("quieto")
			saltando = false
			if(velocidad.x != 0):
				get_node("animaciones").play("caminando")

	procesar_movimiento()
	
	var movimiento = velocidad # asigno velocidad al movimiento
	move_and_slide(movimiento) #mueve en base a la velocidad asignada
	
	#los enemigos van a estar en un Area2D, a los que se nombrarán Mob. 
	#Cuando se choque con alguno emitira el signal hit
	var colision = move_and_collide(velocidad*delta)
	if colision and colision.collider.name=="Mob":
		emit_signal("hit")

# para procesar el movimiento segun la direccion y si se encuentra quieto
func procesar_movimiento():
	if(estado_actual == estados.caminando):
		if(get_node("apuSprite").flip_h):
			velocidad.x = -DESPLAZAMIENTO
		else:
			velocidad.x = DESPLAZAMIENTO
	if(estado_actual == estados.quieto):
		velocidad.x = 0
	

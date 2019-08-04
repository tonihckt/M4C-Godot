extends Area2D

# Declare member variables here:
export (int) var speed
var movement = Vector2() # (x=0,y=0)
var limit
# eventos de colición
signal knock

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Ocultar el personaje
	limit = get_viewport_rect().size # coje el tamñano de la pantalla
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement = Vector2() # se reinicia cada segundo ( valor inicial)
	
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	if movement.length()>0: # verifica si se muevee para normalizar la velocidad
		movement = movement.normalized() * speed
		
	position += movement * delta # siempre lleve el mismo tiempo ( actualizar movimiento)
	position.x = clamp(position.x, 0, limit.x)
	position.y = clamp(position.y, 0, limit.y)
	
	#Implementando los sprites
	if movement.x != 0:
		$Sprite_Player.animation = "side"
		$Sprite_Player.flip_h = movement.x < 0 #voltear horizontal
		$Sprite_Player.flip_h = false
	elif movement.y !=0:
		$Sprite_Player.animation = "back"
		$Sprite_Player.flip_v = movement.y > 0
	else:
		$Sprite_Player.animation = "front"

# cuando haya una colición  con un cuerpo
func _on_Player_body_entered(body):
	hide()
	emit_signal("knock")
	# desactiva su colicion para recibir daños
	$Collision_Player.disabled = true

func start(postn):
	position = postn
	show() # Mostarat el personaje
	$Collision_Player.disabled = false
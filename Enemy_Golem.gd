extends RigidBody2D

export (int) var max_speed
export (int) var min_speed
var enemy_type = ["golem_earth", "golem_wind"]

func _ready():
	$Sprite_Golem.animation = enemy_type[randi() % enemy_type.size()]
	if $Sprite_Golem.animation == "golem_earth":
		# se adapta a la colision del mayor
		$Collision_Golem.scale.x = 1.5
		$Collision_Golem.scale.y = 1.5
	




func _on_Visibility_Golem_screen_exited():
	queue_free() #cuando sale sale de la pantalla se elimina
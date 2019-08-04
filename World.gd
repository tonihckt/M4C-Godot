extends Node
# Para cargar la esecena de los enemigos
export (PackedScene) var Enemy
var Score # Puntuación

func _ready():
	# cada vez que inicia es diferente el patron de enemigos
	randomize()

func new_game():
	Score = 0
	# Cambia la posicion del personaje
	$Player.start($Start_Position.position) #Posicion de inicio del jugador
	$Start_Timer.start() # activa _on_Start_Timer_timeout
	# actualizando la escena
	$Interface.show_message("Are you ready!")
	$Interface.update_score(Score)
	$Audio_Player.play()
 
func game_over():
	$Score_Timer.stop()
	$Enemy_Timer.stop()
	$Interface.game_over()
	$Audio_Death.play()
	$Audio_Player.stop()

func _on_Start_Timer_timeout():
	$Enemy_Timer.start()
	$Score_Timer.start()


func _on_Score_Timer_timeout():
	Score += 1
	#actualiza texto de los puntos
	$Interface.update_score(Score)


func _on_Enemy_Timer_timeout():
	#selecionar un punto aleatorio en el camino
	$Enemy_Road/Enemy_Position.set_offset(randi())
	
	# se crea un obejo en la variable enemigo
	var E = Enemy.instance()
	add_child(E)
	# Direccion que va selecionar el E->Enemigo 
	var D_E = $Enemy_Road/Enemy_Position.rotation + PI /2
	# se crea una posicion aleatoria a cada onjeto
	# y pone la posicion del enemigo en la posicion de la ruta
	E.position = $Enemy_Road/Enemy_Position.position
	# funciona en radianes, no en grados
	D_E += rand_range(-PI /4, PI /4)  # 45grados
	E .rotation = D_E
	E.set_linear_velocity(Vector2(rand_range(E.min_speed, E.max_speed), 0).rotated(D_E))
extends CanvasLayer

signal start_game

func show_message(txt):
	$Message_Label.text = txt
	#mostrar el nodo
	$Message_Label.show()
	$Message_Timer.start()
	
func game_over():
	show_message("Game Over")
	# no pasa hast aque la señal se emita
	yield($Message_Timer, "timeout")
	$Button_Play.show()
	$Message_Label.text = "M4C"
	
func update_score(points):
	$Scrore_Label.text = str(points)
	

func _on_Message_Timer_timeout():
	$Message_Label.hide()


func _on_Button_Play_pressed():
	$Button_Play.hide()
	emit_signal("start_game")
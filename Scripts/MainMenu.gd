extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal start_game_pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBox/Menu/StartButton.grab_focus()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_down():
	$Fadein.show()
	$Fadein.fadeIn()
	


func _on_ExitButton_button_down():
	get_tree().quit()
	


func _on_Fadein_on_fadeIn_finished():
	emit_signal("start_game_pressed")
	

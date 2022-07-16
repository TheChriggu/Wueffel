extends Spatial

export var MainMenuScene = ""
export var MainGameplayScene = ""
export var PauseMenuScene = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	load_main_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_main_menu():
	var node = load(MainMenuScene).instance()
	add_child(node)
	node.connect("start_game_pressed", self, "_on_MainMenu_start_game_pressed")

func _on_MainMenu_start_game_pressed():
	var lastIndex = get_child(get_child_count() - 1)
	remove_child(lastIndex)
	
	var node = load(MainGameplayScene).instance()
	add_child(node)
	
	pass # Replace with function body.

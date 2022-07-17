extends Spatial

export var MainMenuScene = ""
export var MainGameplayScene = ""
export var PauseMenuScene = ""


var gameplay = null

# Called when the node enters the scene tree for the first time.
func _ready():
	load_main_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and gameplay != null:
		load_main_menu()

func load_main_menu():
	if gameplay:
		remove_child(gameplay)
		gameplay = null
	
	var node = load(MainMenuScene).instance()
	add_child(node)
	node.connect("start_game_pressed", self, "_on_MainMenu_start_game_pressed")
	$HUD.menu_mode()

func _on_MainMenu_start_game_pressed():
	var lastIndex = get_child(get_child_count() - 1)
	remove_child(lastIndex)
	
	gameplay = load(MainGameplayScene).instance()
	add_child(gameplay)
	
	pass # Replace with function body.

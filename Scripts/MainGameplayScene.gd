extends Spatial

export(PackedScene) var cup_scene

var controller : Spatial

var currentState = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = SpatialMaterial.new()
	var tex = get_child(1).get_child(0).GetTexture()
	print(get_child(1).get_child(1).get("material/"+str(0)))
	get_child(1).get_child(1).get("material/"+str(0)).set_shader_param("texture_albedo", tex)
	
	controller = get_child(0)
	
	go_into_roll_state()

func _process(delta):
	if Input.is_action_just_pressed("roll"):
		if currentState == 0:
			go_into_roll_state()

func _input(event):
	if currentState == 1:
		if(event is InputEventMouse):
			get_child(1).get_child(0).OnInputEvent(event, event.position)

func _toggle_cam_movement(toggle):
	controller.is_enabled = toggle

func go_into_roll_state():
	currentState = 1
	
	add_child(cup_scene.instance())
	
	$Controller.release_top_down_view()
	$"2DGame/2DTopDownPort".end_hovering()
	
	LazyLinker.hud.enable_roll_label()

func go_into_track_state():
	currentState = 0
	
	print("#### Go track! ####")
	
	$Controller.force_top_down_view()
	$"2DGame/2DTopDownPort".begin_Hovering()
	
	LazyLinker.hud.enable_track_label()

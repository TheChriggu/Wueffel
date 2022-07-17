extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camFocus : Spatial

var currentState = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = SpatialMaterial.new()
	var tex = get_child(1).get_child(0).GetTexture()
	print(get_child(1).get_child(1).get("material/"+str(0)))
	var tx = load("res://Pictures/IMG_20220525_000520__01.jpg")
	get_child(1).get_child(1).get("material/"+str(0)).set_shader_param("texture_albedo", tex)
	
	camFocus = get_child(0).get_child(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if currentState == 1:
			currentState = 0
			get_child(0).release_top_down_view()
		else:
			currentState = 1
			get_child(0).force_top_down_view()

func _input(event):
	if currentState == 1:
		if(event is InputEventMouse):
			get_child(1).get_child(0).OnInputEvent(event, event.position)
		else:
			get_child(1).get_child(0).OnInputEvent(event)
		print("input event")

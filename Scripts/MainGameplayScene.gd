extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camFocus : Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = SpatialMaterial.new()
	var tex = get_child(1).get_child(0).GetTexture()
	print(get_child(1).get_child(1).get("material/"+str(0)))
	var tx = load("res://Pictures/IMG_20220525_000520__01.jpg")
	get_child(1).get_child(1).get("material/"+str(0)).set_shader_param("texture_albedo", tex)
	
	camFocus = get_child(0).get_child(0)

func _toggle_cam_movement(toggle):
	
	camFocus._toggle_cam_move(toggle)
	pass

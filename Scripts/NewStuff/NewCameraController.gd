extends Spatial

export(float) var mouse_sens = 1

var is_enabled : bool = true

var target : Spatial
var focus : Spatial

var originalCameraTransform : Transform

func _ready():
	target = get_child(0)
	focus = get_child(1)
	originalCameraTransform = get_child(2).transform 

func force_top_down_view():
	originalCameraTransform = get_child(2).transform 
	get_child(2).lerpTarget = get_child(3).transform
	get_child(2).hasLerpTarget = true
	is_enabled = false

func release_top_down_view():
	get_child(2).lerpTarget = originalCameraTransform
	is_enabled = true
	get_child(2).hasLerpTarget = true

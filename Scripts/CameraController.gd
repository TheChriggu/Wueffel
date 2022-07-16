extends Spatial

var camera : Camera
var target : Spatial
var focus : Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_child(1)
	target = get_child(0).get_child(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.global_transform = camera.global_transform.interpolate_with(target.global_transform, 0.1)
	pass

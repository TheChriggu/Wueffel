extends Spatial



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = Vector3(0,0,0)

var rot_x = 0
var rot_y = 0
var rot_z = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rot_x += delta * speed.x 
	rot_y += delta * speed.y
	rot_z += delta * speed.z
	
	transform.basis = Basis() # reset rotation
	#rotate_object_local(Vector3(1, 0, 0), rot_x)
	#rotate_object_local(Vector3(0, 1, 0), rot_y)
	#rotate_object_local(Vector3(0, 0, 1), rot_z)
	
	pass

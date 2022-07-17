extends Spatial


var controller : Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = get_parent()

func _input(event):
	
	if !controller.is_enabled:
		return
	
	if event is InputEventMouseMotion:
		var offset_x = event.relative.x * controller.mouse_sens
		var offset_z = event.relative.y * controller.mouse_sens
		
		translate(Vector3(offset_x, 0.0, offset_z))
		
		#rot_y = clamp(rot_y, -1, 1)
		
		#transform.basis = Basis() # reset rotation
		#rotate(Vector3(0, 1, 0), rot_x)
		#rotate(Vector3(0, 0, 1), -rot_y)
	
	pass

extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isCurrentlySelected = false


func _input(event):
	if event is InputEventMouseButton:
		#if (event as InputEventMouseButton).pressed:
		isCurrentlySelected = (event as InputEventMouseButton).pressed
		get_parent()._toggle_cam_movement(!isCurrentlySelected)
		
	elif event is InputEventMouseMotion:
		if isCurrentlySelected:
			var speed = (event as InputEventMouseMotion).speed
			var viewportSize = get_viewport().size
			var speed3D = Vector3(speed.x/viewportSize.x, -speed.y/viewportSize.y, 0)
			var up = get_viewport().get_camera().get_global_transform().basis.y
			
			get_child(0).move_and_slide(speed3D * 5, up)

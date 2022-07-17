extends Spatial

export(float) var max_roll_radius = 3
export(float) var roll_speed = 20
export(float) var max_mouse_delta_to_consider = 40
export(float) var damp = 0.03

var is_enabled = true

var isCurrentlySelected = false

var pos_last_frame : Vector2
var current_speed_mult = 0
var actual_speed_mult = 0


func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == BUTTON_LEFT:
			isCurrentlySelected = mouse_event.pressed
			
			# null check for debug purposes
			if get_parent().has_method("_toggle_cam_movement"):
				get_parent()._toggle_cam_movement(!isCurrentlySelected)
		
		if mouse_event.button_index == BUTTON_RIGHT:
			$AnimationPlayer.play("roll_normal")

func _ready():
	print($SpringArm/KinematicBody.translation)

func _process(delta):
	calc_speed()
	roll(delta)

func calc_speed():
	var pos_this_frame = pos_last_frame
	if isCurrentlySelected:
		pos_this_frame = get_viewport().get_mouse_position()
	
	var pos_delta = pos_last_frame - pos_this_frame
	pos_last_frame = pos_this_frame
	
	current_speed_mult = clamp(pos_delta.length() / max_mouse_delta_to_consider, 0, 1)
	
	actual_speed_mult = lerp(actual_speed_mult, current_speed_mult, damp)
	#print(actual_speed_mult)

func roll(delta):
	$SpringArm.rotate_y(roll_speed * actual_speed_mult * delta)
	$SpringArm.spring_length = actual_speed_mult
	$SpringArm/KinematicBody.global_transform.basis = Basis()

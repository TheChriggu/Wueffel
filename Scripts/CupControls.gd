extends Spatial

export(float) var max_roll_radius = 3
export(float) var roll_speed = 20
export(float) var max_mouse_delta_to_consider = 40
export(float) var damp = 0.03
export(float) var damp_divider = 5
export(float) var max_mouse_diff_length = 50

var is_enabled = true

var isCurrentlySelected = false

var pos_last_frame : Vector2
var current_speed_mult = 0
var actual_speed_mult = 0
var actual_damp = damp

var start_mouse_position : Vector2

var throwing = false


func _input(event):
	if not is_enabled:
		return
	
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == BUTTON_LEFT:
			isCurrentlySelected = mouse_event.pressed
			
			if isCurrentlySelected:
				actual_damp = damp
			else:
				actual_damp = damp / damp_divider
			# null check for debug purposes
			if get_parent().has_method("_toggle_cam_movement"):
				get_parent()._toggle_cam_movement(!isCurrentlySelected)
		
		if mouse_event.button_index == BUTTON_RIGHT:
			if mouse_event.pressed:
				start_mouse_position = get_viewport().get_mouse_position()
			else:
				var diff = calc_mousediff()
				if diff.length() > max_mouse_diff_length:
					throw_direction()
				else:
					throw_normal()
			

func _ready():
	actual_damp = damp / damp_divider

func _process(delta):
	#print(actual_damp)
	if not throwing or not is_enabled:
		calc_speed()
		roll(delta)

func calc_speed():
	var pos_this_frame = pos_last_frame
	if isCurrentlySelected:
		pos_this_frame = get_viewport().get_mouse_position()
	
	var pos_delta = pos_last_frame - pos_this_frame
	pos_last_frame = pos_this_frame
	
	current_speed_mult = clamp(pos_delta.length() / max_mouse_delta_to_consider, 0, 1)
	
	actual_speed_mult = lerp(actual_speed_mult, current_speed_mult, actual_damp)
	#print(actual_speed_mult)

func roll(delta):
	$SpringArm.rotate_y(roll_speed * actual_speed_mult * delta)
	$SpringArm.spring_length = actual_speed_mult
	$SpringArm/KinematicBody.global_transform.basis = Basis()

func throw_normal():
	throwing = true
	
	$AnimationPlayer.play("roll_normal")

func throw_direction():
	throwing = true
	
	var stop_mouse_postion = get_viewport().get_mouse_position()
	var diff = start_mouse_position - stop_mouse_postion
	var rotator = Vector3(diff.x, 0, diff.y).normalized().rotated(Vector3(0,1,0), deg2rad(-90))
	var new_rotation = $SpringArm/KinematicBody.transform.rotated(rotator, deg2rad(120)).basis.get_euler()
	
	$Tweener.interpolate_property($SpringArm/KinematicBody, "rotation", $SpringArm/KinematicBody.rotation, new_rotation, 0.3)
	$Tweener.start()

func calc_mousediff():
	var stop_mouse_postion = get_viewport().get_mouse_position()
	var diff = start_mouse_position - stop_mouse_postion
	
	return diff

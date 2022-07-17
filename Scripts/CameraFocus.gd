extends Spatial


var mouse_sens = 0.01

var rot_x = 0
var rot_y = 0
var rot_z = 0


export (int) var speed = 5

var velocity = Vector2()
var canMove = true

var target: Spatial

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	velocity = velocity.normalized() * speed

func _process(delta):
	if !canMove:
		return
	
	get_input()
	
	var rotated = Vector2(0,0)
	
	var sinAngle = sin(rot_x)
	var cosAngle = cos(rot_x)
	
	rotated.x = cosAngle * velocity.x - sinAngle * velocity.y
	rotated.y = sinAngle * velocity.x + cosAngle * velocity.y
	
	global_translate(Vector3(rotated.x * delta, 0, rotated.y * delta))
	

func _get_rotated_direction_behind():
	var sinAngle = sin(rot_y)
	var cosAngle = cos(rot_y)
	
	var retVal = Vector3(0,0,-1)
	retVal.y = -sinAngle
	retVal.z = cosAngle
	
	sinAngle = sin(rot_x)
	cosAngle = cos(rot_x)
	
	
	var rotated_hor = Vector2(retVal.x,retVal.z)
	
	rotated_hor.x = cosAngle * retVal.x - sinAngle * retVal.z
	rotated_hor.y = sinAngle * retVal.x + cosAngle * retVal.z
	
	return Vector3(rotated_hor.x, -retVal.y, rotated_hor.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	
	if !canMove:
		return
	
	if event is InputEventMouseMotion:
		rot_x += event.relative.x * mouse_sens
		rot_y += event.relative.y * mouse_sens
		
		rot_y = clamp(rot_y, -1, 1)
		
		transform.basis = Basis() # reset rotation
		rotate(Vector3(0, 1, 0), rot_x)
		rotate(Vector3(0, 0, 1), -rot_y)
	
	pass

func _toggle_cam_move(toggle):
	canMove = toggle

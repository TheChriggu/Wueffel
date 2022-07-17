extends RigidBody

class_name Cube

export(float) var time_until_damp = 3
export(float) var time_until_stop = 2

export(Array, Array, int) var point_map = [[0, 5], [1, 2], [2, 3], [3, 4], [4, 1], [5, 6]]

var rotation_last : Vector3
var position_last : Vector3

var points = -1


func _ready():
	rotation_last = rotation
	position_last = translation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotation_diff = rotation - rotation_last
	var position_diff = translation - position_last
	
	rotation_last = rotation
	position_last = translation

func notify_thrown():
	$DampTimer.start(time_until_damp)


func disable():
	$DampTimer.stop()
	$StopTimer.stop()
	$Tweener.stop_all()
	
	self.mode = RigidBody.MODE_STATIC
	
	calc_cube_data()
	
	if get_parent().has_method("on_dice_has_fallen"):
		get_parent().on_dice_has_fallen()


func _on_DampTimer_timeout():
	print ("Start damping...")
	$Tweener.interpolate_property(self, "gravity_scale", self.gravity_scale, 3, time_until_stop)
	$Tweener.interpolate_property(self, "bounce", self.bounce, 0, time_until_stop)
	
	$StopTimer.start(time_until_stop)


func _on_StopTimer_timeout():
	print("Stop!")
	disable()


func _on_Cube_sleeping_state_changed():
	if sleeping:
		disable()

func calc_cube_data():
	var children = {
		$MeshInstance.get_child(0).global_transform.origin.y: 0,
		$MeshInstance.get_child(1).global_transform.origin.y: 1,
		$MeshInstance.get_child(2).global_transform.origin.y: 2,
		$MeshInstance.get_child(3).global_transform.origin.y: 3,
		$MeshInstance.get_child(4).global_transform.origin.y: 4,
		$MeshInstance.get_child(5).global_transform.origin.y: 5,
	}
	var biggest = -1
	
	for child in children.keys():
		biggest = max(biggest, child)
	
	print("Spatial index: " + str(children[biggest]))
	points = point_map[children[biggest]][1]


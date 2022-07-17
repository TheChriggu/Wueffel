extends Camera

var controller : Spatial
var lerpTarget : Transform
var selfTransform : Transform
var hasLerpTarget = false

func _ready():
	controller = get_parent()
	lerpTarget = transform


func _process(delta):
	if !controller.is_enabled or hasLerpTarget:
		self.transform = self.transform.interpolate_with(lerpTarget, 0.1)
		if transform.is_equal_approx(selfTransform):
			hasLerpTarget = false
	else:
		self.look_at(controller.focus.translation, Vector3(0,1,0))
	

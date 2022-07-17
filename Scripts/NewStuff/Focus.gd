extends Spatial


var controller : Spatial


func _ready():
	controller = get_parent()


func _process(delta):
	self.global_transform = self.global_transform.interpolate_with(controller.target.global_transform, 0.1)
	#translate((self.translation - controller.target.translation).abs() * 0.1)

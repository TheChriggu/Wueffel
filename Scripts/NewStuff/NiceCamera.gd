extends Camera

var controller : Spatial


func _ready():
	controller = get_parent()


func _process(delta):
	self.look_at(controller.focus.translation, Vector3(0,1,0))

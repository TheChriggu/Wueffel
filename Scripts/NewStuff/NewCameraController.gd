extends Spatial

export(float) var mouse_sens = 1

var is_enabled : bool = true

var target : Spatial
var focus : Spatial

func _ready():
	target = get_child(0)
	focus = get_child(1)



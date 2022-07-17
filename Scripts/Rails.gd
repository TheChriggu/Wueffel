extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_curve_for_item(index):
	var mesh = get_child(index)
	var path = mesh.get_child(0)
	return path.curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

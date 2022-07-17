extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pixelsPerUnit = 100
var projectAspect = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var projectResolution = max(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	projectAspect = ProjectSettings.get_setting("display/window/size/width")/ProjectSettings.get_setting("display/window/size/height")
	var stretch = projectResolution / pixelsPerUnit
	self.scale = Vector3(stretch * projectAspect, 0, stretch)
	pass # Replace with function body.

func unitsToPixel(units):
	return Vector2(units.x, units.y) * pixelsPerUnit
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

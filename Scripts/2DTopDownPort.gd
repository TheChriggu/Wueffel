extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var projectResolution = Vector2(1920, 1080)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup_size():
	projectResolution = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	size = projectResolution - Vector2(50,50)
	
	var camera = get_child(1)
	camera.size = size.x/2
	pass

func GetTexture():
	return get_texture()

func OnInputEvent(event, position = Vector2(-10000, -10000)):
	
	position.x /= projectResolution.x
	position.y /= projectResolution.y
	position.x *= size.x
	position.y *= size.y
	get_child(0).OnInputEvent(event, position)

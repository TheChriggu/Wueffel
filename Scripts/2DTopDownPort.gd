extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var projectResolution = Vector2(1920, 1080)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func begin_Hovering():
	get_child(0).begin_hovering()
	pass

func end_hovering():
	get_child(0).end_hovering()
	pass

func setup_size():
	projectResolution = max(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	size = Vector2(projectResolution, projectResolution)# - Vector2(50,50)
	
	var camera = get_child(1)
	camera.size = projectResolution/2
	pass

func GetTexture():
	return get_texture()

func OnInputEvent(event, pos = Vector2(-10000, -10000)):
	pass
	#var display = get_parent().get_child(1)
	#var lowerCornerWorldPos = display.translation - Vector3(display.scale.x,0, -display.scale.z)
	#var upperCornerWorldPos = display.translation + Vector3(display.scale.x,0, -display.scale.z)
	#get_parent().get_child(2).translation = upperCornerWorldPos
	
	#var lowerCornerPixelPos = $Camera.unproject_position(lowerCornerWorldPos)
	#var upperCornerPixelPos = $Camera.unproject_position(upperCornerWorldPos)
	
	#pos = (pos - upperCornerPixelPos)/(lowerCornerPixelPos - upperCornerPixelPos)
	#pos *= size
	#var bx = (lowerCornerPixelPos.x/upperCornerPixelPos.x)/((lowerCornerPixelPos.x/upperCornerPixelPos.x) - 1)
	#var ax = (1-bx)/upperCornerPixelPos.x
	
	#var by = (lowerCornerPixelPos.y/upperCornerPixelPos.y)/((lowerCornerPixelPos.y/upperCornerPixelPos.y) - 1)
	#var ay = (1-by)/upperCornerPixelPos.y
	
	#var x = ax * pos.x + bx
	#var y = ay * pos.y + by
	#pos = Vector2(x * (upperCornerPixelPos.x -lowerCornerPixelPos.x),y * (upperCornerPixelPos.y -lowerCornerPixelPos.y))
	
	#print("position")
	#print(pos)
	#print("lowerCornerPixelPos")
	#print(lowerCornerPixelPos)
	#print("upperCornerPixelPos")
	#print(upperCornerPixelPos)
	
	#get_child(0).OnInputEvent(event, pos)

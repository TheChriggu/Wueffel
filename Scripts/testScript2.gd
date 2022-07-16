extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	
	var mat = SpatialMaterial.new() 
	var tex = get_child((2)).GetTexture()
	mat.albedo_texture = tex 
	get_child((3)).material_override = mat
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

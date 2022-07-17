extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		pass
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera = get_parent().get_child(1)
		var dir = camera.project_ray_normal(event.position)
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1
		
		var tileMap = get_child(0)
		var targetTile = tileMap.get_used_cells()[0]
		var targetTilePos = tileMap.map_to_world(targetTile.x, targetTile.y, targetTile.z)
		
		var distance = (targetTilePos.y - from.y)/dir.y
		var targetPos = tileMap.world_to_map(from + distance*dir)
		
		tileMap.set_cell_item(targetPos.x, targetPos.y, targetPos.z, 0)

func place_tile_at_mouse_position(mousePos):
	
	pass

func place_tile_at_grid_position(gridPos):
	pass

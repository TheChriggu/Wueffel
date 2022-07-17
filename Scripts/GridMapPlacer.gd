extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tileMap : GridMap
var validityMap : GridMap

# Called when the node enters the scene tree for the first time.
func _ready():
	tileMap = get_child(0)
	validityMap = get_child(1)
	validityMap.transform = tileMap.transform
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var validTiles = tileMap.get_valid_tiles()
	var invalidTiles = tileMap.get_invalid_tiles()
	
	validityMap.clear()
	
	for tile in validTiles:
		validityMap.set_cell_item(tile.x, tile.y+1, tile.z, 0, 6)
	
	for tile in invalidTiles:
		validityMap.set_cell_item(tile.x, tile.y+1, tile.z, 1, 6)
		
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
		
		tileMap.place_tile_at(targetPos)

func place_tile_at_mouse_position(mousePos):
	
	pass

func place_tile_at_grid_position(gridPos):
	pass

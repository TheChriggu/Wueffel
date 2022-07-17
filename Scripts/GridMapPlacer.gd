extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tileMap : GridMap
var validityMap : GridMap
var previouslyHoveredTile = Vector3(-100000, -1000000, -100000)
var hoveredTile = Vector3(0, -1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	tileMap = get_child(0)
	validityMap = get_child(1)
	validityMap.transform = tileMap.transform

func begin_hovering():
	print("begin_hovering")
	print(previouslyHoveredTile)
	print(hoveredTile)
	if previouslyHoveredTile != Vector3(-100000, -1000000, -100000):
		hoveredTile = previouslyHoveredTile
	else:
		hoveredTile = Vector3(0, -1, 0)
	update_indicators(hoveredTile, false)

func end_hovering():
	print("end_hovering")
	print(previouslyHoveredTile)
	print(hoveredTile)
	var tmpTile = hoveredTile
	hoveredTile = Vector3(-100000, -1000000, -100000)
	update_indicators(hoveredTile, false)
	previouslyHoveredTile = tmpTile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hoveredTile == Vector3(-100000, -1000000, -100000):
		return
	if Input.is_action_just_pressed("ui_left"):
		hoveredTile.z -= 1
		update_indicators(hoveredTile, false)	
	if Input.is_action_just_pressed("ui_right"):
		hoveredTile.z += 1
		update_indicators(hoveredTile, false)
	if Input.is_action_just_pressed("ui_up"):
		hoveredTile.x += 1
		update_indicators(hoveredTile, false)
	if Input.is_action_just_pressed("ui_down"):
		hoveredTile.x -= 1
		update_indicators(hoveredTile, false)
	if Input.is_action_just_pressed("ui_select"):
		
		
		if tileMap.tile_can_be_placed_at_position(hoveredTile):
			if LazyLinker.hud.points > 0:
				tileMap.place_tile_at(hoveredTile)
				update_indicators(hoveredTile, true)
				LazyLinker.hud.points -= 1
		elif tileMap.tile_is_on_path(hoveredTile) and !tileMap.tile_is_secure(hoveredTile):
			tileMap.remove_all_tiles_from_tile_onwards(hoveredTile)
			update_indicators(hoveredTile, true)
			
		
	pass

func OnInputEvent(event, position):
	return
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera = get_parent().get_child(1)
		var dir = camera.project_ray_normal(event.position)
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1
		
		var targetTile = tileMap.get_used_cells()[0]
		var targetTilePos = tileMap.map_to_world(targetTile.x, targetTile.y, targetTile.z)
		
		var distance = (targetTilePos.y - from.y)/dir.y
		var targetPos = tileMap.world_to_map(from + distance*dir)
		
		if tileMap.tile_can_be_placed_at_position(targetPos):
			tileMap.place_tile_at(targetPos)
			update_indicators(targetPos)
			update_indicators(targetPos, true)
		elif tileMap.tile_is_on_path(targetPos) and !tileMap.tile_is_secure(targetPos):
			tileMap.remove_all_tiles_from_tile_onwards(targetPos)
			update_indicators(targetPos, true)
			pass
		
	#elif event is InputEventMouseMotion:
	#	var camera = get_parent().get_child(1)
	#	var dir = camera.project_ray_normal(event.position)
	#	var from = camera.project_ray_origin(event.position)
	#	var to = from + camera.project_ray_normal(event.position) * 1
	#	
	#	var targetTile = tileMap.get_used_cells()[0]
	#	var targetTilePos = tileMap.map_to_world(targetTile.x, targetTile.y, targetTile.z)
	#	
	#	var distance = (targetTilePos.y - from.y)/dir.y
	#	var targetPos = tileMap.world_to_map(from + distance*dir)
	#	update_indicators(targetPos, false)

func update_indicators(hoveredTilePosition, ignoreHoverCheck = false):
	if hoveredTilePosition != previouslyHoveredTile or ignoreHoverCheck:
		previouslyHoveredTile = hoveredTilePosition
		
		validityMap.clear()
		
		var validTiles = tileMap.get_valid_tiles()
		var invalidTiles = tileMap.get_invalid_tiles()
		
		if tileMap.tile_is_on_path(hoveredTilePosition):
			if tileMap.tile_is_secure(hoveredTilePosition):
				validityMap.set_cell_item(hoveredTilePosition.x, hoveredTilePosition.y+1, hoveredTilePosition.z, 5, 6)
				return
			validityMap.set_cell_item(hoveredTilePosition.x, hoveredTilePosition.y+1, hoveredTilePosition.z, 3, 6)
			var followers = tileMap._get_all_tiles_on_path_following(hoveredTilePosition)
			for follower in followers:
				validityMap.set_cell_item(follower.x, follower.y+1, follower.z, 1, 6)
		else:
			for tile in validTiles:
				validityMap.set_cell_item(tile.x, tile.y+1, tile.z, 0, 6)
			
			validityMap.set_cell_item(hoveredTilePosition.x, hoveredTilePosition.y+1, hoveredTilePosition.z, 4, 6)
			if validTiles.find(hoveredTilePosition) != -1:
				validityMap.set_cell_item(hoveredTilePosition.x, hoveredTilePosition.y+1, hoveredTilePosition.z, 2, 6)

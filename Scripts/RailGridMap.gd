extends GridMap

enum RailType {STRAIGHT, CORNER_LD, CORNER_LU, CORNER_RD, CORNER_RU}

export(PackedScene) var track_tempalte
export(int) var tile_id
var path : Path
var pathFollow1 : PathFollow
var pathFollow2 : PathFollow
var pathFollow3 : PathFollow

func _ready():
	path = get_child(0)
	
	var used_rail_tiles = get_used_cells()
	print(used_rail_tiles)
	
	generate_path()
	
	pathFollow1 = path.get_child(0)
	pathFollow1.offset = 3.5
	pathFollow2 = path.get_child(1)
	pathFollow2.offset = 0
	pathFollow3 = path.get_child(2)
	pathFollow3.offset = -3.5

func _process(delta):
	pathFollow1.offset += delta
	pathFollow2.offset += delta
	pathFollow3.offset += delta
	
	print("a")

func generate_path():
	path.curve.clear_points()
	
	var used_rail_tiles = get_used_cells()
	
	for tile in used_rail_tiles:
		var worldCoord = map_to_world(tile.x, tile.y, tile.z)
		path.curve.add_point(worldCoord)

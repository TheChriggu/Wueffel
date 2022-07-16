extends TileMap

enum RailType {STRAIGHT, CORNER_LD, CORNER_LU, CORNER_RD, CORNER_RU}

export(PackedScene) var track_tempalte
export(int) var tile_id

func _ready():
	var used_rail_tiles = get_used_cells_by_id(1)
	print(used_rail_tiles)

func map_rail_tile(tile_Cord: Vector2):
	match(tile_Cord):
		Vector2(0,0):
			print("")

extends TileMap

export(PackedScene) var track_tempalte

func _ready():
	var used_rail_tiles = get_used_cells_by_id(1)
	print(used_rail_tiles)



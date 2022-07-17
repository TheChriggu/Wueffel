extends GridMap

enum RailType {STRAIGHT, CORNER_LD, CORNER_LU, CORNER_RD, CORNER_RU}

export(PackedScene) var track_tempalte
export(int) var tile_id
var path : Path
var pathFollow1 : PathFollow
var pathFollow2 : PathFollow
var pathFollow3 : PathFollow
var tracks

var run = false


func _ready():
	path = get_child(0)
	tracks = get_child(1)
	
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
	if !run:
		return
	
	pathFollow1.offset += delta
	pathFollow2.offset += delta
	pathFollow3.offset += delta

func generate_path():
	
	path.curve.clear_points()
	
	var used_rail_tiles = get_used_cells()
	
	var currentLast = map_to_world(used_rail_tiles[0].x, used_rail_tiles[0].y, used_rail_tiles[0].z)
	var currentLastDist = 4
	
	for tile in used_rail_tiles:
		var worldCoord = map_to_world(tile.x, tile.y, tile.z)
		var item = get_cell_item(tile.x, tile.y, tile.z)
		
		var curve = tracks.get_curve_for_item(item)
		
		for pointIdx in curve.get_point_count():
			var pointPos = curve.get_point_position(pointIdx) + worldCoord
			var pointIn = curve.get_point_in(pointIdx)
			var pointOut = curve.get_point_out(pointIdx)
			
			var dist = (pointPos - currentLast).length_squared()
			
			if currentLastDist == -1:
				path.curve.add_point(pointPos, pointIn, pointOut)
				currentLastDist = dist
			elif currentLastDist > 0 and dist < currentLastDist and path.curve.get_point_count() > 2:
				path.curve.add_point(pointPos, pointIn, pointOut, path.curve.get_point_count() - 2)
			else:
				path.curve.add_point(pointPos, pointIn, pointOut)
				currentLastDist = dist
			
		
		currentLast = path.curve.get_point_position(path.curve.get_point_count() -1)
		currentLastDist = -1
	

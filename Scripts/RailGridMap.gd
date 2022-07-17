extends GridMap

enum RailType {STRAIGHT_H = 4, STRAIGHT_V = 5, CORNER_RU = 0, CORNER_RD = 1, CORNER_LD = 2, CORNER_LU = 3}
enum CardinalDirection {NORTH, SOUTH, EAST, WEST}

export(PackedScene) var track_tempalte
export(int) var tile_id
var path : Path
var pathFollow1 : PathFollow
var pathFollow2 : PathFollow
var pathFollow3 : PathFollow
var tracks

var run = false

var pathPoints = Array()
var savedPoints = Array()
var startCurve : Curve3D



func _ready():
	path = get_child(0)
	
	startCurve = Curve3D.new()
	
	startCurve.add_point(path.curve.get_point_position(0))
	startCurve.add_point(path.curve.get_point_position(1))
	tracks = get_child(1)
	
	var used_rail_tiles = get_used_cells()
	
	for tile in used_rail_tiles:
		pathPoints.append(tile)
		savedPoints.append(tile)
	
	pathFollow1 = path.get_child(0)
	pathFollow2 = path.get_child(1)
	pathFollow3 = path.get_child(2)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		generate_path()
		run = true
	
	if !run:
		return
	
	pathFollow1.offset += delta*5
	pathFollow2.offset += delta*5
	pathFollow3.offset += delta*5

func place_tile_at(index3D):
	if !tile_can_be_placed_at_position(index3D):
		return
	
	var currentLast = pathPoints[pathPoints.size() - 1]
	var currentOneBeforeLast = pathPoints[pathPoints.size() - 2]
	
	var currentLastFromDir = currentLast - currentOneBeforeLast
	var currentDir = index3D - currentLast
	
	var currentLastCorner = Vector2(0,0)
	if currentLastFromDir.x > 0:
		currentLastCorner.y = 1
	if currentLastFromDir.x < 0:
		currentLastCorner.y = -1
	if currentLastFromDir.z > 0:
		currentLastCorner.x = 1
	if currentLastFromDir.z < 0:
		currentLastCorner.x = -1
	
	var currentCorner = Vector2(0,0)
	if currentDir.x > 0:
		currentCorner.y = 1
	if currentDir.x < 0:
		currentCorner.y = -1
	if currentDir.z > 0:
		currentCorner.x = 1
	if currentDir.z < 0:
		currentCorner.x = -1
	
	if currentLastCorner.x != 0 and currentCorner.x != 0:
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.STRAIGHT_H)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_H)
	elif currentLastCorner.y != 0 and currentCorner.y!= 0:
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.STRAIGHT_V)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_V)
	elif (currentLastCorner.x > 0 and currentCorner.y > 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_LU)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_V)
	elif (currentLastCorner.x > 0 and currentCorner.y < 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_LD)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_V)
	elif (currentLastCorner.x < 0 and currentCorner.y > 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_RU)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_V)
	elif (currentLastCorner.x < 0 and currentCorner.y < 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_RD)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_V)
	elif (currentLastCorner.y > 0 and currentCorner.x > 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_RD)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_H)
	elif (currentLastCorner.y > 0 and currentCorner.x < 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_LD)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_H)
	elif (currentLastCorner.y < 0 and currentCorner.x > 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_RU)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_H)
	elif (currentLastCorner.y < 0 and currentCorner.x < 0):
		set_cell_item(currentLast.x, currentLast.y, currentLast.z, RailType.CORNER_LU)
		set_cell_item(index3D.x, index3D.y, index3D.z, RailType.STRAIGHT_H)
	else:
		print("placement unsuccessful.")
		print("currentOneBeforeLast")
		print(currentOneBeforeLast)
		print("currentLast")
		print(currentLast)
		print("index3D")
		print(index3D)
		print("currentLastFromDir")
		print(currentLastFromDir)
		print("currentDir")
		print(currentDir)
		print("currentLastCorner")
		print(currentLastCorner)
		print("currentCorner")
		print(currentCorner)
	
	pathPoints.append(index3D)

func remove_all_tiles_from_tile_onwards(index3D):
	var startIdx = pathPoints.find(index3D)
	if startIdx < 0:
		return
	
	for i in range(pathPoints.size(), startIdx, -1):
		var point = pathPoints.pop_back()
		set_cell_item(point.x, point.y, point.z, -1)
		LazyLinker.hud.points += 1
		pass

func tile_can_be_placed_at_position(index3D):
	
	if tile_is_on_path(index3D):
		return false
	
	var currentLast = pathPoints[pathPoints.size() - 1]
	var diff = index3D - currentLast
	var isValid = (abs(diff.x) + abs(diff.y) + abs(diff.z)) == 1;
	return isValid

func tile_is_on_path(index3D):
	return pathPoints.find(index3D) > -1

func tile_is_secure(index3D):
	return savedPoints.find(index3D) > -1

func get_valid_tiles():
	var currentLast = pathPoints[pathPoints.size() - 1]
	var retVal = Array()
	var left = currentLast - Vector3(0,0,-1)
	var right = currentLast - Vector3(0,0,1)
	var top = currentLast - Vector3(1,0,0)
	var bottom = currentLast - Vector3(-1,0,0)
	
	if tile_can_be_placed_at_position(left):
		retVal.append(left)
	if tile_can_be_placed_at_position(right):
		retVal.append(right)
	if tile_can_be_placed_at_position(top):
		retVal.append(top)
	if tile_can_be_placed_at_position(bottom):
		retVal.append(bottom)
	
	return retVal

func get_invalid_tiles():
	var currentLast = pathPoints[pathPoints.size() - 1]
	var retVal = Array()
	var left = currentLast - Vector3(0,0,-1)
	var right = currentLast - Vector3(0,0,1)
	var top = currentLast - Vector3(1,0,0)
	var bottom = currentLast - Vector3(-1,0,0)
	
	if !tile_can_be_placed_at_position(left):
		retVal.append(left)
	if !tile_can_be_placed_at_position(right):
		retVal.append(right)
	if !tile_can_be_placed_at_position(top):
		retVal.append(top)
	if !tile_can_be_placed_at_position(bottom):
		retVal.append(bottom)
	
	return retVal

func _get_all_tiles_on_path_following(index3D):
	var retVal = Array()
	
	var pointIndex = pathPoints.find(index3D)
	if pointIndex == -1:
		return retVal
	
	for index in pathPoints.size():
		if index > pointIndex:
			retVal.append(pathPoints[index])
	
	return retVal
	
	pass

func generate_path():
	
	path.curve.clear_points()
	
	
	path.curve.add_point(startCurve.get_point_position(0))
	path.curve.add_point(startCurve.get_point_position(1))
	var kickOffPoint = startCurve.get_point_position(1)
	var currentLast = kickOffPoint#map_to_world(kickOffPoint.x, kickOffPoint.y, kickOffPoint.z)
	var currentLastDist = -1
	
	var used_rail_tiles = get_used_cells()
	for savedPoint in savedPoints:
		used_rail_tiles.erase(savedPoint)
	
	for tile in pathPoints:
		var worldCoord = map_to_world(tile.x, tile.y, tile.z)
		var item = get_cell_item(tile.x, tile.y, tile.z)
		
		var curve = tracks.get_curve_for_item(item)
		
		var point1 = curve.get_point_position(1) + worldCoord
		var point2 = curve.get_point_position(2) + worldCoord
		
		var d1 = (point1 - currentLast).length_squared()
		var d2 = (point2 - currentLast).length_squared()
		if d1 < d2:
			path.curve.add_point(point1, curve.get_point_in(1), curve.get_point_out(1))
			path.curve.add_point(point2, curve.get_point_in(2), curve.get_point_out(2))
			currentLast = point2
		else:
			path.curve.add_point(point2, curve.get_point_out(2), curve.get_point_in(2))
			path.curve.add_point(point1, curve.get_point_out(1), curve.get_point_in(1))
			currentLast = point1

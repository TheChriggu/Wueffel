extends Control

var points = 0 setget set_points, get_points

# Called when the node enters the scene tree for the first time.
func _ready():
	LazyLinker.hud = self
	
	set_points(0)

func set_points(p):
	points = p
	
	$Label.text = str(points)

func get_points():
	return points

func enable_roll_label():
	$ColorRect.visible = true
	$ColorRect/LabelRoll.visible = true
	$ColorRect/Labeltrack.visible = false

func enable_track_label():
	$ColorRect.visible = true
	$ColorRect/LabelRoll.visible = false
	$ColorRect/Labeltrack.visible = true

func menu_mode():
	$ColorRect.visible = false
	$ColorRect/LabelRoll.visible = false
	$ColorRect/Labeltrack.visible = false

extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var focus : Spatial
var offsetFromFocus = 5

func _ready():
	focus = get_parent()
	#self.translation
	var offsetDir = focus._get_rotated_direction_behind()
	self.look_at_from_position(focus.translation + offsetDir * offsetFromFocus, focus.translation, Vector3(0,1,0))


func _process(delta):
	var offsetDir = focus._get_rotated_direction_behind()
	self.look_at_from_position(focus.translation + offsetDir * offsetFromFocus, focus.translation, Vector3(0,1,0))


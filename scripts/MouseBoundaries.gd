extends CanvasLayer

const Y_SPAN = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	$move_left_line.set_point_position(0, Vector2(Global.MOVE_LEFT_LINE_X, -Y_SPAN))
	$move_left_line.set_point_position(1, Vector2(Global.MOVE_LEFT_LINE_X, Y_SPAN))

	$move_right_line.set_point_position(0, Vector2(Global.MOVE_RIGHT_LINE_X, -Y_SPAN))
	$move_right_line.set_point_position(1, Vector2(Global.MOVE_RIGHT_LINE_X, Y_SPAN))

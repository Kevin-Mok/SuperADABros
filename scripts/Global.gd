extends Node2D

var view
var camera
var WINDOW_DIMENSIONS = Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height"))
var TEST_WINDOW_DIMENSIONS = Vector2(
		ProjectSettings.get_setting("display/window/size/test_width"),
		ProjectSettings.get_setting("display/window/size/test_height"))
var TEST_WINDOW_SCALE = TEST_WINDOW_DIMENSIONS / WINDOW_DIMENSIONS

const LEFT_AREA = float(1)/6
const RIGHT_AREA = 1-LEFT_AREA
var MOVE_LEFT_LINE_X = WINDOW_DIMENSIONS.x * LEFT_AREA
var MOVE_RIGHT_LINE_X = WINDOW_DIMENSIONS.x * RIGHT_AREA
var TEST_MOVE_LEFT_LINE_X = TEST_WINDOW_DIMENSIONS.x * LEFT_AREA
var TEST_MOVE_RIGHT_LINE_X = TEST_WINDOW_DIMENSIONS.x * RIGHT_AREA

# Called when the node enters the scene tree for the first time.
func _ready():
	view = get_viewport()

#  vars {{{ # 

extends Node2D

# const CAM_DIMENSIONS = Vector2(480,640)
# const SAMPLE_LAST = 5
const DETECTION_OUTPUT_FILE = '/tmp/move_mouse_with_head.out'
var detection_on = false
var mouse_point_set
const NUM_FACE_CENTERS = 3
# const NUM_FACE_CENTERS = 5
# const NUM_FACE_CENTERS = 10
var head_centers = []
var last_head_center = Vector2(0,0)
# scale_head_movement {{{
# var scale_head_movement = Vector2(15,15)
var scale_head_movement = Vector2(20,20)
# var scale_head_movement = Vector2(25,25)
# var scale_head_movement = Vector2(70,35)
# var scale_head_movement = Vector2(200,150)
# }}}
# const NUM_FACE_CENTERS = 5
# MINIMUM_HEAD_MOVEMENT {{{
var MINIMUM_HEAD_MOVEMENT = Vector2(1,1)
# var MINIMUM_HEAD_MOVEMENT = Vector2(1.5,1.5)
# var MINIMUM_HEAD_MOVEMENT = Vector2(5,5)
# }}}
var head_centers_sum = Vector2(0,0)
var head_centers_avg = Vector2(0,0)
var last_head_centers_avg = Vector2(0,0)

#  }}} vars # 

func _ready():# {{{
	set_process(true)
	mouse_point_set = Global.TEST_WINDOW_DIMENSIONS/2
	Input.warp_mouse_position(mouse_point_set)
	check_if_detecting()

func _process(delta):
	if detection_on:
		update_mouse_point_set()
# }}}

func return_min_movement(diff):# {{{
	return ((abs(diff.x) > MINIMUM_HEAD_MOVEMENT.x) || 
			(abs(diff.y) > MINIMUM_HEAD_MOVEMENT.y))
# }}}

func update_mouse_point_set():# {{{
	last_head_centers_avg = head_centers_avg
	update_avg_head_center()
	var diff = head_centers_avg - last_head_centers_avg
	# var latest_head_center = get_last_head_center()
	# if latest_head_center != last_head_center:
		# mouse_point_set += (latest_head_center  - last_head_center) * scale_head_movement
		# last_head_center = latest_head_center
	# if diff != Vector2(0,0):
	if return_min_movement(diff):
		# print(diff * scale_head_movement)
		diff.x *= -1
		mouse_point_set += diff * scale_head_movement
		# last_head_centers_avg = head_centers_avg
		if mouse_point_set.x > Global.TEST_WINDOW_DIMENSIONS.x:
			mouse_point_set.x = Global.TEST_WINDOW_DIMENSIONS.x
		elif mouse_point_set.x < 0:
			mouse_point_set.x = 0
		if mouse_point_set.y > Global.TEST_WINDOW_DIMENSIONS.y:
			mouse_point_set.y = Global.TEST_WINDOW_DIMENSIONS.y
		elif mouse_point_set.y < 0:
			mouse_point_set.y = 0
		Input.warp_mouse_position(mouse_point_set)
# }}}

func convert_out_to_vector(out):# {{{
	out = out.split(" ", false)
	return Vector2(out[0], out[1])# }}}

func check_if_detecting():# {{{
	var output = []
	# OS.execute('tail', ['-n', SAMPLE_LAST, '/tmp/move_mouse_with_head.out'], true,
	OS.execute('cat', [DETECTION_OUTPUT_FILE], true, output)
	detection_on = (output[0].length() != 0)
	# detection_on = false
# }}}

func get_last_head_center():# {{{
	var latest_head_center = []
	# OS.execute('tail', ['-n', SAMPLE_LAST, '/tmp/move_mouse_with_head.out'], true,
	OS.execute('tail', ['-n', '1', '/tmp/move_mouse_with_head.out'], true,
			latest_head_center)
	return convert_out_to_vector(latest_head_center[0])# }}}

func update_avg_head_center():# {{{
	var latest_head_center = get_last_head_center()
	# if latest_head_center != last_head_center:
	# if return_min_movement(latest_head_center - last_head_center):
		# last_head_center = latest_head_center
	head_centers.push_back(latest_head_center)
	head_centers_sum += latest_head_center
	if head_centers.size() > NUM_FACE_CENTERS:
		head_centers_sum -= head_centers.pop_front()
	head_centers_avg = head_centers_sum / head_centers.size()
# }}}

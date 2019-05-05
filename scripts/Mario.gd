#  vars {{{ # 

extends KinematicBody2D

# var speed = 25
const GROUND_SPEED = 100
var speed = GROUND_SPEED
# var gravity = 1300
var	gravity = 3000

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

var on_ramp = false
const RAMP_SPEED = 150
var rotating = false

const RAMP_DEGREES = 26.5
const FRAMES_TO_ROTATE = 15
const RAMP_DEGREES_PER_FRAME = RAMP_DEGREES / FRAMES_TO_ROTATE

var cur_mouse_point 

#  }}} vars # 

func _ready():# {{{
	set_physics_process(true)

func _physics_process(delta):
	_move(delta)
# }}}

func get_mouse_direction():# {{{
	cur_mouse_point = Global.view.get_mouse_position() * Global.TEST_WINDOW_SCALE
	if cur_mouse_point.x < Global.TEST_MOVE_LEFT_LINE_X:
		return Vector2(-1,0)
	elif cur_mouse_point.x > Global.TEST_MOVE_RIGHT_LINE_X:
		return Vector2(1,0)
	else:
		return Vector2(0,0)# }}}

func increment_rotation_degrees(increment, max_degrees):# {{{
	rotation_degrees += increment
	if ((increment < 0 && rotation_degrees < max_degrees) ||
			(increment > 0 && rotation_degrees > max_degrees)):
		rotation_degrees = max_degrees
		rotating = false# }}}

func set_rotation_degree(action):# {{{
	match action:
		'ramp_up':
			increment_rotation_degrees(-RAMP_DEGREES_PER_FRAME, -RAMP_DEGREES)
		'ramp_down':
			increment_rotation_degrees(RAMP_DEGREES_PER_FRAME, RAMP_DEGREES)
		'level':
			if rotation_degrees < 0:
				increment_rotation_degrees(RAMP_DEGREES_PER_FRAME, 0)
			elif rotation_degrees > 0:
				increment_rotation_degrees(-RAMP_DEGREES_PER_FRAME, 0)
# }}}

func set_ramp_status(set_on_ramp, direction):# {{{
	if on_ramp != set_on_ramp:
		rotating = true
	if rotating:
		set_rotation_degree(direction)
	on_ramp = set_on_ramp
# }}}

func _move(delta):# {{{
	# direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	direction.x = get_mouse_direction().x
	
	#  animation {{{ # 
	
	if direction.x != 0 and direction.y == 0:
		$sprite.animation = "move"
		$sprite.playing = true
	elif direction.x == 0 and direction.y == 0:
		$sprite.playing = false
		$sprite.animation = "idle"
	
	if direction.x > 0:
		$sprite.flip_h = false
	elif direction.x < 0:
		$sprite.flip_h = true
	
	#  }}} animation # 
	
	var not_at_left_edge = $sprite.global_position.x > 8
	distance.x = (speed*delta if not_at_left_edge || direction.x == 1 else 0)
	velocity.x = (direction.x*distance.x)/delta
	velocity.y += gravity*delta
	
	move_and_slide(velocity,Vector2(0,-1))
	
	if is_on_floor():# {{{
		velocity.y = 0
		direction.y = 0
	# }}}

	if get_slide_count() > 0:# {{{
		var get_col = get_slide_collision(get_slide_count()-1)
		if get_col.collider.is_in_group("ramp"):
			if get_col.collider.is_in_group("ramp_up"):
				set_ramp_status(true, "ramp_up")
			elif get_col.collider.is_in_group("ramp_down"):
				set_ramp_status(true, "ramp_down")
			# speed = RAMP_SPEED
		else:
			set_ramp_status(false, 'level')
			# speed = GROUND_SPEED
	# }}}

# }}}

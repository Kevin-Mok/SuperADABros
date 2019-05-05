#  vars {{{ # 

extends KinematicBody2D

# var speed = 25
const GROUND_SPEED = 100
# const GROUND_SPEED = 200
var speed = GROUND_SPEED
# var gravity = 1300
# var gravity = 3000
var	gravity = 2000

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

var on_ramp = false
const RAMP_SPEED = 150
var rotating = false
var attacking = false
var attacking_rotating_up

const RAMP_DEGREES = 26.5
const FRAMES_TO_ROTATE = 15
const RAMP_DEGREES_PER_FRAME = RAMP_DEGREES / FRAMES_TO_ROTATE

const ATTACK_DEGREES = 45
# const FRAMES_TO_ATTACK_UP = 12
# const FRAMES_TO_ATTACK_DOWN = 10
const FRAMES_TO_ATTACK_UP = 10
const FRAMES_TO_ATTACK_DOWN = 8
const ATTACK_UP_DEGREES_PER_FRAME = ATTACK_DEGREES / FRAMES_TO_ATTACK_UP
const ATTACK_DOWN_DEGREES_PER_FRAME = ATTACK_DEGREES / FRAMES_TO_ATTACK_DOWN
const REV_DIR_ATTACK_GRAVITY = 50

var cur_mouse_point 

#  }}} vars # 

func _ready():# {{{
	set_physics_process(true)
	Global.MARIO_NODE = self

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
		'attack':
			var degree_multiplier = (-1 if !$sprite.flip_h else 1)
			if attacking_rotating_up:
				increment_rotation_degrees(ATTACK_UP_DEGREES_PER_FRAME *
						degree_multiplier, ATTACK_DEGREES * degree_multiplier)
			else:
				increment_rotation_degrees(-ATTACK_DOWN_DEGREES_PER_FRAME *
						degree_multiplier, 0)
			# if $sprite.flip_h:
				# velocity.y += REV_DIR_ATTACK_GRAVITY
			if rotation_degrees == ATTACK_DEGREES * degree_multiplier:
				attacking_rotating_up = false
			# print(rotation_degrees)
# }}}

func set_ramp_status(set_on_ramp, direction):# {{{
	if on_ramp != set_on_ramp:
		rotating = true
	if rotating:
		set_rotation_degree(direction)
	on_ramp = set_on_ramp
# }}}

func set_attack_status():# {{{
	if attacking:
		rotating = true
		set_rotation_degree('attack')
	if rotation_degrees == 0:
		attacking = false
# }}}

func check_if_can_attack():# {{{
	# only attack if:
	# - mouse in right area
	# - not on ramp/rotating
	#   - calling this function if not on ramp
	# - not moving
	#   - redundant since can't attack and move anyway?
	# - not already attacking
	# - on ground
	#   - calling this function if collision
	if ((cur_mouse_point.y < Global.TEST_ATTACK_LINE_Y) &&
			!rotating &&
			direction.x == 0 &&
			!attacking):
		return true
	return false# }}}

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
	
	# if get_col.collider.is_in_group("ground"):
	if get_slide_count() > 0:# {{{
		var get_col = get_slide_collision(get_slide_count()-1)
		if is_on_floor() && !get_col.collider.is_in_group("enemy"):
			velocity.y = 0
			direction.y = 0
		if get_col.collider.is_in_group("ramp"):
			if get_col.collider.is_in_group("ramp_up"):
				set_ramp_status(true, "ramp_up")
			elif get_col.collider.is_in_group("ramp_down"):
				set_ramp_status(true, "ramp_down")
			# speed = RAMP_SPEED
		else:
			set_ramp_status(false, 'level')
			if check_if_can_attack():
				attacking = true
				attacking_rotating_up = true
			set_attack_status()
			# speed = GROUND_SPEED
	# }}}

	print(velocity.y)
	# print(is_on_floor())
# }}}

func death():# {{{
	visible = false
	Global.MARIO_DEATH_NODE.get_node("wheelchair").flip_h = $sprite.flip_h
	Global.MARIO_DEATH_NODE.play_animation()# }}}

#  vars {{{ # 

extends KinematicBody2D

# var speed = 25
const GROUND_SPEED = 50
var speed = GROUND_SPEED
# var gravity = 1300
var	gravity = 3000

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

var killed_frames = 0
const FRAMES_TO_KILL = 60

#  }}} vars # 

func _ready():# {{{
	set_physics_process(true)
	$sprite.animation = "move"
	$sprite.playing = true
	direction.x = 0
	# direction.x = -1
	# direction.x = 1

func _physics_process(delta):
	if killed_frames == 0:
		_move(delta)
	else:
		killed_frames += 1
		if killed_frames >= FRAMES_TO_KILL:
			queue_free()
# }}}

func check_if_mario_opp_dir():
	var mario_flipped = Global.MARIO_NODE.get_node("sprite").flip_h 
	return ((direction.x == -1 && !mario_flipped) ||
			(direction.x == 1 && mario_flipped))

func _move(delta):# {{{
	var not_at_left_edge = $sprite.get_global_transform_with_canvas()[2].x > 0
	distance.x = (speed*delta if not_at_left_edge || direction.x == 1 else 0)
	velocity.x = (direction.x*distance.x)/delta
	velocity.y += gravity*delta
	
	move_and_slide(velocity,Vector2(0,-1))
	
	if get_slide_count() > 0:
		var get_col = get_slide_collision(get_slide_count()-1)
		if get_col.collider.is_in_group("ramp"):
			direction.x *= -1
		elif get_col.collider.is_in_group("mario"):
			if check_if_mario_opp_dir() && Global.MARIO_NODE.attacking:
				direction.x *= 0
				$sprite.animation = "squash"
				$sprite.playing = false
				get_node("collision").queue_free()
				killed_frames += 1
			else:
				direction.x = 0
				$sprite.playing = false
# }}}

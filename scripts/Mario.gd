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

var cur_mouse_point 

#  }}} vars # 

func _ready():# {{{
	set_physics_process(true)

func _physics_process(delta):
	_move(delta)
# }}}

func _move(delta):# {{{
	direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	
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
	
	var not_at_left_edge = $sprite.global_position.x > 0
	distance.x = (speed*delta if not_at_left_edge || direction.x == 1 else 0)
	velocity.x = (direction.x*distance.x)/delta
	velocity.y += gravity*delta
	
	move_and_slide(velocity,Vector2(0,-1))
	
	if is_on_floor():# {{{
		velocity.y = 0
		direction.y = 0
	# }}}

# }}}

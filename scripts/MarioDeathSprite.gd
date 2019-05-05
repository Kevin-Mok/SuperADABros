extends KinematicBody2D

var play = false
# var play = true

var jump_speed = 60
var jumped = false
# var gravity = jump_speed * 1.5
var gravity = jump_speed * 5
var velocity = Vector2(0,0)

const BELOW_SCREEN = 184

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if play:
		_move(delta)

func _move(delta):# {{{
	velocity.y += gravity*delta
	if !jumped:
		velocity.y -= jump_speed
		jumped = true
	move_and_slide(velocity,Vector2(0,-1))
	if position.y > BELOW_SCREEN:
		Global.MARIO_NODE.update_cur_checkpoint()
		get_tree().reload_current_scene()
# }}}

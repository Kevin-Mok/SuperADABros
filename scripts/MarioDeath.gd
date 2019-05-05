extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Global.MARIO_DEATH_NODE = self

func play_animation():
	visible = true
	position = Global.MARIO_NODE.position
	get_node("Mario Sprite (Death)").play = true

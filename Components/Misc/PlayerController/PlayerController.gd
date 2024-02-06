extends Node

@export var player: CharacterBody2D
@export var speed: float =  20 * 100

func _ready():
	pass # Replace with function body.

var motion = Vector2.ZERO

func _process(__delta):
	if not PlayerFlags.movement_enabled:
		return
	motion.x = Input.get_action_strength("direction_right") - Input.get_action_strength("direction_left")
	motion.y = Input.get_action_strength("direction_down") - Input.get_action_strength("direction_up")

func _physics_process(delta):
	player.velocity = motion.normalized() * speed * delta
	player.move_and_slide()
	motion = Vector2.ZERO


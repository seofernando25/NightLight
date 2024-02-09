extends Node
class_name PlayerMovement

@export var player: CharacterBody2D
@export var speed: float =  20 * 100

static var controller_enabled = true

func _ready():
	pass # Replace with function body.

var motion = Vector2.ZERO
var running = false
func _process(__delta):
	if not controller_enabled or DialogBox.in_dialog or PlayerFlags.in_cutscene:
		return
	running = Input.is_action_pressed("ui_accept")
	motion.x = Input.get_action_strength("direction_right") - Input.get_action_strength("direction_left")
	motion.y = Input.get_action_strength("direction_down") - Input.get_action_strength("direction_up")

func _physics_process(delta):
	player.velocity = motion.normalized() * delta * (speed * (1 + int(running)))
	player.move_and_slide()
	motion = Vector2.ZERO


extends CharacterBody2D
class_name Player

static var instance: Player = null


@onready var char_sprite: AnimatedSprite2D  = %Sprite
@onready var animation_tree: AnimationTree = %AnimationTree

enum initial_heading {UP, DOWN, LEFT, RIGHT}
@export var initialHeading: initial_heading = initial_heading.DOWN
@export var player_movement_enabled = true

func _ready():
	if instance == null:
		instance = self
		if MainCamera.instance != null:
			MainCamera.instance.follow = self

		# Get the texture of the color_bounds node
	else:
		print("Error: There are two players instances in the scene.")
		queue_free()
	
	# Set the initial heading
	match initialHeading:
		initial_heading.LEFT:
			animation_tree.set("parameters/MoveAnimations/blend_position", Vector2(-0.3, 0))
		initial_heading.RIGHT:
			animation_tree.set("parameters/MoveAnimations/blend_position", Vector2(0.3, 0))

		initial_heading.UP:
			animation_tree.set("parameters/MoveAnimations/blend_position", Vector2(0, -0.3))
		# If down set animation to down
		initial_heading.DOWN:
			animation_tree.set("parameters/MoveAnimations/blend_position", Vector2(0, 0.3))

	
@export var speed: float =  20 * 100


var motion = Vector2.ZERO
var running = false
func _process(__delta):
	if not player_movement_enabled or DialogBox.in_dialog or PlayerFlags.in_cutscene:
		return
	running = Input.is_action_pressed("ui_accept")
	if player_movement_enabled:
		motion.x = Input.get_action_strength("direction_right") - Input.get_action_strength("direction_left")
		motion.y = Input.get_action_strength("direction_down") - Input.get_action_strength("direction_up")

var last_motion = Vector2.ZERO
func _physics_process(delta):
	var motion_norm = motion.normalized()
	velocity = motion_norm * delta * (speed * (1 + int(running)))
	if motion_norm != Vector2.ZERO:
		animation_tree.set("parameters/MoveAnimations/blend_position", motion_norm)
		last_motion = motion_norm
	elif last_motion != Vector2.ZERO:
		var last_motion_half = last_motion / 3
		animation_tree.set("parameters/MoveAnimations/blend_position", last_motion_half)
	
	move_and_slide()
	motion = Vector2.ZERO

func _on_sanity_timer_timeout():
	if PlayerFlags.player_in_light > 0:
		PlayerFlags.sanity += PlayerFlags.player_in_light
	else:
		PlayerFlags.sanity -= 10

	if PlayerFlags.sanity < 0:
		PlayerFlags.sanity = 0
	if PlayerFlags.sanity > 100:
		PlayerFlags.sanity = 100

extends CharacterBody2D
class_name Player

static var instance: Player = null
@export var walk_sound: PackedScene = null
@export var run_sound: PackedScene = null
@export var animation_tree: AnimationTree = null

@export var char_sprite: AnimatedSprite2D = null
@export var camera: Camera2D = null

enum initial_heading { UP, DOWN, LEFT, RIGHT }
@export var initialHeading: initial_heading = initial_heading.DOWN
@export var player_movement_enabled = true

@export var speed: float = 20 * 100

var motion = Vector2.ZERO
var running = false
var max_zoom = 3.0
var min_zoom = 2.0
var lerped_zoom = min_zoom

# Array of [t, position] pairs for the player noise time until it fades out and the position of the noise
var noises = []


func _ready():
	if instance == null:
		instance = self
		# Get the texture of the color_bounds node
	else:
		print("There are two players instances in the scene. Removing the previous one.")
		instance.queue_free()
		instance = self

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

	# Set up initial zoom
	camera.zoom = Vector2(min_zoom, min_zoom)


func _process(delta):
	# Camera zoom goes from 1 to 3 depending on the player's sanity (0 to 100) from PlayerFlags.sanity
	var zoom = max_zoom - (PlayerFlags.sanity / 100) * (max_zoom - min_zoom)
	lerped_zoom = lerp(lerped_zoom, zoom, 0.1 * delta)
	camera.zoom = Vector2(lerped_zoom, lerped_zoom)

	if not player_movement_enabled or DialogBox.in_dialog or PlayerFlags.in_cutscene:
		return
	running = Input.is_action_pressed("ui_accept")
	if player_movement_enabled:
		motion.x = (
			Input.get_action_strength("direction_right")
			- Input.get_action_strength("direction_left")
		)
		motion.y = (
			Input.get_action_strength("direction_down") - Input.get_action_strength("direction_up")
		)


var last_motion = Vector2.ZERO
var last_footstep_time = 0


func _physics_process(delta):
	var motion_norm = motion.normalized()
	velocity = motion_norm * delta * (speed * (1 + int(running)))

	# Sanity goes from 100 to 0 multiply velocity from 1 to 0.75 depending on the player's sanity
	velocity *= (0.75) + (PlayerFlags.sanity / 100) * 0.25

	if motion_norm != Vector2.ZERO:
		animation_tree.set("parameters/MoveAnimations/blend_position", motion_norm)
		last_motion = motion_norm

		var base_interval = 600.0
		var running_interval = base_interval / 2.0
		var footstep_interval = running_interval if running else base_interval
		if last_footstep_time + footstep_interval < Time.get_ticks_msec():
			var sound_instance: Node = null
			if running:
				sound_instance = run_sound.instantiate()
			else:
				sound_instance = walk_sound.instantiate()
			get_parent().add_child(sound_instance)
			sound_instance.play()
			sound_instance.global_position = global_position

			last_footstep_time = Time.get_ticks_msec()
	elif last_motion != Vector2.ZERO:
		var last_motion_half = last_motion / 3
		animation_tree.set("parameters/MoveAnimations/blend_position", last_motion_half)

	move_and_slide()
	motion = Vector2.ZERO


func _on_sanity_timer_timeout():
	if PlayerFlags.sanity < 60:
		PlayerFlags.sanity += 1

	if PlayerFlags.sanity < 0:
		PlayerFlags.sanity = 0
	if PlayerFlags.sanity > 100:
		PlayerFlags.sanity = 100

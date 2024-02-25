extends CharacterBody2D
class_name EnemyEntity

@export var vision_area: Area2D = null

@export var animation_player: AnimationPlayer = null
@export var death_scene: PackedScene = null

@export var stingers: Array[AudioStream] = []
@export var stinger_player: AudioStreamPlayer = null

var patrol_nodes: Array[Node2D] = []

@export var blackboard: Blackboard = null

@export var acceleration = 3.45
@export var friction = 0.975

signal on_touch_player

var on_screen = false
var on_screen_times = 0
var time_offscreen = 0.0
var time_touching_player = 0.0
var touched_player = false

static var instance = null


func _ready():
	if instance == null:
		instance = self
	else:
		push_error("There are multiple instances of EnemyEntity in the scene")
		queue_free()
		return


func _process(delta):
	if on_screen:
		PlayerFlags.sanity -= delta * 10
		PlayerFlags.sanity = clamp(PlayerFlags.sanity, 0, 100)

	if not on_screen and on_screen_times > 0:
		time_offscreen += delta
		if time_offscreen > 10.0:
			on_screen_times = 0
			time_offscreen = 0.0
			animation_player.play("end_music")


@onready var desired_position = global_position

var last_player_positions: Array[Vector2] = []


func _physics_process(delta):
	var desired_rotation = blackboard.get_value("desired_rotation")
	var can_see_player = blackboard.get_value("can_see_player", false)
	var has_hearing_bodies = blackboard.get_value("hearing_bodies").size() > 0

	# Set vision area rotation to direction of physics velocity
	if desired_rotation != null:
		desired_rotation = wrapf(desired_rotation, -PI, PI)
		if velocity.length() > 30 and not can_see_player and not has_hearing_bodies:
			vision_area.rotation = lerp(
				vision_area.rotation, velocity.angle() * 0.9 + desired_rotation * 0.1, 2 * delta
			)
			blackboard.set_value("desired_rotation", vision_area.rotation)
		else:
			# print(desired_rotation)
			vision_area.rotation = lerp(vision_area.rotation, desired_rotation, 2 * delta)
	else:
		vision_area.rotation = lerp(vision_area.rotation, -velocity.angle(), 2 * delta)

	if can_see_player:
		last_player_positions.append(Player.instance.global_position)

		# Calculated average position of player by calculating the average vector of the last 5 positions
		# Then adding the average to the last one to predict the next position
		if last_player_positions.size() > 5:
			last_player_positions.pop_at(0)

		var expected_player_position = Vector2()

		if last_player_positions.size() >= 2:
			for i in range(0, last_player_positions.size() - 1):
				var a = last_player_positions[i]
				var b = last_player_positions[i + 1]
				var dir = b - a
				expected_player_position += dir

			expected_player_position /= last_player_positions.size() - 1

			expected_player_position += last_player_positions[last_player_positions.size() - 1]
		else:
			expected_player_position = Player.instance.global_position

		blackboard.set_value("last_player_position", expected_player_position)

	var desired_position_direction = global_position.direction_to(desired_position)

	velocity += desired_position_direction * acceleration
	velocity *= friction
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	# 1 in 5 chance of playing a stinger
	if randi() % 5 == 0 and stingers.size() > 0:
		stinger_player.stream = stingers[randi() % stingers.size()]
		await get_tree().create_timer(0.5).timeout
		stinger_player.play()

	# on_screen = true
	# on_screen_times += 1

	# if animation_player and animation_player.current_animation == "":
	# 	animation_player.play("start_music")


func _on_vision_body_entered(_body: Node2D):
	blackboard.set_value("can_see_player", true)


func _on_vision_body_exited(_body: Node2D):
	blackboard.set_value("can_see_player", false)


func _on_hearing_area_exited(area):
	var footstep_noise = area.get_parent() as FootstepNoise
	blackboard.get_value("hearing_bodies").erase(footstep_noise)


func _on_hearing_area_entered(area):
	var footstep_noise = area.get_parent() as FootstepNoise
	blackboard.get_value("hearing_bodies").append(footstep_noise)

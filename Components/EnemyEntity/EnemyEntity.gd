extends CharacterBody2D
class_name EnemyEntity


@export var animation_player: AnimationPlayer = null
@export var death_scene: PackedScene = null
const SPEED = 25 * 100.0


signal on_touch_player

var on_screen = false
var on_screen_times  = 0
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

func _physics_process(delta):
	if Player.instance :
		var player_dist = global_position.distance_to(Player.instance.global_position + Vector2(0, -20))
		var speed = SPEED;
		if player_dist < 40:
			time_touching_player += delta
			if time_touching_player > 1.0 and not touched_player:
				touched_player = true
				on_touch_player.emit()
				# Change game to death screen
				if GameRoot.instance:
					for child in GameRoot.instance.get_children():
						child.queue_free()
					GameRoot.instance.add_scene(death_scene)
				else:
					# Gameroot is not set we are probably in debug
					get_tree().change_scene_to_packed(death_scene)

			# Lerp snap
			var desired =  Player.instance.global_position + Vector2(0, -20)
			global_position = global_position.lerp(desired, 0.1)
			return;
		else:
			time_touching_player = 0.0
		var player_pos = Player.instance.global_position
		# Adjust to a bit above the player for y position
		player_pos.y -= 10
		var direction = (player_pos - global_position).normalized()
		velocity = direction * speed * delta
		
		move_and_slide()
	else:
		velocity = Vector2()
		move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false

	
func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true
	on_screen_times += 1

	if animation_player and animation_player.current_animation == "":
		animation_player.play("start_music")

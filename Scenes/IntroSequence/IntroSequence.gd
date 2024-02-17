extends Node2D

@export var animation_player: AnimationPlayer
@export var audio_player: AudioStreamPlayer
@export var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# If ui_accept is pressed, play the animation 2x
	if Input.is_action_pressed("ui_accept"):
		animation_player.speed_scale = 2
		audio_player.pitch_scale = 2
	else:
		animation_player.speed_scale = 1
		audio_player.pitch_scale = 1

func goto_next_scene():
	if GameRoot.instance:
		await UIAnimationPlayer.instance.fade_in()
		GameRoot.instance.add_scene(next_scene)
		queue_free()
		await UIAnimationPlayer.instance.fade_out()

	else:
		push_warning("GameRoot instance not found, replacing root scene")
		get_tree().change_scene_to_packed(next_scene)
		

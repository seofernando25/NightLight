extends Node2D

var playerPrefab = preload("res://Components/Player/player.tscn")

@onready var animation_player: AnimationPlayer = %AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var player = playerPrefab.instantiate() 
	add_child(player)
	
	player.global_position = %default_player_start.global_position
	
	# Toggle back
	if PlayerFlags.get_scene_variable("house", "first_entered") != true:
		PlayerFlags.set_scene_variable("house", "first_entered", true)
		if PlayerSprite.instance:
			PlayerSprite.instance.player_controlled = false
			PlayerSprite.instance.face_left()
		# Player alarm sound
		animation_player.play("waking_up")
		await animation_player.animation_finished
		
		if PlayerSprite.instance:
			PlayerSprite.instance.player_controlled = true
	else:
		var saved_position = PlayerFlags.get_saved_position()
		if saved_position:
			print("Saved position found")
			player.global_position = saved_position
		else:
			player.global_position = %default_player_start.global_position

func invoke_dialog(dialog: Dialog):
	PlayerFlags.dialog_start.emit(dialog)

func set_in_cutscene(value: bool):
	PlayerFlags.in_cutscene = value
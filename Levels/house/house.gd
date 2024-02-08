extends Node2D

var playerPrefab = preload("res://Components/Player/player.tscn")
var cameraPrefab = preload("res://Components/Camera/PixelCamera/PixelCamera.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var camera = cameraPrefab.instantiate()
	var player = playerPrefab.instantiate() 
	camera.follow = player
	add_child(camera)
	add_child(player)
	
	player.global_position = %default_player_start.global_position
	
	
	if PlayerFlags.get_scene_variable("house", "first_entered") == null:
		PlayerFlags.set_scene_variable("house", "first_entered", true)
		PlayerMovement.controller_enabled = false
		if PlayerSprite.instance:
			print("PlayerSprite exists")
			PlayerSprite.instance.player_controlled = false
			PlayerSprite.instance.face_left()
		# Player alarm sound
		var alarmSound = preload("res://Audio/Misc/alarm_clock.mp3")
		var audioStream = AudioStreamPlayer.new()
		add_child(audioStream)
		audioStream.stream = alarmSound
		audioStream.play()
		await  audioStream.finished
		audioStream.queue_free()
		if PlayerSprite.instance:
			PlayerSprite.instance.player_controlled = true
		
		
		PlayerMovement.controller_enabled = true
		
		

extends EventCommand

@export var audio_player: AudioStreamPlayer = null

func Execute():
	if audio_player == null:
		push_error("Audio player is not set")
		return

	audio_player.play()	
	await audio_player.finished

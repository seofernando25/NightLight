extends EventCommand

@export var animation_player: AnimationPlayer = null
@export var animation_name: String = ""

func Execute():
	if animation_player == null or animation_name == "":
		push_error("AnimationPlayer or AnimationName is not set.")
		return
	
	print("Playing animation: " + animation_name)

	animation_player.play(animation_name)
	await animation_player.animation_finished
	print("Animation finished: " + animation_name)
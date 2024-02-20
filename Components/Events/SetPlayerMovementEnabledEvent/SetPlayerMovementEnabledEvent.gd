extends EventCommand

@export var enabled: bool = true

func Execute():
	if Player.instance == null:
		push_error("Player not found")
		return

	Player.instance.player_movement_enabled = enabled

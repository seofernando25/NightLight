extends Node2D

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerFlags.on_set_scene.connect(_on_set_scene)
	# Check PlayerFlags.game_data["currentScene"] to determine which scene to load
	current_scene = load(PlayerFlags.game_data.current_scene).instantiate()
	add_child(current_scene)

func _on_set_scene(scene_resource: String):
	var instance = load(scene_resource).instantiate()
	current_scene.queue_free()
	current_scene = instance
	add_child(current_scene)


func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		# DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)   
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if event.is_action_pressed("debug_save"):
		print("Debug save")
		PlayerFlags.write_save()

		# Print inventory
		print("Inventory:")
		for item in PlayerFlags.game_data.inventory:
			print(item.name)

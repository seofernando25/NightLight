extends Node2D
class_name GameRoot

static var instance = null

  

func _ready():
	if instance != null:
		push_error("GameRoot: Multiple instances detected")
		return
	instance = self

func add_scene(scene: PackedScene):
	var node = scene.instantiate()
	add_child(node)
	return node

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
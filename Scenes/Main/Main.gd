extends Node2D
class_name GameRoot

static var instance = null
var current_scene = null

func _ready():
	if instance != null:
		push_error("GameRoot: Multiple instances detected")
		return
	instance = self


	var menu_scene = preload("res://Scenes/Menu/menu.tscn")
	current_scene = menu_scene.instantiate()
	add_child(current_scene)

func change_scene(scene: PackedScene):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scene.instantiate()
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


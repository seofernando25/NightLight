extends Node2D

@export var introScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		# DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)   
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		

func change_scene():
	get_tree().change_scene_to_packed(introScene)


func _on_cutscene_trigger_body_entered(_body:Node2D):
	call_deferred("change_scene")

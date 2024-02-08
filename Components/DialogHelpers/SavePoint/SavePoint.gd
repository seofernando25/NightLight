extends Area2D

@export var dialog: Dialog

signal on_interact
var playerIn = false

func _on_body_entered(_body:Node2D):
	playerIn = true

func _on_body_exited(_body:Node2D):
	playerIn = false

var inDialog = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept") and playerIn and not inDialog:
			print("Save game prompt")
			PlayerFlags.write_save()
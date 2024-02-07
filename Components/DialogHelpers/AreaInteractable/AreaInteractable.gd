extends Area2D

@export var dialog: Dialog

signal on_interact_start
signal on_interact_end

var playerIn = false

func _on_body_entered(_body:Node2D):
	playerIn = true

func _on_body_exited(_body:Node2D):
	playerIn = false

var inDialog = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept") and playerIn and not inDialog:
			on_interact_start.emit()
			inDialog = true
			if dialog:
				PlayerFlags.dialog_start.emit(dialog)
				await PlayerFlags.dialog_end
			inDialog = false
			playerIn = false
			on_interact_end.emit()
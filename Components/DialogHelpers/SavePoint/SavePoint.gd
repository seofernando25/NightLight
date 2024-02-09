extends Area2D

@export var dialog: Dialog

signal on_interact
var playerIn = false

func _on_body_entered(_body:Node2D):
	playerIn = true

func _on_body_exited(_body:Node2D):
	playerIn = false


func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept") and playerIn and not DialogBox.in_dialog and not PlayerFlags.in_cutscene:
			PlayerFlags.dialog_start.emit(dialog)
			await PlayerFlags.dialog_end
			PlayerFlags.write_save()

			# Play save sound
			const saveSound = preload("res://Audio/Misc/save.ogg")
			var audio_player = AudioStreamPlayer.new()
			add_child(audio_player)
			audio_player.stream = saveSound
			audio_player.play()
			await audio_player.finished	
			audio_player.queue_free()


			
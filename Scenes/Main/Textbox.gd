extends ColorRect

@onready var typewriter: Typewriter = %Text

func _ready():
	PlayerFlags.dialog_start.connect(_on_dialog_start)

signal req_end_current_dialog
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if is_dialoging:
			typewriter.set_char_delay(typewriter.char_delay * 0.5)
		req_end_current_dialog.emit()	

var is_dialoging = false

func _on_dialog_start(dialog: Dialog):
	is_dialoging = true
	visible = true
	PlayerFlags.movement_enabled = false
	typewriter.text = ""
	typewriter.to_type = dialog.text
	typewriter.stop_typing()
	typewriter.start_typing()
	await typewriter.typing_finished
	await req_end_current_dialog
	PlayerFlags.movement_enabled = true
	typewriter.set_char_delay(0.05)
	visible = false
	is_dialoging = false


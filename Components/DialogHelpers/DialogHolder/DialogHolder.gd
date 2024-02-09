extends Node

@export var dialog: Dialog = null

func trigger_dialog():
	if dialog == null:
		push_error("Dialog is not set")
		return

	PlayerFlags.dialog_start.emit(dialog)
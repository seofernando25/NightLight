extends EventCommand

@export var dialog: Dialog = null

func Execute():
	print("Triggering dialog")
	if dialog == null:
		push_error("Dialog is not set")
		return

	PlayerFlags.dialog_start.emit(dialog)
	await PlayerFlags.dialog_end
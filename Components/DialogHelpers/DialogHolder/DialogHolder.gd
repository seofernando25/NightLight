extends Node

@export var dialog: Dialog = null

func trigger_dialog():
	print("Triggering dialog")
	if dialog == null:
		push_error("Dialog is not set")
		return

	PlayerFlags.dialog_start.emit(dialog)
	await PlayerFlags.dialog_end

	# Check children for dialog
	for child_node in get_children():
		child_node.trigger_dialog()
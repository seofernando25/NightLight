extends Node

@export var choice_dialog: ChoiceDialog = null

func trigger_dialog():
	if choice_dialog == null:
		push_error("Choice Dialog is not set")
		return

	PlayerFlags.dialog_start.emit(choice_dialog)
	var option_selected = await PlayerFlags.dialog_end

	print("Option selected: " + str(option_selected))

	# Get optionselected-th children
	var child = get_child(option_selected)
	if child == null:
		push_error("Option " + str(option_selected) + " not found")
		return
	
	child.trigger_dialog()
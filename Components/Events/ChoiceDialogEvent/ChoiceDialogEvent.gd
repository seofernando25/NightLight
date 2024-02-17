extends EventCommand

@export var choice_dialog: ChoiceDialog = null

func _execute():
	await Execute()

	# Get optionselected-th children
	var option_selected = await PlayerFlags.dialog_end
	var child = get_child(option_selected)
	if child == null:
		push_error("Option " + str(option_selected) + " not found")
		return
	
	await child._execute()

func Execute():
	if choice_dialog == null:
		push_error("Choice Dialog is not set")
		return

	PlayerFlags.dialog_start.emit(choice_dialog)


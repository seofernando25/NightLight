extends Node
class_name EventCommand

func _execute():
	await Execute()

	# Get all children that are EventCommand and execute them
	for child in get_children():
		if child is EventCommand:
			await child._execute()

func Execute():
	pass
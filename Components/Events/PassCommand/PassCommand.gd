extends Node
class_name EventCommand # Also known as "pass" command as it does nothing and acts as default behavior

func _execute():
	await Execute()

	# Get all children that are EventCommand and execute them
	for child in get_children():
		if child is EventCommand:
			child._execute()

func Execute():
	pass

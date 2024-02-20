@tool
extends EventCommand


@export var variable_name = "unset_variable"
@export var to_compare = 0

func _execute():
	await Execute()

	var variable_value = PlayerFlags.game_data.get_variable(variable_name)
	if variable_value == null:
		push_warning("Variable " + variable_name + " does not exist. Falling back to 0.")
		variable_value = 0
	
	print("Comparing " + str(variable_value) + " (" + variable_name + ") to " + str(to_compare))
	if variable_value < to_compare:
		# Get the LT child
		var LT = get_node_or_null("./LT")
		if LT != null:
			await LT._execute()
	elif variable_value == to_compare:
		# Get the EQ child
		var EQ = get_node_or_null("./EQ")
		if EQ != null:
			await EQ._execute()
	elif variable_value > to_compare:
		# Get the GT child
		var GT = get_node_or_null("./GT")
		if GT != null:
			await GT._execute()

	if variable_value != to_compare:
		# Get the NEQ child
		var NEQ = get_node_or_null("./NEQ")
		if NEQ != null:
			await NEQ._execute()


func _get_configuration_warnings():
	# Children must contain either a node called "LT", "EQ", "GT", or "NEQ"
	var has_valid_children = false
	for child in get_children():
		if child.name in ["LT", "EQ", "GT", "NEQ"]:
			has_valid_children = true
			break
	
	if not has_valid_children:
		return ["Missing branch nodes (LT, EQ, GT, NEQ)"]

	return []

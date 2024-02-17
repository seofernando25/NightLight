extends EventCommand

@export var variable_name = "unset_variable"

enum VariableChangeType { Set, Add }
@export var change_type = VariableChangeType.Set
@export var change_amount = 1

func Execute():
	print("Changing variable")

	if variable_name == "unset_variable":
		push_error("Variable name is not set")
		return

	variable_name = variable_name.strip_edges()
	if variable_name == "":
		push_error("Variable name is empty")
		return

	if change_type == VariableChangeType.Set:
		PlayerFlags.game_data.set_variable(variable_name, change_amount)
		return
	
	var current_value = PlayerFlags.game_data.get_variable(variable_name)
	if current_value == null:
		current_value = 0

	if change_type == VariableChangeType.Add:
		PlayerFlags.game_data.set_variable(variable_name, current_value + change_amount)
		return
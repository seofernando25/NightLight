extends Resource
class_name  GameSave

signal variable_changed(key: String, value: Variant)

# Miscellanous variables that can be used to store game state
@export var variables = {}

# List of Colletable items that the player has collected
@export var collected_items: Dictionary = {}

# List of Colletable items that the player currently possesses
@export var inventory: Array[Colletable] = []
@export var player_position: Vector2 = Vector2(0, 0)
@export var current_scene: String = "res://Scenes/IntroSequence/IntroSequence.tscn"

func _init(p_variables: Dictionary = {}, 
			p_collected_items: Dictionary = {},
			p_inventory: Array[Colletable] = [], 
			p_player_position: Vector2 = Vector2(0, 0)):
	variables = p_variables
	collected_items = p_collected_items
	inventory = p_inventory
	player_position = p_player_position


func set_variable(p_key: String, p_value: Variant):
	print("Setting variable: " + p_key + " to " + str(p_value))
	variables[p_key] = p_value
	variable_changed.emit(p_key, p_value)

func get_variable(p_key: String) -> Variant:
	if not variables.has(p_key):
		return null
	return variables[p_key]
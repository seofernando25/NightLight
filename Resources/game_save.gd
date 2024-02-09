extends Resource
class_name  GameSave

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


func set_variable(p_context: String, p_key: String, p_value: Variant):
	if not variables.has(p_context):
		variables[p_context] = {}
	variables[p_context][p_key] = p_value

func get_variable(p_context: String, p_key: String) -> Variant:
	if not variables.has(p_context):
		return null
	if not variables[p_context].has(p_key):
		return null
	return variables[p_context][p_key]
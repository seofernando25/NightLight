extends Node

signal dialog_start(dialog: Dialog)
signal dialog_end(option: int)

signal on_set_scene(scene_resource: String)

const SAVE_GAME_PATH = "user://save.json"
var game_data = {}

func set_scene_variable(scene: String = "", variable: String = "", value = null):
	if not game_data.has(scene):
		game_data[scene] = {}
	
	game_data[scene][variable] = value

func get_scene_variable(scene: String = "", variable: String = "") :
	if not game_data.has(scene):
		return null
	
	if not game_data[scene].has(variable):
		return null
	
	return game_data[scene][variable]

func set_scene(scene: String):
	game_data["scene"] = scene
	on_set_scene.emit(scene)

func get_scene() -> String:
	return game_data["scene"]

func read_save():
	print("Reading save file")
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		print("No save file found")
		# Create an empty save file
		var save_file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
		save_file.store_string("{}")
		save_file.close()
		return
	
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	var json_str = file.get_as_text()

	var save_game_maybe = JSON.parse_string(json_str)
	game_data = save_game_maybe if save_game_maybe != null else {}

func write_save():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.seek(0)
	file.store_string(JSON.stringify(game_data))
	file.close()

func _ready():
	read_save()
	print("Game data: ", game_data)
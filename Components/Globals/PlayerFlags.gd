extends Node

signal dialog_start(dialog: Dialog)
signal dialog_end(option: int)

signal enable_movement(enable: bool)

const SAVE_GAME_PATH = "user://save.tres"
var game_data: GameSave = GameSave.new()

var sanity = 100.0
var player_in_light = 0
var in_cutscene = false

func save_position():
	if Player.instance == null:
		return
	var position = Player.instance.global_position
	set_scene_variable("player", "position_x", position.x)
	set_scene_variable("player", "position_y", position.y)

func get_saved_position() -> Vector2:
	var x = get_scene_variable("player", "position_x")
	if x == null:
		x = 0
	var y = get_scene_variable("player", "position_y")
	if y == null:
		y = 0
	return Vector2(x, y)

func set_enable_movement(enable: bool):
	set_scene_variable("player", "enable_movement", enable)
	emit_signal("set_enable_movement", enable)


func set_scene_variable(scene: String = "", variable: String = "", value = null):
	game_data.set_variable(scene, variable, value)

func get_scene_variable(scene: String = "", variable: String = "") :
	return game_data.get_variable(scene, variable)

func read_save():
	print("Reading save file")
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		print("No save file found")
		return

	var save_data_maybe = ResourceLoader.load(SAVE_GAME_PATH)
	if save_data_maybe == null:
		print("Failed to load save file")
		return
	game_data = ResourceLoader.load(SAVE_GAME_PATH)

func write_save():
	game_data.current_scene = GameRoot.instance.current_scene.resource_path
	PlayerFlags.save_position()
	ResourceSaver.save(game_data, SAVE_GAME_PATH)

func _ready():
	read_save()
	print("Game data: ", game_data)

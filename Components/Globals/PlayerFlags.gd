extends Node

signal dialog_start(dialog: Dialog)
signal dialog_end(option: int)

signal enable_movement(enable: bool)
signal on_set_scene(scene_resource: String)

const SAVE_GAME_PATH = "user://save.tres"
var game_data: GameSave = GameSave.new()

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

func set_scene(scene: String):
	game_data.current_scene = scene
	on_set_scene.emit(scene)


func read_save():
	print("Reading save file")
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		print("No save file found")
		return

	game_data = ResourceLoader.load(SAVE_GAME_PATH)

func write_save():
	# Save player dat
	PlayerFlags.save_position()
	ResourceSaver.save(game_data, SAVE_GAME_PATH)

func _ready():
	read_save()
	print("Game data: ", game_data)

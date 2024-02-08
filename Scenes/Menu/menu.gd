extends CanvasLayer

@export var new_journey_scene: PackedScene
@export var animation_player: AnimationPlayer

@onready var newGameButton: Button = %NewGameButton
@onready var continueButton: Button = %ContinueButton
@onready var galleryButton: Button = %GalleryButton

func new_journey():
	get_tree().change_scene_to_packed(new_journey_scene)
	
func _on_new_journey_pressed():
	animation_player.play("new_journey")


# Save and load

const SAVE_GAME_PATH = "user://save_game.json"
var gameSaves = []


func read_save():
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		print("No save file found")
		# Create an empty save file
		var save_file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
		save_file.store_string("[]")
		save_file.close()
		return
	
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	var json_str = file.get_as_text()

	var save_game_maybe = JSON.parse_string(json_str)
	if not save_game_maybe is Array:
		return
	
	print("Number of saves: ", save_game_maybe.size())

func _ready():
	# Test writing to file
	read_save()
	if gameSaves.size() == 0:
		continueButton.hide()
	else:
		print("Game saves: ", gameSaves)
		# Show continue button
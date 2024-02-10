extends CanvasLayer

var gameplayManagerScene: PackedScene = preload("res://Scenes/GameplayManager/GameplayManager.tscn")

@export var animation_player: AnimationPlayer

@onready var newGameButton: Button = %NewGameButton
@onready var continueButton: Button = %ContinueButton
@onready var galleryButton: Button = %GalleryButton

func new_journey():
	GameRoot.instance.change_scene(gameplayManagerScene)
	
func _on_new_journey_pressed():
	# TODO: Add a confirmation dialog to avoid accidental new game
	PlayerFlags.game_data = GameSave.new()
	PlayerFlags.game_data.current_scene = "res://Scenes/IntroSequence/IntroSequence.tscn"
	animation_player.play("new_journey")


func _on_continue_button_pressed():
	animation_player.play("new_journey")

# Save and load


func _ready():
	# Test writing to file
	# If gameSave is empty dict, hide continue button
	if PlayerFlags.game_data.variables == {}:
		print("No save data")
		continueButton.hide()



extends CanvasLayer


@export var initial_scene: PackedScene = null

@export var animation_player: AnimationPlayer

@onready var newGameButton: Button = %NewGameButton
@onready var continueButton: Button = %ContinueButton
@onready var galleryButton: Button = %GalleryButton

func continue_journey():
	var scene_instance = load(PlayerFlags.game_data.current_scene)
	GameRoot.instance.change_scene(scene_instance)
	GameUI.instance.show()
	

func new_journey():
	GameRoot.instance.change_scene(initial_scene)
		

func _on_new_journey_pressed():
	PlayerFlags.game_data = GameSave.new()
	animation_player.play("continue_journey")


func _on_continue_button_pressed():
	animation_player.play("new_journey")

# Save and load


func _ready():
	# If gameSave is empty dict, hide continue button
	if PlayerFlags.game_data.variables == {}:
		print("No save data")
		continueButton.hide()



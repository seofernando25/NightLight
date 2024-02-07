extends CanvasLayer

@export var newJourneyScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func new_journey():
	get_tree().change_scene_to_packed(newJourneyScene)
	
func _on_quit_pressed():
	get_tree().quit()


func _on_new_journey_pressed():
	call_deferred("new_journey")

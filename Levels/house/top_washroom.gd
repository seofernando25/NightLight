extends Node2D

@export var noPancakesDialog: Dialog = null
@export var hasPancakesDialog: Dialog = null
@export var alreadyBrushedDialog: Dialog = null

func _on_sink_interact():
	print("Interact")


func player_has_pancakes():
	for item in PlayerFlags.game_data.inventory:
		if item.name.to_lower() == "pancakes":
			return true
	return false

func _on_sinkteractable_on_interact_start():
	print("Interact start")
	if PlayerFlags.game_data.get_variable("house", "brushed_teeth") == true:
		PlayerFlags.dialog_start.emit(alreadyBrushedDialog)
	elif player_has_pancakes():
		PlayerFlags.dialog_start.emit(hasPancakesDialog)
		PlayerFlags.game_data.set_variable("house", "brushed_teeth", true)
	else:
		PlayerFlags.dialog_start.emit(noPancakesDialog)

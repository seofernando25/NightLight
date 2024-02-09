extends Node
class_name  MapCollectable

signal on_interact_start
signal on_interact_end

@export var unique_id: String = "default"
@export var collectable_info: Colletable

func _ready():
	if collectable_info == null:
		push_error("Collectable info is null")
	if PlayerFlags.game_data.collected_items.has(unique_id):
		queue_free()

var playerIn = false
var isCollecting = false

func _on_body_entered(_body:Node2D):
	print("Player entered")
	playerIn = true

func _on_body_exited(_body:Node2D):
	playerIn = false

func _unhandled_input(event):
	if playerIn and not isCollecting and event.is_action_pressed("ui_accept"):
		on_interact_start.emit()
		isCollecting = true
		print("Player collected " + collectable_info.name)
		PlayerFlags.game_data.collected_items[unique_id] = true
		PlayerFlags.game_data.inventory.append(collectable_info)

		# collectable_info.collect_dialog
		if collectable_info.collect_dialog:
			PlayerFlags.dialog_start.emit(collectable_info.collect_dialog)
			await PlayerFlags.dialog_end

		on_interact_end.emit()
		queue_free()

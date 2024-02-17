extends Area2D
class_name  AreaEventTrigger

enum TriggerType {
	ActionButton,
	PlayerEnter
}
var player_in = false
@export var trigger_type = TriggerType.ActionButton
@export var trigger_one_shot = false

var entered_once = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and not DialogBox.in_dialog:
		if player_in and trigger_type == TriggerType.ActionButton and not (trigger_one_shot and entered_once):
			trigger()
			if trigger_one_shot:
				entered_once = true


func trigger():
	print("Triggered")
	# Check children that are of EventCommand type
	for child in get_children():
		if child is EventCommand:
			child._execute()




func _on_player_exited(_body:Node2D):
	print("Player exited")
	player_in = false

func _on_player_entered(_body:Player):
	# Get the centroid of all children colliders
	var centroid = Vector2()
	var count = 0
	for child in get_children():
		if child is CollisionShape2D:
			centroid += child.global_position
			count += 1
	centroid /= count
	
	var player_diff = _body.global_position - centroid
	print("Player diff: ", player_diff)


	player_in = true
	if trigger_type == TriggerType.PlayerEnter and not (trigger_one_shot and entered_once):
		trigger()
		if trigger_one_shot:
			entered_once = true

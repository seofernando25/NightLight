extends Area2D
class_name  EventTrigger

enum TriggerType {
	ActionButton,
	PlayerEnter
}
var player_in = false
@export var trigger_type = TriggerType.ActionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if player_in and trigger_type == TriggerType.ActionButton:
			trigger()


func trigger():
	# Check children that are of EventCommand type
	for child in get_children():
		if child is EventCommand:
			child._execute()




func _on_player_exited(_body:Node2D):
	player_in = false

func _on_player_entered(_body:Node2D):
	player_in = true
	if trigger_type == TriggerType.PlayerEnter:
		trigger()

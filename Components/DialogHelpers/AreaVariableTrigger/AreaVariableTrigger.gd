extends Area2D

signal hit


enum TriggerTimes { Once, Always }
enum TriggerWhen { Set, Unset }

@export var trigger_id = ""
@export var variable = ""
@export var triggerTimes = TriggerTimes.Once
@export var triggerWhen = TriggerWhen.Set

@onready var trigger_id_str = variable + "_trigger_" + trigger_id

func _on_body_entered(_body:Node2D):
	# Persistent trigger
	if triggerTimes == TriggerTimes.Once and PlayerFlags.game_data.get_variable(trigger_id_str):
		return

	# Wants set but not set
	if triggerWhen == TriggerWhen.Set and not PlayerFlags.game_data.get_variable(variable):
		return
	# Wants unset but set
	if triggerWhen == TriggerWhen.Unset and PlayerFlags.game_data.get_variable(variable):
		return

	hit.emit()
		
	if triggerTimes == TriggerTimes.Once:
		PlayerFlags.game_data.set_variable(trigger_id_str, true)
		queue_free()

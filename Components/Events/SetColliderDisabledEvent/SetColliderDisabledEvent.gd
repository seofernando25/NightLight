extends EventCommand

@export var node: CollisionShape2D = null
@export var disabled: bool = false


func _set_disabled(value: bool) -> void:
	node.disabled = value

func Execute():
	if node == null:
		push_error("Node is not set")
		return

	call_deferred("_set_disabled", disabled)
	
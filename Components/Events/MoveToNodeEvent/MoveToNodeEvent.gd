extends EventCommand

@export var node: Node2D = null
@export var destination: Node2D = null

func Execute():
	if node == null:
		push_error("Node is not set")
		return
	if destination == null:
		push_error("Destination is not set")
		return

	node.global_position = destination.global_position

	
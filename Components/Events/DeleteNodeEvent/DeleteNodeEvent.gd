extends EventCommand

@export var node: Node2D = null

func Execute():
	if node == null:
		push_error("Node is not set")
		return

	node.call_deferred("queue_free")

	
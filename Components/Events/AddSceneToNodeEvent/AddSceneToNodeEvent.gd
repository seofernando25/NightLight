extends EventCommand

@export var scene: PackedScene = null
@export var node_to_add: Node2D = null

func Execute():
	if scene == null or node_to_add == null:
		push_error("AddSceneToNodeEvent: Scene or node to add is null.")
		return
	
	print("AddSceneToNodeEvent: Adding scene to node.")
	node_to_add.add_child(scene.instantiate())
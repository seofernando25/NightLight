extends EventCommand

@export var scene: PackedScene = null

func Execute():
	if scene == null:
		push_error("AddSceneEvent: No scene has been set.")
		return
	
	if GameRoot.instance != null:
		GameRoot.instance.add_scene(scene)
	else:
		push_error("AddSceneEvent: No GameRoot instance found.")
		var instance = scene.instantiate()
		get_tree().root.add_child(instance)
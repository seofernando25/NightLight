extends EventCommand

@export var scene: PackedScene = null

func Execute():
	if scene == null:
		push_error("AddSceneEvent: No scene has been set.")
		return
	
	GameRoot.instance.add_scene(scene)

extends Resource
class_name MapPart

@export var area_name: String = "???"
@export var scene: PackedScene = null

func _init(p_area_name = "", p_scene: PackedScene = null):
	area_name = p_area_name
	scene = p_scene

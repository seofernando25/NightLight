extends Resource
class_name Colletable

@export var name = "unnamed_item"
@export var icon: Texture2D = null
@export var important = false
@export var collect_dialog: Dialog = null

func _init(p_name: String = "", p_icon: ImageTexture = null) -> void:
	name = p_name
	icon = p_icon

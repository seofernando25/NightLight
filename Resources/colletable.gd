extends Resource
class_name Colletable

@export var name = "unnamed_item"
@export var description = ""
@export var icon: Texture2D = null
@export var important = false
@export var collect_dialog: Dialog = null

func _init(p_name: String = "", p_icon: ImageTexture = null, p_description: String = "", p_important: bool = false, p_collect_dialog: Dialog = null) -> void:
	name = p_name
	icon = p_icon
	description = p_description
	important = p_important
	collect_dialog = p_collect_dialog
	

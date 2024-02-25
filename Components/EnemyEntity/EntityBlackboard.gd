class_name EntityBlackboard extends Blackboard


func _ready() -> void:
	set_value("can_see_player", false)
	set_value("hearing_bodies", [])
	set_value("next_patrol_index", -1)
	set_value("desired_rotation", null)

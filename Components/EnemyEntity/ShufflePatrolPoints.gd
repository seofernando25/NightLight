extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var actor_char = actor as EnemyEntity
	var next_patrol_idx = blackboard.get_value("next_patrol_index")
	if next_patrol_idx > actor_char.patrol_nodes.size() - 1 or next_patrol_idx < 0:
		print("Shuffling patrol nodes")
		actor_char.patrol_nodes.shuffle()
		blackboard.set_value("next_patrol_index", 0)
		return SUCCESS

	return FAILURE

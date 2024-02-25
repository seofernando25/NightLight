extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var actor_char = actor as EnemyEntity
	var patrol_nodes = actor_char.patrol_nodes

	var patrol_index = blackboard.get_value("next_patrol_index")
	print("Patrol index: ", patrol_index)
	if not patrol_nodes or patrol_nodes.size() == 0:
		return FAILURE

	if patrol_index >= 0 and patrol_index < patrol_nodes.size():
		actor_char.desired_position = patrol_nodes[patrol_index].global_position
	else:
		return FAILURE

	var distance = actor_char.position.distance_to(actor_char.desired_position)
	if distance < 10:
		print("Arrived at patrol point")
		return SUCCESS
	else:
		return RUNNING

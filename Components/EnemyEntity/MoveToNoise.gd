extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	
	var last_position = blackboard.get_value("last_player_position")

	if not last_position:
		return FAILURE

	var actor_char = actor as EnemyEntity

	actor_char.desired_position = last_position

	var distance = actor_char.position.distance_to(last_position)
	if distance < 1:
		return SUCCESS
	else:
		return RUNNING
	

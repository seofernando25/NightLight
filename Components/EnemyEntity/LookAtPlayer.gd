extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	if not Player.instance:
		return FAILURE
	var actor_char = actor as EnemyEntity
	var player_position = Player.instance.global_position
	var offset = Vector2(0, 0)
	var player_direction = (player_position - actor_char.global_position + offset).normalized()
	player_direction = player_direction.normalized()
	blackboard.set_value("desired_rotation", player_direction.angle())

	return SUCCESS

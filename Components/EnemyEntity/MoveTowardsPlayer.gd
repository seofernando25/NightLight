extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	if not Player.instance:
		return FAILURE
	var actor_char = actor as EnemyEntity

	var can_see_player = blackboard.get_value("can_see_player")

	if not can_see_player:
		return FAILURE

	if Player.instance:
		var offset = Vector2(0, -50)
		actor_char.desired_position = Player.instance.global_position + offset

	var distance = actor_char.global_position.distance_to(Player.instance.global_position)
	if distance < 10:
		return SUCCESS

	return RUNNING

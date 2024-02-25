extends ActionLeaf


func tick(actor, _blackboard: Blackboard):
	if not Player.instance:
		return FAILURE
	var actor_char = actor as EnemyEntity
	actor_char.patrol_nodes.shuffle()

	return SUCCESS

extends Camera2D

var initial_pos = Vector2(0, 0)
@export var detection_distance = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if EnemyEntity.instance:
		# Convert monster_pos to local space (Goto 4.0)
		var inverse_transform = global_transform.affine_inverse()
		var monster_pos = inverse_transform * EnemyEntity.instance.global_position
		var monster_delta = monster_pos - inverse_transform * Player.instance.global_position
		var monster_dist = monster_delta.length()
		if monster_dist < detection_distance:
			var percent = 1 - (monster_dist / detection_distance)
			if percent > 0.7:
				percent = 0.7
			position = initial_pos.lerp(monster_pos, percent)
		else:
			position = initial_pos

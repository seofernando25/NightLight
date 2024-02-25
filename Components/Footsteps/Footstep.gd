extends Node2D
class_name FootstepNoise

signal on_delete

static var footstep_noises: Array[FootstepNoise] = []

@export var time_to_live: float = 10.0
@export var collision_shape: CollisionShape2D = null
@export var audio: AudioStreamPlayer = null


static func total_noise() -> float:
	var s = 0.0
	for f in footstep_noises:
		s += f.time_to_live
	return s


var killed = false


func shape_size():
	return time_to_live * 10.0


func _ready():
	footstep_noises.append(self)
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = shape_size()
	if FootstepNoise.total_noise() > 20:
		if EnemyEntity.instance:
			print("running")
			EnemyEntity.instance.blackboard.get_value("hearing_bodies").append(self)


# Note:
# enemy ai director will check the total noise of all footstep noises
# noise > 20 = is_running
# noise < 10 = is_walking


func _process(delta):
	time_to_live -= delta
	if time_to_live <= 0 and not killed:
		killed = true
		on_delete.emit()
		footstep_noises.erase(self)
		queue_free()
	else:
		collision_shape.shape.radius = shape_size()


func play(f = 0.0) -> void:
	if audio:
		audio.play(f)
		audio.pitch_scale = 0.8 + randf() * 0.4

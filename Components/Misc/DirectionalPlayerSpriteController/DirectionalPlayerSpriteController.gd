extends Node
class_name PlayerSprite

@export var animated_sprite: AnimatedSprite2D
@export var rigid_body: CharacterBody2D
var player_controlled: bool = true

static var instance: PlayerSprite

func _ready():
	instance = self

var flip_y = -1
var flip_x = 1
var last_side = 0

func is_moving(val):
	return abs(val) > 10

func face_left():
	animated_sprite.flip_h = false
	last_side = 0
	animated_sprite.play("walk_side")
	animated_sprite.speed_scale = 0
	print("face_left")


func face_right():
	animated_sprite.flip_h = true
	last_side = 1
	animated_sprite.play("walk_side")
	animated_sprite.speed_scale = 0


func face_up():
	animated_sprite.flip_h = false
	animated_sprite.flip_v = true
	last_side = 0
	animated_sprite.play("walk_up")
	animated_sprite.speed_scale = 0


func face_down():
	animated_sprite.flip_h = false
	animated_sprite.flip_v = false
	last_side = 0
	animated_sprite.play("walk_forward")
	animated_sprite.speed_scale = 0


func _process(_delta):
	if not player_controlled:
		return
	var running = Input.is_action_pressed("ui_accept")

	if running:
		animated_sprite.speed_scale = 2
	else:
		animated_sprite.speed_scale = 1

	if is_moving(rigid_body.velocity.y):
		last_side = 0
		if rigid_body.velocity.y < 0:
			animated_sprite.play("walk_up")
			flip_y = -1
		else:
			animated_sprite.play("walk_forward")
			flip_y = 1
		return
	if is_moving(rigid_body.velocity.x):
		last_side = 1
		if rigid_body.velocity.x > 0:
			animated_sprite.flip_h = true
			animated_sprite.play("walk_side")
			flip_x = 1
		else:
			animated_sprite.flip_h = false
			animated_sprite.play("walk_side")
			flip_x = -1
		return
	
	
	if rigid_body.velocity.x == 0 and rigid_body.velocity.y == 0:
		if last_side == 1:
			animated_sprite.play("walk_side")
			animated_sprite.flip_h = flip_x == 1
		else:
			if flip_y == 1:
				animated_sprite.play("walk_forward")
			else:
				animated_sprite.play("walk_up")
		animated_sprite.speed_scale = 0
			

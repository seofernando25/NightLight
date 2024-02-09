extends Node

@export var area_2d: Area2D
@export var animation_player: AnimationPlayer

@export var on_body_entered_animation: String = ""
@export var on_body_exited_animation: String = ""

func _ready():
	area_2d.connect("body_entered", trigger_body_entered_animation)
	area_2d.connect("body_exited", trigger_body_exited_animation)

func trigger_body_entered_animation(_body):
	if on_body_entered_animation != "":
		animation_player.play(on_body_entered_animation)

func trigger_body_exited_animation(_body):
	if on_body_exited_animation != "":
		animation_player.play(on_body_exited_animation)
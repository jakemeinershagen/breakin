extends Node2D

var brick_set_scene = preload("res://Scenes/brick_set.tscn")
var brick_set_inst

func _ready():
	_add_new_brick_set()


func _on_score_point():
	if GameState.score % 128 == 0:
		brick_set_inst.free()
		_add_new_brick_set()


func _add_new_brick_set():
	brick_set_inst = brick_set_scene.instantiate()
	brick_set_inst.global_position = Vector2(300, 125)
	add_child(brick_set_inst)

extends Node2D

var brick_set_scene = preload("res://Scenes/brick_set.tscn")
var brick_set_inst
@export var brick_set_debug = false

func _ready():
	_add_new_brick_set()


func _on_score_point():
	if GameState.check_new_brick_set():
		brick_set_inst.free()
		_add_new_brick_set()


func _add_new_brick_set():
	brick_set_inst = brick_set_scene.instantiate()
	brick_set_inst.global_position = Vector2(300, 125)
	_check_brick_set_debug()
	add_child(brick_set_inst)


func _check_brick_set_debug():
	if brick_set_debug:
		brick_set_inst.find_child("Row8").free()
		brick_set_inst.find_child("Row7").free()
		brick_set_inst.find_child("Row6").free()
		brick_set_inst.find_child("Row5").free()
		brick_set_inst.find_child("Row4").free()
		brick_set_inst.find_child("Row3").free()
		brick_set_inst.find_child("Row2").free()
		
		GameState.brick_set_number = 16

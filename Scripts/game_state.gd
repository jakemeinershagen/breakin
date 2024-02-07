extends Node

@onready var lives = 3
@onready var score = 0

var brick_set_number = 128


func add_point():
	score += 1


func remove_life():
	lives -= 1


func check_new_brick_set():
	if score % brick_set_number == 0:
		return true
	else:
		return false

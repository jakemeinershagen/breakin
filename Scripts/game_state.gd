extends Node

@onready var lives = 3
@onready var score = 0

var brick_set_number = 128
var game_running = true


func add_point():
	score += 1


func remove_life():
	lives -= 1
	_check_lose_condition()


func check_new_brick_set():
	if score % brick_set_number == 0:
		return true
	else:
		return false


func _check_lose_condition():
	if lives == 0:
		game_running = false
		get_node("/root/World/UI/LostLabel").visible = true
		print("lost")

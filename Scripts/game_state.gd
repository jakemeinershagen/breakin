extends Node

@onready var lives = 3
@onready var score = 0

func add_point():
	score += 1

func remove_life():
	lives -= 1

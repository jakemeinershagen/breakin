extends StaticBody2D

class_name Brick

func _ready():
	$ColorRect.color = get_parent().row_color

extends Control




func _on_score_point():
	$Score.text = "Score: %03d" % GameState.score


func _on_remove_life(body):
	# doing this here because it is easiest even though I don't love updating the state from UI
	GameState.remove_life()
	$Lives.text = "Lives: %d" % GameState.lives

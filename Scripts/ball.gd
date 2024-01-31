extends CharacterBody2D

var waiting_to_start = false
const SPEED = 300.0

signal score_point


func _ready():
	_reset_ball()


func _physics_process(delta):
	var collision: KinematicCollision2D = null
	if !waiting_to_start:
		collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() is Paddle:
			# relative position on paddle from 0 to 1, 0 is on the left
			var rel_pos_norm = ((collision.get_position().x - collision.get_collider().position.x) / \
									collision.get_collider_shape().get_shape().get_rect().size.x) + 0.5
			var angle_in_rad = deg_to_rad((rel_pos_norm * 120) + 30)
			# here sin is from 0 to 1 and cos is from 1 to -1, top half of unit circle
			var direction = Vector2(-cos(angle_in_rad), -sin(angle_in_rad))
			$DebugVector.set_point_position(1, 20 * direction)
			velocity = direction * SPEED
		elif collision.get_collider() is Wall:
			velocity = velocity.bounce(collision.get_normal())
		elif collision.get_collider() is Brick:
			velocity = velocity.bounce(collision.get_normal())
			collision.get_collider().queue_free()
			GameState.add_point()
			emit_signal("score_point")
		$BounceSound.play()


func _reset_ball():
	velocity = Vector2(0, SPEED)
	position.x = get_viewport().size.x / 2
	position.y = get_viewport().size.y / 2
	$Timer.start()
	waiting_to_start = true

func _on_timer_timeout():
	waiting_to_start = false


func _on_bounds_body_entered(body):
	_reset_ball()


func _on_score_point():
	if GameState.score % 128 == 0:
		_reset_ball()

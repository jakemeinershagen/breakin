extends CharacterBody2D

var waiting_to_start = false
var ceiling_bounced = false
var direction = Vector2.DOWN

const SPEED = 300.0
const CEILING_BOUNCE_SPEED = 550.0

signal score_point


func _ready():
	_reset_ball()


func _physics_process(delta):
	var collision: KinematicCollision2D = null
	if !waiting_to_start and GameState.game_running:
		collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider() is Paddle:
			# relative position on paddle from 0 to 1, 0 is on the left
			var rel_pos_norm = ((collision.get_position().x - collision.get_collider().position.x) / \
									collision.get_collider_shape().get_shape().get_rect().size.x) + 0.5
			var angle_in_rad = deg_to_rad((rel_pos_norm * 120) + 30)
			# here sin is from 0 to 1 and cos is from 1 to -1, top half of unit circle
			direction = Vector2(-cos(angle_in_rad), -sin(angle_in_rad))
			$DebugVector.set_point_position(1, 20 * direction)
			_set_velocity()
		elif collision.get_collider() is Wall:
			if collision.get_normal().y > 0.99:
				ceiling_bounced = true
			direction = direction.bounce(collision.get_normal())
			_set_velocity()
		elif collision.get_collider() is Brick:
			direction = direction.bounce(collision.get_normal())
			_set_velocity()
			collision.get_collider().queue_free()
			GameState.add_point()
			emit_signal("score_point")
		$BounceSound.play()


func _set_velocity():
	if !ceiling_bounced:
		velocity = direction * SPEED
	else:
		velocity = direction * CEILING_BOUNCE_SPEED


func _reset_ball():
	velocity = Vector2.DOWN * SPEED
	position.x = get_viewport().size.x / 2
	position.y = get_viewport().size.y / 2
	$Timer.start()
	waiting_to_start = true
	ceiling_bounced = false

func _on_timer_timeout():
	waiting_to_start = false


func _on_bounds_body_entered(body):
	_reset_ball()


func _on_score_point():
	if GameState.check_new_brick_set():
		_reset_ball()

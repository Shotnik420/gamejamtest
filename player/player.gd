extends CharacterBody2D
class_name Player
var speed : float = 400.0
var accelerate : float = 1200.0
var friction: float = 1200.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		# Move as long as the key/button is pressed.
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1

	if Input.is_action_pressed("forward"):
		# Move as long as the key/button is pressed.
		direction.y -= 1
	if Input.is_action_pressed("back"):
		direction.y += 1
	
	direction = direction.normalized()
	
	var target_velocity = direction * speed
	if direction != Vector2.ZERO:
		# Accelerate towards the target velocity
		velocity = velocity.move_toward(target_velocity, accelerate * delta)
	else:
		# Apply friction to gradually slow down
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	# Move the character using the velocity
	move_and_slide()
	

extends CharacterBody2D


@export var  SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@export var DECEL = 290
@export var fastFallRate = 1.1
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("down"):
			velocity = velocity  + get_gravity() * delta * fastFallRate
		else:
			velocity= velocity + get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	# define movement for left to right
	
	if Input.is_action_pressed("left"):
		velocity.x = SPEED * -1
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
	elif not Input.is_action_pressed("left") and velocity.x < 0:
		velocity.x = velocity.x + DECEL * delta
		if velocity.x > 0:
			velocity.x = 0
	elif not Input.is_action_pressed("right") and velocity.x > 0:
		velocity.x = velocity.x + DECEL * delta * -1
		if velocity.x < 0:
			velocity.x = 0
	if Input.is_action_pressed("down") and is_on_floor():
		velocity.x = 0
	move_and_slide()

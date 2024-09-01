extends CharacterBody2D


@export var  SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@export var DECEL = 290
@export var fastFallRate = 1.1
var platVel = Vector2(0, 0)
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
		if get_platform_on_leave():
			velocity.x = platVel.x

	
	# define movement for left to right

	#if Input.is_action_pressed("left"):
		#velocity.x = SPEED * -1
	#elif Input.is_action_pressed("right"):
		#velocity.x = SPEED
	#elif not Input.is_action_pressed("left") and velocity.x < 0:
		#velocity.x = velocity.x + DECEL * delta
		#if velocity.x > 0:
			#velocity.x = platVel.x
	#elif not Input.is_action_pressed("right") and velocity.x > 0:
		#velocity.x = velocity.x + DECEL * delta * -1
		#if velocity.x < 0:
			#velocity.x = platVel.x
	#if Input.is_action_pressed("down") and is_on_floor():
		#velocity.x = 0
	
	#define the direction
	var direction = Input.get_axis("left", "right")
	# checking to see if direction is non - zero, if non-zero then a button was pressed 
	if direction:
		velocity.x = SPEED * direction
	elif is_on_floor():
		if velocity.x != 0:
			
			if velocity.x < 0:
				# so we decelerate the object based on the deceleration value and delta
				velocity.x = velocity.x + DECEL * delta
				# check if the value went over zero the other way, and correct it if that's the case
				if velocity.x > 0:
					velocity.x = 0
			elif velocity.x > 0:
				# do the same thing when moving ot the right but remember to make the deceleration in the opposite direction
				velocity.x = velocity.x + DECEL * delta * -1
				if velocity.x < 0:
					velocity.x = 0
			
	if Input.is_action_pressed("down") and is_on_floor():
		velocity.x = 0
	
	# have all the physics be calculated
	move_and_slide()
	platVel = get_platform_velocity()

extends CharacterBody2D


const SPEED = 500.0
const ACCELERATION = 50
const DECELERATION_THRESHOLD = 50



func _physics_process(_delta):
	var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .05) # Lambda function to decelerate
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	print(velocity.y)
	if down and up:
		decelerate.call()
	elif down:
		if velocity.y < SPEED:
			velocity.y +=  ACCELERATION

	elif up:
		if velocity.y > -SPEED:
			velocity.y -=  ACCELERATION

	else:
		decelerate.call()

	move_and_slide()

func _physics_process_(delta):
	var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .05) # Lambda function to decelerate
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	
	if down and up:
		decelerate.call()
	elif down:
		if velocity.y >= -DECELERATION_THRESHOLD:
			velocity.y =  max(ACCELERATION*delta, SPEED)
		else:
			decelerate.call()
	elif up:
		if velocity.y <= DECELERATION_THRESHOLD:
			velocity.y =  min(-ACCELERATION*delta, -SPEED)
		else:
			decelerate.call()
	else:
		decelerate.call()

	move_and_slide()

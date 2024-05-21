extends CharacterBody2D


const SPEED = 900.0
const ACCELERATION = 55


func wants_move_up():
	return Input.is_action_pressed("up")
	
func wants_move_down():
	return Input.is_action_pressed("down")

func _physics_process(_delta):
	var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .05) # Lambda function to decelerate
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var up = wants_move_up()
	var down = wants_move_down()
	
	if position.y < 0 or position.y > GameParameters.WINDOW_HEIGHT:
		velocity *= -1

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


func _on_hit_box_area_entered(area):
	print(area.name)

extends CharacterBody2D
class_name Player


const SPEED = 900.0
const ACCELERATION = 55

var in_obstacle_area := false
var damage := 1


func wants_move_up():
	return Input.is_action_pressed("up")
	
func wants_move_down():
	return Input.is_action_pressed("down")
	
func hurt():
	self.velocity.y = 0

func _physics_process(_delta):
	velocity.x = 0
	position.x = 200
	var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .05) # Lambda function to decelerate
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var up = wants_move_up()
	var down = wants_move_down()
	
	
	if position.y < 0 or position.y > GameParameters.WINDOW_HEIGHT:
		velocity *= -1
		
	if not in_obstacle_area:
		if down and up:
			decelerate.call()
		elif down and position.y < GameParameters.WINDOW_HEIGHT:
			if velocity.y < SPEED:
				velocity.y +=  ACCELERATION

		elif up and position.y > 0:
			if velocity.y > -SPEED:
				velocity.y -=  ACCELERATION

		else:
			decelerate.call()
		
	move_and_slide()



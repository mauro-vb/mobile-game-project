extends CharacterBody2D
class_name Player

const SPEED = 900.0
const MAX_SPEED = 1200.0
const ACCELERATION = 55

var in_obstacle_area := false
var damage := 1

var set_flash_state = func(v): sprite.material.set_shader_parameter("flashState", v)


@onready var sprite = $TempSprite

var slider
var buttons

@export var health : HealthComponent

func _ready(): 
	print(buttons)
	position.y = 360

	add_to_group("player")

func wants_move_up():
	if slider:
		return slider.smooth_control_up(position.y)
	elif buttons:
		return buttons.up_pressing
	return Input.is_action_pressed("up")
	
func wants_move_down():
	if slider:
		return slider.smooth_control_down(position.y)
	elif buttons:
		return buttons.down_pressing
	return Input.is_action_pressed("down")
	
func hurt():
	self.velocity.y = 0

func _physics_process(_delta):
	velocity.x = 0
	position.x = 200
	velocity.y = MAX_SPEED if velocity.y > MAX_SPEED else velocity.y 
	var decelerate = func(): velocity.y = lerp(velocity.y, 0.0, .07) # Lambda function to decelerate
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var up = wants_move_up()
	var down = wants_move_down()
	
	
	if position.y < 0 or position.y > GameParameters.WINDOW_HEIGHT:
		var edges_spring_force = 500
		velocity.y += edges_spring_force if velocity.y > 0 else -edges_spring_force
		velocity.y *= -1
		
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

func flash(color:Color,duration=.2,loops=1):
	sprite.material.set_shader_parameter("color", color)
	var flash_tween = create_tween()
	flash_tween.set_loops(loops)
	flash_tween.tween_method(set_flash_state, 0,1,duration/2)
	flash_tween.tween_method(set_flash_state, 1,0,duration/2)
	
	


extends StaticBody2D
class_name SpikedPlatform

@export var base_speed := 10
@export var bounce_area : CollisionPolygon2D
@export var hurt_area : Area2D

var speed

func _ready():
	speed = base_speed
	hurt_area.body_entered.connect(deal_dmg)

func _physics_process(_delta):
	hurt_area
	position.x -= speed 
	
func _process(_delta):
	if position.x < -200:
		queue_free()
		
func deal_dmg(body):
	speed = base_speed/2
	print(body)
	await get_tree().create_timer(2).timeout
	speed = base_speed

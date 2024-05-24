extends Node2D
class_name SpikedPlatform

@export var base_speed := 10
@export var bounce_area : Area2D
@export var hurt_area : Area2D
@onready var health := $PlatformHealth

var speed

func _ready():
	speed = base_speed
	hurt_area.body_entered.connect(deal_dmg)
	bounce_area.body_entered.connect(bounce)
	bounce_area.body_exited.connect(exited)
	health.health_depleted.connect(destroy)
	health.health_changed.connect(health_changed)

func _physics_process(_delta):
	hurt_area
	position.x -= speed 
	
func _process(_delta):
	if position.x < -200:
		queue_free()
		
func deal_dmg(body):
	if body is CharacterBody2D:
		speed = base_speed/1.5
		await get_tree().create_timer(.2).timeout
		queue_free()
	
func bounce(body):
	if body is Player:
		bounce_area.damage(body.damage)
		body.in_obstacle_area = true
		body.velocity *= -1
		
func exited(body):
	if body is Player:
		body.in_obstacle_area = false
		
func destroy():
	queue_free()

func health_changed():
	print(health.health)

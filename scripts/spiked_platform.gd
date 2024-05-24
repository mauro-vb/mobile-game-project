extends Node2D
class_name SpikedPlatform

@export var base_speed := 10
@export var bounce_area : Area2D
@export var hurt_area : Area2D

@onready var health := $PlatformHealth
@onready var sprite := $TempSprite


var bounceable := true
var speed

var set_flash_state = func(v): sprite.material.set_shader_parameter("flashState", v)
	
func _ready():
	add_to_group("platforms")
	speed = base_speed
	hurt_area.body_entered.connect(deal_dmg)
	bounce_area.body_entered.connect(bounce)
	bounce_area.body_exited.connect(exited)
	health.health_depleted.connect(destroy)
	health.health_changed.connect(health_changed)

func _physics_process(_delta):
	position.x -= speed 
	
func _process(_delta):
	if position.x < -200:
		queue_free()
		
func deal_dmg(body):
	bounceable = false
	var flash_tween = create_tween()
	sprite.material.set_shader_parameter("color", Color("Red"))
	flash_tween.tween_method(set_flash_state, 0,1,.2)
	if body is CharacterBody2D:
		speed = base_speed/2
		await get_tree().create_timer(.2).timeout
		queue_free()
	
func bounce(body):
	if bounceable:
		if body is Player:
			bounce_area.damage(body.damage)
			body.in_obstacle_area = true
			body.velocity *= -1
		
func exited(body):
	if body is Player:
		body.in_obstacle_area = false
		
func destroy():
	await get_tree().create_timer(.1).timeout
	queue_free()

func health_changed():
	flash("white")

func flash(color:Color):
	sprite.material.set_shader_parameter("color", color)
	var flash_tween = create_tween()
	flash_tween.tween_method(set_flash_state, 0,1,.1)
	flash_tween.tween_method(set_flash_state, 1,0,.1)

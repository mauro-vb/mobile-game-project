extends Node2D

@onready var timer : = $Timer

const SPAWN_LINE_X : float = GameParameters.WINDOW_WIDTH * 1.5

var obstacle_dict : Dictionary = {"basic": preload("res://scenes/obstacles/basic_platform.tscn"),
									"big": preload("res://scenes/obstacles/big_spiked_platform.tscn"),
									"chasing":preload("res://scenes/obstacles/chasing_platform.tscn"),
									"big_healthy":preload("res://scenes/obstacles/big_healthy_platform.tscn")
									}
var heart_consumable = preload("res://scenes/consumables/consumable.tscn")

var next_obstacle : String

var health_sequence : Array = [false, false, false, false, false, true, true]
var health_drop_index : int = 0
var obstacle_sequences : Array = [["basics", "big", "", "big_healthy"],
								["chasing", "basics", "big", "chasing"],
								["chasing", "big", "", "big_healthy"],
								["big", "big", "basics", "chasing"]]
var current_sequence : Array
var shuffled_sequences : Array
var sequence_index : int = 0
var obstacle_index : int = 0

func shuffle_sequences() -> void:
	shuffled_sequences = obstacle_sequences.duplicate()
	shuffled_sequences.shuffle()
	current_sequence = shuffled_sequences[sequence_index]

@export var first_obstacle : String = "big" 

var min_space:int = GameParameters.PLAYER_SIZE + 200 # Minimum possible space to squeeze into
var max_space:int = min_space + 30

func _ready() -> void:
	timer.wait_time = 5
	timer.timeout.connect(_on_timer_timeout)
	shuffle_sequences()
	spawn_obstacle(current_sequence[obstacle_index], false)
	obstacle_index += 1
	timer.start()
	
func _on_timer_timeout() -> void:
	if obstacle_index >= current_sequence.size():
		obstacle_index = 0
		sequence_index += 1
		timer.wait_time -= 1
		timer.wait_time = max(timer.wait_time, 1.8)
		if sequence_index >= shuffled_sequences.size():
			sequence_index = 0
			shuffle_sequences()
			
		current_sequence = shuffled_sequences[sequence_index]
	if health_drop_index >= health_sequence.size():
		health_drop_index = 0
		health_sequence.shuffle()
		
	var obstacle_name = current_sequence[obstacle_index]
	var health_drop = health_sequence[health_drop_index]
	spawn_obstacle(obstacle_name, health_drop)
	obstacle_index += 1
	health_drop_index += 1
	

func spawn_obstacle(obstacle_name:String, with_health:bool) -> void:
	var obstacle : SpikedPlatform
	match obstacle_name:
		"basics":
			#obstacle = instantiate_basics(with_health)
			spawn_tunnel(with_health)
		"big":
			obstacle = instantiate_big(with_health)
		"chasing":
			obstacle = instantiate_chasing(with_health)
		"big_healthy":
			obstacle = instantiate_big_healthy(with_health)
	add_child(obstacle)
	
func instantiate_basics(with_health:bool) -> SpikedPlatform:
	var separation:int = randf_range(min_space, max_space+20)
	var y:int = randf_range(55, GameParameters.WINDOW_HEIGHT - separation - 55)
	var x_delay:int = randi_range(30, 150)
	
	var obstacle = obstacle_dict["basic"].instantiate()
	var obstacle2 = obstacle_dict["basic"].instantiate()
	
	obstacle.position = Vector2(SPAWN_LINE_X,y)
	obstacle2.position = Vector2(0 + x_delay, separation) # relative to obstacle 1
	obstacle2.base_speed = 0 # as to move with obstacle 1
	if with_health:
		var heart:Consumable = heart_consumable.instantiate()
		heart.position.y = y + (separation/2)
		heart.base_speed = 0  # as to move with obstacle 1
		obstacle.add_child(heart)
	obstacle.add_child(obstacle2)
	return obstacle
	
func spawn_tunnel(consumable = false):
	var separation:int = randf_range(min_space, max_space)
	var y_first:int = randf_range(55, GameParameters.WINDOW_HEIGHT - separation - 55)
	var y_second:int = y_first + separation if y_first < GameParameters.WINDOW_HEIGHT / 2 else y_first - separation
	var x_delay = randf_range(50, 150) if randf() > .2 else 0.0 
	var obstacle1 = obstacle_dict["basic"].instantiate()
	var obstacle2 = obstacle_dict["basic"].instantiate()
	obstacle1.position = Vector2(SPAWN_LINE_X+x_delay,y_first)
	obstacle2.position = Vector2(SPAWN_LINE_X,y_second)
	obstacle1.spring_force = 200
	obstacle2.spring_force = 200
	#obstacle2.base_speed = 1
	add_child(obstacle1)
	add_child(obstacle2)
	
func instantiate_big(with_health:bool) -> SpikedPlatform:
	var obstacle : SpikedPlatform  = obstacle_dict["big"].instantiate()
	obstacle.position = Vector2(SPAWN_LINE_X, randi_range(obstacle.spawn_y_range[0], obstacle.spawn_y_range[1]))
	obstacle.with_consumable = with_health
	return obstacle
	
func instantiate_chasing(with_health:bool) -> SpikedPlatform:
	var obstacle : SpikedPlatform = obstacle_dict["chasing"].instantiate()
	obstacle.position = Vector2(SPAWN_LINE_X, randi_range(obstacle.spawn_y_range[0], obstacle.spawn_y_range[1]))
	obstacle.with_consumable = with_health
	return obstacle
	
func instantiate_big_healthy(with_health:bool) -> SpikedPlatform:
	var obstacle : SpikedPlatform = obstacle_dict["big_healthy"].instantiate()
	obstacle.with_consumable = with_health
	if randf() > .5:
		obstacle.position = Vector2(SPAWN_LINE_X, randi_range(min_space, max_space))
	else:
		obstacle.top_or_bot = "bot"
		obstacle.position = Vector2(SPAWN_LINE_X, randi_range(GameParameters.WINDOW_HEIGHT-min_space,GameParameters.WINDOW_HEIGHT-max_space))
	return obstacle

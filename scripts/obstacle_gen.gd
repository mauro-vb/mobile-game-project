extends Node2D
var test = "test"

const SPAWN_LINE_X = GameParameters.WINDOW_WIDTH *2

var obstacle_dict := {"basic": preload("res://scenes/obstacles/basic_platform.tscn"),
					"big": preload("res://scenes/obstacles/big_spiked_platform.tscn"),
					"chasing":preload("res://scenes/obstacles/chasing_platform.tscn"),
					"big_healthy":preload("res://scenes/obstacles/big_healthy_platform.tscn")
					}

var consumable_dict:= {"test":preload("res://scenes/consumables/slow_down_consumable.tscn"),
						"health":preload("res://scenes/consumables/consumable.tscn")
						}


func _ready():
	spawn_obstacle("big_healthy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func spawn_obstacle(obstacle_name, x_displacement=0.0):
	var obstacle = obstacle_dict[obstacle_name].instantiate()
	if obstacle_name == "big_healthy":
		var min_space = 135 + GameParameters.PLAYER_SIZE  * 1.75
		var max_space = 135 + GameParameters.PLAYER_SIZE  * 3.5
		if randf() > .5:
			obstacle.position = Vector2(SPAWN_LINE_X+x_displacement, randi_range(min_space, max_space))
		else:
			obstacle.position = Vector2(SPAWN_LINE_X+x_displacement, randi_range(GameParameters.WINDOW_HEIGHT-min_space,GameParameters.WINDOW_HEIGHT-max_space))
	else:
		obstacle.position = Vector2(SPAWN_LINE_X+x_displacement, randi_range(obstacle.spawn_y_range[0], obstacle.spawn_y_range[1]))
	add_child(obstacle)
	
func spawn_consumable(consumable_name, y = 300, x_displacement=0):
	
	var consumable = consumable_dict[consumable_name].instantiate()
	consumable.position = Vector2(SPAWN_LINE_X+x_displacement, randi_range(200, 500))
	consumable.rotation_degrees = randi()
	add_child(consumable)

func _on_timer_timeout():
	if randf() > .92:
		spawn_consumable("health")
	var rand = randf()
	if rand >= .75:
		spawn_obstacle("big_healthy")
	elif rand >= .50:
		spawn_tunnel()
	elif rand >= .25:
		spawn_obstacle("big")
	else:
		spawn_obstacle("chasing", randf_range(30, GameParameters.WINDOW_HEIGHT-30))
	$Timer.wait_time = 2.0+randf()

func pause(t):
	$Timer.stop()
	await get_tree().create_timer(t).timeout
	$Timer.start()

func spawn_tunnel():
	var separation = randf_range(GameParameters.PLAYER_SIZE + 150, 250)
	var y_first = randf_range(30, GameParameters.WINDOW_HEIGHT-30)
	var y_second = y_first + separation if y_first < GameParameters.WINDOW_HEIGHT / 2 else y_first - separation
	var x_delay = randf_range(50, 150) if randf() > .2 else 0.0 
	var obstacle1 = obstacle_dict["basic"].instantiate()
	var obstacle2 = obstacle_dict["basic"].instantiate()
	obstacle1.position = Vector2(SPAWN_LINE_X+x_delay,y_first)
	obstacle2.position = Vector2(SPAWN_LINE_X,y_second)
	obstacle1.spring_force = 200
	obstacle2.spring_force = 200
	add_child(obstacle1)
	add_child(obstacle2)
	#if randf() > .2:
		#var y_mid = (y_first + y_second) /2
		#spawn_consumable("test",y_mid)

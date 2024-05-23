extends Node2D

const SPAWN_LINE_X = GameParameters.WINDOW_WIDTH + 100
var obstacle_dict := {"static_wall": preload("res://Scenes/obstacles/static_wall.tscn"),
					"consumable":preload("res://scenes/obstacles/consumable.tscn"),
					"test": preload("res://scenes/obstacles/basic_platform.tscn")}

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_obstacle("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func spawn_obstacle(obstacle_name, y = 300, x_displacement=0):
	var obstacle = obstacle_dict[obstacle_name].instantiate()
	obstacle.position = Vector2(SPAWN_LINE_X+x_displacement, y)
	add_child(obstacle)


func _on_timer_timeout():
	var mid = GameParameters.WINDOW_HEIGHT / 2
	if randf() > .5:
		spawn_obstacle("test", randi_range(30, GameParameters.WINDOW_HEIGHT-30))
	else:
		var separation = randi_range(GameParameters.PLAYER_SIZE + 120, 250)
		var y_first = randi_range(30, GameParameters.WINDOW_HEIGHT-30)
		var y_second = y_first + separation if y_first < GameParameters.WINDOW_HEIGHT / 2 else y_first - separation
		var x_delay = randi_range(0, 100) if randf() > .2 else 0 
		spawn_obstacle("test",y_first,x_delay)
		spawn_obstacle("test",y_second)
	$Timer.wait_time = 1+randf()

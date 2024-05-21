extends Node2D

const SPAWN_LINE_X = GameParameters.WINDOW_WIDTH + 100
var obstacle_dict := {"static_wall": preload("res://Scenes/obstacles/static_wall.tscn")
}



# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_obstacle("static_wall")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#await get_tree().create_timer(5).timeout
	
	

func spawn_obstacle(obstacle_name):
	var obstacle = obstacle_dict[obstacle_name].instantiate()
	obstacle.position = Vector2(SPAWN_LINE_X, 100)
	add_child(obstacle)

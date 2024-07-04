extends Label

var score = 0: 
	set(value):
		text = "Score: %s  " % value
		GameParameters.LastScore = score
		score = value
		

func _process(_delta):
	for platform in get_tree().get_nodes_in_group("platforms"):
		if not platform.destroyed.is_connected(_increase_score):
			platform.destroyed.connect(_increase_score)
		#if not platform.missed.is_connected(_decrease_score):
			#platform.missed.connect(_decrease_score)
		
func _increase_score(points):
	score += points
	
func _decrease_score(points):
	if points > score:
		score = 0 
	else:
		score -= points

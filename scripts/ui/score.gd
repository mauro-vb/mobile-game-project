extends Label

var score = 0

func _process(delta):
	for platform in get_tree().get_nodes_in_group("platforms"):
		platform.destroyed.connect(_increase_score)
		platform.missed.connect(_decrease_score)
		
func _increase_score(points):
	score += points
	text = "Score:\n%s" % score
	print(text)
	
func _decrease_score(points):
	if points > score:
		score = 0 
	else:
		score -= points
	text = "Score:\n%s" % score
	print(text)

extends Spatial

onready var level1 = preload("Hole1.tscn")
onready var level2 = preload("Hole2.tscn")
onready var level3 = preload("Hole3.tscn")
onready var level4 = preload("Hole4.tscn")

var progress = 0

func _ready():
	var scene = level1.instance()
	add_child(scene)

func progress():
	progress += 1
	
	get_child(0).queue_free()
	var scene
	
	if progress == 1:
		scene = level2.instance()
		add_child(scene)
		
	if progress == 2:
		scene = level4.instance()
		add_child(scene)
		
	if progress == 3:
		scene = level3.instance()
		add_child(scene)

extends Spatial

onready var level1 = preload("Hole1.tscn")
onready var level2 = preload("Hole2.tscn")
onready var level3 = preload("Hole3.tscn")
onready var level4 = preload("Hole4.tscn")
onready var End = preload("End.tscn")

var progress = 0

func _ready():
	var scene = level1.instance()
	$Game.add_child(scene)

func progress():
	progress += 1
	
	get_node("Game").get_child(0).queue_free()
	var scene
	
	if progress == 0:
		scene = level1.instance()
		$Game.add_child(scene)
	
	if progress == 1:
		scene = level2.instance()
		$Game.add_child(scene)
		
	if progress == 2:
		scene = level4.instance()
		$Game.add_child(scene)
		
	if progress == 3:
		scene = level3.instance()
		$Game.add_child(scene)
		
	if progress == 4:
		scene = End.instance()
		$Game.add_child(scene)
		
func _process(delta):
	if Input.is_action_just_released("restart"):
		progress = -1
		progress()
	if Input.is_action_just_released("L1"):
		progress = -1
		progress()
	if Input.is_action_just_released("L2"):
		progress = 0
		progress()
	if Input.is_action_just_released("L3"):
		progress = 1
		progress()
	if Input.is_action_just_released("L4"):
		progress = 2
		progress()

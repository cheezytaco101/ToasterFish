extends Spatial

onready var anim = $AnimationPlayer

func _ready():
	spawn_particle()
	pass
	
func shoot_particle():
	$Shoot.restart()
	
func spawn_particle():
	$Spawn.restart()

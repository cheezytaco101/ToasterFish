extends Spatial

onready var init_offset = transform.origin
var fish_position = Vector3()

func _process(delta):
	global_transform.origin = lerp(global_transform.origin, fish_position + init_offset, 0.1)


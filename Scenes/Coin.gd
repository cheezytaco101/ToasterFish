extends MeshInstance

onready var p = get_parent()

func _on_Area_body_entered(body):
	p.score -= 1
	p.updateScore()
	queue_free()

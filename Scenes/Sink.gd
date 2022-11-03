extends Spatial




func _on_Area_body_entered(body):
	if body.name == "Fish":
		emit_signal("Win")
		print("Win")
